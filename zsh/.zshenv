if [ -d "$PATH/.bin" ] && [[ ":$PATH:" != *":${HOME}/.bin:"* ]]; then
   export PATH="$HOME/.bin:$PATH"
fi
