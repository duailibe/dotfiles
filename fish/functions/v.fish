function v -d "activates the virtualenv from the current directory"
  set -l activate (find "$PWD" -wholename "*/bin/activate.fish" -type f)

  if test (count $activate) -eq 1
    source "$activate"
    return 0
  end

  if test (count $activate) -eq 0
    echo "No virtualenv found in this directory"
    return 1
  end

  echo "Found multiple virtualenvs in this directory"
end
