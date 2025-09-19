function vmos --wraps='ssh os@192.128.122.217' --wraps='ssh os@192.18.122.217' --wraps='ssh os@192.168.122.217' --wraps='ssh os@192.168.122.51' --description 'alias vmos=ssh os@192.168.122.51'
  ssh os@192.168.122.51 $argv
        
end
