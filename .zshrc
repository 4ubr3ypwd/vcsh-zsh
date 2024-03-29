#!/bin/zsh

setopt no_monitor # For commands below eding in &, do not report done when running in background.

# Make sure that we have our Screenshot folders.
mkdir -p "$HOME/Pictures/Screenshots/Dropshare" &> /dev/null &
mkdir -p "$HOME/Pictures/Screenshots/Greenshot" &> /dev/null &
mkdir -p "$HOME/Pictures/Screenshots/Licecap" &> /dev/null &
mkdir -p "$HOME/Pictures/Screenshots/macOS" &> /dev/null &
mkdir -p "$HOME/Movies/Zoom" &> /dev/null &

# Don't show last login message, e.g. you have mail, etc.
touch "$HOME/.hushlogin"

# Make sure keys and identities make it into keychain.
ssh-add -q -A -k &> /dev/null &

###
 # PATH
 #
 # @since Thursday, 10/1/2020
 ##
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH="/Applications/Sublime Merge.app/Contents/SharedSupport/bin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
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
 # Nobs for compilers to find openssl@1.1
 #
 # @since Thursday, 10/1/2020
 ##
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig" # For pkg-config to find openssl@1.1 you may need to set:

###
 # macOS Default Flags
 #
 # @since Thursday, 10/1/2020
 ##
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true &> /dev/null &
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false &> /dev/null &
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false &> /dev/null &
defaults write com.apple.TextEdit SmartQuotes -bool false &> /dev/null &
defaults write com.apple.TextEdit SmartDashes -bool false &> /dev/null &
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false &> /dev/null &
defaults write com.dteoh.SlowQuitApps invertList -bool YES &> /dev/null & # Make whitelist a blacklist
defaults write com.dteoh.SlowQuitApps delay -int 1000 &> /dev/null & # On whitelisted apps, quit after 3 seconds
defaults write com.apple.screencapture location "$screenshots_dir"
defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.Finder QuitMenuItem 1 &> /dev/null & # Add quit to Finder
defaults write com.apple.dock springboard-columns -int 7
defaults write com.apple.dock springboard-rows -int 7 &> /dev/null & # Launchpad Grid
defaults write com.apple.Dock autohide-delay -float 0 &> /dev/null & # Show dock after X seconds, e.g. 99 co
defaults write com.apple.dock showhidden -bool false &> /dev/null & # When Apps are hidden, dim them in Dock.
defaults write com.apple.dock static-only -bool false &> /dev/null & # Only show running apps in Dock (when set to true)
defaults write com.googlecode.iterm2 "Secure Input" 0 &> /dev/null & # Tell iterm2 to allow non-secure input for escape
defaults write com.apple.screencapture type jpg # Take jpg screenshots.

###
 # Configure Greenshots Screenshots Location
 #
 # Make sure that Greenshot Screenshots make it to:
 #
 #     ~/Pictures/Screenshots/Greenshot
 #
 # @since Thursday, 10/1/2020
 ##
[[ -d "$HOME/Pictures/Greenshot" ]] || $(
	# Link Greenshot's default location to the new one.
	mkdir -p "$HOME/Pictures/Screenshots/Greenshot" \
		&& ln -sf "$HOME/Pictures/Screenshots/Greenshot" "$HOME/Pictures/Greenshot" &> /dev/null &
)

###
 # Enable history between panels.
 #
 # @since Thursday, 10/1/2020
 ##
unsetopt inc_append_history
unsetopt share_history

###
 # Load a .zshrc file that you aren't tracking in VCS.
 #
 # @since Thursday, 10/1/2020
 ##
if [ -f "$HOME/.zshrc.secure" ]; then
	source "$HOME/.zshrc.secure"
fi

###
 # iTerm2 History Support
 #
 # @since Monday, 9/21/2020
 ##
test -e "${HOME}/.iterm2_shell_integration.zsh" \
	&& source "${HOME}/.iterm2_shell_integration.zsh" &> /dev/null &

###
 # Terminus for Sublime Text 3 Support
 #
 # @since Monday, 9/21/2020
 ##
if [ "$TERM_PROGRAM" = "Terminus-Sublime" ]; then
	bindkey "\e[1;3C" forward-word &> /dev/null &
	bindkey "\e[1;3D" backward-word &> /dev/null &
