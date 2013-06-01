function git_repo_dirty --description 'Is the current branch dirty?'
	echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end
