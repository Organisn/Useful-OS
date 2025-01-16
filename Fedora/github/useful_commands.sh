# PUSH TO REMOTE REPOSITORY STEP-BY-STEP
cd ~/working/directory
	# Option 1
	git clone git@github.com:OWNER/REPOSITORY.git # This won't update files/dirs into ~/working/directory 'cause it will create a new folder called "REPOSITORY" containing the actually cloned repository
	# Option 2
	git init
	git remote add origin git@github.com:OWNER/REPO.git # This will add the remote branch to repo
	git pull origin main # this will not delete or overwrite untracked files or folders as long long as they don't own the same names (otherwise git will simply interrupt the entire pull operation asking to delete or displace those homonymous files/dirs)
# Track previously existing folder files
git add .
git commit -m "Commit message"
git push # -u origin main (origin is the default remote name, main is the default branch on GitHub)

# New branch
git branch branch_name
# List existing branches
git branch --all # or -a
# Switch branch
git checkout branch_name
# Rename current branch (according to GitHub default one, but be aware local "main" won't be automatically associated to remote origin/main...)
git branch -m main # Btw it won't be initiated until first commit
# Set remote tracking infos for current branch
git branch --set-upstream-to=origin/branch_name current_branch_name
# Configure the initial branch name to use in all of your new repositories
git config --global init.defaultBranch main
# Pre-commit stage
git stash
