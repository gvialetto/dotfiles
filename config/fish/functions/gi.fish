function gi --description 'Gitignore.io assisted .gitignore generation'
	curl http://gitignore.io/api/$argv
end
