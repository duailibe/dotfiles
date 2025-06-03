function venv -d "creates virtualenv"
  set -l activate ".venv/bin/activate.fish"
  set -l venv_dir "$HOME/.local/virtualenvs"

  # If no arguments, try to activate a virtualenv in .venv
  if test (count $argv) -eq 0; and test -e "$activate"
      source "$activate"
      return
  end

  argparse --name=venv 'h/help' 'p/python=' -- $argv

  if set -q _flag_h
    echo "venv [name] [-p python]"
    return
  end

  set -l venv_name (basename $PWD | tr . _)
  if set -q argv[1]
    set venv_name $argv[1]
  end

  set -l python_bin (which "python")
  if set -q _flag_p
    set python_bin (which "$_flag_p")
  end

  if not test -e "$python_bin"
    echo "Python binary not found: $python_bin"
    return 1
  end

  echo "Creating virtualenv '$venv_name' with $python_bin"
  if test -e "$venv_dir/$venv_name"
    echo "Warning: will clear the existing virtualenv"
  end
  virtualenv --clear -q -p "$python_bin" "$venv_dir/$venv_name"
  ln -s "$venv_dir/$venv_name" ".venv"

  source "$activate"
end

complete -c venv -s p -x -a "(__fish_complete_subcommand --commandline python)"
