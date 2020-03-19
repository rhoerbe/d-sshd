#!/usr/bin/env bash

# This script expects a customized configuration in /opt/etc/ssh

main() {
    get_commandline_opts $@
    create_sshd_keys
    start_sshd
}


get_commandline_opts() {
    daemonmode='-D'
    while getopts ":dh" opt; do
      case $opt in
        D) daemonmode='';;
        *) usage; exit 0;;
      esac
    done
}


usage() {
    echo "usage: $0 [-D] [-h]
       -D  start in background (default: foreground)
       -h  print this help text
    "
}


create_sshd_keys() {
    [ -e /opt/etc/ssh/ssh_host_rsa_key ] || ssh-keygen -q -N '' -t rsa -f /etc/ssh/ssh_host_rsa_key
    [ -e /opt/etc/ssh/ssh_host_ecdsa_key ] || ssh-keygen -q -N '' -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
    [ -e /opt/etc/ssh/ssh_host_ed25519_key ] || ssh-keygen -q -N '' -t ed25519 -f /etc/ssh/ssh_host_ed25519_key
}


start_sshd() {
    if [[ "$daemonmode" == '-D' ]]; then
        echo 'starting sshd in foreground'
    fi
    /usr/sbin/sshd ${daemonmode} $SSHD_OPTS -f /opt/etc/ssh/sshd_config
}


main "$@"