fi

###
 # Load fzf autocomplete.
 #
 # @since Thursday, 10/1/2020
 ##
[ -f ~/.fzf.zsh ] \
	&& source ~/.fzf.zsh &> /dev/null &

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
chflags hidden "$HOME/Applications" &> /dev/null &
chflags nohidden "$HOME/Library" &> /dev/null &
chflags hidden "$HOME/.Brewfile" &> /dev/null &

###
 # Bail if oh-my-zsh isn't installed yet.
 #
 # @since Thursday, 10/1/2020
 ##
if [ ! -e "$ZSH" ]; then
	echo ".oh-my-zsh isn't installed!"
	echo "  Install: https://ohmyz.sh/#install"
	return
fi

###
 # Builtin Plugins
 #
 # - Must be done before you shource oh-my-zsh.
 #
 # @since 10/1/20
 ##
plugins=(
	aubreypwd # Should be symlinked to .config (will go away soon)
)

###
 # Theme
 #
 # - Must be done before you shource oh-my-zsh.
 #
 # @since Monday, 9/21/2020 frisk
 # @since 10/1/20           ys
 # @since Wednesday, 10/7/2020 Switched to refined for more simplicity.
 ##
ZSH_THEME="refined"

###
 # Load oh-my-zsh now that it's been configured.
 #
 # - Should happen AFTER plugins and theme's are defined.
 #
 # @since Thursday, 10/1/2020 Added
 ##
source $ZSH/oh-my-zsh.sh

###
 # Antigen Plugin Manager
 #
 # I use Antigen to source my various zsh functions and aliases.
 #
 # - Think of "bundle" as "plugin".
 # - E.g. `Tarrasch/zsh-bd` should clone from Github by default
 # - Cloning using ssh URL ensures the resutling clone is contributable upstream with 2FA
 #
 # @see   $HOME/.antigen/bundle                 Where the repos are cloned and sourced from.
 # @see   https://github.com/zsh-users/antigen  Antigen download and info.
 #
 # @since Monday, 9/21/2020
 ##
if [[ ! -f "/usr/local/share/antigen/antigen.zsh" ]]; then
	echo "Please install antigen and reload to install ZSH plugins:"
	echo "  Homebrew: brew reinstall antigen"
else
	source /usr/local/share/antigen/antigen.zsh # brew install antigen

	# Builtin:
	antigen bundle git
	antigen bundle wp-cli
	antigen bundle svn
	antigen bundle git-extras
	antigen bundle history-substring-search
	antigen bundle osx
	antigen bundle z

	# Others:
	antigen bundle Tarrasch/zsh-bd

	# My Plugins:
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-x
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-reload
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-require  # export REQUIRE_AUTO_INSTALL="off" # Un-comment to disable autoinstall.
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
	antigen bundle ssh://git@github.com/aubreypwd/zsh-plugin-vcshr.git

	antigen apply
fi

###
 # Required Commands
 #
 # - Note, if antigen above hasn't installed yet, a reload will install require and install the below.
 #
 # @see   https://github.com/aubreypwd/zsh-plugin-require Uses this bundle to run require function/command.
 # @since Friday, 10/2/2020                               The initial ones.
 ##
if [[ ! $( command -v require ) ]]; then
	echo "Could not find the 'require' function."
	echo "  Please install: https://github.com/aubreypwd/zsh-plugin-require"
