# Adapted from http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh
# and https://github.com/sindresorhus/pure

autoload colors && colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:*' max-exports 1
# export branch (%b)
zstyle ':vcs_info:git*' formats '%b'
zstyle ':vcs_info:git*' actionformats '%b|%a'

PROMPT='%(12V.%F{242}%12v%f .)❯ '

if [[ -z $prompt_newline ]]; then
  typeset -g prompt_newline=$'\n%{\r%}'
fi

git_branch() {
  setopt localoptions noshwordsplit

  local git_color=green
  local dirty=''

  test -z "$(command git status --porcelain --ignore-submodules -unormal)"
  if (( $? != 0 )); then
    git_color=red
    dirty='*'
  fi

  echo "%F{$git_color}${vcs_info_msg_0_}${dirty}%f"
}

git_unpushed() {
  command git rev-list --count HEAD...@'{u}' 2>/dev/null
}

render() {
  setopt localoptions noshwordsplit

  # initialize the array
  local -a parts

  # set the path
  parts+=('%F{242}%~%f')

  vcs_info
  if [[ -n $vcs_info_msg_0_ ]]; then
    parts+=($(git_branch))

    local unpushed=$(git_unpushed)
    if [[ -n $unpushed ]] && (( $unpushed > 0 )); then
      parts+=('%F{cyan}⇡%f')
    fi
  fi

  local cleaned_ps1=$PROMPT
  local -H MATCH MBEGIN MEND
  if [[ $PROMPT = *$prompt_newline* ]]; then
		# When the prompt contains newlines, we keep everything before the first
		# and after the last newline, leaving us with everything except the
		# preprompt. This is needed because some software prefixes the prompt
		# (e.g. virtualenv).
		cleaned_ps1=${PROMPT%%${prompt_newline}*}${PROMPT##*${prompt_newline}}
  fi
  unset MATCH MBEGIN MEND

  local -ah ps1
  ps1=(
    $prompt_newline
    ${(j. .)parts}
    $prompt_newline
    $cleaned_ps1
  )

  PROMPT="${(j..)ps1}"
}

set_title() {
  setopt localoptions noshwordsplit

  # don't set title over serial console
  case $TTY in
    /dev/ttyS[0-9]*) return;;
  esac

  # tell the terminal we are setting the title
  print -n '\e]0;'

  # show hostname if connected through ssh
  [[ -n $SSH_CONNECTION ]] && print -Pn '(%m) '

  case $1 in
    expand-prompt)
      print -Pn $2;;
    ignore-escape)
      print -rn $2;;
  esac

  # end set title
  print -n '\a'
}

preexec() {
  # shows the current dir and executed command in the title while a process is active
  set_title 'ignore-escape' "$PWD:t: $2"
}

precmd() {
  # shows the full path in the title
  set_title 'expand-prompt' '%~'

  psvar[12]=
  if [[ -n $VIRTUAL_ENV ]]; then
    psvar[12]="${VIRTUAL_ENV:t}"
  fi

  render
}
