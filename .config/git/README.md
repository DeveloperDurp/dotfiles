The global hooks are installed by `ansible/scripts/install_watermarks_remover.yml`
through `make run`. The remover is pinned to the v0.7.0 commit and lives in
`~/.local/share/watermarks-remover`; it needs Python 3.10+ and no pip packages.

The pre-commit and pre-merge-commit hooks check staged regular files without
editing them or calling an LLM. Staged symlinks, submodules, and deletions are
excluded. The upstream checker skips unsupported formats and oversized files,
so passing does not mean
every file was inspected or every kind of watermark was removed.

All hook entry points dispatch existing executable hooks in the repository's
default hooks directory. A repository-specific `core.hooksPath` overrides the
global configuration and must include this check itself. Ansible stops if a
different global hook directory is already configured.

Run `bash .config/git/tests/hooks.sh` to check staged-content handling and hook
dispatch. The test uses temporary repositories and a small checker fixture;
it does not install the remover or change global Git configuration.
