# vim:set ts=2 sts=2 sw=2:

# suppress a welcome message
set fish_greeting

# prompt
function fish_prompt
  set -l home_escaped (echo -n $HOME | sed 's/\//\\\\\//g')
  set -l pwd (echo -n $PWD | sed "s/^$home_escaped/~/")
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

function fish_right_prompt
  set_color ff8c00
  echo (__fish_git_prompt)
  set_color normal
end

# aliases
function mv; command mv -iv $argv; end
function cp; command cp -iv $argv; end
function rm; command rm -iv $argv; end
function mkdir; command mkdir -pv $argv; end

function less; command less -M $argv; end
function grep; command grep -n --color=auto $argv; end

function vi; command vim $argv; end
function vir; command vim -R $argv; end
function clang; command clang -Wall $argv; end
function clang++; command clang++ -Wall $argv; end

# colorized ls
switch (uname -s)
  case Darwin
    set -x LSCOLORS gxfxcxdxbxegedabagacad
    function ls; command ls -AhFG $argv; end
  case Linux
    function ls; command ls -AFh --color=auto $argv; end
end
