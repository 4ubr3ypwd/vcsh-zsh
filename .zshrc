#!/bin/zsh

# Don't show last login message anymore.
touch "$HOME/.hushlogin"

# Make sure keys and identities make it into keychain.
ssh-add -q -A -k >/dev/null 2>&1

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
export COMPOSER_PROCESS_TIMEOUT=15 # Fail after 15 seconds.

###
 # macOS Default Flags
 #
 # Note, if you modify please delete the $flagfile
 #
 # @since Thursday, 10/1/2020
 ##
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true;
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write com.apple.TextEdit SmartQuotes -bool false
defaults write com.apple.TextEdit SmartDashes -bool false
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.dteoh.SlowQuitApps invertList -bool YES # Make whitelist a blacklist
defaults write com.dteoh.SlowQuitApps delay -int 1000 # On whitelisted apps, quit after 3 seconds
defaults write com.apple.screencapture location "$screenshots_dir"
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.Finder QuitMenuItem 1 # Add quit to Finder
defaults write com.apple.dock springboard-columns -int 7 && defaults write com.apple.dock springboard-rows -int 7 # Launchpad Grid
defaults write com.apple.Dock autohide-delay -float 0 # Show dock after X seconds, e.g. 99 could hide it.
defaults write com.apple.dock showhidden -bool false # When Apps are hidden, dim them in Dock.
defaults write com.apple.dock static-only -bool false # Only show running apps in Dock (when set to true)
defaults write com.googlecode.iterm2 "Secure Input" 0 # Tell iterm2 to allow non-secure input for escape

###
 # Make sure that Greenshot Screenshots make it to the ~/Pictures/Screenshots/Greenshot folder.
 #
 # @since Thursday, 10/1/2020
 ##
[[ -d "$HOME/Pictures/Greenshot" ]] || $(
	mkdir -p "$HOME/Pictures/Screenshots/Greenshot"
	ln -sf "$HOME/Pictures/Screenshots/Greenshot" "$HOME/Pictures/Greenshot"
)


###
 # Enable history between panels.
 #
 # @since Thursday, 10/1/2020
 ##
unsetopt inc_append_history
unsetopt share_history

###
 # ghq Repositories
 #
 # For repositories you want to persist on your system, add them below.
 # This uses ghq to try and (silently) install repositories you want installed.
 #
 # @since Wednesday, 9/23/2020
 ##
if [[ ! -f "/usr/local/bin/ghq" ]]; then
	echo "Please install ghq and reload to install persistent repos:"
	echo "  brew install ghq"
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
 # Hidden/Unhidden files
 #
 # @since Thursday, 10/1/2020
 ##
chflags hidden "$HOME/Applications"
chflags nohidden "$HOME/Library"

###
 # Bail if oh-my-zsh isn't installed yet.
 #
 # @since Thursday, 10/1/2020
 ##
if [ ! -e "$ZSH" ]; then
	echo ".oh-my-zsh isn't installed!"
	echo "  https://ohmyz.sh/#install"
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
	echo "Please install antigen and reload to install ZSH plugins:"
	echo "  Homebrew: brew reinstall antigen"
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

	# My Plugins:
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-x
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-reload
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-require
		# export REQUIRE_AUTO_INSTALL="off" # Un-comment to disable autoinstall.

	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-fzf-git-branch
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-tdl
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-hide
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-delete
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-comment
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-pwdcp
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-cvideo
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-yt2mp3
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-fd
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-download
	antigen bundle ssh://git@github.com/WebDevStudios/zsh-plugin-satisbuild.git
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-bruse.git

	antigen apply
fi

###
 # Required Commands
 #
 # @see   https://github.com/aubreypwd/zsh-plugin-require Uses this bundle to run require function/command.
 #
 # @since Friday, 10/2/2020 The initial ones.
 ##
require "brew" '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'
	require "curl" "brew reinstall curl"  "brew"
	require "wget" "brew reinstall wget" "brew"
	require "svn" "brew reinstall subversion" "brew"
	require "trash" "brew reinstall trash-cli" "brew"
		require "trash-empty" "brew reinstall trash-cli" "brew"
	require "wp" "brew reinstall wp-cli" "brew"
	require "composer" "brew reinstall composer" "brew"
	require "hcl" "gem install hcl && hcl config -r"
	require "slack" "brew tap rockymadden/rockymadden && brew reinstall rockymadden/rockymadden/slack-cli && slack init"
	require "fzf" "brew reinstall fzf" "brew"
	require "nativefier" "brew reinstall nativefier" "brew"
	require "python" "brew reinstall python" "brew"
		require "rainbow" "easy_install rainbow" "easy_install" # Colorize less.
	require "npm" "brew reinstall node" "brew" # Also installs node.
	require "git" "brew reinstall git" "brew"
	require "watch" "brew reinstall watch" "brew"
	require "watchexec" "brew reinstall watchexec" "brew"
	require "ffmpeg" "brew reinstall ffmpeg" "brew"
		require "gifify" "brew reinstall gifify" "brew"

###
 # Aliases
 #
 # @since Thursday, 10/1/2020 Moved over from .config
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
