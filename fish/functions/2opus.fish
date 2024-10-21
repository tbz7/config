function 2opus
    for f in $argv
        ffmpeg -i $f -c:a libopus -ab 128k (path change-extension opus $f)
    end
end
