# OhMyZsh git plugin aliases port to Windows Powershell
# From https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

# Git version checking
autoload -Uz is-at-least
git_version="${${(As: :)$(git version 2>/dev/null)}[3]}"

#
# Functions
#

# The name of the current branch
# Back-compatibility wrapper for when this function was defined here in
# the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# to fix the core -> git plugin dependency.
function current_branch() {
  git_current_branch
}

# Pretty log messages
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
compdef _git _git_log_prettily=git-log

# Warn if the current branch is a WIP
function work_in_progress() {
  command git -c log.showSignature=false log -n 1 2>/dev/null | grep -q -- "--wip--" && echo "WIP!!"
}

# Check if main exists and use instead of master
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local ref
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return
    fi
  done
  echo master
}

# Check for develop and similarly named branches
function git_develop_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  local branch
  for branch in dev devel development; do
    if command git show-ref -q --verify refs/heads/$branch; then
      echo $branch
      return
    fi
  done
  echo develop
}

#
# Aliases
# (sorted alphabetically)
#

Function Alias-g {git}
New-Alias g Alias-g

Function Alias-ga {git add}
New-Alias ga Alias-ga 
Function Alias-gaa {git add --all}
New-Alias gaa Alias-gaa 
Function Alias-gapa {git add --patch}
New-Alias gapa Alias-gapa 
Function Alias-gau {git add --update}
New-Alias gau Alias-gau 
Function Alias-gav {git add --verbose}
New-Alias gav Alias-gav 
Function Alias-gap {git apply}
New-Alias gap Alias-gap 
Function Alias-gapt {git apply --3way}
New-Alias gapt Alias-gapt 

Function Alias-gb {git branch}
New-Alias gb Alias-gb 
Function Alias-gba {git branch -a}
New-Alias gba Alias-gba 
Function Alias-gbd {git branch -d}
New-Alias gbd Alias-gbd 
alias gbda='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
Function Alias-gbD {git branch -D}
New-Alias gbD Alias-gbD 
Function Alias-gbl {git blame -b -w}
New-Alias gbl Alias-gbl 
Function Alias-gbnm {git branch --no-merged}
New-Alias gbnm Alias-gbnm 
Function Alias-gbr {git branch --remote}
New-Alias gbr Alias-gbr 
Function Alias-gbs {git bisect}
New-Alias gbs Alias-gbs 
Function Alias-gbsb {git bisect bad}
New-Alias gbsb Alias-gbsb 
Function Alias-gbsg {git bisect good}
New-Alias gbsg Alias-gbsg 
Function Alias-gbsr {git bisect reset}
New-Alias gbsr Alias-gbsr 
Function Alias-gbss {git bisect start}
New-Alias gbss Alias-gbss 

Function Alias-gc {git commit -v}
New-Alias gc Alias-gc 
Function Alias-gc {git commit -v --amend}
New-Alias gc! Alias-gc 
Function Alias-gcn {git commit -v --no-edit --amend}
New-Alias gcn! Alias-gcn 
Function Alias-gca {git commit -v -a}
New-Alias gca Alias-gca 
Function Alias-gca {git commit -v -a --amend}
New-Alias gca! Alias-gca 
Function Alias-gcan {git commit -v -a --no-edit --amend}
New-Alias gcan! Alias-gcan 
Function Alias-gcans {git commit -v -a -s --no-edit --amend}
New-Alias gcans! Alias-gcans 
Function Alias-gcam {git commit -a -m}
New-Alias gcam Alias-gcam 
Function Alias-gcsm {git commit -s -m}
New-Alias gcsm Alias-gcsm 
Function Alias-gcas {git commit -a -s}
New-Alias gcas Alias-gcas 
Function Alias-gcasm {git commit -a -s -m}
New-Alias gcasm Alias-gcasm 
Function Alias-gcb {git checkout -b}
New-Alias gcb Alias-gcb 
Function Alias-gcf {git config --list}
New-Alias gcf Alias-gcf 

function gccd() {
  command git clone --recurse-submodules "$@"
  [[ -d "$_" ]] && cd "$_" || cd "${${_:t}%.git}"
}
compdef _git gccd=git-clone

