#!/usr/bin/env bash

###############################################################################
# CHT.SH AUTOCOMPLETE
###############################################################################

_cht_complete() {
  local cur prev opts
  _get_comp_words_by_ref -n : cur

  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  opts="$(curl -s cheat.sh/:list)"

  if [ ${COMP_CWORD} = 1 ]; then
    COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
    __ltrim_colon_completions "$cur"
  fi
  return 0
}
complete -F _cht_complete cht.sh

###############################################################################
# ATUIN AUTOCOMPLETE
###############################################################################

. "$HOME/.atuin/bin/env"

[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(atuin init bash)"
_atuin() {
  local i cur prev opts cmd
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  cmd=""
  opts=""

  for i in ${COMP_WORDS[@]}; do
    case "${cmd},${i}" in
    ",$1")
      cmd="atuin"
      ;;
    atuin,account)
      cmd="atuin__account"
      ;;
    atuin,contributors)
      cmd="atuin__contributors"
      ;;
    atuin,daemon)
      cmd="atuin__daemon"
      ;;
    atuin,default-config)
      cmd="atuin__default__config"
      ;;
    atuin,doctor)
      cmd="atuin__doctor"
      ;;
    atuin,dotfiles)
      cmd="atuin__dotfiles"
      ;;
    atuin,gen-completions)
      cmd="atuin__gen__completions"
      ;;
    atuin,help)
      cmd="atuin__help"
      ;;
    atuin,history)
      cmd="atuin__history"
      ;;
    atuin,import)
      cmd="atuin__import"
      ;;
    atuin,info)
      cmd="atuin__info"
      ;;
    atuin,init)
      cmd="atuin__init"
      ;;
    atuin,key)
      cmd="atuin__key"
      ;;
    atuin,kv)
      cmd="atuin__kv"
      ;;
    atuin,login)
      cmd="atuin__login"
      ;;
    atuin,logout)
      cmd="atuin__logout"
      ;;
    atuin,register)
      cmd="atuin__register"
      ;;
    atuin,scripts)
      cmd="atuin__scripts"
      ;;
    atuin,search)
      cmd="atuin__search"
      ;;
    atuin,server)
      cmd="atuin__server"
      ;;
    atuin,stats)
      cmd="atuin__stats"
      ;;
    atuin,status)
      cmd="atuin__status"
      ;;
    atuin,store)
      cmd="atuin__store"
      ;;
    atuin,sync)
      cmd="atuin__sync"
      ;;
    atuin,uuid)
      cmd="atuin__uuid"
      ;;
    atuin,wrapped)
      cmd="atuin__wrapped"
      ;;
    atuin__account,change-password)
      cmd="atuin__account__change__password"
      ;;
    atuin__account,delete)
      cmd="atuin__account__delete"
      ;;
    atuin__account,help)
      cmd="atuin__account__help"
      ;;
    atuin__account,login)
      cmd="atuin__account__login"
      ;;
    atuin__account,logout)
      cmd="atuin__account__logout"
      ;;
    atuin__account,register)
      cmd="atuin__account__register"
      ;;
    atuin__account,verify)
      cmd="atuin__account__verify"
      ;;
    atuin__account__help,change-password)
      cmd="atuin__account__help__change__password"
      ;;
    atuin__account__help,delete)
      cmd="atuin__account__help__delete"
      ;;
    atuin__account__help,help)
      cmd="atuin__account__help__help"
      ;;
    atuin__account__help,login)
      cmd="atuin__account__help__login"
      ;;
    atuin__account__help,logout)
      cmd="atuin__account__help__logout"
      ;;
    atuin__account__help,register)
      cmd="atuin__account__help__register"
      ;;
    atuin__account__help,verify)
      cmd="atuin__account__help__verify"
      ;;
    atuin__dotfiles,alias)
      cmd="atuin__dotfiles__alias"
      ;;
    atuin__dotfiles,help)
      cmd="atuin__dotfiles__help"
      ;;
    atuin__dotfiles,var)
      cmd="atuin__dotfiles__var"
      ;;
    atuin__dotfiles__alias,clear)
      cmd="atuin__dotfiles__alias__clear"
      ;;
    atuin__dotfiles__alias,delete)
      cmd="atuin__dotfiles__alias__delete"
      ;;
    atuin__dotfiles__alias,help)
      cmd="atuin__dotfiles__alias__help"
      ;;
    atuin__dotfiles__alias,list)
      cmd="atuin__dotfiles__alias__list"
      ;;
    atuin__dotfiles__alias,set)
      cmd="atuin__dotfiles__alias__set"
      ;;
    atuin__dotfiles__alias__help,clear)
      cmd="atuin__dotfiles__alias__help__clear"
      ;;
    atuin__dotfiles__alias__help,delete)
      cmd="atuin__dotfiles__alias__help__delete"
      ;;
    atuin__dotfiles__alias__help,help)
      cmd="atuin__dotfiles__alias__help__help"
      ;;
    atuin__dotfiles__alias__help,list)
      cmd="atuin__dotfiles__alias__help__list"
      ;;
    atuin__dotfiles__alias__help,set)
      cmd="atuin__dotfiles__alias__help__set"
      ;;
    atuin__dotfiles__help,alias)
      cmd="atuin__dotfiles__help__alias"
      ;;
    atuin__dotfiles__help,help)
      cmd="atuin__dotfiles__help__help"
      ;;
    atuin__dotfiles__help,var)
      cmd="atuin__dotfiles__help__var"
      ;;
    atuin__dotfiles__help__alias,clear)
      cmd="atuin__dotfiles__help__alias__clear"
      ;;
    atuin__dotfiles__help__alias,delete)
      cmd="atuin__dotfiles__help__alias__delete"
      ;;
    atuin__dotfiles__help__alias,list)
      cmd="atuin__dotfiles__help__alias__list"
      ;;
    atuin__dotfiles__help__alias,set)
      cmd="atuin__dotfiles__help__alias__set"
      ;;
    atuin__dotfiles__help__var,delete)
      cmd="atuin__dotfiles__help__var__delete"
      ;;
    atuin__dotfiles__help__var,list)
      cmd="atuin__dotfiles__help__var__list"
      ;;
    atuin__dotfiles__help__var,set)
      cmd="atuin__dotfiles__help__var__set"
      ;;
    atuin__dotfiles__var,delete)
      cmd="atuin__dotfiles__var__delete"
      ;;
    atuin__dotfiles__var,help)
      cmd="atuin__dotfiles__var__help"
      ;;
    atuin__dotfiles__var,list)
      cmd="atuin__dotfiles__var__list"
      ;;
    atuin__dotfiles__var,set)
      cmd="atuin__dotfiles__var__set"
      ;;
    atuin__dotfiles__var__help,delete)
      cmd="atuin__dotfiles__var__help__delete"
      ;;
    atuin__dotfiles__var__help,help)
      cmd="atuin__dotfiles__var__help__help"
      ;;
    atuin__dotfiles__var__help,list)
      cmd="atuin__dotfiles__var__help__list"
      ;;
    atuin__dotfiles__var__help,set)
      cmd="atuin__dotfiles__var__help__set"
      ;;
    atuin__help,account)
      cmd="atuin__help__account"
      ;;
    atuin__help,contributors)
      cmd="atuin__help__contributors"
      ;;
    atuin__help,daemon)
      cmd="atuin__help__daemon"
      ;;
    atuin__help,default-config)
      cmd="atuin__help__default__config"
      ;;
    atuin__help,doctor)
      cmd="atuin__help__doctor"
      ;;
    atuin__help,dotfiles)
      cmd="atuin__help__dotfiles"
      ;;
    atuin__help,gen-completions)
      cmd="atuin__help__gen__completions"
      ;;
    atuin__help,help)
      cmd="atuin__help__help"
      ;;
    atuin__help,history)
      cmd="atuin__help__history"
      ;;
    atuin__help,import)
      cmd="atuin__help__import"
      ;;
    atuin__help,info)
      cmd="atuin__help__info"
      ;;
    atuin__help,init)
      cmd="atuin__help__init"
      ;;
    atuin__help,key)
      cmd="atuin__help__key"
      ;;
    atuin__help,kv)
      cmd="atuin__help__kv"
      ;;
    atuin__help,login)
      cmd="atuin__help__login"
      ;;
    atuin__help,logout)
      cmd="atuin__help__logout"
      ;;
    atuin__help,register)
      cmd="atuin__help__register"
      ;;
    atuin__help,scripts)
      cmd="atuin__help__scripts"
      ;;
    atuin__help,search)
      cmd="atuin__help__search"
      ;;
    atuin__help,server)
      cmd="atuin__help__server"
      ;;
    atuin__help,stats)
      cmd="atuin__help__stats"
      ;;
    atuin__help,status)
      cmd="atuin__help__status"
      ;;
    atuin__help,store)
      cmd="atuin__help__store"
      ;;
    atuin__help,sync)
      cmd="atuin__help__sync"
      ;;
    atuin__help,uuid)
      cmd="atuin__help__uuid"
      ;;
    atuin__help,wrapped)
      cmd="atuin__help__wrapped"
      ;;
    atuin__help__account,change-password)
      cmd="atuin__help__account__change__password"
      ;;
    atuin__help__account,delete)
      cmd="atuin__help__account__delete"
      ;;
    atuin__help__account,login)
      cmd="atuin__help__account__login"
      ;;
    atuin__help__account,logout)
      cmd="atuin__help__account__logout"
      ;;
    atuin__help__account,register)
      cmd="atuin__help__account__register"
      ;;
    atuin__help__account,verify)
      cmd="atuin__help__account__verify"
      ;;
    atuin__help__dotfiles,alias)
      cmd="atuin__help__dotfiles__alias"
      ;;
    atuin__help__dotfiles,var)
      cmd="atuin__help__dotfiles__var"
      ;;
    atuin__help__dotfiles__alias,clear)
      cmd="atuin__help__dotfiles__alias__clear"
      ;;
    atuin__help__dotfiles__alias,delete)
      cmd="atuin__help__dotfiles__alias__delete"
      ;;
    atuin__help__dotfiles__alias,list)
      cmd="atuin__help__dotfiles__alias__list"
      ;;
    atuin__help__dotfiles__alias,set)
      cmd="atuin__help__dotfiles__alias__set"
      ;;
    atuin__help__dotfiles__var,delete)
      cmd="atuin__help__dotfiles__var__delete"
      ;;
    atuin__help__dotfiles__var,list)
      cmd="atuin__help__dotfiles__var__list"
      ;;
    atuin__help__dotfiles__var,set)
      cmd="atuin__help__dotfiles__var__set"
      ;;
    atuin__help__history,dedup)
      cmd="atuin__help__history__dedup"
      ;;
    atuin__help__history,end)
      cmd="atuin__help__history__end"
      ;;
    atuin__help__history,init-store)
      cmd="atuin__help__history__init__store"
      ;;
    atuin__help__history,last)
      cmd="atuin__help__history__last"
      ;;
    atuin__help__history,list)
      cmd="atuin__help__history__list"
      ;;
    atuin__help__history,prune)
      cmd="atuin__help__history__prune"
      ;;
    atuin__help__history,start)
      cmd="atuin__help__history__start"
      ;;
    atuin__help__import,auto)
      cmd="atuin__help__import__auto"
      ;;
    atuin__help__import,bash)
      cmd="atuin__help__import__bash"
      ;;
    atuin__help__import,fish)
      cmd="atuin__help__import__fish"
      ;;
    atuin__help__import,nu)
      cmd="atuin__help__import__nu"
      ;;
    atuin__help__import,nu-hist-db)
      cmd="atuin__help__import__nu__hist__db"
      ;;
    atuin__help__import,replxx)
      cmd="atuin__help__import__replxx"
      ;;
    atuin__help__import,resh)
      cmd="atuin__help__import__resh"
      ;;
    atuin__help__import,xonsh)
      cmd="atuin__help__import__xonsh"
      ;;
    atuin__help__import,xonsh-sqlite)
      cmd="atuin__help__import__xonsh__sqlite"
      ;;
    atuin__help__import,zsh)
      cmd="atuin__help__import__zsh"
      ;;
    atuin__help__import,zsh-hist-db)
      cmd="atuin__help__import__zsh__hist__db"
      ;;
    atuin__help__kv,delete)
      cmd="atuin__help__kv__delete"
      ;;
    atuin__help__kv,get)
      cmd="atuin__help__kv__get"
      ;;
    atuin__help__kv,list)
      cmd="atuin__help__kv__list"
      ;;
    atuin__help__kv,rebuild)
      cmd="atuin__help__kv__rebuild"
      ;;
    atuin__help__kv,set)
      cmd="atuin__help__kv__set"
      ;;
    atuin__help__scripts,delete)
      cmd="atuin__help__scripts__delete"
      ;;
    atuin__help__scripts,edit)
      cmd="atuin__help__scripts__edit"
      ;;
    atuin__help__scripts,get)
      cmd="atuin__help__scripts__get"
      ;;
    atuin__help__scripts,list)
      cmd="atuin__help__scripts__list"
      ;;
    atuin__help__scripts,new)
      cmd="atuin__help__scripts__new"
      ;;
    atuin__help__scripts,run)
      cmd="atuin__help__scripts__run"
      ;;
    atuin__help__server,default-config)
      cmd="atuin__help__server__default__config"
      ;;
    atuin__help__server,start)
      cmd="atuin__help__server__start"
      ;;
    atuin__help__store,pull)
      cmd="atuin__help__store__pull"
      ;;
    atuin__help__store,purge)
      cmd="atuin__help__store__purge"
      ;;
    atuin__help__store,push)
      cmd="atuin__help__store__push"
      ;;
    atuin__help__store,rebuild)
      cmd="atuin__help__store__rebuild"
      ;;
    atuin__help__store,rekey)
      cmd="atuin__help__store__rekey"
      ;;
    atuin__help__store,status)
      cmd="atuin__help__store__status"
      ;;
    atuin__help__store,verify)
      cmd="atuin__help__store__verify"
      ;;
    atuin__history,dedup)
      cmd="atuin__history__dedup"
      ;;
    atuin__history,end)
      cmd="atuin__history__end"
      ;;
    atuin__history,help)
      cmd="atuin__history__help"
      ;;
    atuin__history,init-store)
      cmd="atuin__history__init__store"
      ;;
    atuin__history,last)
      cmd="atuin__history__last"
      ;;
    atuin__history,list)
      cmd="atuin__history__list"
      ;;
    atuin__history,prune)
      cmd="atuin__history__prune"
      ;;
    atuin__history,start)
      cmd="atuin__history__start"
      ;;
    atuin__history__help,dedup)
      cmd="atuin__history__help__dedup"
      ;;
    atuin__history__help,end)
      cmd="atuin__history__help__end"
      ;;
    atuin__history__help,help)
      cmd="atuin__history__help__help"
      ;;
    atuin__history__help,init-store)
      cmd="atuin__history__help__init__store"
      ;;
    atuin__history__help,last)
      cmd="atuin__history__help__last"
      ;;
    atuin__history__help,list)
      cmd="atuin__history__help__list"
      ;;
    atuin__history__help,prune)
      cmd="atuin__history__help__prune"
      ;;
    atuin__history__help,start)
      cmd="atuin__history__help__start"
      ;;
    atuin__import,auto)
      cmd="atuin__import__auto"
      ;;
    atuin__import,bash)
      cmd="atuin__import__bash"
      ;;
    atuin__import,fish)
      cmd="atuin__import__fish"
      ;;
    atuin__import,help)
      cmd="atuin__import__help"
      ;;
    atuin__import,nu)
      cmd="atuin__import__nu"
      ;;
    atuin__import,nu-hist-db)
      cmd="atuin__import__nu__hist__db"
      ;;
    atuin__import,replxx)
      cmd="atuin__import__replxx"
      ;;
    atuin__import,resh)
      cmd="atuin__import__resh"
      ;;
    atuin__import,xonsh)
      cmd="atuin__import__xonsh"
      ;;
    atuin__import,xonsh-sqlite)
      cmd="atuin__import__xonsh__sqlite"
      ;;
    atuin__import,zsh)
      cmd="atuin__import__zsh"
      ;;
    atuin__import,zsh-hist-db)
      cmd="atuin__import__zsh__hist__db"
      ;;
    atuin__import__help,auto)
      cmd="atuin__import__help__auto"
      ;;
    atuin__import__help,bash)
      cmd="atuin__import__help__bash"
      ;;
    atuin__import__help,fish)
      cmd="atuin__import__help__fish"
      ;;
    atuin__import__help,help)
      cmd="atuin__import__help__help"
      ;;
    atuin__import__help,nu)
      cmd="atuin__import__help__nu"
      ;;
    atuin__import__help,nu-hist-db)
      cmd="atuin__import__help__nu__hist__db"
      ;;
    atuin__import__help,replxx)
      cmd="atuin__import__help__replxx"
      ;;
    atuin__import__help,resh)
      cmd="atuin__import__help__resh"
      ;;
    atuin__import__help,xonsh)
      cmd="atuin__import__help__xonsh"
      ;;
    atuin__import__help,xonsh-sqlite)
      cmd="atuin__import__help__xonsh__sqlite"
      ;;
    atuin__import__help,zsh)
      cmd="atuin__import__help__zsh"
      ;;
    atuin__import__help,zsh-hist-db)
      cmd="atuin__import__help__zsh__hist__db"
      ;;
    atuin__kv,delete)
      cmd="atuin__kv__delete"
      ;;
    atuin__kv,get)
      cmd="atuin__kv__get"
      ;;
    atuin__kv,help)
      cmd="atuin__kv__help"
      ;;
    atuin__kv,list)
      cmd="atuin__kv__list"
      ;;
    atuin__kv,rebuild)
      cmd="atuin__kv__rebuild"
      ;;
    atuin__kv,set)
      cmd="atuin__kv__set"
      ;;
    atuin__kv__help,delete)
      cmd="atuin__kv__help__delete"
      ;;
    atuin__kv__help,get)
      cmd="atuin__kv__help__get"
      ;;
    atuin__kv__help,help)
      cmd="atuin__kv__help__help"
      ;;
    atuin__kv__help,list)
      cmd="atuin__kv__help__list"
      ;;
    atuin__kv__help,rebuild)
      cmd="atuin__kv__help__rebuild"
      ;;
    atuin__kv__help,set)
      cmd="atuin__kv__help__set"
      ;;
    atuin__scripts,delete)
      cmd="atuin__scripts__delete"
      ;;
    atuin__scripts,edit)
      cmd="atuin__scripts__edit"
      ;;
    atuin__scripts,get)
      cmd="atuin__scripts__get"
      ;;
    atuin__scripts,help)
      cmd="atuin__scripts__help"
      ;;
    atuin__scripts,list)
      cmd="atuin__scripts__list"
      ;;
    atuin__scripts,new)
      cmd="atuin__scripts__new"
      ;;
    atuin__scripts,run)
      cmd="atuin__scripts__run"
      ;;
    atuin__scripts__help,delete)
      cmd="atuin__scripts__help__delete"
      ;;
    atuin__scripts__help,edit)
      cmd="atuin__scripts__help__edit"
      ;;
    atuin__scripts__help,get)
      cmd="atuin__scripts__help__get"
      ;;
    atuin__scripts__help,help)
      cmd="atuin__scripts__help__help"
      ;;
    atuin__scripts__help,list)
      cmd="atuin__scripts__help__list"
      ;;
    atuin__scripts__help,new)
      cmd="atuin__scripts__help__new"
      ;;
    atuin__scripts__help,run)
      cmd="atuin__scripts__help__run"
      ;;
    atuin__server,default-config)
      cmd="atuin__server__default__config"
      ;;
    atuin__server,help)
      cmd="atuin__server__help"
      ;;
    atuin__server,start)
      cmd="atuin__server__start"
      ;;
    atuin__server__help,default-config)
      cmd="atuin__server__help__default__config"
      ;;
    atuin__server__help,help)
      cmd="atuin__server__help__help"
      ;;
    atuin__server__help,start)
      cmd="atuin__server__help__start"
      ;;
    atuin__store,help)
      cmd="atuin__store__help"
      ;;
    atuin__store,pull)
      cmd="atuin__store__pull"
      ;;
    atuin__store,purge)
      cmd="atuin__store__purge"
      ;;
    atuin__store,push)
      cmd="atuin__store__push"
      ;;
    atuin__store,rebuild)
      cmd="atuin__store__rebuild"
      ;;
    atuin__store,rekey)
      cmd="atuin__store__rekey"
      ;;
    atuin__store,status)
      cmd="atuin__store__status"
      ;;
    atuin__store,verify)
      cmd="atuin__store__verify"
      ;;
    atuin__store__help,help)
      cmd="atuin__store__help__help"
      ;;
    atuin__store__help,pull)
      cmd="atuin__store__help__pull"
      ;;
    atuin__store__help,purge)
      cmd="atuin__store__help__purge"
      ;;
    atuin__store__help,push)
      cmd="atuin__store__help__push"
      ;;
    atuin__store__help,rebuild)
      cmd="atuin__store__help__rebuild"
      ;;
    atuin__store__help,rekey)
      cmd="atuin__store__help__rekey"
      ;;
    atuin__store__help,status)
      cmd="atuin__store__help__status"
      ;;
    atuin__store__help,verify)
      cmd="atuin__store__help__verify"
      ;;
    *) ;;
    esac
  done

  case "${cmd}" in
  atuin)
    opts="-h -V --help --version history import stats search sync login logout register key status account kv store dotfiles scripts init info doctor wrapped daemon default-config server uuid contributors gen-completions help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account)
    opts="-h --help login register logout delete change-password verify help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__change__password)
    opts="-c -n -h --current-password --new-password --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --current-password)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -c)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --new-password)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__delete)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__help)
    opts="login register logout delete change-password verify help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__help__change__password)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__help__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__help__login)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__help__logout)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__help__register)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__help__verify)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__login)
    opts="-u -p -k -h --username --password --key --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --username)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -u)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --password)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -p)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --key)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -k)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__logout)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__register)
    opts="-u -p -e -h --username --password --email --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --username)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -u)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --password)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -p)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --email)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -e)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__account__verify)
    opts="-t -h --token --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --token)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -t)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__contributors)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__daemon)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__default__config)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__doctor)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles)
    opts="-h --help alias var help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__alias)
    opts="-h --help set delete list clear help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__alias__clear)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__alias__delete)
    opts="-h --help <NAME>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__alias__help)
    opts="set delete list clear help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__alias__help__clear)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__alias__help__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__alias__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__alias__help__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__alias__help__set)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__alias__list)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__alias__set)
    opts="-h --help <NAME> <VALUE>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__help)
    opts="alias var help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__help__alias)
    opts="set delete list clear"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__help__alias__clear)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__help__alias__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__help__alias__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__help__alias__set)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__help__var)
    opts="set delete list"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__help__var__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__help__var__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__help__var__set)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__var)
    opts="-h --help set delete list help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__var__delete)
    opts="-h --help <NAME>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__var__help)
    opts="set delete list help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__var__help__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__var__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__var__help__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__var__help__set)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__var__list)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__dotfiles__var__set)
    opts="-n -h --no-export --help <NAME> <VALUE>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__gen__completions)
    opts="-s -o -h --shell --out-dir --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --shell)
      COMPREPLY=($(compgen -W "bash elvish fish nushell powershell zsh" -- "${cur}"))
      return 0
      ;;
    -s)
      COMPREPLY=($(compgen -W "bash elvish fish nushell powershell zsh" -- "${cur}"))
      return 0
      ;;
    --out-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -o)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help)
    opts="history import stats search sync login logout register key status account kv store dotfiles scripts init info doctor wrapped daemon default-config server uuid contributors gen-completions help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__account)
    opts="login register logout delete change-password verify"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__account__change__password)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__account__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__account__login)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__account__logout)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__account__register)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__account__verify)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__contributors)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__daemon)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__default__config)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__doctor)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__dotfiles)
    opts="alias var"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__dotfiles__alias)
    opts="set delete list clear"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__dotfiles__alias__clear)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__dotfiles__alias__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__dotfiles__alias__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__dotfiles__alias__set)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__dotfiles__var)
    opts="set delete list"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__dotfiles__var__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__dotfiles__var__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__dotfiles__var__set)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 5 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__gen__completions)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__history)
    opts="start end list last init-store prune dedup"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__history__dedup)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__history__end)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__history__init__store)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__history__last)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__history__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__history__prune)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__history__start)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import)
    opts="auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import__auto)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import__bash)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import__fish)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import__nu)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import__nu__hist__db)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import__replxx)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import__resh)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import__xonsh)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import__xonsh__sqlite)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import__zsh)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__import__zsh__hist__db)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__info)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__init)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__key)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__kv)
    opts="set delete get list rebuild"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__kv__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__kv__get)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__kv__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__kv__rebuild)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__kv__set)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__login)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__logout)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__register)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__scripts)
    opts="new run list get edit delete"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__scripts__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__scripts__edit)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__scripts__get)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__scripts__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__scripts__new)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__scripts__run)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__search)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__server)
    opts="start default-config"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__server__default__config)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__server__start)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__stats)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__status)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__store)
    opts="status rebuild rekey purge verify push pull"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__store__pull)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__store__purge)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__store__push)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__store__rebuild)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__store__rekey)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__store__status)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__store__verify)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__sync)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__uuid)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__help__wrapped)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history)
    opts="-h --help start end list last init-store prune dedup help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__dedup)
    opts="-n -b -h --dry-run --before --dupkeep --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --before)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -b)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --dupkeep)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__end)
    opts="-e -d -h --exit --duration --help <ID>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --exit)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -e)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --duration)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -d)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__help)
    opts="start end list last init-store prune dedup help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__help__dedup)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__help__end)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__help__init__store)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__help__last)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__help__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__help__prune)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__help__start)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__init__store)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__last)
    opts="-f -h --human --cmd-only --tz --timezone --format --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --timezone)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --tz)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --format)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -f)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__list)
    opts="-c -s -r -f -h --cwd --session --human --cmd-only --print0 --reverse --tz --timezone --format --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --reverse)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    -r)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --timezone)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --tz)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --format)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -f)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__prune)
    opts="-n -h --dry-run --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__history__start)
    opts="-h --help [COMMAND]..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import)
    opts="-h --help auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__auto)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__bash)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__fish)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help)
    opts="auto zsh zsh-hist-db bash replxx resh fish nu nu-hist-db xonsh xonsh-sqlite help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__auto)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__bash)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__fish)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__nu)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__nu__hist__db)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__replxx)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__resh)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__xonsh)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__xonsh__sqlite)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__zsh)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__help__zsh__hist__db)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__nu)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__nu__hist__db)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__replxx)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__resh)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__xonsh)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__xonsh__sqlite)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__zsh)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__import__zsh__hist__db)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__info)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__init)
    opts="-h --disable-ctrl-r --disable-up-arrow --help zsh bash fish nu xonsh"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__key)
    opts="-h --base64 --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv)
    opts="-h --help set delete get list rebuild help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__delete)
    opts="-n -h --namespace --help <KEYS>..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --namespace)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__get)
    opts="-n -h --namespace --help <KEY>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --namespace)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__help)
    opts="set delete get list rebuild help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__help__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__help__get)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__help__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__help__rebuild)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__help__set)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__list)
    opts="-n -a -h --namespace --all-namespaces --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --namespace)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__rebuild)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__kv__set)
    opts="-k -n -h --key --namespace --help <VALUE>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --key)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -k)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --namespace)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__login)
    opts="-u -p -k -h --username --password --key --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --username)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -u)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --password)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -p)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --key)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -k)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__logout)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__register)
    opts="-u -p -e -h --username --password --email --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --username)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -u)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --password)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -p)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --email)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -e)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts)
    opts="-h --help new run list get edit delete help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__delete)
    opts="-f -h --force --help <NAME>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__edit)
    opts="-d -t -s -h --description --tags --no-tags --rename --shebang --script --no-edit --help <NAME>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --description)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -d)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --tags)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -t)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --rename)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --shebang)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -s)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --script)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__get)
    opts="-s -h --script --help <NAME>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__help)
    opts="new run list get edit delete help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__help__delete)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__help__edit)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__help__get)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__help__list)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__help__new)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__help__run)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__list)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__new)
    opts="-d -t -s -h --description --tags --shebang --script --last --no-edit --help <NAME>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --description)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -d)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --tags)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -t)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --shebang)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -s)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --script)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --last)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__scripts__run)
    opts="-v -h --var --help <NAME>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --var)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -v)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__search)
    opts="-c -e -b -i -r -f -h --cwd --exclude-cwd --exit --exclude-exit --before --after --limit --offset --interactive --filter-mode --search-mode --shell-up-key-binding --keymap-mode --human --cmd-only --print0 --delete --delete-it-all --reverse --tz --timezone --format --inline-height --include-duplicates --help [QUERY]..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --cwd)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -c)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --exclude-cwd)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --exit)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -e)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --exclude-exit)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --before)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -b)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --after)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --limit)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --offset)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --filter-mode)
      COMPREPLY=($(compgen -W "global host session directory workspace" -- "${cur}"))
      return 0
      ;;
    --search-mode)
      COMPREPLY=($(compgen -W "prefix full-text fuzzy skim" -- "${cur}"))
      return 0
      ;;
    --keymap-mode)
      COMPREPLY=($(compgen -W "emacs vim-normal vim-insert auto" -- "${cur}"))
      return 0
      ;;
    --timezone)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --tz)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --format)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -f)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --inline-height)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__server)
    opts="-h --help start default-config help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__server__default__config)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__server__help)
    opts="start default-config help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__server__help__default__config)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__server__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__server__help__start)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__server__start)
    opts="-p -h --host --port --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --host)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --port)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -p)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__stats)
    opts="-c -n -h --count --ngram-size --help [PERIOD]..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --count)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -c)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --ngram-size)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__status)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store)
    opts="-h --help status rebuild rekey purge verify push pull help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__help)
    opts="status rebuild rekey purge verify push pull help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__help__help)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__help__pull)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__help__purge)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__help__push)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__help__rebuild)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__help__rekey)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__help__status)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__help__verify)
    opts=""
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 4 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__pull)
    opts="-t -h --tag --force --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --tag)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -t)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__purge)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__push)
    opts="-t -h --tag --host --force --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --tag)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -t)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --host)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__rebuild)
    opts="-h --help <TAG>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__rekey)
    opts="-h --help [KEY]"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__status)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__store__verify)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__sync)
    opts="-f -h --force --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__uuid)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  atuin__wrapped)
    opts="-h --help [YEAR]"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  esac
}

