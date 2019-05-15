# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
#tooldir=$HOME/my_env/tools

if [ -f $HOME/.git-completion.bash ]; then
    source $HOME/.git-completion.bash
fi

export LANGUAGE=zh_CN.UTF-8
export LC_ALL=en_US.UTF-8

#export LANG=zh_CN.UTF-8
export PYTHONSTARTUP=~/.pythonstartup.py
export PATH=$PATH:~/my_env/tools
export HISTTIMEFORMAT='%F %T '
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/workspace/engine/3rd/libevent/lib/
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/workspace/engine/3rd/protobuf/lib/
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/workspace/engine/3rd/mongo-c-driver/lib/
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/workspace/engine/3rd/msgpack/lib/
#LD_LIBRARY_PATH=$LD_LIBRARY_PATH:~/workspace/engine/3rd/jemalloc/lib/
export LD_LIBRARY_PATH

alias rm="trash.sh"
alias df='df -kTh'
alias ls='ls --color=auto'
alias ll='ls -la --color=auto'

ulimit -c unlimited
ulimit -n 4096

find_git_branch () {
    local dir=. head
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.git/HEAD" ]; then
            head=$(< "$dir/.git/HEAD")
            if [[ $head = ref:\ refs/heads/* ]]; then
                git_branch="(${head#*/*/})"
            elif [[ $head != '' ]]; then
                git_branch="detached"
            else
                git_branch="unknow"
            fi  
            return
        fi
        dir="../$dir"
    done
    git_branch=''
}

find_current_work () {
    local dir=.
    until [ "$dir" -ef / ]; do
        if [ -f "$dir/.cur_work" ]; then
            cur_work=$(cat "$dir/.cur_work")
            return 
        fi
        dir="../$dir"
    done
    cur_work=''
}

PROMPT_COMMAND="find_git_branch;find_current_work; $PROMPT_COMMAND"
PS1="[\[\033[0;32m\]\u\[\033[00m\]@\[\033[0;36m\]\w\[\033[00m\]]\[\033[1;33m\]\$cur_work$git_branch\[\033[00m\]\$"

function search()
{
    #find . -name "*.[ch]" | xargs grep $1 --color=auto -ni; 
    find . -name "*.[ch]" | xargs grep $1 --color=auto -n; 
}

function godev()
{
    cd $HOME/workspace/q1develop/logic
}

function gomer()
{
    cd $HOME/workspace/q1merge/logic
}

function gocode()
{
    cd $HOME/workspace/q6code/logic
}

function cs()
{
    cs.sh
}

#nowtime [2008-01-01]
function nowtime()
{
    if [ $# -lt 1 ] ; then
        date +%s
    else
        date -d $1 +%s
    fi
}

#nowtime [1231412414]
function nowdate()
{
    if [ $# -lt 1 ] ; then
        date
    else
        date -d "1970-01-01 UTC $1 seconds"
    fi
}

function parse()
{
    PARSE_LOG_PATH=lhh-parse
    PWD=$(pwd)

    if [ ! -f ${PWD}/tools/parse_table.py ] ; then
        echo "please enter logic root path"
        return
    fi

    if [ ! -d ${PWD}/log ] ; then
        mkdir -p ${PWD}/log
    fi

    if [ ! -d ${PWD}/log/${PARSE_LOG_PATH} ] ; then
        mkdir -p ${PWD}/log/${PARSE_LOG_PATH}
    fi

    python2 ${PWD}/tools/parse_table.py ${PWD} $1 default ${PARSE_LOG_PATH}
}

function myfind()
{
    if [ $# -lt 1 ] ; then
        return
    else
        find ./ -type f -name "*$1*" |grep $1 |grep '\.c'
    fi
}

function mytar()
{
    if [ $# -lt 1 ] ; then
        return
    else
        mytar.sh $1
    fi
}
