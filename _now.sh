
#!env bash
# set -x
# run to enable autocompletion.

_now() 
{
    # This function is called by the shell when it's time to autocomplete.
    # At the time of calling, the following environmental valiables are set:
    # COMP_WORDS= Array of words on the line so far
    # COMP_CWORD= index into COMP_WORDS of the word to be completed
    #
    # This script will set the environmental (array) variable COMPREPLY.

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
	w="${COMP_WORDS[COMP_CWORD]}"
	qw="$(printf %q "$w")"
	sw="$(perl -we '$_ = shift @ARGV; s/^'"'"'//; s/'"'"'$//; print;' "${w}" )"
	qsw="$(printf %q "${sw}")";
	echo -e "w: ${w}; qw: ${qw}; sw: ${sw}; qsw: ${qsw};" | perl -ple 'BEGIN {print "\nbasic vars";}' 1>&2
	echo "$(cat $projects | perl -wple "s/(.*)/'"'$1'"'/" | fgrep "${sw}" )" | perl -ple 'BEGIN {print 1;}' 1>&2
	echo "$(cat $projects | perl -wple "s/(.*)/'"'$1'"'/" | fgrep "${sw}" | perl -wple 'BEGIN {$w=shift; print "w = $w";} if (/^$w$/ && 0) { '"s/^'(\d+\.?\d*|\d*.\?\d+)/'/;"' }' "${w}")" | perl -ple 'BEGIN {print 2;} END {print "done";};' 1>&2
	COMPREPLY=( $(cat $projects | perl -wple "s/(.*)/'"'$1'"'/" | fgrep "${sw}" | perl -wple 'BEGIN {$w=shift;} if (/^$w$/ && 0) { '"s/^'(\d+\.?\d*|\d*.\?\d+)/'/;"' }' ${qw}) )
        return 0
    fi
}
# complete -P \" -S \" -F _now now
complete -o nospace -F _now now
