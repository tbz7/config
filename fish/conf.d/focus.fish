function fish_enable_focus --on-event fish_prompt
    echo -en '\e[?1004h'
end

function fish_disable_focus --on-event fish_preexec
    echo -en '\e[?1004l'
end

for m in default insert paste replace replace_one visual
    bind -M $m \e\[I 'emit fish_focus_in'
    bind -M $m \e\[O 'emit fish_focus_out'
end
