# OhMyZsh git plugin aliases port to Windows Powershell
# From https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

# Git version checking

# TODO: Rewrite to PowerShell commands
<#
autoload -Uz is-at-least
#>

<#
git_version="${${(As: :)$(git version 2>/dev/null)}[3]}"
#>
$git_version_string = $($(git version) 2>$null)
# If git is not installed $git_version_string is null and we return empty string.
# In other case "git version" return string like "git version 2.30.0.windows.2". We find third word and remove windows postfix.
# If git is not installed returns empty string ("").
# If git installed returns git version
$git_version = if ($null -ne $git_version_string) {$($($git_version_string -split " ")[2]) -replace ".windows.(.*)", ""} else {""}

#
# Functions
#

# The name of the current branch
# Back-compatibility wrapper for when this function was defined here in
# the plugin, before being pulled in to core lib/git.zsh as git_current_branch()
# to fix the core -> git plugin dependency.

# TODO: Rewrite to PowerShell commands
<#
function current_branch() {
  git_current_branch
}
#>

# TODO: Rewrite to PowerShell commands
# Pretty log messages
<#
function _git_log_prettily(){
  if ! [ -z $1 ]; then
    git log --pretty=$1
  fi
}
compdef _git _git_log_prettily=git-log
#>

# TODO: Rewrite to PowerShell commands
# Warn if the current branch is a WIP
<#
function work_in_progress() {
  command git -c log.showSignature=false log -n 1 2>/dev/null | grep -q -- "--wip--" && echo "WIP!!"
}
#>

# TODO: Rewrite to PowerShell commands
# Check if main exists and use instead of master

<#
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
#>

# TODO: WIP
<#
function git_development_branch() {
  git rev-parse --git-dir *>>$null
  if (!$?)
  {return;}
  git show-ref -q --verify 'refs/heads/master'
  if ($?)
  {return 'master';}
  return 'fail';
}
#>

# TODO: Rewrite to PowerShell commands
# Check for develop and similarly named branches
<#
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
#>

#
# Aliases
# (sorted alphabetically)
#

Function Alias-g {git $args}
New-Alias g Alias-g

Function Alias-ga {git add $args}
New-Alias ga Alias-ga 
Function Alias-gaa {git add --all $args}
New-Alias gaa Alias-gaa 
Function Alias-gapa {git add --patch $args}
New-Alias gapa Alias-gapa 
Function Alias-gau {git add --update $args}
New-Alias gau Alias-gau 
Function Alias-gav {git add --verbose $args}
New-Alias gav Alias-gav 
Function Alias-gap {git apply $args}
New-Alias gap Alias-gap 
Function Alias-gapt {git apply --3way $args}
New-Alias gapt Alias-gapt 

Function Alias-gb {git branch $args}
New-Alias gb Alias-gb 
Function Alias-gba {git branch -a $args}
New-Alias gba Alias-gba 
Function Alias-gbd {git branch -d $args}
New-Alias gbd Alias-gbd

# TODO: Rewrite with PowerShell commands
<#
alias gbda='git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch -d 2>/dev/null'
#>

# TODO: conflicts with existing alias gdb
<#
Function Alias-gbD {git branch -D $args}
New-Alias gbD Alias-gbD
#>

Function Alias-gbl {git blame -b -w $args}
New-Alias gbl Alias-gbl 
Function Alias-gbnm {git branch --no-merged $args}
New-Alias gbnm Alias-gbnm 
Function Alias-gbr {git branch --remote $args}
New-Alias gbr Alias-gbr 
Function Alias-gbs {git bisect $args}
New-Alias gbs Alias-gbs 
Function Alias-gbsb {git bisect bad $args}
New-Alias gbsb Alias-gbsb 
Function Alias-gbsg {git bisect good $args}
New-Alias gbsg Alias-gbsg 
Function Alias-gbsr {git bisect reset $args}
New-Alias gbsr Alias-gbsr 
Function Alias-gbss {git bisect start $args}
New-Alias gbss Alias-gbss 

