function mkv-cleanup
    for f in $argv
        mkvpropedit $f \
            -e track:v1 -s flag-default=true -s language=und -d name \
            -e track:a1 -s flag-default=true

        for e in (mkvmerge -J $f | jq -r '.tracks[] | select(.type=="audio") | "\(.properties.number):\(.properties.language):\(.properties.default_track)"')
            set e (string split : $e)
            mkvpropedit $f -e track:$e[1] -s language=$e[2] -s flag-default=$e[3]
        end

        for e in (mkvmerge -J $f | jq -r '.tracks[] | select(.type=="subtitles") | "\(.properties.number):\(.properties.language):\(.properties.default_track)"')
            set e (string split : $e)
            mkvpropedit $f -e track:$e[1] -s language=$e[2] -s flag-default=$e[3]
        end
    end
end