Function Alias-gcl {git clone --recurse-submodules}
New-Alias gcl Alias-gcl 
Function Alias-gclean {git clean -id}
New-Alias gclean Alias-gclean 
Function Alias-gpristine {git reset --hard && git clean -dffx}
New-Alias gpristine Alias-gpristine 
Function Alias-gcm {git checkout $(git_main_branch)}
New-Alias gcm Alias-gcm 
Function Alias-gcd {git checkout $(git_develop_branch)}
New-Alias gcd Alias-gcd 
Function Alias-gcmsg {git commit -m}
New-Alias gcmsg Alias-gcmsg 
Function Alias-gco {git checkout}
New-Alias gco Alias-gco 
Function Alias-gcor {git checkout --recurse-submodules}
New-Alias gcor Alias-gcor 
Function Alias-gcount {git shortlog -sn}
New-Alias gcount Alias-gcount 
Function Alias-gcp {git cherry-pick}
New-Alias gcp Alias-gcp 
Function Alias-gcpa {git cherry-pick --abort}
New-Alias gcpa Alias-gcpa 
Function Alias-gcpc {git cherry-pick --continue}
New-Alias gcpc Alias-gcpc 
Function Alias-gcs {git commit -S}
New-Alias gcs Alias-gcs 
Function Alias-gcss {git commit -S -s}
New-Alias gcss Alias-gcss 
Function Alias-gcssm {git commit -S -s -m}
New-Alias gcssm Alias-gcssm 

Function Alias-gd {git diff}
New-Alias gd Alias-gd 
Function Alias-gdca {git diff --cached}
New-Alias gdca Alias-gdca 
Function Alias-gdcw {git diff --cached --word-diff}
New-Alias gdcw Alias-gdcw 
Function Alias-gdct {git describe --tags $(git rev-list --tags --max-count=1)}
New-Alias gdct Alias-gdct 
Function Alias-gds {git diff --staged}
New-Alias gds Alias-gds 
Function Alias-gdt {git diff-tree --no-commit-id --name-only -r}
New-Alias gdt Alias-gdt 
Function Alias-gdup {git diff @{upstream}}
New-Alias gdup Alias-gdup 
Function Alias-gdw {git diff --word-diff}
New-Alias gdw Alias-gdw 

function gdnolock() {
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
compdef _git gdnolock=git-diff

function gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff

Function Alias-gf {git fetch}
New-Alias gf Alias-gf 

# --jobs=<n> was added in git 2.8
is-at-least 2.8 "$git_version" \
  && alias gfa='git fetch --all --prune --jobs=10' \
  || alias gfa='git fetch --all --prune'
Function Alias-gfo {git fetch origin}
New-Alias gfo Alias-gfo 

alias gfg='git ls-files | grep'

Function Alias-gg {git gui citool}
New-Alias gg Alias-gg 
Function Alias-gga {git gui citool --amend}
New-Alias gga Alias-gga 

function ggf() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force origin "${b:=$1}"
}
compdef _git ggf=git-checkout
function ggfl() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force-with-lease origin "${b:=$1}"
}
compdef _git ggfl=git-checkout

function ggl() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git pull origin "${b:=$1}"
  fi
}
compdef _git ggl=git-checkout

function ggp() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
  fi
}
compdef _git ggp=git-checkout

function ggpnp() {
  if [[ "$#" == 0 ]]; then
    ggl && ggp
  else
    ggl "${*}" && ggp "${*}"
  fi
}
compdef _git ggpnp=git-checkout

function ggu() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git pull --rebase origin "${b:=$1}"
}
compdef _git ggu=git-checkout

Function Alias-ggpur {ggu}
New-Alias ggpur Alias-ggpur 
Function Alias-ggpull {git pull origin "$(git_current_branch)"}
New-Alias ggpull Alias-ggpull 
Function Alias-ggpush {git push origin "$(git_current_branch)"}
New-Alias ggpush Alias-ggpush 

Function Alias-ggsup {git branch --set-upstream-to=origin/$(git_current_branch)}
New-Alias ggsup Alias-ggsup 
Function Alias-gpsup {git push --set-upstream origin $(git_current_branch)}
New-Alias gpsup Alias-gpsup 

Function Alias-ghh {git help}
New-Alias ghh Alias-ghh 

Function Alias-gignore {git update-index --assume-unchanged}
New-Alias gignore Alias-gignore 
Function Alias-gignored {git ls-files -v | grep "^[[:lower:]]"}
New-Alias gignored Alias-gignored 
Function Alias-git-svn-dcommit-push {git svn dcommit && git push github $(git_main_branch):svntrunk}
New-Alias git-svn-dcommit-push Alias-git-svn-dcommit-push 

Function Alias-gk {\gitk --all --branches &!}
New-Alias gk Alias-gk 
Function Alias-gke {\gitk --all $(git log -g --pretty=%h) &!}
New-Alias gke Alias-gke 