if [[ "${BASH_VERSINFO[0]}" -eq 4 && "${BASH_VERSINFO[1]}" -ge 4 || "${BASH_VERSINFO[0]}" -gt 4 ]]; then
  complete -F _atuin -o nosort -o bashdefault -o default atuin
else
  complete -F _atuin -o bashdefault -o default atuin
fi

###############################################################################
# GH LICENSE AUTOCOMPLETE
###############################################################################

# bash completion V2 for gh-license                           -*- shell-script -*-

__gh-license_debug() {
  if [[ -n ${BASH_COMP_DEBUG_FILE:-} ]]; then
    echo "$*" >>"${BASH_COMP_DEBUG_FILE}"
  fi
}

# Macs have bash3 for which the bash-completion package doesn't include
# _init_completion. This is a minimal version of that function.
__gh-license_init_completion() {
  COMPREPLY=()
  _get_comp_words_by_ref "$@" cur prev words cword
}

# This function calls the gh-license program to obtain the completion
# results and the directive.  It fills the 'out' and 'directive' vars.
__gh-license_get_completion_results() {
  local requestComp lastParam lastChar args

  # Prepare the command to request completions for the program.
  # Calling ${words[0]} instead of directly gh-license allows to handle aliases
  args=("${words[@]:1}")
  requestComp="${words[0]} __complete ${args[*]}"

  lastParam=${words[$((${#words[@]} - 1))]}
  lastChar=${lastParam:$((${#lastParam} - 1)):1}
  __gh-license_debug "lastParam ${lastParam}, lastChar ${lastChar}"

  if [ -z "${cur}" ] && [ "${lastChar}" != "=" ]; then
    # If the last parameter is complete (there is a space following it)
    # We add an extra empty parameter so we can indicate this to the go method.
    __gh-license_debug "Adding extra empty parameter"
    requestComp="${requestComp} ''"
  fi

  # When completing a flag with an = (e.g., gh-license -n=<TAB>)
  # bash focuses on the part after the =, so we need to remove
  # the flag part from $cur
  if [[ "${cur}" == -*=* ]]; then
    cur="${cur#*=}"
  fi

  __gh-license_debug "Calling ${requestComp}"
  # Use eval to handle any environment variables and such
  out=$(eval "${requestComp}" 2>/dev/null)

  # Extract the directive integer at the very end of the output following a colon (:)
  directive=${out##*:}
  # Remove the directive
  out=${out%:*}
  if [ "${directive}" = "${out}" ]; then
    # There is not directive specified
    directive=0
  fi
  __gh-license_debug "The completion directive is: ${directive}"
  __gh-license_debug "The completions are: ${out}"
}

__gh-license_process_completion_results() {
  local shellCompDirectiveError=1
  local shellCompDirectiveNoSpace=2
  local shellCompDirectiveNoFileComp=4
  local shellCompDirectiveFilterFileExt=8
  local shellCompDirectiveFilterDirs=16

  if [ $((directive & shellCompDirectiveError)) -ne 0 ]; then
    # Error code.  No completion.
    __gh-license_debug "Received error from custom completion go code"
    return
  else
    if [ $((directive & shellCompDirectiveNoSpace)) -ne 0 ]; then
      if [[ $(type -t compopt) = "builtin" ]]; then
        __gh-license_debug "Activating no space"
        compopt -o nospace
      else
        __gh-license_debug "No space directive not supported in this version of bash"
      fi
    fi
    if [ $((directive & shellCompDirectiveNoFileComp)) -ne 0 ]; then
      if [[ $(type -t compopt) = "builtin" ]]; then
        __gh-license_debug "Activating no file completion"
        compopt +o default
      else
        __gh-license_debug "No file completion directive not supported in this version of bash"
      fi
    fi
  fi

  # Separate activeHelp from normal completions
  local completions=()
  local activeHelp=()
  __gh-license_extract_activeHelp

  if [ $((directive & shellCompDirectiveFilterFileExt)) -ne 0 ]; then
    # File extension filtering
    local fullFilter filter filteringCmd

    # Do not use quotes around the $completions variable or else newline
    # characters will be kept.
    for filter in ${completions[*]}; do
      fullFilter+="$filter|"
    done

    filteringCmd="_filedir $fullFilter"
    __gh-license_debug "File filtering command: $filteringCmd"
    $filteringCmd
  elif [ $((directive & shellCompDirectiveFilterDirs)) -ne 0 ]; then
    # File completion for directories only

    # Use printf to strip any trailing newline
    local subdir
    subdir=$(printf "%s" "${completions[0]}")
    if [ -n "$subdir" ]; then
      __gh-license_debug "Listing directories in $subdir"
      pushd "$subdir" >/dev/null 2>&1 && _filedir -d && popd >/dev/null 2>&1 || return
    else
      __gh-license_debug "Listing directories in ."
      _filedir -d
    fi
  else
    __gh-license_handle_completion_types
  fi

  __gh-license_handle_special_char "$cur" :
  __gh-license_handle_special_char "$cur" =

  # Print the activeHelp statements before we finish
  if [ ${#activeHelp[*]} -ne 0 ]; then
    printf "\n"
    printf "%s\n" "${activeHelp[@]}"
    printf "\n"

    # The prompt format is only available from bash 4.4.
    # We test if it is available before using it.
    if (x=${PS1@P}) 2>/dev/null; then
      printf "%s" "${PS1@P}${COMP_LINE[@]}"
    else
      # Can't print the prompt.  Just print the
      # text the user had typed, it is workable enough.
      printf "%s" "${COMP_LINE[@]}"
    fi
  fi
}

# Separate activeHelp lines from real completions.
# Fills the $activeHelp and $completions arrays.
__gh-license_extract_activeHelp() {
  local activeHelpMarker="_activeHelp_ "
  local endIndex=${#activeHelpMarker}

  while IFS='' read -r comp; do
    if [ "${comp:0:endIndex}" = "$activeHelpMarker" ]; then
      comp=${comp:endIndex}
      __gh-license_debug "ActiveHelp found: $comp"
      if [ -n "$comp" ]; then
        activeHelp+=("$comp")
      fi
    else
      # Not an activeHelp line but a normal completion
      completions+=("$comp")
    fi
  done < <(printf "%s\n" "${out}")
}

__gh-license_handle_completion_types() {
  __gh-license_debug "__gh-license_handle_completion_types: COMP_TYPE is $COMP_TYPE"

  case $COMP_TYPE in
  37 | 42)
    # Type: menu-complete/menu-complete-backward and insert-completions
    # If the user requested inserting one completion at a time, or all
    # completions at once on the command-line we must remove the descriptions.
    # https://github.com/spf13/cobra/issues/1508
    local tab=$'\t' comp
    while IFS='' read -r comp; do
      [[ -z $comp ]] && continue
      # Strip any description
      comp=${comp%%$tab*}
      # Only consider the completions that match
      if [[ $comp == "$cur"* ]]; then
        COMPREPLY+=("$comp")
      fi
    done < <(printf "%s\n" "${completions[@]}")
    ;;

  *)
    # Type: complete (normal completion)
    __gh-license_handle_standard_completion_case
    ;;
  esac
}

__gh-license_handle_standard_completion_case() {
  local tab=$'\t' comp

  # Short circuit to optimize if we don't have descriptions
  if [[ "${completions[*]}" != *$tab* ]]; then
    IFS=$'\n' read -ra COMPREPLY -d '' < <(compgen -W "${completions[*]}" -- "$cur")
    return 0
  fi

  local longest=0
  local compline
  # Look for the longest completion so that we can format things nicely
  while IFS='' read -r compline; do
    [[ -z $compline ]] && continue
    # Strip any description before checking the length
    comp=${compline%%$tab*}
    # Only consider the completions that match
    [[ $comp == "$cur"* ]] || continue
    COMPREPLY+=("$compline")
    if ((${#comp} > longest)); then
      longest=${#comp}
    fi
  done < <(printf "%s\n" "${completions[@]}")

  # If there is a single completion left, remove the description text
  if [ ${#COMPREPLY[*]} -eq 1 ]; then
    __gh-license_debug "COMPREPLY[0]: ${COMPREPLY[0]}"
    comp="${COMPREPLY[0]%%$tab*}"
    __gh-license_debug "Removed description from single completion, which is now: ${comp}"
    COMPREPLY[0]=$comp
  else # Format the descriptions
    __gh-license_format_comp_descriptions $longest
  fi
}

__gh-license_handle_special_char() {
  local comp="$1"
  local char=$2
  if [[ "$comp" == *${char}* && "$COMP_WORDBREAKS" == *${char}* ]]; then
    local word=${comp%"${comp##*${char}}"}
    local idx=${#COMPREPLY[*]}
    while [[ $((--idx)) -ge 0 ]]; do
      COMPREPLY[$idx]=${COMPREPLY[$idx]#"$word"}
    done
  fi
}

__gh-license_format_comp_descriptions() {
  local tab=$'\t'
  local comp desc maxdesclength
  local longest=$1

  local i ci
  for ci in ${!COMPREPLY[*]}; do
    comp=${COMPREPLY[ci]}
    # Properly format the description string which follows a tab character if there is one
    if [[ "$comp" == *$tab* ]]; then
      __gh-license_debug "Original comp: $comp"
      desc=${comp#*$tab}
      comp=${comp%%$tab*}

      # $COLUMNS stores the current shell width.
      # Remove an extra 4 because we add 2 spaces and 2 parentheses.
      maxdesclength=$((COLUMNS - longest - 4))

      # Make sure we can fit a description of at least 8 characters
      # if we are to align the descriptions.
      if [[ $maxdesclength -gt 8 ]]; then
        # Add the proper number of spaces to align the descriptions
        for ((i = ${#comp}; i < longest; i++)); do
          comp+=" "
        done
      else
        # Don't pad the descriptions so we can fit more text after the completion
        maxdesclength=$((COLUMNS - ${#comp} - 4))
      fi

      # If there is enough space for any description text,
      # truncate the descriptions that are too long for the shell width
      if [ $maxdesclength -gt 0 ]; then
        if [ ${#desc} -gt $maxdesclength ]; then
          desc=${desc:0:$((maxdesclength - 1))}
          desc+="…"
        fi
        comp+="  ($desc)"
      fi
      COMPREPLY[ci]=$comp
      __gh-license_debug "Final comp: $comp"
    fi
  done
}

__start_gh-license() {
  local cur prev words cword split

  COMPREPLY=()

  # Call _init_completion from the bash-completion package
  # to prepare the arguments properly
  if declare -F _init_completion >/dev/null 2>&1; then
    _init_completion -n "=:" || return
  else
    __gh-license_init_completion -n "=:" || return
  fi

  __gh-license_debug
  __gh-license_debug "========= starting completion logic =========="
  __gh-license_debug "cur is ${cur}, words[*] is ${words[*]}, #words[@] is ${#words[@]}, cword is $cword"

  # The user could have moved the cursor backwards on the command-line.
  # We need to trigger completion from the $cword location, so we need
  # to truncate the command-line ($words) up to the $cword location.
  words=("${words[@]:0:$cword+1}")
  __gh-license_debug "Truncated words[*]: ${words[*]},"

  local out directive
  __gh-license_get_completion_results
  __gh-license_process_completion_results
}

if [[ $(type -t compopt) = "builtin" ]]; then
  complete -o default -F __start_gh-license gh-license
else
  complete -o default -o nospace -F __start_gh-license gh-license
fi

###############################################################################
# ZELLIJ AUTOCOMPLETE
###############################################################################

_zellij() {
  local i cur prev opts cmds
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD - 1]}"
  cmd=""
  opts=""

  for i in ${COMP_WORDS[@]}; do
    case "${i}" in
    "$1")
      cmd="zellij"
      ;;
    action)
      cmd+="__action"
      ;;
    attach)
      cmd+="__attach"
      ;;
    clear)
      cmd+="__clear"
      ;;
    close-pane)
      cmd+="__close__pane"
      ;;
    close-tab)
      cmd+="__close__tab"
      ;;
    convert-config)
      cmd+="__convert__config"
      ;;
    convert-layout)
      cmd+="__convert__layout"
      ;;
    convert-theme)
      cmd+="__convert__theme"
      ;;
    delete-all-sessions)
      cmd+="__delete__all__sessions"
      ;;
    delete-session)
      cmd+="__delete__session"
      ;;
    dump-layout)
      cmd+="__dump__layout"
      ;;
    dump-screen)
      cmd+="__dump__screen"
      ;;
    edit)
      cmd+="__edit"
      ;;
    edit-scrollback)
      cmd+="__edit__scrollback"
      ;;
    focus-next-pane)
      cmd+="__focus__next__pane"
      ;;
    focus-previous-pane)
      cmd+="__focus__previous__pane"
      ;;
    go-to-next-tab)
      cmd+="__go__to__next__tab"
      ;;
    go-to-previous-tab)
      cmd+="__go__to__previous__tab"
      ;;
    go-to-tab)
      cmd+="__go__to__tab"
      ;;
    go-to-tab-name)
      cmd+="__go__to__tab__name"
      ;;
    half-page-scroll-down)
      cmd+="__half__page__scroll__down"
      ;;
    half-page-scroll-up)
      cmd+="__half__page__scroll__up"
      ;;
    help)
      cmd+="__help"
      ;;
    kill-all-sessions)
      cmd+="__kill__all__sessions"
      ;;
    kill-session)
      cmd+="__kill__session"
      ;;
    launch-or-focus-plugin)
      cmd+="__launch__or__focus__plugin"
      ;;
    launch-plugin)
      cmd+="__launch__plugin"
      ;;
    list-aliases)
      cmd+="__list__aliases"
      ;;
    list-clients)
      cmd+="__list__clients"
      ;;
    list-sessions)
      cmd+="__list__sessions"
      ;;
    move-focus)
      cmd+="__move__focus"
      ;;
    move-focus-or-tab)
      cmd+="__move__focus__or__tab"
      ;;
    move-pane)
      cmd+="__move__pane"
      ;;
    move-pane-backwards)
      cmd+="__move__pane__backwards"
      ;;
    move-tab)
      cmd+="__move__tab"
      ;;
    new-pane)
      cmd+="__new__pane"
      ;;
    new-tab)
      cmd+="__new__tab"
      ;;
    next-swap-layout)
      cmd+="__next__swap__layout"
      ;;
    options)
      cmd+="__options"
      ;;
    page-scroll-down)
      cmd+="__page__scroll__down"
      ;;
    page-scroll-up)
      cmd+="__page__scroll__up"
      ;;
    pipe)
      cmd+="__pipe"
      ;;
    plugin)
      cmd+="__plugin"
      ;;
    previous-swap-layout)
      cmd+="__previous__swap__layout"
      ;;
    query-tab-names)
      cmd+="__query__tab__names"
      ;;
    rename-pane)
      cmd+="__rename__pane"
      ;;
    rename-session)
      cmd+="__rename__session"
      ;;
    rename-tab)
      cmd+="__rename__tab"
      ;;
    resize)
      cmd+="__resize"
      ;;
    run)
      cmd+="__run"
      ;;
    scroll-down)
      cmd+="__scroll__down"
      ;;
    scroll-to-bottom)
      cmd+="__scroll__to__bottom"
      ;;
    scroll-to-top)
      cmd+="__scroll__to__top"
      ;;
    scroll-up)
      cmd+="__scroll__up"
      ;;
    setup)
      cmd+="__setup"
      ;;
    start-or-reload-plugin)
      cmd+="__start__or__reload__plugin"
      ;;
    switch-mode)
      cmd+="__switch__mode"
      ;;
    toggle-active-sync-tab)
      cmd+="__toggle__active__sync__tab"
      ;;
    toggle-floating-panes)
      cmd+="__toggle__floating__panes"
      ;;
    toggle-fullscreen)
      cmd+="__toggle__fullscreen"
      ;;
    toggle-pane-embed-or-floating)
      cmd+="__toggle__pane__embed__or__floating"
      ;;
    toggle-pane-frames)
      cmd+="__toggle__pane__frames"
      ;;
    undo-rename-pane)
      cmd+="__undo__rename__pane"
      ;;
    undo-rename-tab)
      cmd+="__undo__rename__tab"
      ;;
    write)
      cmd+="__write"
      ;;
    write-chars)
      cmd+="__write__chars"
      ;;
    *) ;;
    esac
  done

  case "${cmd}" in
  zellij)
    opts="-h -V -s -l -c -d --help --version --max-panes --data-dir --server --session --layout --config --config-dir --debug options setup list-sessions list-aliases attach kill-session delete-session kill-all-sessions delete-all-sessions action run plugin edit convert-config convert-layout convert-theme pipe help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 1 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --max-panes)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --data-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --server)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --session)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -s)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --layout)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -l)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -c)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --config-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action)
    opts="-h --help write write-chars resize focus-next-pane focus-previous-pane move-focus move-focus-or-tab move-pane move-pane-backwards clear dump-screen dump-layout edit-scrollback scroll-up scroll-down scroll-to-bottom scroll-to-top page-scroll-up page-scroll-down half-page-scroll-up half-page-scroll-down toggle-fullscreen toggle-pane-frames toggle-active-sync-tab new-pane edit switch-mode toggle-pane-embed-or-floating toggle-floating-panes close-pane rename-pane undo-rename-pane go-to-next-tab go-to-previous-tab close-tab go-to-tab go-to-tab-name rename-tab undo-rename-tab new-tab move-tab previous-swap-layout next-swap-layout query-tab-names start-or-reload-plugin launch-or-focus-plugin launch-plugin rename-session pipe list-clients help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__clear)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__close__pane)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__close__tab)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__dump__layout)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__dump__screen)
    opts="-f -h --full --help <PATH>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__edit)
    opts="-d -l -f -i -x -y -h --direction --line-number --floating --in-place --cwd --x --y --width --height --help <FILE>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --direction)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -d)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --line-number)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -l)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --cwd)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --x)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -x)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --y)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -y)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --width)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --height)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__edit__scrollback)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__focus__next__pane)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__focus__previous__pane)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__go__to__next__tab)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__go__to__previous__tab)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__go__to__tab)
    opts="-h --help <INDEX>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__go__to__tab__name)
    opts="-c -h --create --help <NAME>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__half__page__scroll__down)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__half__page__scroll__up)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__help)
    opts="<SUBCOMMAND>..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__launch__or__focus__plugin)
    opts="-f -i -m -c -s -h --floating --in-place --move-to-focused-tab --configuration --skip-plugin-cache --help <URL>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --configuration)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -c)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__launch__plugin)
    opts="-f -i -c -s -h --floating --in-place --configuration --skip-plugin-cache --help <URL>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --configuration)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -c)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__list__clients)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__move__focus)
    opts="-h --help <DIRECTION>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__move__focus__or__tab)
    opts="-h --help <DIRECTION>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__move__pane)
    opts="-h --help <DIRECTION>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__move__pane__backwards)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__move__tab)
    opts="-h --help <DIRECTION>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__new__pane)
    opts="-d -p -f -i -n -c -s -x -y -h --direction --plugin --cwd --floating --in-place --name --close-on-exit --start-suspended --configuration --skip-plugin-cache --x --y --width --height --help <COMMAND>..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --direction)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -d)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --plugin)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -p)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --cwd)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --name)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --configuration)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --x)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -x)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --y)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -y)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --width)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --height)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__new__tab)
    opts="-l -n -c -h --layout --layout-dir --name --cwd --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --layout)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -l)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --layout-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --name)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --cwd)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -c)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__next__swap__layout)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__page__scroll__down)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__page__scroll__up)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__pipe)
    opts="-n -a -p -c -l -s -f -i -w -t -h --name --args --plugin --plugin-configuration --force-launch-plugin --skip-plugin-cache --floating-plugin --in-place-plugin --plugin-cwd --plugin-title --help <PAYLOAD>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --name)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --args)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -a)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --plugin)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -p)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --plugin-configuration)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -c)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --floating-plugin)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    -f)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --in-place-plugin)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    -i)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --plugin-cwd)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -w)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --plugin-title)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -t)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__previous__swap__layout)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__query__tab__names)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__rename__pane)
    opts="-h --help <NAME>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__rename__session)
    opts="-h --help <NAME>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__rename__tab)
    opts="-h --help <NAME>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__resize)
    opts="-h --help <RESIZE> <DIRECTION>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__scroll__down)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__scroll__to__bottom)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__scroll__to__top)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__scroll__up)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__start__or__reload__plugin)
    opts="-c -h --configuration --help <URL>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --configuration)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -c)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__switch__mode)
    opts="-h --help <INPUT_MODE>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__toggle__active__sync__tab)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__toggle__floating__panes)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__toggle__fullscreen)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__toggle__pane__embed__or__floating)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__toggle__pane__frames)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__undo__rename__pane)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__undo__rename__tab)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__write)
    opts="-h --help <BYTES>..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__action__write__chars)
    opts="-h --help <CHARS>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__attach)
    opts="-c -b -f -h --create --create-background --index --force-run-commands --help <SESSION_NAME> options help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --index)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__attach__help)
    opts="<SUBCOMMAND>..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__attach__options)
    opts="-h --disable-mouse-mode --no-pane-frames --simplified-ui --theme --default-mode --default-shell --default-cwd --default-layout --layout-dir --theme-dir --mouse-mode --pane-frames --mirror-session --on-force-close --scroll-buffer-size --copy-command --copy-clipboard --copy-on-select --scrollback-editor --session-name --attach-to-session --auto-layout --session-serialization --serialize-pane-viewport --scrollback-lines-to-serialize --styled-underlines --serialization-interval --disable-session-metadata --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 3 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --simplified-ui)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --theme)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --default-mode)
      COMPREPLY=($(compgen -W "normal locked resize pane tab scroll enter-search search rename-tab rename-pane session move prompt tmux" -- "${cur}"))
      return 0
      ;;
    --default-shell)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --default-cwd)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --default-layout)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --layout-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --theme-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --mouse-mode)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --pane-frames)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --mirror-session)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --on-force-close)
      COMPREPLY=($(compgen -W "quit detach" -- "${cur}"))
      return 0
      ;;
    --scroll-buffer-size)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --copy-command)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --copy-clipboard)
      COMPREPLY=($(compgen -W "system primary" -- "${cur}"))
      return 0
      ;;
    --copy-on-select)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --scrollback-editor)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --session-name)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --attach-to-session)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --auto-layout)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --session-serialization)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --serialize-pane-viewport)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --scrollback-lines-to-serialize)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --styled-underlines)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --serialization-interval)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --disable-session-metadata)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__convert__config)
    opts="-h --help <OLD_CONFIG_FILE>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__convert__layout)
    opts="-h --help <OLD_LAYOUT_FILE>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__convert__theme)
    opts="-h --help <OLD_THEME_FILE>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__delete__all__sessions)
    opts="-y -f -h --yes --force --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__delete__session)
    opts="-f -h --force --help <TARGET_SESSION>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__edit)
    opts="-l -d -i -f -x -y -h --line-number --direction --in-place --floating --cwd --x --y --width --height --help <FILE>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --line-number)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -l)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --direction)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -d)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --cwd)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --x)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -x)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --y)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -y)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --width)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --height)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__help)
    opts="<SUBCOMMAND>..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__kill__all__sessions)
    opts="-y -h --yes --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__kill__session)
    opts="-h --help <TARGET_SESSION>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__list__aliases)
    opts="-h --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__list__sessions)
    opts="-n -s -r -h --no-formatting --short --reverse --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__options)
    opts="-h --disable-mouse-mode --no-pane-frames --simplified-ui --theme --default-mode --default-shell --default-cwd --default-layout --layout-dir --theme-dir --mouse-mode --pane-frames --mirror-session --on-force-close --scroll-buffer-size --copy-command --copy-clipboard --copy-on-select --scrollback-editor --session-name --attach-to-session --auto-layout --session-serialization --serialize-pane-viewport --scrollback-lines-to-serialize --styled-underlines --serialization-interval --disable-session-metadata --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --simplified-ui)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --theme)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --default-mode)
      COMPREPLY=($(compgen -W "normal locked resize pane tab scroll enter-search search rename-tab rename-pane session move prompt tmux" -- "${cur}"))
      return 0
      ;;
    --default-shell)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --default-cwd)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --default-layout)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --layout-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --theme-dir)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --mouse-mode)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --pane-frames)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --mirror-session)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --on-force-close)
      COMPREPLY=($(compgen -W "quit detach" -- "${cur}"))
      return 0
      ;;
    --scroll-buffer-size)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --copy-command)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --copy-clipboard)
      COMPREPLY=($(compgen -W "system primary" -- "${cur}"))
      return 0
      ;;
    --copy-on-select)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --scrollback-editor)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --session-name)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --attach-to-session)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --auto-layout)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --session-serialization)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --serialize-pane-viewport)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --scrollback-lines-to-serialize)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --styled-underlines)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    --serialization-interval)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --disable-session-metadata)
      COMPREPLY=($(compgen -W "true false" -- "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__pipe)
    opts="-n -a -p -c -h --name --args --plugin --plugin-configuration --help <PAYLOAD>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --name)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --args)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -a)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --plugin)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -p)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --plugin-configuration)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -c)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__plugin)
    opts="-c -f -i -s -x -y -h --configuration --floating --in-place --skip-plugin-cache --x --y --width --height --help <URL>"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --configuration)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -c)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --x)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -x)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --y)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -y)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --width)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --height)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__run)
    opts="-d -f -i -n -c -s -x -y -h --direction --cwd --floating --in-place --name --close-on-exit --start-suspended --x --y --width --height --help <COMMAND>..."
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --direction)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -d)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --cwd)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --name)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -n)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --x)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -x)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --y)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    -y)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --width)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --height)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  zellij__setup)
    opts="-h --dump-config --clean --check --dump-layout --dump-swap-layout --dump-plugins --generate-completion --generate-auto-start --help"
    if [[ ${cur} == -* || ${COMP_CWORD} -eq 2 ]]; then
      COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
      return 0
    fi
    case "${prev}" in
    --dump-layout)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --dump-swap-layout)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --dump-plugins)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --generate-completion)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    --generate-auto-start)
      COMPREPLY=($(compgen -f "${cur}"))
      return 0
      ;;
    *)
      COMPREPLY=()
      ;;
    esac
    COMPREPLY=($(compgen -W "${opts}" -- "${cur}"))
    return 0
    ;;
  esac
}

