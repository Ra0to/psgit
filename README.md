# PowerShell Git Aliases

This repo provides Git Aliases for Powershell.
Aliases based on [OhMyZsh](https://github.com/ohmyzsh) [Git Aliases](https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh).

Recommend to use with [PoshGit](https://github.com/dahlbyk/posh-git).

## Installation guide
1. Install Git. [Guide](https://git-scm.com/download/win).
2. Install PoshGit. [Guide](https://github.com/dahlbyk/posh-git#installation).
3. Copy paste aliases from `git.plugin.ps1` into your PowerShell profile.
Important! Aliases should be placed before importing PostGit.
4. Import PoshGit with arguments for tab completion work with aliases. 
```Import-Module posh-git -arg 0,0,1```
5. Enjoi shortcuts!