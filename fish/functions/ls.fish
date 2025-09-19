function ls --wraps='eza --oneline --group-directories-first' --wraps='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first --oneline' --description 'alias ls=eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first --oneline'
  eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first --oneline $argv
        
end
