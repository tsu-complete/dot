
# ---------- helper_svn() -----------------------------------------------------
helper_svn() {
  ref=$(command svn info . 2>/dev/null) || return
  STATUS=$(svn status)

  if [ -n "$status" ]; then
    STATUS_BAR=""
    STATUS_CNT=$(echo $STATUS | grep -c ^A)
    STATUS_BAR="$STATUS_BAR $fg[green]+$STATUS_CNT"
    STATUS_CNT=$(echo $STATUS | grep -c ^M)
    STATUS_BAR="$STATUS_BAR $fg[yellow]~$STATUS_CNT"
    STATUS_CNT=$(echo $STATUS | grep -c ^D)
    STATUS_BAR="$STATUS_BAR $fg[red]-$STATUS_CNT"
    STATUS_CNT=$(echo $STATUS | grep -c '^\?')
    STATUS_BAR="$STATUS_BAR $fg[black]?$STATUS_CNT"
    STATUS=" $fg[yellow][$STATUS_BAR$fg[yellow] ]"
  fi

  local repo=$(svn info . | grep "Repository Root" | sed 's/.*\///g')
  local rev=$(svn info . | grep "Revision" | sed 's/.*: //g')

  echo -n "$fg[green]($repo:$rev)$STATUS "
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

  if [[ -n $INDEXED || -n $WORKING ]]; then
    STATUS="$INDEXED $fg[yellow]|$WORKING"
  fi

  local stashes=$(git stash list | grep -c .)
  if [ $stashes -ne 0 ]; then
    STATUS="$STATUS $fg[cyan]($stashes)"
  fi

  if [[ -n $STATUS ]]; then
    STATUS=" $fg[yellow][$STATUS$fg[yellow] ]"
  fi

  local branch=$(git branch --no-color | grep \* | cut -f2 -d' ')
  echo -n " $fg[green]($branch)$STATUS"
}

# ---------- prompt_status() --------------------------------------------------
prompt_status() {
  if [[ $RETVAL -eq 147 ]]; then
    echo -n " $fg[red]404"
  elif [[ $RETVAL -ne 0 ]]; then
    echo -n " $fg[red]$RETVAL"
  else
    echo -n " $fg[green]0"
  fi

  [[ $UID -eq 0 ]] && echo -n " $fg[yellow]su"
  local jcnt=$(jobs | grep -c '\[')
  if [ $jcnt -gt 0 ]; then
    echo -n " $fg[cyan]&$jcnt"
  fi
}


# ---------- prompt_dir() -----------------------------------------------------
prompt_dir() {
  local pth="%(5C.%-1~/… /%2~.%~)"
  echo -n " $fg[blue]$pth"
}

# ---------- prompt_host() ----------------------------------------------------
prompt_host() {
  [[ -z $TSU_HIDEUSER ]] && echo -n ' %{%F{yellow}%}%n'
  [[ -z $TSU_HIDEHOST ]] && echo -n '%{%F{yellow}%}@%m'
}

# ---------- prompt_prompt() --------------------------------------------------
prompt_prompt() {
  echo -n ' $ '
}

# ---------- build_prompt() ---------------------------------------------------
build_prompt() {
  RETVAL=$?
  echo
  prompt_status
  rps1_face
  rps1_time
  prompt_host
  helper_git
  helper_svn
  prompt_dir
  echo
  prompt_prompt
}

PROMPT='%{%f%b%k%}$(build_prompt)%{%f%b%k%}'


# ---------- rps1_time() ------------------------------------------------------
rps1_time() {
  [[ -z $TSU_HIDETIME ]] && echo -n " $fg[cyan][$(echo $(date) | cut -d' ' -f4)]"
}

# ---------- rps1_face() -----------------------------------------------------
rps1_face() {
  [[ -z $TSU_HIDEFACE ]] || return
  [[ $RETVAL -ne 0 ]] && echo -n " $fg[red]:("
  [[ $RETVAL -eq 0 ]] && echo -n " $fg[green]:)"
}

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