else

	###
	 # Install homebrew.
	 #
	 # E.g: brew
	 #
	 # @since Friday, 10/2/2020
	 # @see   https://brew.sh
	 ##
	require "brew" '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"' &> /dev/null &

	###
	 # Install package managers from homebrew.
	 #
	 # Also installs gem
	 #
	 # @since Friday, 10/2/2020
	 ##
	require "composer" "brew reinstall composer" "brew" &> /dev/null & # Composer, @see https://composer.org
	require "npm" "brew reinstall node" "brew" &> /dev/null & # Also installs node.
	require "python" "brew reinstall python" "brew" &> /dev/null & # Installs pip3 and easy_install
	require "ruby" "brew reinstall ruby" "brew" &> /dev/null & # Installs gem

	###
	 # Install repo managers.
	 #
	 # @since Friday, 10/2/2020
	 ##
	require "ghq" "brew reinstall ghq" "brew" &> /dev/null &
	require "vcsh" "brew reinstall vcsh" "brew" &> /dev/null &

	###
	 # Homebrew Requirements
	 #
	 # @since Friday, 10/2/2020
	 # @see   https://brew.sh
	 ##
	require "curl" "brew reinstall curl" "brew" &> /dev/null &
	require "m" "brew reinstall m" "brew" &> /dev/null &
	require "git" "brew reinstall git" "brew" &> /dev/null &
	require "svn" "brew reinstall subversion" "brew" &> /dev/null &
	require "ffmpeg" "brew reinstall ffmpeg" "brew" &> /dev/null &
	require "fzf" "brew reinstall fzf" "brew" &> /dev/null &
	require "gifify" "brew reinstall gifify" "brew" &> /dev/null &
	require "nativefier" "brew reinstall nativefier" "brew" &> /dev/null &
	require "slack" "brew tap rockymadden/rockymadden && brew reinstall rockymadden/rockymadden/slack-cli && slack init" &> /dev/null &
	require "trash" "brew reinstall trash-cli" "brew" &> /dev/null &
	require "trash-empty" "brew reinstall trash-cli" "brew" &> /dev/null &
	require "watch" "brew reinstall watch" "brew" &> /dev/null &
	require "watchexec" "brew reinstall watchexec" "brew" &> /dev/null &
	require "wget" "brew reinstall wget" "brew" &> /dev/null &
	require "wp" "brew reinstall wp-cli" "brew" &> /dev/null &

	###
	 # Non-homebrew Requirements
	 #
	 # @since Friday, 10/2/2020
	 ##
	require "hcl" "gem install hcl && hcl config -r" &> /dev/null &
	require "rainbow" "easy_install rainbow" "easy_install" &> /dev/null & # Colorize less.
fi

###
 # ghq Persistent Repositories
 #
 # For repositories you want to persist on your system, add them below.
 # This uses ghq to try and (silently) install repositories you want installed.
 #
 # @since Wednesday, 9/23/2020
 ##
if [[ ! $( command -v ghq ) ]]; then
	echo "Please install ghq and reload to install persistent repos:"
	echo "  Homebrew: brew install ghq"
else
	ghq get -p -s git@github.com:aubreypwd/Alfred.alfredpreferences.git &> /dev/null &
	ghq get -p -s git@github.com:aubreypwd/config.git &> /dev/null &
	ghq get -p -s git@github.com:aubreypwd/iTerm2.git &> /dev/null &
	ghq get -p -s git@github.com:aubreypwd/aubreypwd.github.io-hugo.git &> /dev/null &
	ghq get -p -s git@github.com:aubreypwd/sql-queries.git &> /dev/null &
fi

###
 # Require VCSH Repositories and ensure ignore is setup for each.
 #
 # @since Friday, 10/2/2020
 # @see https://github.com/aubreypwd/zsh-plugin-vcshr vcshr command.
 ##
if [[ ! $( command -v vcsh ) ]]; then
	echo "Could not find command 'vcsh', please reinstall and reload."
	echo "  Homebrew: brew require vcsh"
else

	# Require each and setup ignore.
	vcshr "brew" "aubreypwd" "vcsh-brew" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "choosy" "aubreypwd" "vcsh-choosy" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "composer" "aubreypwd" "vcsh-composer" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "git" "aubreypwd" "vcsh-git" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "brew" "aubreypwd" "vcsh-brew" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "node" "aubreypwd" "vcsh-node" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "specktacle" "aubreypwd" "vcsh-specktacle" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "st3-snippets" "aubreypwd" "vcsh-st3-snippets" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "st3" "aubreypwd" "vcsh-st3" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "zsh-secure" "aubreypwd" "vcsh-zsh-secure" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "zsh" "aubreypwd" "vcsh-zsh" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "ssh" "aubreypwd" "vcsh-ssh" --overwrite --autoignore --ssh &> /dev/null &
	vcshr "vim" "aubreypwd" "vcsh-vim" --overwrite --autoignore --ssh &> /dev/null &

	# Make sure all these auto ignore all files (must add via -f).
	vcsh write-gitignore brew &> /dev/null &
	vcsh write-gitignore choosy &> /dev/null &
	vcsh write-gitignore composer &> /dev/null &
	vcsh write-gitignore git &> /dev/null &
	vcsh write-gitignore node &> /dev/null &
	vcsh write-gitignore specktacle &> /dev/null &
	vcsh write-gitignore st3-snippets &> /dev/null &
	vcsh write-gitignore st3 &> /dev/null &
	vcsh write-gitignore zsh-secure &> /dev/null &
	vcsh write-gitignore zsh &> /dev/null &
	vcsh write-gitignore ssh &> /dev/null &
	vcsh write-gitignore vim &> /dev/null &
