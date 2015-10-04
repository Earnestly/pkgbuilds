# Usage: in_array object array
#        object = item to search for
#        array  = array in which to look
in_array() {
	local object=$1
	local seeker

	for seeker in "${@:2}"; do
		[[ $seeker == "$object" ]] && return 0
	done

	return 1
}

# Usage: confirm bias format ...
#        bias   = yes | no
#        format = printf formatter
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

# Comment: This is specific to fetching changes for bare mirrors.
# Usage: check_updates_git branch
check_updates_git() {
    local branch="$1"

    git symbolic-ref HEAD refs/heads/"$branch"

    git fetch "$(git config remote.origin.url)" "$branch" 2> /dev/null

    distance=$(git rev-list HEAD...FETCH_HEAD --count "$branch")

    if ((distance > 0)); then
        if confirm yes '%d new commits found, view log?' "$distance"; then
            git log --pretty=format:'%C(auto)%h %C(blue)%an %C(green bold)(%cr) %C(reset)%s' HEAD...FETCH_HEAD
            return 0
        fi
    fi
    return 1
}
