# << homebrew >>
# ref - https://github.com/Homebrew/brew/blob/master/docs/Manpage.md#environment

export HOMEBREW_INSTALL_CLEANUP=0 # checking existence, not value
export HOMEBREW_AUTO_UPDATE_SECS=86400 # check for update every 24 hours

# << tmuxinator >>
# ref - https://github.com/tmuxinator/tmuxinator#project-configuration-location
export TMUXINATOR_CONFIG="$DOTFILES/tmux/tmuxinator_configs"

# set default editors
# technically only aliasing $VISUAL is necessary but $EDITOR is used elsewhere
# in these dotfiles and should be `nvim`
export VISUAL=nvim
export EDITOR=nvim
