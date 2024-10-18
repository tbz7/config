function termtest
    set -l colors bg 00 08 01 09 02 10 03 11 04 12 05 13 06 14 07 15 fg

    echo -e '\n    ' {$colors}' '

    for i in $colors
        echo -en " $i "
        for j in $colors
            switch $i$j
                case fgfg
                    echo -en '\e[7m    \e[0m'
                case bgbg
                    echo -en '    '
                case fgbg
                    echo -en ' ab '
                case bgfg
                    echo -en '\e[7m ab \e[0m'
                case 'fg*'
                    [ $j -gt 7 ] && set -l d 92 || set -l d 40
                    echo -en "\e[$(math $j + $d)m ab \e[0m"
                case 'bg*'
                    [ $j -gt 7 ] && set -l d 82 || set -l d 30
                    echo -en "\e[7m\e[$(math $j + $d)m ab \e[0m"
                case '*fg'
                    [ $i -gt 7 ] && set -l d 92 || set -l d 40
                    echo -en "\e[7m\e[$(math $i + $d)m ab \e[0m"
                case '*bg'
                    [ $i -gt 7 ] && set -l d 82 || set -l d 30
                    echo -en "\e[$(math $i + $d)m ab \e[0m"
                case '*'
                    [ $i -gt 7 ] && set -l d 82 || set -l d 30
                    [ $j -gt 7 ] && set -l e 92 || set -l e 40
                    echo -en "\e[$(math $i + $d)m\e[$(math $j + $e)m ab \e[0m"
            end
        end
        echo
    end

    for r in (seq 0 5)
        echo -en '\n    '
        for g in (seq 0 5)
            for b in (seq 0 5)
                echo -en "\e[48;5;$(math "16 + ($r * 36) + ($g * 6) + $b")m  "
            end
        end
        echo -en '\e[0m'
    end
    echo -en '\n\n   '

    for i in (seq 232 255)
        echo -en ' \e[48;5;'$i'm  '
    end
    echo -en ' \e[0m\n\n    '

    for i in (seq 0 71)
        printf "\e[48;2;%d;%d;%dm " \
            (math "floor(-255 / 71 * $i + 255)") \
            (math "floor(255 - abs($i * (510 / 71) - 255))") \
            (math "floor(255 / 71 * $i)")
    end
    echo -e '\e[0m\n'

    for c in '' '\e[31m'
        echo -en " \e[0m$c  "
        echo -en ' normal'
        echo -en ' \e[1mbold\e[22m'
        echo -en ' \e[2mdim\e[22m'
        echo -en ' \e[3mitalics\e[23m'
        echo -en ' \e[4munder\e[24m'
        echo -en ' \e[21munder2\e[24m'
        echo -en ' \e[53mover\e[55m'
        echo -en ' \e[5mblink\e[25m'
        echo -en ' \e[6mblink2\e[25m'
        echo -en ' \e[7mreverse\e[27m'
        echo -e ' \e[9mstrikeout\e[0m'
    end

    echo -e '    \e[8minvisible\e[0m'

    for c in '' '\e[58:5:1m'
        echo -en " \e[0m$c  "
        echo -en ' \e[4:1msingle\e[4:0m'
        echo -en ' \e[4:2mdouble\e[4:0m'
        echo -en ' \e[4:3mcurly\e[4:0m'
        echo -en ' \e[4:4mdotted\e[4:0m'
        echo -en ' \e[4:5mdashed\e[4:0m'
        echo -en ' \e[53mover\e[55m'
        echo -e ' \e[9mstrike\e[0m'
    end
    echo
end
