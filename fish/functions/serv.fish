function serv --wraps='ssh root@100.78.27.68' --wraps='ssh root@serv' --description 'alias serv=ssh root@serv'
  ssh root@serv $argv
        
end
