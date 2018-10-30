local ret_status="%(?: 🍏: 🍎)"
local red_arrow="%{$fg_bold[red]%}➢%{$reset_color%}"
# local curr_dir="%{$fg[cyan]%}%c%{$reset_color%}"
local curr_path="%{$fg[blue]%}%$%~%{$reset_color%}"
local time="%{$fg_bold[blue]%}%t%{$reset_color%}"

PROMPT='${ret_status} ${curr_path} ${red_arrow} '
RPROMPT='$(git_custom_prompt) ${time}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}[%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="💋 "
ZSH_THEME_GIT_PROMPT_CLEAN=""

git_custom_prompt() {
  # branch name (.oh-my-zsh/plugins/git/git.plugin.zsh)
  local branch=$(current_branch)
  if [ -n "$branch" ]; then
    # parse_git_dirty echoes PROMPT_DIRTY or PROMPT_CLEAN (.oh-my-zsh/lib/git.zsh)
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$branch$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}
