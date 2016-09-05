# init according to man page
if (( $+commands[pyenv] ))
then
  eval "$(pyenv init -)"

  if (( $+commands[pyenv-virtualenvwrapper_lazy] ))
  then
    pyenv virtualenvwrapper_lazy
  fi
fi
