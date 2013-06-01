function fish_prompt --description 'My Prompt'
	set -l white (set_color -o white)
	set -l red (set_color -o red)
	set -l blue (set_color -o blue)
	set -l cwd $white(prompt_pwd)
	if [ (git_branch_name) ]
		set git_info " ($red"(git_branch_name)
		if [ (git_repo_dirty) ]
			set git_info "$git_info*"
		end
		set git_info "$git_info$blue)"
	end
	echo -n -s $cwd $blue $git_info ' % '
	set_color normal
end
