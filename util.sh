#!/bin/sh --
# util.sh - various utility functions used in other helper scripts

# requires tig

# This is POSIX sh with the local keyword
# shellcheck disable=SC2039

# usage: confirm bias format ...
#        bias    yes | no
#        format  printf formatter
confirm() {
    local -l reply
    local prompt bias=$1
    shift

    case $bias in
        yes) prompt=Y/n ;;
        no)  prompt=y/N ;;
    esac

    # I'm placing the terminal control and prompt variables in the printf
    # formatter as I want to expose printf's DSL to the user but without
    # letting their formats break the layout.
    # shellcheck disable=SC2059
    printf -- "$(tput bold)* $1 [$prompt]$(tput sgr0) " "${@:2}"
    read -r reply

    case $bias in
        yes) [ "$reply" = y ] || [ ! "$reply" ] ;;
        no)  [ "$reply" = y ] ;;
    esac
}

# usage: check_updates_git branch
# warning: This procedure is specific to fetching changes from bare mirrors
check_updates_git() {
    local branch=$1
    local distance=0

    # Using symbolic-ref is required as bare repos have no checkout, without
    # this git will do the wrong thing and update the HEAD regardless of what
    # the refs point at even if git is explicitly configured to not do this.

    # This changed was made based on the assumption that users would find it
    # confusing if they couldn't compare the HEAD against the branch they
    # explicitly fetched from instead of realising they should have used
    # FETCH_HEAD instead.

    # <https://github.com/git/git/commit/f269048754f3>
    git symbolic-ref HEAD refs/heads/"$branch"

    if git fetch "$(git config remote.origin.url)" "$branch" 2> /dev/null; then
        distance=$(git rev-list HEAD...FETCH_HEAD --count "$branch")
    fi

    if [ "$distance" -eq 0 ]; then
        return 1
    elif confirm yes '%d new commits found, view log?' "$distance"; then
        tig HEAD...FETCH_HEAD
        return 0
    fi
}
