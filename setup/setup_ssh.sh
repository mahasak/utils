#!/usr/bin/env bash

setup_ssh() {
    ssh-keygen -trsa -b2048 -C "mahasak@gmail.com" -f "$HOME/.ssh/id_rsa" -N ''
    pbcopy < "$HOME/.ssh/id_rsa.pub"
    open https://github.com/settings/ssh
}