# TODO: Conflicts with PowerShell alias gc -> Get-Content
<#
Function Alias-gc {git commit -v}
New-Alias gc Alias-gc 
#>

Function Alias-gc! {git commit -v --amend $args}
New-Alias gc! Alias-gc!

Function Alias-gcn {git commit -v --no-edit --amend $args}
New-Alias gcn! Alias-gcn 
Function Alias-gca {git commit -v -a $args}
New-Alias gca Alias-gca 
Function Alias-gca {git commit -v -a --amend $args}
New-Alias gca! Alias-gca 
Function Alias-gcan {git commit -v -a --no-edit --amend $args}
New-Alias gcan! Alias-gcan 
Function Alias-gcans {git commit -v -a -s --no-edit --amend $args}
New-Alias gcans! Alias-gcans 
Function Alias-gcam {git commit -a -m $args}
New-Alias gcam Alias-gcam 
Function Alias-gcsm {git commit -s -m $args}
New-Alias gcsm Alias-gcsm 
Function Alias-gcas {git commit -a -s $args}
New-Alias gcas Alias-gcas 
Function Alias-gcasm {git commit -a -s -m $args}
New-Alias gcasm Alias-gcasm 

# TODO: Conflicts with PowerShell alias gcb -> Get-Clipboard
<#
Function Alias-gcb {git checkout -b}
New-Alias gcb Alias-gcb 
#>

Function Alias-gcf {git config --list $args}
New-Alias gcf Alias-gcf 

# TODO: Rewrite to PowerShell commands
<#
function gccd() {
  command git clone --recurse-submodules "$@"
  [[ -d "$_" ]] && cd "$_" || cd "${${_:t}%.git}"
}
compdef _git gccd=git-clone
#>

Function Alias-gcl {git clone --recurse-submodules $args}
New-Alias gcl Alias-gcl 
Function Alias-gclean {git clean -id $args}
New-Alias gclean Alias-gclean 

# TODO: Rewrite to PowerShell commands. See: https://stackoverflow.com/questions/2416662/what-are-the-powershell-equivalents-of-bashs-and-operators
<#
Function Alias-gpristine {git reset --hard && git clean -dffx}
New-Alias gpristine Alias-gpristine 
#>

# TODO: Uncomment when git_main_branch function will be implemented
<#
Function Alias-gcm {git checkout $(git_main_branch)}
New-Alias gcm Alias-gcm
#>

Function Alias-gcd {git checkout $(git_develop_branch) $args}
New-Alias gcd Alias-gcd 
Function Alias-gcmsg {git commit -m $args}
New-Alias gcmsg Alias-gcmsg 
Function Alias-gco {git checkout $args}
New-Alias gco Alias-gco 
Function Alias-gcor {git checkout --recurse-submodules $args}
New-Alias gcor Alias-gcor 
Function Alias-gcount {git shortlog -sn $args}
New-Alias gcount Alias-gcount 
Function Alias-gcp {git cherry-pick $args}
New-Alias gcp Alias-gcp 
Function Alias-gcpa {git cherry-pick --abort $args}
New-Alias gcpa Alias-gcpa 
Function Alias-gcpc {git cherry-pick --continue $args}
New-Alias gcpc Alias-gcpc 

# TODO: Conflicts with default PowerShell alias gcs -> Get-PSCallStack
<#
Function Alias-gcs {git commit -S}
New-Alias gcs Alias-gcs 
#>

Function Alias-gcss {git commit -S -s $args}
New-Alias gcss Alias-gcss 
Function Alias-gcssm {git commit -S -s -m $args}
New-Alias gcssm Alias-gcssm 

Function Alias-gd {git diff $args}
New-Alias gd Alias-gd 
Function Alias-gdca {git diff --cached $args}
New-Alias gdca Alias-gdca 
Function Alias-gdcw {git diff --cached --word-diff $args}
New-Alias gdcw Alias-gdcw 

