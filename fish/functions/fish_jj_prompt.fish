function fish_jj_prompt
    command -sq jj
    and jj log 2>/dev/null --no-graph --ignore-working-copy --color always -r @ -T \
        'if(empty,
            label("elided", "(empty)"),
            separate(" ", format_short_change_id(change_id), bookmarks, tags))'
end