complete -F _zellij -o bashdefault -o default zellij
function zr() { zellij run --name "$*" -- bash -ic "$*"; }
function zrf() { zellij run --name "$*" --floating -- bash -ic "$*"; }
function zri() { zellij run --name "$*" --in-place -- bash -ic "$*"; }
function ze() { zellij edit "$*"; }
function zef() { zellij edit --floating "$*"; }
function zei() { zellij edit --in-place "$*"; }
function zpipe() {
  if [ -z "$1" ]; then
    zellij pipe
  else
    zellij pipe -p $1
  fi
}

###############################################################################
# CHEZMOI AUTOCOMPLETE
###############################################################################
# bash completion V2 for chezmoi                              -*- shell-script -*-

__chezmoi_debug()
{
    if [[ -n ${BASH_COMP_DEBUG_FILE-} ]]; then
        echo "$*" >> "${BASH_COMP_DEBUG_FILE}"
    fi
}

# Macs have bash3 for which the bash-completion package doesn't include
# _init_completion. This is a minimal version of that function.
__chezmoi_init_completion()
{
    COMPREPLY=()
    _get_comp_words_by_ref "$@" cur prev words cword
}

# This function calls the chezmoi program to obtain the completion
# results and the directive.  It fills the 'out' and 'directive' vars.
__chezmoi_get_completion_results() {
    local requestComp lastParam lastChar args

    # Prepare the command to request completions for the program.
    # Calling ${words[0]} instead of directly chezmoi allows handling aliases
    args=("${words[@]:1}")
    requestComp="${words[0]} __complete ${args[*]}"

    lastParam=${words[$((${#words[@]}-1))]}
    lastChar=${lastParam:$((${#lastParam}-1)):1}
    __chezmoi_debug "lastParam ${lastParam}, lastChar ${lastChar}"

    if [[ -z ${cur} && ${lastChar} != = ]]; then
        # If the last parameter is complete (there is a space following it)
        # We add an extra empty parameter so we can indicate this to the go method.
        __chezmoi_debug "Adding extra empty parameter"
        requestComp="${requestComp} ''"
    fi

    # When completing a flag with an = (e.g., chezmoi -n=<TAB>)
    # bash focuses on the part after the =, so we need to remove
    # the flag part from $cur
    if [[ ${cur} == -*=* ]]; then
        cur="${cur#*=}"
    fi

    __chezmoi_debug "Calling ${requestComp}"
    # Use eval to handle any environment variables and such
    out=$(eval "${requestComp}" 2>/dev/null)

    # Extract the directive integer at the very end of the output following a colon (:)
    directive=${out##*:}
    # Remove the directive
    out=${out%:*}
    if [[ ${directive} == "${out}" ]]; then
        # There is not directive specified
        directive=0
    fi
    __chezmoi_debug "The completion directive is: ${directive}"
    __chezmoi_debug "The completions are: ${out}"
}

__chezmoi_process_completion_results() {
    local shellCompDirectiveError=1
    local shellCompDirectiveNoSpace=2
    local shellCompDirectiveNoFileComp=4
    local shellCompDirectiveFilterFileExt=8
    local shellCompDirectiveFilterDirs=16
    local shellCompDirectiveKeepOrder=32

    if (((directive & shellCompDirectiveError) != 0)); then
        # Error code.  No completion.
        __chezmoi_debug "Received error from custom completion go code"
        return
    else
        if (((directive & shellCompDirectiveNoSpace) != 0)); then
            if [[ $(type -t compopt) == builtin ]]; then
                __chezmoi_debug "Activating no space"
                compopt -o nospace
            else
                __chezmoi_debug "No space directive not supported in this version of bash"
            fi
        fi
        if (((directive & shellCompDirectiveKeepOrder) != 0)); then
            if [[ $(type -t compopt) == builtin ]]; then
                # no sort isn't supported for bash less than < 4.4
                if [[ ${BASH_VERSINFO[0]} -lt 4 || ( ${BASH_VERSINFO[0]} -eq 4 && ${BASH_VERSINFO[1]} -lt 4 ) ]]; then
                    __chezmoi_debug "No sort directive not supported in this version of bash"
                else
                    __chezmoi_debug "Activating keep order"
                    compopt -o nosort
                fi
            else
                __chezmoi_debug "No sort directive not supported in this version of bash"
            fi
        fi
        if (((directive & shellCompDirectiveNoFileComp) != 0)); then
            if [[ $(type -t compopt) == builtin ]]; then
                __chezmoi_debug "Activating no file completion"
                compopt +o default
            else
                __chezmoi_debug "No file completion directive not supported in this version of bash"
            fi
        fi
    fi

    # Separate activeHelp from normal completions
    local completions=()
    local activeHelp=()
    __chezmoi_extract_activeHelp

    if (((directive & shellCompDirectiveFilterFileExt) != 0)); then
        # File extension filtering
        local fullFilter="" filter filteringCmd

        # Do not use quotes around the $completions variable or else newline
        # characters will be kept.
        for filter in ${completions[*]}; do
            fullFilter+="$filter|"
        done

        filteringCmd="_filedir $fullFilter"
        __chezmoi_debug "File filtering command: $filteringCmd"
        $filteringCmd
    elif (((directive & shellCompDirectiveFilterDirs) != 0)); then
        # File completion for directories only

        local subdir
        subdir=${completions[0]}
        if [[ -n $subdir ]]; then
            __chezmoi_debug "Listing directories in $subdir"
            pushd "$subdir" >/dev/null 2>&1 && _filedir -d && popd >/dev/null 2>&1 || return
        else
            __chezmoi_debug "Listing directories in ."
            _filedir -d
        fi
    else
        __chezmoi_handle_completion_types
    fi

    __chezmoi_handle_special_char "$cur" :
    __chezmoi_handle_special_char "$cur" =

    # Print the activeHelp statements before we finish
    __chezmoi_handle_activeHelp
}

__chezmoi_handle_activeHelp() {
    # Print the activeHelp statements
    if ((${#activeHelp[*]} != 0)); then
        if [ -z $COMP_TYPE ]; then
            # Bash v3 does not set the COMP_TYPE variable.
            printf "\n";
            printf "%s\n" "${activeHelp[@]}"
            printf "\n"
            __chezmoi_reprint_commandLine
            return
        fi

        # Only print ActiveHelp on the second TAB press
        if [ $COMP_TYPE -eq 63 ]; then
            printf "\n"
            printf "%s\n" "${activeHelp[@]}"

            if ((${#COMPREPLY[*]} == 0)); then
                # When there are no completion choices from the program, file completion
                # may kick in if the program has not disabled it; in such a case, we want
                # to know if any files will match what the user typed, so that we know if
                # there will be completions presented, so that we know how to handle ActiveHelp.
                # To find out, we actually trigger the file completion ourselves;
                # the call to _filedir will fill COMPREPLY if files match.
                if (((directive & shellCompDirectiveNoFileComp) == 0)); then
                    __chezmoi_debug "Listing files"
                    _filedir
                fi
            fi

            if ((${#COMPREPLY[*]} != 0)); then
                # If there are completion choices to be shown, print a delimiter.
                # Re-printing the command-line will automatically be done
                # by the shell when it prints the completion choices.
                printf -- "--"
            else
                # When there are no completion choices at all, we need
                # to re-print the command-line since the shell will
                # not be doing it itself.
                __chezmoi_reprint_commandLine
            fi
        elif [ $COMP_TYPE -eq 37 ] || [ $COMP_TYPE -eq 42 ]; then
            # For completion type: menu-complete/menu-complete-backward and insert-completions
            # the completions are immediately inserted into the command-line, so we first
            # print the activeHelp message and reprint the command-line since the shell won't.
            printf "\n"
            printf "%s\n" "${activeHelp[@]}"

            __chezmoi_reprint_commandLine
        fi
    fi
}

__chezmoi_reprint_commandLine() {
    # The prompt format is only available from bash 4.4.
    # We test if it is available before using it.
    if (x=${PS1@P}) 2> /dev/null; then
        printf "%s" "${PS1@P}${COMP_LINE[@]}"
    else
        # Can't print the prompt.  Just print the
        # text the user had typed, it is workable enough.
        printf "%s" "${COMP_LINE[@]}"
    fi
}

# Separate activeHelp lines from real completions.
# Fills the $activeHelp and $completions arrays.
__chezmoi_extract_activeHelp() {
    local activeHelpMarker="_activeHelp_ "
    local endIndex=${#activeHelpMarker}

    while IFS='' read -r comp; do
        [[ -z $comp ]] && continue

        if [[ ${comp:0:endIndex} == $activeHelpMarker ]]; then
            comp=${comp:endIndex}
            __chezmoi_debug "ActiveHelp found: $comp"
            if [[ -n $comp ]]; then
                activeHelp+=("$comp")
            fi
        else
            # Not an activeHelp line but a normal completion
            completions+=("$comp")
        fi
    done <<<"${out}"
}

__chezmoi_handle_completion_types() {
    __chezmoi_debug "__chezmoi_handle_completion_types: COMP_TYPE is $COMP_TYPE"

    case $COMP_TYPE in
    37|42)
        # Type: menu-complete/menu-complete-backward and insert-completions
        # If the user requested inserting one completion at a time, or all
        # completions at once on the command-line we must remove the descriptions.
        # https://github.com/spf13/cobra/issues/1508

        # If there are no completions, we don't need to do anything
        (( ${#completions[@]} == 0 )) && return 0

        local tab=$'\t'

        # Strip any description and escape the completion to handled special characters
        IFS=$'\n' read -ra completions -d '' < <(printf "%q\n" "${completions[@]%%$tab*}")

        # Only consider the completions that match
        IFS=$'\n' read -ra COMPREPLY -d '' < <(IFS=$'\n'; compgen -W "${completions[*]}" -- "${cur}")

        # compgen looses the escaping so we need to escape all completions again since they will
        # all be inserted on the command-line.
        IFS=$'\n' read -ra COMPREPLY -d '' < <(printf "%q\n" "${COMPREPLY[@]}")
        ;;

    *)
        # Type: complete (normal completion)
        __chezmoi_handle_standard_completion_case
        ;;
    esac
}

__chezmoi_handle_standard_completion_case() {
    local tab=$'\t'

    # If there are no completions, we don't need to do anything
    (( ${#completions[@]} == 0 )) && return 0

    # Short circuit to optimize if we don't have descriptions
    if [[ "${completions[*]}" != *$tab* ]]; then
        # First, escape the completions to handle special characters
        IFS=$'\n' read -ra completions -d '' < <(printf "%q\n" "${completions[@]}")
        # Only consider the completions that match what the user typed
        IFS=$'\n' read -ra COMPREPLY -d '' < <(IFS=$'\n'; compgen -W "${completions[*]}" -- "${cur}")

        # compgen looses the escaping so, if there is only a single completion, we need to
        # escape it again because it will be inserted on the command-line.  If there are multiple
        # completions, we don't want to escape them because they will be printed in a list
        # and we don't want to show escape characters in that list.
        if (( ${#COMPREPLY[@]} == 1 )); then
            COMPREPLY[0]=$(printf "%q" "${COMPREPLY[0]}")
        fi
        return 0
    fi

    local longest=0
    local compline
    # Look for the longest completion so that we can format things nicely
    while IFS='' read -r compline; do
        [[ -z $compline ]] && continue

        # Before checking if the completion matches what the user typed,
        # we need to strip any description and escape the completion to handle special
        # characters because those escape characters are part of what the user typed.
        # Don't call "printf" in a sub-shell because it will be much slower
        # since we are in a loop.
        printf -v comp "%q" "${compline%%$tab*}" &>/dev/null || comp=$(printf "%q" "${compline%%$tab*}")

        # Only consider the completions that match
        [[ $comp == "$cur"* ]] || continue

        # The completions matches.  Add it to the list of full completions including
        # its description.  We don't escape the completion because it may get printed
        # in a list if there are more than one and we don't want show escape characters
        # in that list.
        COMPREPLY+=("$compline")

        # Strip any description before checking the length, and again, don't escape
        # the completion because this length is only used when printing the completions
        # in a list and we don't want show escape characters in that list.
        comp=${compline%%$tab*}
        if ((${#comp}>longest)); then
            longest=${#comp}
        fi
    done < <(printf "%s\n" "${completions[@]}")

    # If there is a single completion left, remove the description text and escape any special characters
    if ((${#COMPREPLY[*]} == 1)); then
        __chezmoi_debug "COMPREPLY[0]: ${COMPREPLY[0]}"
        COMPREPLY[0]=$(printf "%q" "${COMPREPLY[0]%%$tab*}")
        __chezmoi_debug "Removed description from single completion, which is now: ${COMPREPLY[0]}"
    else
        # Format the descriptions
        __chezmoi_format_comp_descriptions $longest
    fi
}

__chezmoi_handle_special_char()
{
    local comp="$1"
    local char=$2
    if [[ "$comp" == *${char}* && "$COMP_WORDBREAKS" == *${char}* ]]; then
        local word=${comp%"${comp##*${char}}"}
        local idx=${#COMPREPLY[*]}
        while ((--idx >= 0)); do
            COMPREPLY[idx]=${COMPREPLY[idx]#"$word"}
        done
    fi
}

__chezmoi_format_comp_descriptions()
{
    local tab=$'\t'
    local comp desc maxdesclength
    local longest=$1

    local i ci
    for ci in ${!COMPREPLY[*]}; do
        comp=${COMPREPLY[ci]}
        # Properly format the description string which follows a tab character if there is one
        if [[ "$comp" == *$tab* ]]; then
            __chezmoi_debug "Original comp: $comp"
            desc=${comp#*$tab}
            comp=${comp%%$tab*}

            # $COLUMNS stores the current shell width.
            # Remove an extra 4 because we add 2 spaces and 2 parentheses.
            maxdesclength=$(( COLUMNS - longest - 4 ))

            # Make sure we can fit a description of at least 8 characters
            # if we are to align the descriptions.
            if ((maxdesclength > 8)); then
                # Add the proper number of spaces to align the descriptions
                for ((i = ${#comp} ; i < longest ; i++)); do
                    comp+=" "
                done
            else
                # Don't pad the descriptions so we can fit more text after the completion
                maxdesclength=$(( COLUMNS - ${#comp} - 4 ))
            fi

            # If there is enough space for any description text,
            # truncate the descriptions that are too long for the shell width
            if ((maxdesclength > 0)); then
                if ((${#desc} > maxdesclength)); then
                    desc=${desc:0:$(( maxdesclength - 1 ))}
                    desc+="…"
                fi
                comp+="  ($desc)"
            fi
            COMPREPLY[ci]=$comp
            __chezmoi_debug "Final comp: $comp"
        fi
    done
}

__start_chezmoi()
{
    local cur prev words cword split

    COMPREPLY=()

    # Call _init_completion from the bash-completion package
    # to prepare the arguments properly
    if declare -F _init_completion >/dev/null 2>&1; then
        _init_completion -n =: || return
    else
        __chezmoi_init_completion -n =: || return
    fi

    __chezmoi_debug
    __chezmoi_debug "========= starting completion logic =========="
    __chezmoi_debug "cur is ${cur}, words[*] is ${words[*]}, #words[@] is ${#words[@]}, cword is $cword"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $cword location, so we need
    # to truncate the command-line ($words) up to the $cword location.
    words=("${words[@]:0:$cword+1}")
    __chezmoi_debug "Truncated words[*]: ${words[*]},"

    local out directive
    __chezmoi_get_completion_results
    __chezmoi_process_completion_results
}

if [[ $(type -t compopt) = "builtin" ]]; then
    complete -o default -F __start_chezmoi chezmoi
else
    complete -o default -o nospace -F __start_chezmoi chezmoi
fi

# ex: ts=4 sw=4 et filetype=sh
