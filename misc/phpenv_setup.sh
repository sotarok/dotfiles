#!/bin/zsh
set -e

usage() {
    echo "USAGE: `basename $0` [Options]"
    echo ""
    echo "Required:"
    echo ""
    echo "Options:"
    echo "  -s                  setup only"
    echo "  -i, --install-only  install version (ex. --version 5.5.4)"
    echo "  --version           install version (ex. --version 5.5.4)"
    echo "  -h, --help          show this help"
    echo "  -v, --verbose       show detail commands"
    echo "  --dry               dry run mode"
    exit 1;
}

main() {
    script_dir=$(cd $(dirname $0); pwd)
    opts=`getopt -o shvoi: -l version:,install-only,help,verbose,dry, -- "$@"`
    eval set -- "$opts"
    while [ -n "$1" ]; do
        case $1 in
            -s) setup_only=1;;
            -i|--install-only) install_only=1;;
            --version) version=$2; shift;;
            -h|--help) usage;;
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


    if [ ! $install_only ];then
        cd $HOME
        test ! -d ./.php-build \
            && run git clone https://github.com/CHH/php-build.git ./.php-build
        run "cd ./.php-build && PREFIX=$HOME/local ./install.sh && cd .."

        test ! -d ./.phpenv \
            && run curl -s https://raw.github.com/CHH/phpenv/master/bin/phpenv-install.sh | bash
    fi

    if [ $setup_only ];then
        info "install finished."
        exit
    fi

    info "setup $version"
    run php-build -i development $version $HOME/.phpenv/versions/$version
    info "setup as default version: phpenv rehash && phpenv global $version"
    info "install finished."
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

