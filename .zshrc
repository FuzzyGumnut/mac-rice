# -------------------------------
# 🚀 PATH Configuration
# -------------------------------
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/aircrack-ng/bin:$PATH"
export PATH="/Users/bowenduff/.spicetify:$PATH"

# -------------------------------
# ⚡ Run Fastfetch on Startup
# -------------------------------
fastfetch

# -------------------------------
# 🚀 Starship Prompt Initialization
# -------------------------------
eval "$(starship init zsh)"

# -------------------------------
# 🌈 Syntax Highlighting & Autosuggestions
# -------------------------------
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# -------------------------------
# 🏎️ Useful Aliases for Speed
# -------------------------------
alias cls="clear"   # Clear screen
alias ll="ls -lah"  # Detailed file list
alias gs="git status"  # Check Git status
alias py="python3"  # Short Python command
alias update="brew update && brew upgrade"  # Update everything
alias matrix="cmatrix -s"  # Run Matrix rain effect
alias starwars="telnet towel.blinkenlights.nl"  # ASCII Star Wars

# -------------------------------
# 🔥 Custom Command Shortcuts
# -------------------------------
alias fetch="fastfetch"  # Run fastfetch manually
alias ports="sudo lsof -i -P -n | grep LISTEN"  # Check open ports

# -------------------------------
# 🏁 Zsh History Configuration
# -------------------------------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt appendhistory
setopt histignorealldups
setopt incappendhistory
setopt sharehistory
setopt autocd

# Git status prompt integration
source ~/.zsh/gitstatus/gitstatus.plugin.zsh

# Remove Powerlevel10k as you requested
# Removed Powerlevel10k configuration
export PATH="$(brew --prefix)/opt/python@3.13/libexec/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
alias updateall='brew update && brew upgrade && brew upgrade --cask && brew cleanup'
