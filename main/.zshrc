source ~/.aliases
source ~/.profile

export PATH=/usr/local/opt/ccache/libexec:$PATH
export PATH=$HOME/bin:$PATH

export EDITOR='mvim '
export VISUAL='mvim '

# added by Miniconda3 4.3.21 installer
export PATH="/Users/hjp/miniconda3/bin:$PATH"

eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# # pulled from: https://statico.github.io/vim3.html
# # fzf via Homebrew
# if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
#   source /usr/local/opt/fzf/shell/key-bindings.zsh
#   source /usr/local/opt/fzf/shell/completion.zsh
# fi

# # fzf via local installation
# if [ -e ~/.fzf ]; then
#   _append_to_path ~/.fzf/bin
#   source ~/.fzf/shell/key-bindings.zsh
#   source ~/.fzf/shell/completion.zsh
# fi

# fzf + ag configuration
if (( $+commands[fzf] )) && (( $+commands[ag] )); then
  export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  # export FZF_DEFAULT_OPTS='
  # --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  # --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  # '
fi

source "$HOME/.slimzsh/slim.zsh"

# Emacs mode
bindkey -e

unsetopt correct_all
setopt correct

# automatically expand history arguments like !$
# this behavior is similar to bash
unsetopt hist_verify
setopt hist_expand
