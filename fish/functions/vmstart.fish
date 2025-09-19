function vmstart --wraps=' sudo virsh start os' --wraps='sudo virsh start os' --wraps='sudo virsh start advos' --description 'alias vmstart=sudo virsh start advos'
  sudo virsh start advos $argv
        
end
