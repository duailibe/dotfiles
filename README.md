# dotfiles

These are my dotfiles, forked from [holman's](http://github.com/holman/dotfiles).

## Install

```sh
curl -L https://git.io/dualdot | sh
```

## How it works

Everything's built around topic areas. If you're adding a new area to your forked dotfiles — say, "Java" — you can simply add a `java` directory and put files in there.

Files named `setup.sh` are executed automatically.

## Goodies

### **`dot`**

`dot` is a simple script that installs dependencies and keeps things updated. It should be safe run `dot` multiple times, so just run it periodically.

You can find this script in `bin/`.

### **`c`**

Like `cd` but directly to your code folder, configured by `$CODE_PATH` (defaults to `~/Code`).