fi

###
 # Aliases
 #
 # @since Thursday, 10/1/2020 Moved over from .config
 ##
alias edit="subl -n"
	alias e="edit"
	alias editzsh="subl -n ~/.zshrc"
		alias ezsh="editzsh"
	alias editgit="subl -n ~/.gitconfig"
		alias egit="editgit"
	alias editssh="subl -n ~/.ssh/config"
		alias essh="editssh"

alias vc="vcsh"
alias ls='ls -laGFh'
alias c=clear
alias tower='gittower'

# Easy composer commands.
alias cu="composer uninstall"
alias cis="composer install --prefer-source" # source install.
alias cid="composer install --prefer-dist" # dist install.
alias crd="composer uninstall && composer install --prefer-dist" # reinstall with dist.
alias crs="composer uninstall && composer install --prefer-source" # reinstall with source.
alias ccc="composer clearcache && composer global clearcache"

# Composer versions
alias c@2="composer self-update --2"
alias c@1="composer self-update --1"

# Fuzzy find at certain levels easily.
alias fdd="fd 2" # Two levels.
alias fd!="fd 10" # Deeper.
	alias goto="fd!" # Just an easier way to get to fd!.
alias fd~="fd 50" # Super deep.

# Misc.
alias vim="vim -c 'startinsert'" # Start Vim in insert mode (mostly for commit writing).
alias repo="cd ~/Repos && fdd" # An easy way to get to a repo using my ffd command.

alias locals="cd ~/Sites/Local && fd 3" # An easy way to get to a local.
	alias localsite="locals"
	alias loc="locals"

# npm install's.
alias npmib="n auto && npm i && npm run build"

# npm install, build, and DEV
alias npmid="n auto && npm i && (npm run dev || npm run watch || npm run start || true)"
alias npmibd="n auto && npm i && npm run build && (npm run dev || npm run watch || npm run start || true)"

# Homebrew
alias brewdump="brew bundle dump --file=$HOME/.Brewfile --verbose --all --describe --force --no-lock && vcsh brew diff && vcsh brew status" # Dump what's installed to my Brewfile
	alias brewout="brewdump"
	alias brewd="brewdump"

# Sounds
alias bell="tput bel"
alias beep="bell"
alias b="bell"

# jq: package.json
alias jqps="jq .scripts package.json"
alias jqpi="jq .dependancies package.json"

# jq: composer.json
alias jqcs="jq .scripts composer.json"
alias jqci="jq .require composer.json"

# diff folders
alias difff="diff -rq" # Diff a directory.

###
 # Compress a Video using ffmpeg+crf
 #
 # E.g: ffmpeg+compress-video "original-file.mp4" <crf>
 # E.g: ffmpeg+compress-video "original-file.mp4" 32
 #
 # @since Tuesday, 5/18/2021
 ##
function compressv {

	OUT="libx264-crf-$2-$1"

	if [ -z "$2" ]; then

		echo "Please specify crf as 2nd parameter."
		return
	fi

	ffmpeg -i "$1" -vcodec libx264 -crf $2 "$OUT"
}
alias compress:video="compressv"

###
 # Misc Nobs
 #
 # @since Friday, 10/2/2020
 ##
export COMPOSER_PROCESS_TIMEOUT=60 # Fail after x seconds.
export LESS="-F -X $LESS" # Don't pager on less.
export MANPAGER='ul | cat -s' # Don't use less.

composer self-update --1 &> /dev/null & # Use Composer Version 1 for now...

###
 # Editors.
 #
 # @since Thursday, 5/13/2021
 ##
export EDITOR='vim'
export GIT_EDITOR='vim'
export VISUAL='vim'
