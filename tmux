# Re-assigning C-b to C-a
set-option -g prefix C-a

# Bindings for C-a a
bind-key a send-prefix

# Set status bar
set -g status-bg black
set -g status-fg white
set -g status-left ""
set -g status-right '#[fg=green,bold]#H | %a %d.%m, %H:%M'

set-window-option -g window-status-format ' #I #W '
set-window-option -g window-status-current-format ' #I #W '
set-window-option -g window-status-current-attr bold

set-window-option -g window-status-current-bg blue
set-window-option -g window-status-bell-bg yellow

# Set window notifications
#setw -g monitor-activity on
#set -g visual-activity on

# Allow tmux to pass trough Ctrl, Alt and Shift modifiers
setw -g xterm-keys on
set -g terminal-overrides 'xterm*:smcup@:rmcup@'

# Bindings for vertical + horizontal splits
unbind %
bind s split-window -v
bind v split-window -h

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind H resize-pane -L 10
bind J resize-pane -D 10
bind K resize-pane -U 10
bind L resize-pane -R 10

# Base for numbering is 1, not 0
set -g base-index 1

# various
#set-option -g lock-command vlock
set-window-option -g utf8 on
setw -g automatic-rename on
#set -g default-terminal “screen-256color”
