alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Setup environment
[ -f $HOME/.shenv ] && . $HOME/.shenv
# Define any useful functions
[ -f $HOME/.shfunc ] && . $HOME/.shfunc
# Setup aliases
[ -f $HOME/.shalias ] && . $HOME/.shalias