Function Alias-gdct {git describe --tags $(git rev-list --tags --max-count=1)}
New-Alias gdct Alias-gdct

Function Alias-gds {git diff --staged $args}
New-Alias gds Alias-gds 
Function Alias-gdt {git diff-tree --no-commit-id --name-only -r $args}
New-Alias gdt Alias-gdt 

# TODO: Find what is happend here
<#
Function Alias-gdup {git diff @{upstream}}
New-Alias gdup Alias-gdup 
#>

Function Alias-gdw {git diff --word-diff $args}
New-Alias gdw Alias-gdw 

# TODO: Rewrite to powershell syntax
<#
function gdnolock() {
  git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
compdef _git gdnolock=git-diff
#>

# TODO: Rewrite to powershell syntax
<#
function gdv() { git diff -w "$@" | view - }
compdef _git gdv=git-diff
#>

Function Alias-gf {git fetch $args}
New-Alias gf Alias-gf 

# TODO: Rewrite to powershell syntax
# --jobs=<n> was added in git 2.8
<#
is-at-least 2.8 "$git_version" \
  && alias gfa='git fetch --all --prune --jobs=10' \
  || alias gfa='git fetch --all --prune'
  #>

Function Alias-gfo {git fetch origin $args}
New-Alias gfo Alias-gfo 

# TODO: Rewrite to powershell commands
<#
alias gfg='git ls-files | grep'
#>

Function Alias-gg {git gui citool $args}
New-Alias gg Alias-gg 
Function Alias-gga {git gui citool --amend $args}
New-Alias gga Alias-gga 

# TODO: Rewrite to powershell syntax
<#
function ggf() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force origin "${b:=$1}"
}
compdef _git ggf=git-checkout
#>

# TODO: Rewrite to powershell syntax
<#
function ggfl() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git push --force-with-lease origin "${b:=$1}"
}
compdef _git ggfl=git-checkout
#>

# TODO: Rewrite to powershell syntax
<#
function ggl() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git pull origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git pull origin "${b:=$1}"
  fi
}
compdef _git ggl=git-checkout
#>

# TODO: Rewrite to powershell syntax
<#
function ggp() {
  if [[ "$#" != 0 ]] && [[ "$#" != 1 ]]; then
    git push origin "${*}"
  else
    [[ "$#" == 0 ]] && local b="$(git_current_branch)"
    git push origin "${b:=$1}"
  fi
}
compdef _git ggp=git-checkout
#>

# TODO: Rewrite to powershell syntax
<#
function ggpnp() {
  if [[ "$#" == 0 ]]; then
    ggl && ggp
  else
    ggl "${*}" && ggp "${*}"
  fi
}
compdef _git ggpnp=git-checkout
#>

# TODO: Rewrite to powershell syntax
<#
function ggu() {
  [[ "$#" != 1 ]] && local b="$(git_current_branch)"
  git pull --rebase origin "${b:=$1}"
}
compdef _git ggu=git-checkout
#>

# TODO: Uncomment when ggu function will be implemeted. Add args passing to aliases
<#
Function Alias-ggpur {ggu}
New-Alias ggpur Alias-ggpur
#>

# TODO: Uncomment when git_current_branch will be implemented. Add args passing to aliases
<#
Function Alias-ggpull {git pull origin "$(git_current_branch)"}
New-Alias ggpull Alias-ggpull 
Function Alias-ggpush {git push origin "$(git_current_branch)"}
New-Alias ggpush Alias-ggpush 
#>

# TODO: Uncomment when git_current_branch will be implemented. Add args passing to aliases
<#
Function Alias-ggsup {git branch --set-upstream-to=origin/$(git_current_branch)}
New-Alias ggsup Alias-ggsup 
Function Alias-gpsup {git push --set-upstream origin $(git_current_branch)}
New-Alias gpsup Alias-gpsup 
#>

Function Alias-ghh {git help $args}
New-Alias ghh Alias-ghh 

Function Alias-gignore {git update-index --assume-unchanged $args}
New-Alias gignore Alias-gignore 

