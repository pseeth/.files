# this file sets the $PATH environment variable to enable various executables
#
# why set this here and not in `zshenv`? because macOS & certain Linux distros
# run `/etc/profile` after `zshenv` overwriting path modifications
# ref - https://stackoverflow.com/a/34244862
#
# zsh conveniently links `path` array and `PATH` env var
# to prepend new entry - `path=(<new-addition> $path)`
# to append new entry - `path+=<new-addition>` (`()` required to add >1 entry)

typeset -U path # make path array unique (a set)

# python dependency manager
[[ -d "$HOME/.poetry/bin" ]] && path=("$HOME/.poetry/bin" $path)

# where `pip install --user` installs executables
[[ -d "$HOME/.local/bin" ]] && path=("$HOME/.local/bin" $path)

[[ -d "$HOME/.cargo/bin" ]] && path=("$HOME/.cargo/bin" $path) # rust packages

# `rust-analyzer` language server
# built by $DOTFILES/infra/setup/bin/setup_language_servers
[[ -d "$DOTFILES/target/rust-analyzer/target/release" ]] && {
  path=("$DOTFILES/target/rust-analyzer/target/release" $path)
}

# homebrew
[[ -d "$HOMEBREW_PREFIX" ]] && {
  path=(
    "$HOMEBREW_PREFIX/bin"
    "$HOMEBREW_PREFIX/sbin"
    $path
  )

  # enable usage of `gmake` as `make` (`gmake` installed via `make` in Brewfile)
  [[ -d "$HOMEBREW_PREFIX/opt/make/libexec/gnubin" ]] && {
    path=("$HOMEBREW_PREFIX/opt/make/libexec/gnubin" $path)
  }

  "$DOTFILES/infra/scripts/is_macos.sh" || {
    # run the below scripts to add `brew` to PATH on linux installations
    # ref - https://docs.brew.sh/Homebrew-on-Linux#install

    # installs to separate user if given `sudo` access during installation
    if [ -d /home/linuxbrew/.linuxbrew ]; then
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    # installs to home directory if NOT given `sudo` access during installation
    elif [ -d "$HOME/.linuxbrew" ]; then
      eval "$($HOME/.linuxbrew/bin/brew shellenv)"
    fi
  }
}

# << work-specific >>
[ -d "$HOME/work" ] && {
  { # android studio
    local ANDROID_PATH="$HOME/Library/Android"
    [[ -d "$ANDROID_PATH/tools" ]] && path+="$ANDROID_PATH/tools"
    [[ -d "$ANDROID_PATH/platform-tools" ]] && {
      path+="$ANDROID_PATH/platform-tools"
    }
  }

  # Go executables
  [[ -d "$GOPATH/bin" ]] && path=("$GOPATH/bin" $path)
}
# << end work-specific >>
