
# run to enable autocompletion.

_now() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    pCOMP_CWORD="$[COMP_CWORD-1]"
    opts="--help --verbose --version"
    
    projects="/Users/danielpatru/Dropbox/.projects"

    if [[ ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
        return 0
    else
        local IFS=$'\n' 
        local GLOBIGNORE='*'
	line="${COMP_WORDS[@]:1}"
	pline="${COMP_WORDS[@]:1:pCOMP_CWORD}"
        read -d '' -r -a lines < $projects
	COMPREPLY=( $(env line="$line" pline="$pline" perl -lne 'if (/^$ENV{line}/) { $_ =~ s/^$ENV{pline}//; $_ =~ s/([^a-zA-Z0-9])/\\$1/g; print $_; }' $projects) )
	# echo -e "\n$COMP_CWORD:${pline}:${line}:${COMPREPLY[@]}"
        return 0
    fi
}
# complete -P \" -S \" -F _now now
complete -o nospace -F _now now