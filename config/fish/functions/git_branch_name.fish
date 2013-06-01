function git_branch_name --description 'Name of the current branch of the repository'
	echo (git symbolic-ref HEAD 2>/dev/null | sed 's#refs/heads/##')
end
