#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -n "$TMUX" ] && export TERM=screen-256color

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob        # Necessary for programmable completion.

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

if [ -n "$DISPLAY" ]; then
    BROWSER=firefox
else
    BROWSER=links
fi

export EDITOR=vim
export RCC=/home/rsacia/developer/pi/yocto/yoctoProject/raspberryPiBuild/tmp/sysroots/x86_64-linux/usr/bin/armv6-vfp-poky-linux-gnueabi/arm-poky-linux-gnueabi-

complete -cf sudo
alias vi='vim'
alias where='type -a'
alias cdprogf='cd /mnt/windows/Program\ Files\ \(x86\)/'
alias make='make -j9'
alias cd='pushd $@ >/dev/null'
alias ba='popd'

export GREP_COLOR="1;33"
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias chx="chmod +x"
alias svim="sudo vim"
alias cdo="eject /dev/cdrom"
alias cdc="eject -t /dev/cdrom"
alias play="mplayer *"

# svn aliases
alias svn-addall="svn st | grep ^? | awk '{print $2}' | xargs svn add"

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe()
{ find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ; }

# Find a pattern in a set of files and highlight them:
# (needs a recent version of egrep)
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
    Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
            i) case="-i " ;;
        *) echo "$usage"; return;;
    esac
done

shift $(( $OPTIND - 1 ))
if [ "$#" -lt 1 ]; then
    echo "$usage"
    return;
fi

find . -type f -name "${2:-*}" -print0 | \
    xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | less 
}

function ask()          # See 'killps' for example of use.
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

# Kill by process name.
function killps()                 
{
    local pid pname sig="-TERM"   # Default signal.
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
        then kill $sig $pid
        fi
    done
}

# Get IP adresses.
function my_ip() 
{
    MY_IP=$(/sbin/ifconfig ppp0 | awk '/inet/ { print $2 } ' | \
        sed -e s/addr://)
    MY_ISP=$(/sbin/ifconfig ppp0 | awk '/P-t-P/ { print $3 } ' | \
        sed -e s/P-t-P://)
}

# Get current host related info.
function ii()   
{
    echo -e "\nYou are logged on ${RED}$HOST"
    echo -e "\nAdditionnal information:$NC " ; uname -a
    echo -e "\n${RED}Users logged on:$NC " ; w -h
    echo -e "\n${RED}Current date :$NC " ; date
    echo -e "\n${RED}Machine stats :$NC " ; uptime
    echo -e "\n${RED}Memory stats :$NC " ; free
    my_ip 2>&- ;
    echo -e "\n${RED}Local IP Address :$NC" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${RED}ISP Address :$NC" ; echo ${MY_ISP:-"Not connected"}
    echo -e "\n${RED}Open connections :$NC "; netstat -pan --inet;
    echo
}

extract() {
    local c e i

    (($#)) || return

    for i; do
        c=''
        e=1

        if [[ ! -r $i ]]; then
            echo "$0: file is unreadable: \`$i'" >&2
            continue
        fi

        case $i in
            *.t@(gz|lz|xz|b@(2|z?(2))|a@(z|r?(.@(Z|bz?(2)|gz|lzma|xz)))))
                c='bsdtar xvf';;
            *.7z)  c='7z x';;
            *.Z)   c='uncompress';;
            *.bz2) c='bunzip2';;
            *.exe) c='cabextract';;
            *.gz)  c='gunzip';;
            *.rar) c='unrar x';;
            *.xz)  c='unxz';;
            *.zip) c='unzip';;
            *)     echo "$0: unrecognized file extension: \`$i'" >&2
                continue;;
        esac

        command $c "$i"
        e=$?
    done

    return $e
}

# Compression
complete -f -o default -X '*.+(zip|ZIP)'  zip
complete -f -o default -X '!*.+(zip|ZIP)' unzip
complete -f -o default -X '*.+(z|Z)'      compress
complete -f -o default -X '!*.+(z|Z)'     uncompress
complete -f -o default -X '*.+(gz|GZ)'    gzip
complete -f -o default -X '!*.+(gz|GZ)'   gunzip
complete -f -o default -X '*.+(bz2|BZ2)'  bzip2
complete -f -o default -X '!*.+(bz2|BZ2)' bunzip2
complete -f -o default -X '!*.+(zip|ZIP|z|Z|gz|GZ|bz2|BZ2)' extract

wcpdf() {
    pdftotext $1 - | wc -w
}
