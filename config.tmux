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

# tmux plugin manager configuration
# reference : https://github.com/tmux-plugins/tpm
# ==========================================
set -g @plugin 'tmux-plugins/tpm'

# tmux-resurrect configuration
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @resurrect-processes 'ssh'

# Initialize TMUX plugin manager
run '~/.tmux/plugins/tpm/tpm'
# ==========================================

set-option -g allow-rename off

# Ctrl-l will clear the console together with the tmux scroll back buffer
bind -n C-l send-keys C-l \; clear-history

# Performance_Note : Setting this ends up using much more memory
set-option -g history-limit 20000

# Reduce the repeat time
set-option -g repeat-time 200

setw -g mode-keys vi

bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."
