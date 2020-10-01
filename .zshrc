###
 # PATH
 #
 # @since Thursday, 10/1/2020
 ##
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/Applications/Sublime Merge.app/Contents/SharedSupport/bin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/lib/node_modules:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.6.0/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.3.0/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH" # If you need to have openssl@1.1 first in your PATH run
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

###
 # For compilers to find openssl@1.1 you may need to set:
 #
 # @since Thursday, 10/1/2020
 ##
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig" # For pkg-config to find openssl@1.1 you may need to set:

###
 # Enable history between panels.
 #
 # @since Thursday, 10/1/2020
 ##
unsetopt inc_append_history
unsetopt share_history

###
 # Aliases
 #
 # @since Thursday, 10/1/2020
 ##
alias edit="subl -n"
alias v="vcsh"

###
 # ghq Repositories
 #
 # For repositories you want to persist on your system, add them below.
 # This uses ghq to try and (silently) install repositories you want installed.
 #
 # @since Wednesday, 9/23/2020
 ##
if [[ ! -f "/usr/local/bin/ghq" ]]; then
	echo "Please install ghq:"
	echo "\tbrew install ghq"
	echo "\treload"
else
	ghq get git@github.com:aubreypwd/Alfred.alfredpreferences.git &> /dev/null
	ghq get git@github.com:aubreypwd/system.git &> /dev/null
	ghq get git@github.com:aubreypwd/iTerm2.git &> /dev/null
fi

###
 # Load a .zshrc file that you aren't tracking in VCS.
 #
 # @since Thursday, 10/1/2020
 ##
if [ -e "$HOME/.zshrc.secure" ]; then
	source "$HOME/.zshrc.secure"
fi

###
 # iTerm2 History Support
 #
 # @since Monday, 9/21/2020
 ##
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

###
 # Terminus for Sublime Text 3 Support
 #
 # @since Monday, 9/21/2020
 ##
if [ "$TERM_PROGRAM" = "Terminus-Sublime" ]; then
	bindkey "\e[1;3C" forward-word
	bindkey "\e[1;3D" backward-word
fi

###
 # Load fzf autocomplete.
 #
 # @since Thursday, 10/1/2020
 ##
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###
 # ZSH & oh-my-zsh Specific Configs
 #
 # E.g:
 #
 # @since Thursday, 10/1/2020
 ##
export UPDATE_ZSH_DAYS=90
export ZSH="$HOME/.oh-my-zsh" # Path to your oh-my-zsh installation.

###
 # Bail if oh-my-zsh isn't installed yet.
 #
 # @since Thursday, 10/1/2020
 ##
if [ ! -e "$ZSH" ]; then
	echo ".oh-my-zsh isn't installed!"
	echo "\thttps://ohmyz.sh/#install"
	exit;
fi

###
 # Load oh-my-zsh now that it's been configured.
 #
 # @since Thursday, 10/1/2020
 ##
source $ZSH/oh-my-zsh.sh

###
 # Theme
 #
 # @since Monday, 9/21/2020 frisk
 ##
ZSH_THEME="frisk"

###
 # Builtin Plugins
 ##
plugins=(
	aubreypwd # Should be symlinked to .config
)

###
 # Configure my prompt.
 #
 # @see .oh-my-zsh/themes/frisk.zsh-theme Based on the frisk ZSH theme.
 #
 # @since Thursday, 10/1/2020
 ##
PROMPT=$'
%{$fg[red]%}%2/%{$reset_color%} $(git_prompt_info)$(bzr_prompt_info)% %{$fg[black]%}[%T]%{$reset_color%}
%{$fg_bold[black]%}$%{$reset_color%} '

###
 # Antigen Plugin Manager
 #
 # @see https://github.com/zsh-users/antigen
 # @since Monday, 9/21/2020
 ##
if [[ ! -f "/usr/local/share/antigen/antigen.zsh" ]]; then
	echo "Please install antigen:"
	echo "\tbrew reinstall antigen"
	echo "\treload"
else
	source /usr/local/share/antigen/antigen.zsh # brew install antigen

	antigen bundle git # Builtin
	antigen bundle wp-cli # Builtin
	antigen bundle svn # Builtin
	antigen bundle git-extras # Builtin
	antigen bundle history-substring-search # Builtin
	antigen bundle osx # Builtin
	antigen bundle z # Builtin
	antigen bundle Tarrasch/zsh-bd
	antigen bundle aubreypwd/zsh-plugin-x
	antigen bundle aubreypwd/zsh-plugin-reload

	antigen apply
fi
