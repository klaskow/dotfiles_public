# dotfiles

> [!WARNING]
> This repo uses **force-push**. Treat it as inspiration - don't track it as an upstream.

My public dotfiles managed with a custom `dotfiles` script. Supports two repos side by side - `dotfiles_public` (this one) and an optional `dotfiles_private` for anything you don't want public.

## How it works

Each file maps 1:1 to `~/`. The `.zshrc` is a thin loader:

```zsh
[ -f ~/.zshrc.public ]  && source ~/.zshrc.public
[ -f ~/.zshrc.private ] && source ~/.zshrc.private
[ -f ~/.zshrc.local ]   && source ~/.zshrc.local   # machine-specific, never committed
```

Shell config is split: public config in `dotfiles_public`, secrets/work config in `dotfiles_private`, per-machine tweaks in `~/.zshrc.local`. Each layer can override the previous one.

## Quick start

```bash
git clone https://github.com/klaskow/dotfiles_public ~/.dotfiles/dotfiles_public
~/.dotfiles/dotfiles_public/.local/bin/dotfiles public apply
```

After the first apply the script is available as `dotfiles` globally. Default repo location is `~/.dotfiles`. 

> [!NOTE]
> To use a different path, set `DOTFILES_DIR` before applying and persist it in `~/.zshrc.local`:
>
> ```bash
> export DOTFILES_DIR=~/code/dotfiles
> $DOTFILES_DIR/dotfiles_public/.local/bin/dotfiles public apply
> ```

## Private repo

```bash
git clone https://github.com/yourname/dotfiles_private ~/.dotfiles/dotfiles_private
dotfiles private apply
```

Both repos are managed independently - they share no files.

## Commands

| Command | Description |
|---------|-------------|
| `dotfiles public apply` | Copy files from repo → `~/` |
| `dotfiles public apply --dry-run` | Preview what would change, nothing is copied |
| `dotfiles public save` | Copy all changed files `~/` → repo |
| `dotfiles public save ~/.zshrc.public` | Copy one file `~/` → repo (adds if new, updates if exists) |
| `dotfiles public edit ~/.zshrc.public` | Open file from repo in `$EDITOR` |
| `dotfiles public diff` | Show differences between machine and repo |
| `dotfiles public status` | Short summary of changes |
| `dotfiles public doctor` | Check repo health (permissions, cross-repo conflicts) |

All commands work the same for `dotfiles private`.

**Typical workflow**:

```bash
dotfiles public apply    # lays down the base config
dotfiles private apply   # asked: replace ~/.config/nvim? [y/N]
```