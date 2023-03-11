package main

import (
	"hash/crc32"
	"log"
	"net"
	"os"
	"os/exec"
	"sync"
	"time"
)

var socket = os.Args[1]
var command = os.Args[2]

var wait sync.WaitGroup

var cache = make(map[string]cacheEntry)
var cacheMutex = sync.Mutex{}
var execSem = make(chan int, 4)

type cacheEntry struct {
	timestamp time.Time
	value     string
	updating  bool
}

func main() {
	listener, err := net.Listen("unix", socket)
	if err != nil {
		log.Fatal(err)
	}
	defer listener.Close()

	go serve(listener)

	wait.Add(1)
	go func() {
		time.Sleep(10 * time.Second)
		wait.Done()
	}()
	wait.Wait()

	log.Println("No open connections, exiting...")
}

func serve(listener net.Listener) {
	for {
		conn, err := listener.Accept()
		if err != nil {
			log.Println(err)
			continue
		}
		log.Println("Accepted connection")

		wait.Add(1)
		go func() {
			defer conn.Close()
			defer wait.Done()

			buf := make([]byte, 1024)
			for {
				conn.SetDeadline(time.Now().Add(time.Hour))
				n, err := conn.Read(buf)
				if err != nil {
					log.Println(err)
					return
				}
				res := fetch(buf[0] == '1', string(buf[1:n]))
				conn.Write([]byte(res + "\000"))
			}
		}()
	}
}

func fetch(active bool, cwd string) string {
	cacheMutex.Lock()
	defer cacheMutex.Unlock()

	entry := cache[cwd]

	if entry.updating {
		return entry.value
	}

	if !active {
		fuzz := crc32.ChecksumIEEE([]byte(cwd)) % 2000
		if time.Since(entry.timestamp).Milliseconds() < int64(59000+fuzz) {
			return entry.value
		}
	}

	entry.updating = true
	cache[cwd] = entry

	go func() {
		execSem <- 1
		out, _ := exec.Command(command, cwd).Output()
		<-execSem

		cacheMutex.Lock()
		defer cacheMutex.Unlock()

		t := time.Now()
		cache[cwd] = cacheEntry{t, string(out), false}

		if len(cache) > 100 {
			minK := cwd
			minT := t
			for eK, eV := range cache {
				if eV.timestamp.Before(minT) {
					minK = eK
					minT = eV.timestamp
				}
			}
			delete(cache, minK)
		}
	}()
	return entry.value
}
