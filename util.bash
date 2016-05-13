#!/bin/bash

# Usage: in_array mark list
#        mark  item to search for
#        list  list in which to look
in_array() {
    local mark=$1
    local search

    for search in "${@:2}"; do
        if [[ $search == "$mark" ]]; then
            return 0
        fi
    done

    # Mark not found.
    return 1
}

# Usage: confirm bias format ...
#        bias    yes | no
#        format  printf formatter
confirm() {
    local -l reply
    local message prompt
    local bias=$1; shift

    case $bias in
        yes) prompt=Y/n ;;
        no)  prompt=y/N ;;
    esac

    printf -v message -- "\033[1;29m* $1 [$prompt]\033[0m " "${@:2}"
    read -rp "$message" reply

    case $bias in
        yes) [[ $reply = y || ! $reply ]] ;;
        no)  [[ $reply = y ]] ;;
    esac
}

# Warning: This procedure is specific to fetching changes fro bare mirrors.
# Usage: check_updates_git branch
check_updates_git() {
    local branch=$1
    local format='%C(auto)%h %C(blue)%an %C(green bold)(%cr) %C(reset)%s'
    local distance=0

    # Using symbolic-ref is required as bare repos have no checkout, without
    # this git will do the wrong thing and update the HEAD regardless of what
    # the refs point at even if git is explicitly configured to not do this.

    # This changed was made based on the assumption that users would find it
    # confusing if they couldn't compare the HEAD against the branch they
    # explicitly fetched from instead of realising they should have used
    # FETCH_HEAD instead.

    # From the school of DWIM: <https://github.com/git/git/commit/f269048754f3>
    git symbolic-ref HEAD refs/heads/"$branch"

    if git fetch "$(git config remote.origin.url)" "$branch" 2> /dev/null; then
        distance=$(git rev-list HEAD...FETCH_HEAD --count "$branch")
    fi

    if ((distance == 0)); then
        # No new commit(s) found.
        return 1
    elif confirm yes '%d new commits found, view log?' "$distance"; then
        git log --pretty=format:"$format" HEAD...FETCH_HEAD
        return 0
    fi
}
