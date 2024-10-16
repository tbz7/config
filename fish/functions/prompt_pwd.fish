function prompt_pwd --description 'short CWD for the prompt'
    set -l np (string escape --style=regex -- "$NIX_PROFILES[1]")
    set -l tmp (string replace -r '^'"$np"'($|/)' '~nix$1' $PWD)

    set -l realhome (string escape --style=regex -- ~)
    set -l tmp (string replace -r '^'"$realhome"'($|/)' '~$1' $tmp)

    string shorten -lc … -m 30 $tmp
end
