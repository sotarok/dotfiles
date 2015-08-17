#!/bin/bash
set -e

usage() {
    echo "USAGE: `basename $0` [Options]"
    echo ""
    echo "Required:"
    echo ""
    echo "Options:"
    echo "  -h, --help          show this help."
    echo "  -v, --verbose       show detail commands."
    echo "  --dry               dry run mode."
    exit 1;
}

main() {
    script_dir=$(cd $(dirname $0); pwd)
    opts=`getopt -o hvo: -l help,verbose,option:,dry, -- "$@"`
    eval set -- "$opts"
    while [ -n "$1" ]; do
        case $1 in
            -h|--help) usage;;
            -o|--option) option=$2; shift;;
            -v|--verbose) is_verbose=1;;
            --dry) is_dry=1;;
            --) shift; break;;
            *) usage;;
        esac
        shift
    done

    if [ $is_dry ];then
        info "dry run..."
    fi

    run test -f /bin/zsh || sudo yum install --enablerepo=remi,epel -y curl curl-devel expat-devel
    run test ! -d ~/.dotfiles && git clone git@github.com:sotarok/dotfiles ~/.dotfiles || (cd ~/.dotfiles && git pull -q origin master && cd ..)
    run ~/.dotfiles/misc/setup.sh ~/.dotfiles
    run test -f /bin/zsh || sudo yum install --enablerepo=remi,epel -y zsh
    run sudo chsh -s /bin/zsh vagrant
    run test -f /usr/bin/tmux || sudo yum install --enablerepo=remi,epel -y tmux
    run test -f ~/bin/git || (sudo yum install -y perl-ExtUtils-MakeMaker && wget -q https://www.kernel.org/pub/software/scm/git/git-2.4.6.tar.gz && tar zxf git-2.4.6.tar.gz && cd git-2.4.6 && ./configure --prefix=$HOME --with-curl --with-expat && make && make install && cd .. && rm -r git-2.4.6*)
    run sudo yum -y install bzip2-devel ncurses-devel zlib-devel python-devel ruby-devel lua-devel
    run test -f ~/bin/vim || (wget -q ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2 && tar xjf vim-7.4.tar.bz2 && cd vim74 && ./configure --prefix=$HOME --disable-selinux --enable-multibyte --with-features=huge --enable-pythoninterp=dynamic && make && make install && cd .. && rm -r ./vim*)

    run test -f ~/bin/peco || (wget -q https://github.com/peco/peco/releases/download/v0.2.3/peco_linux_amd64.tar.gz && tar xzf peco_linux_amd64.tar.gz && cd peco_linux_amd64 && cp peco ~/bin/ && cd .. && rm -r peco*)
    run test -f /usr/bin/ag || sudo rpm -ivh http://swiftsignal.com/packages/centos/6/x86_64/the-silver-searcher-0.13.1-1.el6.x86_64.rpm
    run sudo yum --enablerepo=remi-php56 install -y php-pecl-xdebug
    run vim +BundleInstall +qall

}

## utility
run() {
    if [ $is_dry ]; then
        echo "[dry run] $@"
    else
        if [ $is_verbose ];then
            echo "[run] $@"
        fi
        eval "$@"
    fi
}

red() {
    echo -n "[1;31m$1[0m"
}

yellow() {
    echo -n "[1;33m$1[0m"
}

green() {
    echo -n "[1;32m$1[0m"
}

fatal() {
    red "[fatal] "
    echo "$1"
}

warn() {
    yellow "[warn] "
    echo "$1"
}

info() {
    green "[info] "
    echo "$1"
}

# call main.
main "$@"

