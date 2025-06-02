# ANSI formatting function (\033[<code>m)
# 0: reset, 1: bold, 4: underline, 22: no bold, 24: no underline, 31: red, 33: yellow
omz_f() {
  [ $# -gt 0 ] || return
  IFS=";" printf "\033[%sm" $*
}
# If stdout is not a terminal ignore all formatting
[ -t 1 ] || omz_f() { :; }

PROMPT=$'$(omz_f 0 1)╓─{$(omz_f 22 34)%n@%m$(omz_f 0 1)}─{$(omz_f 22 36)%~$(omz_f 0 1)}$(git_super_status)$(virtualenv_prompt_info)$(omz_f 0 1)─{$(omz_f 22 33)%D{%a %b %d, %H:%M}$(omz_f 0 1)} 
$(omz_f 0 1)╙─{%(?:$(omz_f 22 32)✔︎:$(omz_f 22 31)✘)$(omz_f 0 1)}$(omz_f 0 1) %(!.#.$)$(omz_f 0) '

PS2=$' $(omz_f 0 1)>$(omz_f 0) '

unset RPROMPT #because I moved the git status into my left prompt

ZSH_THEME_GIT_PROMPT_PREFIX="$(omz_f 0 1)─{$(omz_f 0)"
ZSH_THEME_GIT_PROMPT_SUFFIX="$(omz_f 0 1)}$(omz_f 0)"
ZSH_THEME_GIT_PROMPT_BRANCH+=''
ZSH_THEME_VIRTUALENV_PREFIX="$(omz_f 0 1)─{$(omz_f 22 32)"
ZSH_THEME_VIRTUALENV_SUFFIX="$(omz_f 0 1)}"

# 🐍 🪾 