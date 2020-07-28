source ~/.config/fish/init.fish
source ~/.config/fish/completions/exercism.fish
# source /home/vlad/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true

set -xg PATH ~/.psvm/current/bin ~/.local/gems/bin ~/code/k/k-distribution/target/release/k/bin ~/.idris2/bin   $PATH
set TERM 'alacritty'

set GEM_HOME ~/.local/gems

## other theme
# set fish_greeting ""
# set -g fish_prompt_pwd_dir_length 4
# set -g theme_display_user "yes"
# set -g theme_hostname "always"

# bob the fish theme
set -g theme_display_git yes
set -g theme_display_git_dirty yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_display_git_dirty_verbose yes
set -g theme_display_git_master_branch yes
#set -g theme_git_worktree_support yes
set -g theme_display_vagrant yes
set -g theme_display_docker_machine yes
set -g theme_display_k8s_context yes
set -g theme_display_hg yes
set -g theme_display_virtualenv yes
set -g theme_display_ruby no
set -g theme_display_user yes
set -g theme_display_hostname yes
set -g theme_display_vi no
set -g theme_avoid_ambiguous_glyphs no
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts no
set -g theme_show_exit_status yes
set -g theme_color_scheme dark
set -g fish_prompt_pwd_dir_length 8
set -g theme_project_dir_length 1
set -g theme_newline_cursor no

set -g XMODIFIERS "@im=none"

# Nix
fenv source $HOME/.nix-profile/etc/profile.d/nix.sh
set -xg LC_ALL en_US.UTF-8
set -xg LANG en_US.UTF-8
# End Nix