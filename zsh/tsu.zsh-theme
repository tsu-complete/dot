
# ---------- helper_space() ---------------------------------------------------
helper_space() {
  echo -n ' '
}


# ---------- helper_git() -----------------------------------------------------
helper_git() {
  # inspired by https://github.com/elboletaire/zsh-theme-racotecnic
  STATUS=""
  INDEXED=""
  WORKING=""
  ref=$(command git symbolic-ref HEAD 2>/dev/null) || \
  ref=$(command git rev-parse --short HEAD 2>/dev/null) || \
  return

  INDEX=$(command git status --porcelain -b 2>/dev/null)

  local c_index_added=$(echo "$INDEX" | grep -c '^A')
  if [ $c_index_added -ne 0 ]; then
    INDEXED="$INDEXED $fg[green]+$c_index_added"
  fi

  local c_index_modified=$(echo "$INDEX" | grep -c -E '^[MR]')
  if [ $c_index_modified -ne 0 ]; then
    INDEXED="$INDEXED $fg[yellow]~$c_index_modified"
  fi

  local c_index_deleted=$(echo "$INDEX" | grep -c '^D')
  if [ $c_index_deleted -ne 0 ]; then
    INDEXED="$INDEXED $fg[red]-$c_index_deleted"
  fi

  local c_index_conflict=$(echo "$INDEX" | grep -c '^U')
  if [ $c_index_conflict -ne 0 ]; then
    INDEXED="$INDEXED $fg[magenta]!$c_index_conflict"
  fi

  local c_work_untracked=$(echo "$INDEX" | grep -c -E '^[\?A][\?A] ')
  if [ $c_work_untracked -ne 0 ]; then
    WORKING="$WORKING $fg[green]+$c_work_untracked"
  fi

  local c_work_modified=$(echo "$INDEX" | grep -c -E '^[A-Z ][MR] ')
  if [ $c_work_modified -ne 0 ]; then
    WORKING="$WORKING $fg[yellow]~$c_work_modified"
  fi

  local c_work_deleted=$(echo "$INDEX" | grep -c -E '^[A-Z ]D ')
  if [ $c_work_deleted -ne 0 ]; then
    WORKING="$WORKING $fg[red]-$c_work_deleted"
  fi

  local c_work_conflict=$(echo "$INDEX" | grep -c '^[A-Z ]U ')
  if [ $c_work_conflict -ne 0 ]; then
    WORKING="$WORKING $fg[magenta]!$c_work_conflict"
  fi

  if [[ -n $INDEXED && -n $WORKING ]]; then
    STATUS="$INDEXED $fg[yellow]|$WORKING"
  else
    STATUS="$INDEXED$WORKING"
  fi

  local stashes=$(git stash list | grep -c .)
  if [ $stashes -ne 0 ]; then
    STATUS="$STATUS $fg[cyan]($stashes)"
  fi

  if [[ -n $STATUS ]]; then
    STATUS=" $fg[yellow][$STATUS$fg[yellow] ]"
  fi

  local branch=$(git branch --no-color | grep \* | cut -f2 -d' ')
  echo -n "$fg[green]($branch)$STATUS "
}

# ---------- prompt_status() --------------------------------------------------
prompt_status() {
  [[ $RETVAL -ne 0 ]] && echo -n '%{%F{red}%}✘(%?)'
  [[ $RETVAL -eq 0 ]] && echo -n '%{%F{green}%}✓'
  [[ $UID -eq 0 ]] && echo -n ' %{%F{yellow}%}⚡'
  local jcnt=$(jobs | grep -c "\[")
  if [ $jcnt -gt 0 ]; then
    echo -n " $fg[cyan]⚙($jcnt)"
  fi
}


# ---------- prompt_dir() -----------------------------------------------------
prompt_dir() {
  local pth="%(5C.%-1~/… /%2~.%~)"
  echo -n "$fg[blue]$pth"
}

# ---------- prompt_host() ----------------------------------------------------
prompt_host() {
  [[ -z $TSU_HIDEUSER ]] && echo -n '%{%F{yellow}%}%n'
  [[ -z $TSU_HIDEHOST ]] && echo -n '%{%F{yellow}%}@%m'
}

# ---------- prompt_prompt() --------------------------------------------------
prompt_prompt() {
  echo -n '$'
}

# ---------- build_prompt() ---------------------------------------------------
build_prompt() {
  RETVAL=$?
  echo
  helper_space
  prompt_status
  helper_space
  prompt_host
  helper_space
  helper_git
  prompt_dir
  echo
  helper_space
  prompt_prompt
  helper_space
}

PROMPT='%{%f%b%k%}$(build_prompt)%{%f%b%k%}'


# ---------- rps1_time() ------------------------------------------------------
rps1_time() {
  [[ -z $TSU_HIDETIME ]] && echo -n "%{%F{cyan}%}[$(echo $(date) | cut -d' ' -f4)]"
}

# ---------- rps1_face() -----------------------------------------------------
rps1_face() {
  [[ -z $TSU_HIDEFACE ]] || return
  [[ $RETVAL -ne 0 ]] && echo -n "$fg[red]:("
  [[ $RETVAL -eq 0 ]] && echo -n "$fg[green]:)"
}

# ---------- build_rps1() -----------------------------------------------------
build_rps1() {
  RETVAL=$?
  helper_space
  rps1_time
  helper_space
  rps1_face
}

RPS1='%{%f%b%k%}$(build_rps1)%{%f%b%k%}'

# ---------- tsu() ------------------------------------------------------------
tsu() {
  case "$1" in
  "show")
    case "$2" in
    "host") unset TSU_HIDEHOST ;;
    "user") unset TSU_HIDEUSER ;;
    "time") unset TSU_HIDETIME ;;
    "face") unset TSU_HIDEFACE ;;
    *) echo "usage: tsu help | ([show|hide] [host|user|time|face])" ;;
    esac
  ;;
  "hide")
    case "$2" in
    "host") TSU_HIDEHOST=1 ;;
    "user") TSU_HIDEUSER=1 ;;
    "time") TSU_HIDETIME=1 ;;
    "face") TSU_HIDEFACE=1 ;;
    *) echo "usage: tsu help | ([show|hide] [host|user|time|face])" ;;
    esac
  ;;
  *)
    echo "usage: tsu help | ([show|hide] [host|user|time|face])"
  esac
}

