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
export LESS="-F -X $LESS" # Don't pager on less.
export MANPAGER='ul | cat -s'

###
 # Enable history between panels.
 #
 # @since Thursday, 10/1/2020
 ##
unsetopt inc_append_history
unsetopt share_history
touch "$HOME/.hushlogin" # Don't show last login message anymore.

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
 # Builtin Plugins
 #
 # Must be done before you shource oh-my-zsh.
 #
 # @since 10/1/20
 ##
plugins=(
	aubreypwd # Should be symlinked to .config
)

###
 # Theme
 #
 # Must be done before you shource oh-my-zsh.
 #
 # @since Monday, 9/21/2020 frisk
 # @since 10/1/20           ys
 ##
ZSH_THEME="ys"

###
 # Load oh-my-zsh now that it's been configured.
 #
 # @since Thursday, 10/1/2020
 ##
source $ZSH/oh-my-zsh.sh

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
	antigen bundle aubreypwd/zsh-plugin-require
	antigen bundle aubreypwd/zsh-plugin-fzf-git-branch
	antigen bundle aubreypwd/zsh-plugin-tdl
	antigen bundle aubreypwd/zsh-plugin-hide
	antigen bundle aubreypwd/zsh-plugin-delete
	antigen bundle aubreypwd/zsh-plugin-comment
	antigen bundle aubreypwd/zsh-plugin-pwdcp

	antigen apply
fi

require "brew" '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'
require "ffmpeg" "brew reinstall ffmpeg"
require "wget" "brew reinstall wget"
require "curl" "brew reinstall curl"
require "svn" "brew reinstall subversion"
require "trash" "brew reinstall trash-cli"
require "trash-empty" "brew reinstall trash-cli"
require "wp" "brew reinstall wp-cli"
require "youtube-dl" "brew reinstall youtube-dl"
require "composer" "brew reinstall composer"
require "hcl" "gem install hcl && hcl config -r"
require "slack" "brew tap rockymadden/rockymadden && brew reinstall rockymadden/rockymadden/slack-cli && slack init"
require "fzf" "brew reinstall fzf"
require "nativefier" "brew reinstall nativefier"
require "rainbow" "brew reinstall python && sudo easy_install rainbow" # Colorize less.
require "npm" "brew reinstall node@10.16.1"
require "git" "brew reinstall git"
require "hcl" "gem install hcl"
require "git-open" "npm install --global git-open"
require "watch" "brew reinstall watch"
require "python" "brew reinstall python"

###
 # Hidden/Unhidden files
 #
 # @since Thursday, 10/1/2020
 # @since Thursday, 10/1/2020 Using hide/unhide from antigen bundle aubreypwd/zsh-plugin-hide
 ##
hide "$HOME/Applications"
unhide "$HOME/Library"

###
 # Aliases
 #
 # @since Thursday, 10/1/2020
 ##
alias edit="subl -n"
alias v="vcsh"
alias ls='ls -laGFh'
alias c=clear
alias tower='gittower'
alias cu="composer uninstall"
alias ci="composer install --prefer-source"
alias cid="composer install --prefer-dist"
alias cr="composer uninstall; composer install"
alias cri="composer uninstall; composer install --prefer-source"
