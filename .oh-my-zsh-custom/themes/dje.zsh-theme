PROMPT=$'%{$fg_bold[white]%}╓─{%{$fg_no_bold[blue]%}%n@%m%{$fg_bold[white]%}}─{%{$fg_no_bold[cyan]%}%~%{$fg_bold[white]%}}$(git_super_status)$(virtualenv_prompt_info)%{$fg_bold[white]%}─{%{$fg_no_bold[yellow]%}%D{%a %b %d, %H:%M}%{$fg_bold[white]%}} 
%{$fg_bold[white]%}╙─{%(?:%{$fg_no_bold[green]%}✔︎:%{$fg_no_bold[red]%}✘)%{$fg_bold[white]%}}%{$fg_bold[white]%} %(!.#.$)%{$reset_color%} '

PS2=$' %{$fg_bold[white]%}>%{$reset_color%} '

unset RPROMPT #because I moved the git status into my left prompt

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}─{%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[white]%}}%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BRANCH+=''
ZSH_THEME_VIRTUALENV_PREFIX="%{$fg_bold[white]%}─{%{$fg_no_bold[green]%}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$fg_bold[white]%}}"

# 🐍 🪾 