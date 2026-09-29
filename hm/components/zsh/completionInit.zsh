#!bin/zsh

autoload -Uz compinit

local zdot="${ZDOTDIR:-$HOME/.zsh}"
local dump="$zdot/.zcompdump"

rm -f -- "$zdot"/.zcompdump.*(N.mh+1) 2>/dev/null

if [[ -n "$dump"(#qN.mh+24) ]]; then
  compinit -C -d "$dump"
else
  compinit -d "$dump"
fi

autoload -Uz bashcompinit && bashcompinit

if whence complete >/dev/null 2>&1 && command -v aws_completer >/dev/null 2>&1; then
	complete -C "$(command -v aws_completer)" aws
fi

if command -v senv >/dev/null; then
	source <(senv completion zsh)
fi

zstyle ':completion::complete:make::' tag-order targets variables
