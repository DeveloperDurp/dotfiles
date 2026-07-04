# .dotfiles

Personal config repo. Source of truth for `~/` via GNU Stow + Ansible provisioning. This is a personal-config repo, not an application — "tests" and "build" are edit/stow/source, not `make test`.

## Editing workflow

1. Edit in `~/.dotfiles/...`
2. Re-stow: `stow --adopt .` (existing files get adopted into the repo, **then `git reset --hard` to drop unintended adoptions**)
3. Source the relevant file (`.bashrc`, `.zshrc`, restart app, etc.)

`.stow-local-ignore` lists what stow skips: `ansible/`, `Makefile`, `.env`, `.git`, `.gitmodules`, `.gitignore`, `install.sh`, `DesktopAnsible` (stale submodule), `.omo`, `.codegraph`.

`install.sh` is devpod bootstrap only — `make devpod` is the canonical dev-container entry. `make run` is the local entry.

## Provisioning

| Command | Playbook | Target |
|---|---|---|
| `make run` | `ansible/local.yml` | Local dev (user `user`) |
| `make devpod` | `ansible/devpod.yml` | DevPod container (user `vscode`) |
| `make security` | `ansible/security.yml` | UFW + unattended-upgrades |
| `make update` | `ansible/update.yml` | All package managers |

Prereqs for `make run` (one-time): `sudo apt install python3-pip python3-psutil && ansible-galaxy collection install community.general`. See `ansible/requirements.sh`.

**`make` requires an unlocked Bitwarden CLI** — `bw` must be unlocked (e.g. `export BW_SESSION=$(bw unlock --raw)`) before running. The Makefile `include .env`s `GITLAB_TOKEN="$(bw get password cli-gitlab)"`. Without a session, every `make` target fails immediately.

## nvim config (the trap)

There are two nvim trees in this repo, and a third in `~/.config/nvim/`. The split is intentional-but-fragile.

- **`~/.dotfiles/.config/nvim/`** — canonical source. Most files in `~/.config/nvim/` are symlinked here individually (init.lua, lua/plugins/*.lua, LICENSE, README, etc.).
- **`~/.config/nvim/`** — runtime tree. Top-level files symlinked to dotfiles; `lazyvim.json` and `lazy-lock.json` are regular files owned by LazyVim. The `lua/` subtree is a real directory mirroring dotfiles via per-file symlinks (e.g. `lua/plugins/tmux.lua` → dotfiles; `lua/plugins/golang.lua` → dotfiles; `lua/plugins/example.lua` → dotfiles).
- **`~/.dotfiles/.config/nvim_1/`** — untracked, the previous custom config kept as reference. Don't edit; treat as read-only history.

**Edits to plugin specs (`lua/plugins/*.lua`) belong in dotfiles.** The symlinks in `~/.config/nvim/lua/plugins/` mirror them. After editing the dotfiles file, restart nvim.

**Edits to LazyVim-owned files** (`lazyvim.json`, `lazy-lock.json`) belong in `~/.config/nvim/` directly. Don't symlink them; LazyVim updates them on `:Lazy sync`.

To add a new plugin spec: create `~/.dotfiles/.config/nvim/lua/plugins/<name>.lua`, then symlink it: `ln -s ../../../../.dotfiles/.config/nvim/lua/plugins/<name>.lua ~/.config/nvim/lua/plugins/<name>.lua`.

## OpenCode

Multiple config files coexist:
- `~/.dotfiles/.config/opencode/opencode.json` — primary; sets model `deepseek-v4-flash`, providers (Ollama on `192.168.12.50:11434`), plugin `oh-my-openagent@latest`.
- `~/.dotfiles/.config/opencode/opencode.jsonc` — JSONC variant; check whether it's a duplicate or env-specific before editing.
- `~/.dotfiles/.config/opencode/AGENTS.md` — Ponytail persona (lazy-senior-dev operating rules). Sourced automatically.

## Layout (high-signal only)

- `.config/` — all stow-managed app config. Heavy: `nvim/`, `opencode/`, `tmux/`, `sway/`, `kitty/`, `ghostty/`, `terminator/`, `qutebrowser/`, `cosmic/`, `nvim/`, `yazi/`, `lazygit/`, `k9s/`, `bat/`, `ohmyposh/`, `yubikey/`.
- `ansible/roles/{packages,customize,devpod,security,update}/` — provisioners.
- `ansible/scripts/`, `ansible/files/` — role helpers; check before adding new roles.
- `.themes/` — Catppuccin Mocha assets; used by bat, ghostty, kitty.
- `.ideavimrc` — JetBrains IDEAVim parity; mirrors the nvim keymap conventions.

## Conventions

- **Theme**: Catppuccin Mocha everywhere.
- **Shells**: bash + zsh (zinit) + powershell, all with `oh-my-posh` prompt. Aliases in `.bashrc`: `ls`→`eza`, `cat`→`bat`, `docker`→`podman`, `vim`→`nvim`.
- **Secrets**: Bitwarden CLI. Anything secret goes through `bw get password <item>` — never commit secrets; `.env` is git-ignored.
- **Stale submodule**: `DesktopAnsible` is initialized but not used. `.gitmodules` still references it.

## Gotchas

- `ansible/local.yml` runs `become: true` and writes to `~user` — don't run it on a devpod (use `make devpod`).
- `.config/cosmic/` is for the System76 COSMIC desktop. Don't delete it on a non-COSMIC box.
- `ansible.cfg` sets `log_path=/tmp/ansible` — ansible logs there on every run.
- `inventory` is a one-liner; this is a localhost-only repo, no remote hosts.
