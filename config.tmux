# Set back tick as the prefix
unbind C-b
set -g prefix `
bind-key ` send-prefix

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# hjkl pane traversal
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

set -g mouse on

set -g @plugin 'tmux-plugins/tmux-resurrect'

set-option -g allow-rename off

bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

