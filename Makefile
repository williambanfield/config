.PHONY: i3
i3:
	sudo pacman -S i3-gaps i3-wm i3status
	pacaur -S polybar
	ln -s `pwd`/i3 ~/.config/i3

pacaur: git
	git clone https://aur.archlinux.org/yay.git
	cd yay && makepkg -si
	rm -rf yay

vim:
	sudo pacman -S neovim
	curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -sfLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
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
	sudo pip install --upgrade pip
	sudo pip install ptpython
go:
	sudo pacman -S go
	sudo mkdir -p ~/godev

languages-all: python go

cli-tools: 
	sudo pacman -S wget tree jq the_silver_searcher

applications: 
	sudo pacman -S chromium 

xorg:
	sudo pacman -S xorg-xinit xorg-server
	ln -s `pwd`/Xresources ~/.Xresources

terminal: xorg
	yay -Syu ttf-monaco
	sudo pacman -S rxvt-unicode

