function serv --wraps='ssh root@100.78.27.68' --wraps='ssh root@serv' --wraps='ssh mche3kek@serv' --description 'alias serv=ssh mche3kek@serv'
  ssh mche3kek@serv $argv
        
end
