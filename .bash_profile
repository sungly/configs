PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH=~/.local/bin:$PATH
export PATH=$PATH:/Applications/cia.app/Contents/MacOS

# git auto complete
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
export PATH=/usr/local/Cellar/ruby/2.4.1_1/bin:$PATH
export PATH="/usr/local/opt/ruby/bin:$PATH"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
