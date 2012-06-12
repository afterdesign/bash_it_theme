#!/bin/bash
SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓"
SCM_THEME_PROMPT_PREFIX=" |"
SCM_THEME_PROMPT_SUFFIX="${green}|"

GIT_THEME_PROMPT_DIRTY="${red}✗"
GIT_THEME_PROMPT_CLEAN="${green}✓"
GIT_THEME_PROMPT_PREFIX="[git:"
GIT_THEME_PROMPT_SUFFIX="]"

function get_pwd() {
   echo "${PWD/$HOME/~}"
}

function git_prompt_info {
  git_prompt_vars
  echo -e "$SCM_STATE$SCM_PREFIX$SCM_BRANCH$SCM_SUFFIX"
}

function put_spacing() {
    local lpwd=$(get_pwd)
    local termwidth
    local columns=$(tput cols)
    local git_data=$(git_prompt_info)

    ((termwidth=${columns}-${#git_data}-${#lpwd}-11))
    local spacing=""
    for ((i=0; i<$termwidth; i++)); do
        spacing="${spacing} "
    done
    printf '%s' "$spacing"
}

function prompt_command() {
    PS1="\h ${reset_color}in ${cyan}\w ${reset_color}$(put_spacing)$(scm_prompt_info)${reset_color}\n→${reset_color} "
}

PROMPT_COMMAND=prompt_command;