status is-interactive && string match -qr '^3\.7' $FISH_VERSION || return

function __focus_enable --on-event fish_prompt
    echo -en '\e[?1004h'
end

function __focus_disable --on-event fish_preexec
    echo -en '\e[?1004l'
end

for m in default insert replace replace_one visual
    bind -M $m \e\[I 'emit fish_focus_in'
    bind -M $m \e\[O 'emit fish_focus_out'
end
