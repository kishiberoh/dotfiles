function la --wraps=ls --wraps='eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first --oneline -a' --description 'alias la=eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first --oneline -a'
  eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first --oneline -a $argv
        
end
