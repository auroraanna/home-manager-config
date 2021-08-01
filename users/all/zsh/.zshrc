# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Initial Setup
#touch "$HOME/.cache/zshhistory

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zshhistory
setopt appendhistory

# ex - archive extractor
## usage: ex <file>
ex ()
{
	if [ -f $1 ] ; then
		case $1 in
			*.tar.bz2)	tar xjf $1						;;
			*.tar.gz)	tar xzf $1						;;
			*.tar.xz)	tar xJf $1						;;
			*.bz2)	bunzip2 $1						;;
			*.rar)	unrar x $1						;;
			*.gz)		gunzip $1						;;
			*.tar)	tar xf $1						;;
			*.tbz2)	tar xjf $1						;;
			*.tgz)	tar xzf $1						;;
			*.zip)	unzip $1						;;
			*.Z)		uncompress $1					;;
			*.7z)		7z x $1						;;
			*)		echo "'$1' cannot be extracted via ex()"	;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		   # Include hidden files.

# Custom ZSH Binds
bindkey '^ ' autosuggest-accept

# Lines configured by zsh-newuser-install
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$HOME/.zshrc'

alias zshrc='${EDITOR} ~/.zshrc' # Quick access to the ~/.zshrc file
alias aliases='${EDITOR} ~/.aliases' # Quick access to the ~/.aliases file

alias grep='grep --color'
alias sgrep='grep -R -n -H -C 5 --exclude-dir={.git,.svn,CVS} '

alias t='tail -f'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g L="| less"
alias -g M="| most"
alias -g LL="2>&1 | less"
alias -g CA="2>&1 | cat -A"
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"
alias -g P="2>&1| pygmentize -l pytb"

alias fd='find . -type d -name'
alias ff='find . -type f -name'

alias h='history'
alias hgrep="fc -El 0 | grep"
alias help='man'
alias p='ps -f'
alias sortnr='sort -n -r'
alias unexport='unset'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Enable colors:
autoload -U colors && colors

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

freshfetch