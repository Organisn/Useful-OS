# After git installation
# Before first commit
# Set local account identity
git config --global user.email "tu@esempio.com"
git config --global user.name "Il tuo nome"


# FEDORA SSH KEYS SETUP
# CHECK EXISTING KEYS
ls -al ~/.ssh
# Possible filenames for GitHub public keys:
# id_rsa.pub
# id_ecdsa.pub
# id_ed25519.pub (mine)
# GENERATE NEW SSH KEY
# Replace mail address with that associated with github account
ssh-keygen -t ed25519 -C "emanuele.snidero@gmail.com"
# When you're prompted to "Enter a file in which to save the key (/home/YOU/.ssh/id_ALGORITHM): ", 
# you can press Enter to accept the default file location. Please note that if you created SSH keys previously, 
# ssh-keygen may ask you to rewrite another key, in which case we recommend creating a custom-named SSH key. 
# To do so, type the default file location and replace id_ALGORITHM with your custom key name
# FIRST PASSPHRASE: Passalaffras3!
# The key's randomart image is:
# +--[ED25519 256]--+
# |   ....oo        |
# |    + o .o       |
# |     E o ..    . |
# |    + . o  o    o|
# |   .   oS.  o ...|
# |    .   =oo  ..+ |
# |     o o.O.. .. .|
# |    + =oO=+.  .  |
# |   .o*.===+ ..   |
# +----[SHA256]-----+
# ADD SSH KEY TO SSH AGENT
# Start ssh-agent in the background
eval "$(ssh-agent -s)"
# Add key
# Replace filename with generated key one
ssh-add ~/.ssh/id_ed25519
# ADD SSH KEY TO GITHUB ACCOUNT
# Copy public key file content
cat ~/.ssh/id_ed25519.pub # then CTRL + SHIFT + C
# In the upper-right corner of any page on GitHub, click your profile photo, then click Settings.
# In the "Access" section of the sidebar, click
# SSH and GPG keys.
# Click New SSH key or Add SSH key.
# In the "Title" field, add a descriptive label for the new key. For example, if you're using a personal laptop, you might call this key "Personal laptop".
# Select the type of key, either authentication or signing.
# In the "Key" field, paste your public key.
# Click Add SSH key.
# (for previously cloned repositories) SWITCH REMOTE URLS FROM HTTPS TO SSH
# Change the current working directory to your local project
# List your existing remotes in order to get the name of the remote you want to change.
git remote -v
# origin  https://github.com/OWNER/REPOSITORY.git (fetch)
# origin  https://github.com/OWNER/REPOSITORY.git (push)
# Change your remote's URL from HTTPS to SSH with the git remote set-url command.
git remote set-url origin git@github.com:OWNER/REPOSITORY.git
# Verify that the remote URL has changed.
git remote -v
# origin  git@github.com:OWNER/REPOSITORY.git (fetch)
# origin  git@github.com:OWNER/REPOSITORY.git (push)
