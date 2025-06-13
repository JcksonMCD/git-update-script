# git-update-script
The script needs to cycle through all the git repo folders in this new folder.  
The script once in the folder has to:  
Find the "main" branch  
Checkout the main branch,  
Pull  
Checkout your target branch  
Pull  
Rebase the target branch with the "main" branch  
Check if any errors occoured, if yes print error, if no do a "git push -f"  
Cycle to next repo  
