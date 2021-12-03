if test -z "$CODE_PATH"
  set -U CODE_PATH "$HOME/Code"
end

if ! test -e "$CODE_PATH"
  mkdir -p "$CODE_PATH"
end

if test ! -z c
  function c -d "Go to code"
    cd "$CODE_PATH/$argv"
  end

  function __c_complete
    set -l token (commandline -ct)
    set -l pwd $PWD

    builtin cd $CODE_PATH
    and complete -C"cd $token"
    builtin cd $pwd
  end

  complete -c c -f -a "(__c_complete)"
end
