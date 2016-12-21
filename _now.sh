
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

    if [[ ${cur} == -* ]] ; then
        COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
	return 0
    fi
    #echo -e "\nCOMP_WORDS ${COMP_WORDS}; COMP_CWORD ${COMP_CWORD}; COMP_LINE ${COMP_LINE}; COMP_POINT ${COMP_POINT}; COMP_TYPE ${COMP_TYPE}; COMP_WORDBREAKS ${COMP_WORDBREAK}; COMP_KEY ${COMP_KEY};" 1>&2

    # change these as needed
    projects="/Users/danielpatru/Dropbox/.projects"
    nowfile="/Users/danielpatru/Dropbox/.now"
    
    # set the separator to new line
    local IFS=$'\n'
    # Don't expand files
    local GLOBIGNORE='*'
    # current word
    w="${COMP_WORDS[COMP_CWORD]}"
    # current word escaped
    qw="$(printf %q "$w")"
    # current word in quotes and escaped
    sw="$(perl -we '$_ = shift @ARGV; s/^'"'"'//; s/'"'"'$//; print;' "${w}" )"
    qsw="$(printf %q "${sw}")"
    COMPREPLY=( $(compgen -W "$(cat $projects | perl -wple "s/(.*)/'"'$1'"'/" | perl -wnle 'BEGIN{$w=shift @ARGV;} if (! $w) {print; if (s/^(.)[\d\. ]+(.*)$/$1$2/) {print;}} elsif (/^.$w/) {print;} elsif (s/^(.)[\d\. ]+$w/$1$w/) {print;}' ${sw} 2> /dev/null ; tail $nowfile 2> /dev/null | perl -nE 'say $1 if /^[\d-: ]+(.*)/;' )" -- ${cur} 2> /dev/null ) )

    return 0
    
}
# complete -P \" -S \" -F _now now
complete -o nospace -F _now now
