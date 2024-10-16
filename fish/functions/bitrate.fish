function bitrate
    for f in $argv
        set -l size (stat -c %s $f)
        and set -l duration (
            ffprobe -v -8 -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 $f)
        and printf '%.2f Mb/s - %.2f GiB - %s\n' \
            (math $size / 1024 / 128 / $duration) \
            (math $size / 2 ^ 30) \
            $f
    end
end
