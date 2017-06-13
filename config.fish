# prompt
function fish_prompt
	set -l home_escaped (echo -n $HOME | sed 's/\//\\\\\//g')
    set -l pwd (echo -n $PWD | sed "s/^$home_escaped/~/" | sed 's/ /%20/g')
    set -l prompt_symbol ''
    switch $USER
        case root toor
            set prompt_symbol '# '
        case '*'
            set prompt_symbol '$ '
    end

    set_color green
    echo -n (whoami)@(prompt_hostname)
    set_color grey
    echo -n ' '[(date +%T)]:' '
    set_color cyan
    echo $pwd
    set_color grey normal
    echo $prompt_symbol
end

# alias
function mv; command mv -iv $argv; end
function cp; command cp -iv $argv; end
function rm; command rm -iv $argv; end
function mkdir; command mkdir -pv $argv; end

function ls; command ls -AFh --color=auto $argv; end

function vi; command vim $argv; end
