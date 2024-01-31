git:
	git config --global core.excludesfile $$XDG_CONFIG_HOME/git/ignore.global

all:
	stow --verbose --no-folding --target=$$HOME --restow */
delete:
	stow --verbose --target=$$HOME --delete */

.PHONY: git all delete
