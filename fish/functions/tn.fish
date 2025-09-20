function tn --wraps='tmux new-session -s' --wraps='tmux new-session' --description 'alias tn=tmux new-session'
  tmux new-session $argv
        
end
