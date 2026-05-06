set fish_greeting ""


if status is-interactive
    if not set -q TMUX
        tmux new-session -A -s main
    end

    zoxide init fish | source
    alias cd="z"
    alias cat="batcat"
    alias ls="eza --icons"
end
