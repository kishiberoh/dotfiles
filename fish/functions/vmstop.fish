function vmstop --wraps='sudo virsh shutdown advos' --description 'alias vmstop=sudo virsh shutdown advos'
  sudo virsh shutdown advos $argv
        
end