# TODO: Rewrite to PowerShell syntax
<#
Function Alias-gignored {git ls-files -v | grep "^[[:lower:]]"}
New-Alias gignored Alias-gignored 
#>

# TODO: Uncomment when git_main_branch will be implemented. And add args passing.
<#
Function Alias-git-svn-dcommit-push {git svn dcommit && git push github $(git_main_branch):svntrunk}
New-Alias git-svn-dcommit-push Alias-git-svn-dcommit-push 
#>

# TODO: Rewrite to powershell syntax
<#
Function Alias-gk {\gitk --all --branches &!}
New-Alias gk Alias-gk 
Function Alias-gke {\gitk --all $(git log -g --pretty=%h) &!}
New-Alias gke Alias-gke 
#>

# TODO: Conflicts with default PowerShell alias gl -> Get-Location
<#
Function Alias-gl {git pull}
New-Alias gl Alias-gl
#>

Function Alias-glg {git log --stat $args}
New-Alias glg Alias-glg 
Function Alias-glgp {git log --stat -p $args}
New-Alias glgp Alias-glgp 
Function Alias-glgg {git log --graph $args}
New-Alias glgg Alias-glgg 
Function Alias-glgga {git log --graph --decorate --all $args}
New-Alias glgga Alias-glgga 
Function Alias-glgm {git log --graph --max-count=10 $args}
New-Alias glgm Alias-glgm 
Function Alias-glo {git log --oneline --decorate $args}
New-Alias glo Alias-glo 
Function Alias-glol {git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' $args}
New-Alias glol Alias-glol 
Function Alias-glols {git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat $args}
New-Alias glols Alias-glols 
Function Alias-glod {git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' $args}
New-Alias glod Alias-glod 
Function Alias-glods {git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset' --date=short $args}
New-Alias glods Alias-glods 
Function Alias-glola {git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --all $args}
New-Alias glola Alias-glola 
Function Alias-glog {git log --oneline --decorate --graph $args}
New-Alias glog Alias-glog 
Function Alias-gloga {git log --oneline --decorate --graph --all $args}
New-Alias gloga Alias-gloga 
Function Alias-glp {_git_log_prettily $args}
New-Alias glp Alias-glp 

# TODO: Conflicts with default PowerShell alias gm -> Get-Member
<#
Function Alias-gm {git merge}
New-Alias gm Alias-gm 
#>

# TODO: Uncomment when git_main_branch will be implemented
<#
Function Alias-gmom {git merge origin/$(git_main_branch)}
New-Alias gmom Alias-gmom
#>

Function Alias-gmtl {git mergetool --no-prompt $args}
New-Alias gmtl Alias-gmtl 

Function Alias-gmtlvim {git mergetool --no-prompt --tool=vimdiff $args}
New-Alias gmtlvim Alias-gmtlvim

# TODO: Uncomment when git_main_branch will be implemented
<#
Function Alias-gmum {git merge upstream/$(git_main_branch)}
New-Alias gmum Alias-gmum
#>

Function Alias-gma {git merge --abort $args}
New-Alias gma Alias-gma 

# TODO: Conflicts with default PowerShell alias gp -> Get-ItemProperty
<#
Function Alias-gp {git push}
New-Alias gp Alias-gp 
#>

Function Alias-gpd {git push --dry-run $args}
New-Alias gpd Alias-gpd 
Function Alias-gpf {git push --force-with-lease $args}
New-Alias gpf Alias-gpf 
Function Alias-gpf {git push --force $args}
New-Alias gpf! Alias-gpf 

# TODO: Rewrite to PowerShell syntax
<#
Function Alias-gpoat {git push origin --all && git push origin --tags}
New-Alias gpoat Alias-gpoat
#>

Function Alias-gpr {git pull --rebase $args}
New-Alias gpr Alias-gpr 
Function Alias-gpu {git push upstream $args}
New-Alias gpu Alias-gpu 

# TODO: Conflicts with default PowerShell alias gpt -> Get-ItemPropertyValue
<#
Function Alias-gpv {git push -v}
New-Alias gpv Alias-gpv 
#>

Function Alias-gr {git remote $args}
New-Alias gr Alias-gr 
Function Alias-gra {git remote add $args}
New-Alias gra Alias-gra 
Function Alias-grb {git rebase $args}
New-Alias grb Alias-grb 
Function Alias-grba {git rebase --abort $args}
New-Alias grba Alias-grba 
Function Alias-grbc {git rebase --continue $args}
New-Alias grbc Alias-grbc 

# TODO: Uncomment when get_develop_branch will be implemented
<#
Function Alias-grbd {git rebase $(git_develop_branch)}
New-Alias grbd Alias-grbd
#>

Function Alias-grbi {git rebase -i $args}
New-Alias grbi Alias-grbi 

# TODO: Uncomment when get_main_branch will be implemented
<#
Function Alias-grbm {git rebase $(git_main_branch)}
New-Alias grbm Alias-grbm
#>

# TODO: Uncomment when get_main_branch will be implemented
<#
Function Alias-grbom {git rebase origin/$(git_main_branch)}
New-Alias grbom Alias-grbom
#>

Function Alias-grbo {git rebase --onto $args}
New-Alias grbo Alias-grbo 
Function Alias-grbs {git rebase --skip $args}
New-Alias grbs Alias-grbs 
Function Alias-grev {git revert $args}
New-Alias grev Alias-grev 
Function Alias-grh {git reset $args}
New-Alias grh Alias-grh 
Function Alias-grhh {git reset --hard $args}
New-Alias grhh Alias-grhh 

# TODO: Uncomment when get_current_branch will be implemented
<#
Function Alias-groh {git reset origin/$(git_current_branch) --hard}
New-Alias groh Alias-groh
#>

Function Alias-grm {git rm $args}
New-Alias grm Alias-grm 
Function Alias-grmc {git rm --cached $args}
New-Alias grmc Alias-grmc 
Function Alias-grmv {git remote rename $args}
New-Alias grmv Alias-grmv 
Function Alias-grrm {git remote remove $args}
New-Alias grrm Alias-grrm 
Function Alias-grs {git restore $args}
New-Alias grs Alias-grs 
Function Alias-grset {git remote set-url $args}
New-Alias grset Alias-grset 
Function Alias-grss {git restore --source $args}
New-Alias grss Alias-grss 
Function Alias-grst {git restore --staged $args}
New-Alias grst Alias-grst 

# TODO: Rewrite to PowerShell syntax
<#
Function Alias-grt {cd "$(git rev-parse --show-toplevel || echo .)"}
New-Alias grt Alias-grt
#>

Function Alias-gru {git reset -- $args}
New-Alias gru Alias-gru 
Function Alias-grup {git remote update $args}
New-Alias grup Alias-grup 
Function Alias-grv {git remote -v $args}
New-Alias grv Alias-grv 

Function Alias-gsb {git status -sb $args}
New-Alias gsb Alias-gsb 
Function Alias-gsd {git svn dcommit $args}
New-Alias gsd Alias-gsd 
Function Alias-gsh {git show $args}
New-Alias gsh Alias-gsh 
Function Alias-gsi {git submodule init $args}
New-Alias gsi Alias-gsi 
Function Alias-gsps {git show --pretty=short --show-signature $args}
New-Alias gsps Alias-gsps 
Function Alias-gsr {git svn rebase $args}
New-Alias gsr Alias-gsr 
Function Alias-gss {git status -s $args}
New-Alias gss Alias-gss 
Function Alias-gst {git status $args}
New-Alias gst Alias-gst 

# TODO: Rewrite to PowerShell syntax
# use the default stash push on git 2.13 and newer
<#
is-at-least 2.13 "$git_version" \
  && alias gsta='git stash push' \
  || alias gsta='git stash save'
#>

Function Alias-gstaa {git stash apply $args}
New-Alias gstaa Alias-gstaa 
Function Alias-gstc {git stash clear $args}
New-Alias gstc Alias-gstc 
Function Alias-gstd {git stash drop $args}
New-Alias gstd Alias-gstd 
Function Alias-gstl {git stash list $args}
New-Alias gstl Alias-gstl 
Function Alias-gstp {git stash pop $args}
New-Alias gstp Alias-gstp 
Function Alias-gsts {git stash show --text $args}
New-Alias gsts Alias-gsts 
Function Alias-gstu {gsta --include-untracked $args}
New-Alias gstu Alias-gstu 
Function Alias-gstall {git stash --all $args}
New-Alias gstall Alias-gstall 
Function Alias-gsu {git submodule update $args}
New-Alias gsu Alias-gsu 
Function Alias-gsw {git switch $args}
New-Alias gsw Alias-gsw 
Function Alias-gswc {git switch -c $args}
New-Alias gswc Alias-gswc 

# TODO: Uncomment when git_main_branch will be implemented
<#
Function Alias-gswm {git switch $(git_main_branch)}
New-Alias gswm Alias-gswm
#>

# TODO: Uncomment when git_develop_branch will be implemented
<# 
Function Alias-gswd {git switch $(git_develop_branch)}
New-Alias gswd Alias-gswd 
#>

Function Alias-gts {git tag -s $args}
New-Alias gts Alias-gts 

# TODO: Rewrite with PowerShell syntax
<#
Function Alias-gtv {git tag | sort -V}
New-Alias gtv Alias-gtv
#>

# TODO: Rewrite with PowerShell syntax
<#
Function Alias-gtl {gtl(){ git tag --sort=-v:refname -n -l "${1}*" }; noglob gtl}
New-Alias gtl Alias-gtl 
#>

Function Alias-gunignore {git update-index --no-assume-unchanged}
New-Alias gunignore Alias-gunignore 

# TODO: Rewrite with PowerShell syntax
<#
Function Alias-gunwip {git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1}
New-Alias gunwip Alias-gunwip
#>

Function Alias-gup {git pull --rebase $args}
New-Alias gup Alias-gup 
Function Alias-gupv {git pull --rebase -v $args}
New-Alias gupv Alias-gupv 
Function Alias-gupa {git pull --rebase --autostash $args}
New-Alias gupa Alias-gupa 
Function Alias-gupav {git pull --rebase --autostash -v $args}
New-Alias gupav Alias-gupav 

# TODO: Uncomment when git_main_branch will be implemented
<#
Function Alias-gupom {git pull --rebase origin $(git_main_branch)}
New-Alias gupom Alias-gupom
#>

# TODO: Uncomment when git_main_branch will be implemented
<#
Function Alias-gupomi {git pull --rebase=interactive origin $(git_main_branch)}
New-Alias gupomi Alias-gupomi
#>

# TODO: Uncomment when git_develop_branch will be implemented
<#
Function Alias-glum {git pull upstream $(git_main_branch)}
New-Alias glum Alias-glum 
#>

Function Alias-gwch {git whatchanged -p --abbrev-commit --pretty=medium $args}
New-Alias gwch Alias-gwch 

# TODO: Rewrite with PowerShell syntax
<#
Function Alias-gwip {git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign -m "--wip-- [skip ci]"}
New-Alias gwip Alias-gwip 
#>

Function Alias-gam {git am $args}
New-Alias gam Alias-gam 
Function Alias-gamc {git am --continue $args}
New-Alias gamc Alias-gamc 
Function Alias-gams {git am --skip $args}
New-Alias gams Alias-gams 
Function Alias-gama {git am --abort $args}
New-Alias gama Alias-gama 
Function Alias-gamscp {git am --show-current-patch $args}
New-Alias gamscp Alias-gamscp 

# TODO: Rewrite with PowerShell syntax
<#
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
#>

# TODO: Rewrite with PowerShell syntax. Clear-Variable -Name git_version
<#
unset git_version
#>