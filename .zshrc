# If you come from bash you might have to change your $PATH.
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

# If you need to have openssl@1.1 first in your PATH run:
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

# For compilers to find openssl@1.1 you may need to set:
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

# For pkg-config to find openssl@1.1 you may need to set:
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

sleep "0.$RANDOM$RANDOM$RANDOM$RANDOM$RANDOM" # Fixes issue where loading iTerm arrangements can cause issues, sleeping a few miliseconds per session gives each one time to finish what it's doing.

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

if [ ! -e "$ZSH" ]; then
	echo ".oh-my-zsh isn't installed!"
	return;
fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# ZSH_THEME="minimal_improve"
# ZSH_THEME="blinks"
# ZSH_THEME="amuse"
ZSH_THEME="frisk"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=90

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

(
	thepwd=$(pwd)

	cd "$HOME/.config"

	if [ ! -e "$HOME/.config/symlinked/zshrc/plugins/aubreypwd" ]; then
		git submodule update --init --recursive >/dev/null 2>&1
	fi

	# Make sure the custom plugin is linked.
	OH_MY_ZSH_CUSTOM_PLUGIN="$HOME/.oh-my-zsh/custom/plugins/aubreypwd"

	if [ -e "$OH_MY_ZSH_CUSTOM_PLUGIN" ]; then

		# Remove the old one so the next symlink is always up to date.
		unlink "$OH_MY_ZSH_CUSTOM_PLUGIN"
	fi

	ln -sf "$HOME/.config/symlinked/zshrc/plugins/aubreypwd" "$OH_MY_ZSH_CUSTOM_PLUGIN"

	cd "$thepwd"
)

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	aubreypwd # Should be symlinked to .config
	git
	wp-cli
	svn
	git-extras
	history-substring-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

unsetopt inc_append_history
unsetopt share_history

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

# This is where you put secure things.
if [ -e "$HOME/.zshrc.secure" ]; then
	source "$HOME/.zshrc.secure"
fi

# From /Users/aubreypwd/.oh-my-zsh/themes/frisk.zsh-theme
PROMPT=$'
%{$fg[red]%}%2/%{$reset_color%} $(git_prompt_info)$(bzr_prompt_info)% %{$fg[black]%}[%T]%{$reset_color%}
%{$fg_bold[black]%}$%{$reset_color%} '

# Load NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# load-nvmrc() {
# 	if [[ -f .nvmrc && -r .nvmrc ]] && [[ $(nvm version) != $(nvm version $(cat .nvmrc)) ]]; then
# 		nvm install
# 		nvm use
# 	else
# 		if [[ -f "$HOME/.nvmrc" ]] && [[ $(nvm version) != $(nvm version $(cat "$HOME/.nvmrc")) ]]; then
# 			nvm use $(cat "$HOME/.nvmrc")
# 		fi
# 	fi
# }
# autoload -U add-zsh-hook
# add-zsh-hook chpwd load-nvmrc
# load-nvmrc

# if ! [ -f "$HOME/.nvmrc" ]; then
# 	echo "10" > "$HOME/.nvmrc"
# 	nvm install $(nvm version $(cat "$HOME/.nvmrc"))
# 	nvm use $(cat "$HOME/.nvmrc")
# 	echo "Updated default node (~/.nvmrc) to 10."
# fi

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

export ENHANCD_FILTER=fzf

if ! [[ -d "$HOME/.enhancd" ]]; then
	#git clone https://github.com/b4b4r07/enhancd "$HOME/.enhancd"
	#brew reinstall fzy ccat percol peco fzf
	#source "$HOME/.enhancd/init.sh" # Load enhancd
else
	#source "$HOME/.enhancd/init.sh" # Load enhancd
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh # Load fzf autocomplete.

if [ "$TERM_PROGRAM" = "Terminus-Sublime" ]; then
	bindkey "\e[1;3C" forward-word
	bindkey "\e[1;3D" backward-word
fi
