.PHONY: i3
i3:
	sudo pacman -S i3-gaps i3-wm i3status
	yay -S polybar
	ln -s `pwd`/i3 ~/.config/i3

yay: 
	rm -rf yay
	git clone https://aur.archlinux.org/yay.git
	cd yay && makepkg -si
	rm -rf yay

npm: 
	sudo pacman -S npm 
	sudo chown -R `whoami` /usr/lib/node_modules

# yarn is required for instant-markdown/vim-instant-markdown
yarn: 
	sudo pacman -S yarn
	sudo chown -R `whoami` /usr/lib/node_modules/yarn

instant-markdown:
	#this required sudo, not sure how to change that at the moment. this program is a much nicer alternative to livedown!
	npm -g install instant-markdown-d

vim: yarn
	sudo pacman -S neovim
	sh -c 'curl -fLo ~/.local/share}/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	mkdir -p ~/.config/nvim/
	ln -s `pwd`/init.vim ~/.config/nvim/init.vim
	# https://wiki.archlinux.org/title/Neovim#Installation
	sudo pacman -S python-pynvim
	nvim --headless +PlugInstall +UpdateRemotePlugins +qa

git:
	sudo pacman -S git
	ln -s `pwd`/gitconfig ~/.gitconfig	

tmux:
	sudo pacman -S tmux xclip
	ln -s `pwd`/tmux.conf ~/.tmux.conf	
gnome:
	sudo pacman -S gdm gnome
	systemctl enable gdm.service

network-manager:
	sudo pacman -S networkmanager
	systemctl enable NetworkManager

python:
	sudo pacman -S python3 python-pip python-virtualenv
	pip install --upgrade pip
	pip install ptpython
go:
	sudo pacman -S go
	mkdir -p ~/godev
	nvim --headless +GoInstallBinaries +qa

languages-all: python go

cli-tools: 
	sudo pacman -S wget tree jq the_silver_searcher fzf

applications: 
	yay -S google-chrome 

xorg:
	sudo pacman -S xorg-xinit xorg-server
	ln -s `pwd`/Xresources ~/.Xresources

terminal: xorg
	yay -Syu ttf-monaco
	sudo pacman -S rxvt-unicode

