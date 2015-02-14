#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

shopt -s extglob
shopt -s histappend histreedit histverify
shopt -s cdspell
shopt -s checkhash
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s cmdhist

HISTSIZE=1000
HISTFILESIZE=2000


if [ -f ~/.bash_aliases ]
then
    . ~/.bash_aliases
fi

export PATH=$PATH:~/tools
export EDITOR=vim

complete -cf sudo

