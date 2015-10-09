# Usage: in_array article array
#        mark  : item to search for
#        array : array in which to look
in_array() {
	local mark=$1
	local element

	for element in "${@:2}"; do
		if [[ $element == "$mark" ]]; then
            return 0
        fi
	done

    # Mark not found.
	return 1
}

# Usage: confirm bias format ...
#        bias   : yes | no
#        format : printf formatter
confirm() {
    local -l reply
    local message prompt
    local bias=$1; shift

    case $bias in
        yes) prompt=Y/n ;;
        no)  prompt=y/N ;;
    esac

    printf -v message -- "\033[1;29m* $1 [$prompt]\033[0m " "${@:2}"
    read -p "$message" reply

    case $bias in
        yes) [[ $reply = y || ! $reply ]] ;;
        no)  [[ $reply = y ]] ;;
    esac
}

# Comment: This procedure is specific to fetching changes for bare mirrors.
# Usage: check_updates_git branch
check_updates_git() {
    local branch=$1
    local format='%C(auto)%h %C(blue)%an %C(green bold)(%cr) %C(reset)%s'

    # Using symbolic-ref is required as bare repos have no checkout, without
    # this git will do the wrong thing and update the HEAD regardless of what
    # the refs point at even if git is explicitly configured to not do this.

    # This was changed because users would find it confusing if they couldn't
    # compare the HEAD against the branch they explicitly fetched from and
    # didn't realise they should have used FETCH_HEAD instead.  Sigh.

    # From the school of DWIM: https://github.com/git/git/commit/f269048754f3
    git symbolic-ref HEAD refs/heads/"$branch"

    git fetch "$(git config remote.origin.url)" "$branch" 2> /dev/null

    distance=$(git rev-list HEAD...FETCH_HEAD --count "$branch")

    if ((distance > 0)); then
        if confirm yes '%d new commits found, view log?' "$distance"; then
            git log --pretty=format:"$format" HEAD...FETCH_HEAD
            return 0
        fi
    fi

    # No new commit(s) found.
    return 1
}