Function Alias-gl {git pull}
New-Alias gl Alias-gl 
Function Alias-glg {git log --stat}
New-Alias glg Alias-glg 
Function Alias-glgp {git log --stat -p}
New-Alias glgp Alias-glgp 
Function Alias-glgg {git log --graph}
New-Alias glgg Alias-glgg 
Function Alias-glgga {git log --graph --decorate --all}
New-Alias glgga Alias-glgga 
Function Alias-glgm {git log --graph --max-count=10}
New-Alias glgm Alias-glgm 
Function Alias-glo {git log --oneline --decorate}
New-Alias glo Alias-glo 
Function Alias-glol {git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'}
New-Alias glol Alias-glol 
Function Alias-glols {git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat}
New-Alias glols Alias-glols 
Function Alias-glod {git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset'}
New-Alias glod Alias-glod 
Function Alias-glods {git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short}
New-Alias glods Alias-glods 
Function Alias-glola {git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all}
New-Alias glola Alias-glola 
Function Alias-glog {git log --oneline --decorate --graph}
New-Alias glog Alias-glog 
Function Alias-gloga {git log --oneline --decorate --graph --all}
New-Alias gloga Alias-gloga 
Function Alias-glp {_git_log_prettily}
New-Alias glp Alias-glp 

Function Alias-gm {git merge}
New-Alias gm Alias-gm 
Function Alias-gmom {git merge origin/$(git_main_branch)}
New-Alias gmom Alias-gmom 
Function Alias-gmtl {git mergetool --no-prompt}
New-Alias gmtl Alias-gmtl 
Function Alias-gmtlvim {git mergetool --no-prompt --tool=vimdiff}
New-Alias gmtlvim Alias-gmtlvim 
Function Alias-gmum {git merge upstream/$(git_main_branch)}
New-Alias gmum Alias-gmum 
Function Alias-gma {git merge --abort}
New-Alias gma Alias-gma 

Function Alias-gp {git push}
New-Alias gp Alias-gp 
Function Alias-gpd {git push --dry-run}
New-Alias gpd Alias-gpd 
Function Alias-gpf {git push --force-with-lease}
New-Alias gpf Alias-gpf 
Function Alias-gpf {git push --force}
New-Alias gpf! Alias-gpf 
Function Alias-gpoat {git push origin --all && git push origin --tags}
New-Alias gpoat Alias-gpoat 
Function Alias-gpr {git pull --rebase}
New-Alias gpr Alias-gpr 
Function Alias-gpu {git push upstream}
New-Alias gpu Alias-gpu 
Function Alias-gpv {git push -v}
New-Alias gpv Alias-gpv 

Function Alias-gr {git remote}
New-Alias gr Alias-gr 
Function Alias-gra {git remote add}
New-Alias gra Alias-gra 
Function Alias-grb {git rebase}
New-Alias grb Alias-grb 
Function Alias-grba {git rebase --abort}
New-Alias grba Alias-grba 
Function Alias-grbc {git rebase --continue}
New-Alias grbc Alias-grbc 
Function Alias-grbd {git rebase $(git_develop_branch)}
New-Alias grbd Alias-grbd 
Function Alias-grbi {git rebase -i}
New-Alias grbi Alias-grbi 
Function Alias-grbm {git rebase $(git_main_branch)}
New-Alias grbm Alias-grbm 
Function Alias-grbom {git rebase origin/$(git_main_branch)}
New-Alias grbom Alias-grbom 
Function Alias-grbo {git rebase --onto}
New-Alias grbo Alias-grbo 
Function Alias-grbs {git rebase --skip}
New-Alias grbs Alias-grbs 
Function Alias-grev {git revert}
New-Alias grev Alias-grev 
Function Alias-grh {git reset}
New-Alias grh Alias-grh 
Function Alias-grhh {git reset --hard}
New-Alias grhh Alias-grhh 
Function Alias-groh {git reset origin/$(git_current_branch) --hard}
New-Alias groh Alias-groh 
Function Alias-grm {git rm}
New-Alias grm Alias-grm 
Function Alias-grmc {git rm --cached}
New-Alias grmc Alias-grmc 
Function Alias-grmv {git remote rename}
New-Alias grmv Alias-grmv 
Function Alias-grrm {git remote remove}
New-Alias grrm Alias-grrm 
Function Alias-grs {git restore}
New-Alias grs Alias-grs 
Function Alias-grset {git remote set-url}
New-Alias grset Alias-grset 
Function Alias-grss {git restore --source}
New-Alias grss Alias-grss 
Function Alias-grst {git restore --staged}
New-Alias grst Alias-grst 
Function Alias-grt {cd "$(git rev-parse --show-toplevel || echo .)"}
New-Alias grt Alias-grt 
Function Alias-gru {git reset --}
New-Alias gru Alias-gru 
Function Alias-grup {git remote update}
New-Alias grup Alias-grup 
Function Alias-grv {git remote -v}
New-Alias grv Alias-grv 

Function Alias-gsb {git status -sb}
New-Alias gsb Alias-gsb 
Function Alias-gsd {git svn dcommit}
New-Alias gsd Alias-gsd 
Function Alias-gsh {git show}
New-Alias gsh Alias-gsh 
Function Alias-gsi {git submodule init}
New-Alias gsi Alias-gsi 
Function Alias-gsps {git show --pretty=short --show-signature}
New-Alias gsps Alias-gsps 
Function Alias-gsr {git svn rebase}
New-Alias gsr Alias-gsr 
Function Alias-gss {git status -s}
New-Alias gss Alias-gss 
Function Alias-gst {git status}
New-Alias gst Alias-gst 

# use the default stash push on git 2.13 and newer
is-at-least 2.13 "$git_version" \
  && alias gsta='git stash push' \
  || alias gsta='git stash save'

Function Alias-gstaa {git stash apply}
New-Alias gstaa Alias-gstaa 
Function Alias-gstc {git stash clear}
New-Alias gstc Alias-gstc 
Function Alias-gstd {git stash drop}
New-Alias gstd Alias-gstd 
Function Alias-gstl {git stash list}
New-Alias gstl Alias-gstl 
Function Alias-gstp {git stash pop}
New-Alias gstp Alias-gstp 
Function Alias-gsts {git stash show --text}
New-Alias gsts Alias-gsts 
Function Alias-gstu {gsta --include-untracked}
New-Alias gstu Alias-gstu 
Function Alias-gstall {git stash --all}
New-Alias gstall Alias-gstall 
Function Alias-gsu {git submodule update}
New-Alias gsu Alias-gsu 
Function Alias-gsw {git switch}
New-Alias gsw Alias-gsw 
Function Alias-gswc {git switch -c}
New-Alias gswc Alias-gswc 
Function Alias-gswm {git switch $(git_main_branch)}
New-Alias gswm Alias-gswm 
Function Alias-gswd {git switch $(git_develop_branch)}
New-Alias gswd Alias-gswd 

Function Alias-gts {git tag -s}
New-Alias gts Alias-gts 
Function Alias-gtv {git tag | sort -V}
New-Alias gtv Alias-gtv 
Function Alias-gtl {gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl}
New-Alias gtl Alias-gtl 

Function Alias-gunignore {git update-index --no-assume-unchanged}
New-Alias gunignore Alias-gunignore 
Function Alias-gunwip {git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1}
New-Alias gunwip Alias-gunwip 
Function Alias-gup {git pull --rebase}
New-Alias gup Alias-gup 
Function Alias-gupv {git pull --rebase -v}
New-Alias gupv Alias-gupv 
Function Alias-gupa {git pull --rebase --autostash}
New-Alias gupa Alias-gupa 
Function Alias-gupav {git pull --rebase --autostash -v}
New-Alias gupav Alias-gupav 
Function Alias-gupom {git pull --rebase origin $(git_main_branch)}
New-Alias gupom Alias-gupom 
Function Alias-gupomi {git pull --rebase=interactive origin $(git_main_branch)}
New-Alias gupomi Alias-gupomi 
Function Alias-glum {git pull upstream $(git_main_branch)}
New-Alias glum Alias-glum 

Function Alias-gwch {git whatchanged -p --abbrev-commit --pretty=medium}
New-Alias gwch Alias-gwch 
Function Alias-gwip {git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"}
New-Alias gwip Alias-gwip 

Function Alias-gam {git am}
New-Alias gam Alias-gam 
Function Alias-gamc {git am --continue}
New-Alias gamc Alias-gamc 
Function Alias-gams {git am --skip}
New-Alias gams Alias-gams 
Function Alias-gama {git am --abort}
New-Alias gama Alias-gama 
Function Alias-gamscp {git am --show-current-patch}
New-Alias gamscp Alias-gamscp 

function grename() {
  if [[ -z "$1" || -z "$2" ]]; then
    echo "Usage: $0 old_branch new_branch"
    return 1
  fi

  # Rename branch locally
  git branch -m "$1" "$2"
  # Rename branch in origin remote
  if git push origin :"$1"; then
    git push --set-upstream origin "$2"
  fi
}

unset git_version
