function prompt_pwd --description 'short CWD for the prompt'
    set -l replacements $prompt_pwd_extra_replacements $HOMEBREW_PREFIX:'~homebrew' $HOME:'~'

    set -l wd $PWD
    for r in $replacements
        set -l esc (string split : $r)
        if [ -n "$esc[1]" ]
            set wd (string replace -r "^$esc[1](\$|/)" "$esc[2]\$1" "$wd")
        end
    end

    string shorten -lc … -m 30 $wd
end
