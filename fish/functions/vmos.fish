function vmos --wraps='ssh os@192.128.122.217' --wraps='ssh os@192.18.122.217' --wraps='ssh os@192.168.122.217' --wraps='ssh os@192.168.122.51' --wraps='ssh os@advos' --description 'alias vmos=ssh os@advos'
  ssh os@advos $argv
        
end
