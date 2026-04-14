# dotfiles

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

After the first apply the script is available as `dotfiles` globally. Default repo location is `~/.dotfiles`. To use a different path, set `DOTFILES_DIR` before applying and persist it in `~/.zshrc.local`:

```bash
export DOTFILES_DIR=~/code/dotfiles
$DOTFILES_DIR/dotfiles_public/.local/bin/dotfiles public apply
```

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

### Shell helpers

| Name | Description |
|------|-------------|
| `$DOTFILES_DIR` | Path to the directory containing both repos (default: `~/.dotfiles`) |
| `dotpub` | `cd` to `dotfiles_public` |
| `dotpriv` | `cd` to `dotfiles_private` |

## Private repo

```bash
git clone https://github.com/yourname/dotfiles_private ~/.dotfiles/dotfiles_private
dotfiles private apply
```

Both repos are managed independently — they share no files.

## Control files

Each repo can contain these optional control files (never copied to `~/`):

| File | Purpose |
|------|---------|
| `.dotfiles-ignore` | Patterns to skip during `apply`/`diff`/`status` |
| `.dotfiles-allow-override` | Paths allowed to exist in both repos without a conflict error |
| `.dotfiles-replace` | Dirs/files to wipe and replace wholesale on `apply` |

### `.dotfiles-replace`

Use this when a repo needs to **own an entire directory** — for example when `dotfiles_private` has a completely different nvim config that should replace whatever `dotfiles_public` applied:

```
# dotfiles_private/.dotfiles-replace
.config/nvim
```

On `dotfiles private apply` the script will ask for confirmation, back up the existing directory as `~/.config/nvim.bak.YYYY-MM-DD_HH-MM-SS`, delete it, then copy the repo version in full. Declining the prompt leaves the directory untouched.

Typical workflow:

```bash
dotfiles public apply    # lays down the base config
dotfiles private apply   # asked: replace ~/.config/nvim? [y/N]
```

## Contents

| File | Description |
|------|-------------|
| `.zshrc` | Thin loader - sources public, private, local |
| `.zshrc.public` | Shell config: PATH, editor, fnm, pnpm etc. |
| `.tmux.conf` | tmux: vi keys, popup keybinds |
| `.tmux-automatizer.local` | Per-project tmux session hook |
| `.tmux-automatizer.global` | Global-project tmux session hook |
| `.config/git/ignore` | Global gitignore |
| `.local/bin/cds` | Fuzzy tmux session switcher |
| `.local/bin/dotfiles` | Dotfiles manager script |
