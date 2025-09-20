if status is-interactive
    # Commands to run in interactive sessions can go here
end
starship init fish | source

# If systemd has set SSH_AUTH_SOCK, export it
if set -q SSH_AUTH_SOCK
    set -x SSH_AUTH_SOCK $SSH_AUTH_SOCK
end

thefuck --alias | source
