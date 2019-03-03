.PHONY: i3
i3:
	sudo pacman -S i3-gaps i3-wm i3status
	pacaur -S polybar
	ln -s `pwd`/i3 ~/.config/i3

pacaur: git
	git clone https://aur.archlinux.org/cower.git
	cd cower && makepkg -si
	git clone https://aur.archlinux.org/pacaur.git
	cd pacaur && makepkg -si
	rm -rf cower pacaur

vim:
	sudo pacman -S neovim
	mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.config/nvim
	curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -sfLo ~/.vim/autoload/plug.vim --create-dirs
	ln -s `pwd`/init.vim ~/.config/nvim/init.vim
	nvim --headless +PlugInstall +UpdateRemotePlugins +qa

git:
	sudo pacman -S git
	ln -s `pwd`/gitconfig ~/.gitconfig	

tmux:
	sudo pacman -S tmux
	ln -s `pwd`/tmux.conf ~/.tmux.conf	

python:
	sudo pacman -S python python-pip python-virtualenv
	pip install --upgrade pip
	sudo pip install ptpython
go:
	sudo pacman -S go
	sudo mkdir -p ~/godev

languages-all: python go

cli-tools: 
	sudo pacman -S wget tree jq the_silver_searcher

applications: pacaur
	sudo pacman -S chromium 
	pacaur -S chromium

xorg:
	sudo pacman -S xorg-xinit xorg-server
	ln -s `pwd`/Xresources ~/.Xresources

terminal: xorg
	sudo pacman -S rxvt-unicode
