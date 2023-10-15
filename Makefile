.PHONY: i3
i3:
	sudo pacman -S i3-gaps i3-wm i3status dmenu
	yay -S polybar
	ln -s `pwd`/i3 ~/.config/i3

gcc:
	sudo pacman -S gcc

.PHONY: yay
yay: gcc
	sudo pacman -S fakeroot
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

bash-lsp:
	sudo pacman -S bash-language-server

vim-plug:
	sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

vim-packer: yay
	yay -S nvim-packer-git

vim-install:
	sudo pacman -S neovim
vim-config:
	mkdir -p ~/.config/
	ln -s `pwd`/nvim ~/.config/nvim

vim-plugin-install:
	# https://wiki.archlinux.org/title/Neovim#Installation
	sudo pacman -S python-pynvim
	nvim --headless +PlugInstall +UpdateRemotePlugins +qa

vim: vim-install vim-packer vim-plug vim-config vim-plugin-install

git:
	sudo pacman -S git
	ln -s `pwd`/gitconfig ~/.gitconfig
	ln -s `pwd`/gitignore ~/.gitignore

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
	sudo pacman -S wget tree jq ripgrep fzf man

applications:  yay
	yay -S google-chrome 

xorg:
	sudo pacman -S xorg-xinit xorg-server
	ln -s `pwd`/Xresources ~/.Xresources

fonts: yay
	yay -S ttf-monaco noto-fonts noto-fonts-emoji

alacritty-install:
	sudo pacman -S alacritty
	mkdir -p ${HOME}/.config/alacritty
	ln -s `pwd`/alacritty.yml ${HOME}/.config/alacritty/alacritty.yml

terminal: yay xorg fonts alacritty-install

github-cli:
	sudo pacman -S github-cli

github-login: github-cli
	mkdir -p ~/.ssh
	ssh-keygen -t ed25519 -C "wbanfield@gmail.com" -f ~/.ssh/github-key
	gh auth login
	ssh -i ~/.ssh/github-key git@github.com

docker:
	sudo pacman -S docker
	sudo systemctl enable docker.service

docker-user:
	sudo usermod -aG docker `whoami`

docker-all: docker docker-user
