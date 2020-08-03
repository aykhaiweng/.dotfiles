# If we can detect the ZSH_VERSION source the zshrc file
if [ -n "$ZSH_VERSION" ]; then
   source ~/.zshrc
else
   source ~/.bashrc
fi