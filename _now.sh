
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
    
    #echo -e "\nCOMP_WORDS ${COMP_WORDS}; COMP_CWORD ${COMP_CWORD}; COMP_LINE ${COMP_LINE}; COMP_POINT ${COMP_POINT}; COMP_TYPE ${COMP_TYPE}; COMP_WORDBREAKS ${COMP_WORDBREAK}; COMP_KEY ${COMP_KEY};" 1>&2

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
	COMPREPLY=( $(cat $projects | perl -wple "s/(.*)/'"'$1'"'/" | perl -wnle 'BEGIN{$w=shift @ARGV;} if (! $w) {print; if (s/^(.)[\d\. ]+(.*)$/$1$2/) {print;}} elsif (/^.$w/) {print;} elsif (s/^(.)[\d\. ]+$w/$1$w/) {print;}' ${sw}) )
	#echo "COMPREPLY ${COMPREPLY[*]};" 
        return 0
    fi
}
# complete -P \" -S \" -F _now now
complete -o nospace -F _now now
