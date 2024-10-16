function rgc
    rg -pC3 $argv | perl -pe "s/(\d+\e\[0m-)(.*)/\$1\e[90m\$2\e[0m/"
end
