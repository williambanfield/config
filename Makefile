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

gptscripts:
	mkdir -p repos
	git clone github.com/williambanfield:gptscripts.git "$(HOME)/repos/gptscripts"
	ln -s "$(HOME)/repos/gptscripts" "$(HOME)/.gptscripts"

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

vim-packer: yay
	yay -S nvim-packer-git

vim-install:
	sudo pacman -S neovim
vim-config:
	mkdir -p ~/.config/
	ln -s `pwd`/nvim ~/.config/nvim

vim-plugin-install:
	nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

vim: vim-install vim-packer vim-config vim-plugin-install

git:
	sudo pacman -S git
	ln -s `pwd`/gitconfig ~/.gitconfig
	ln -s `pwd`/gitignore ~/.gitignore

.PHONY: tmux
tmux:
	sudo pacman -S tmux xclip
	ln -s `pwd`/tmux/tmux.conf ~/.tmux.conf
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
	yay -S 1password-cli

applications:  yay
	yay -S google-chrome 

xorg:
	sudo pacman -S xorg-xinit xorg-server
	ln -s `pwd`/xinitrc ~/.xinitrc
	ln -s `pwd`/Xresources ~/.Xresources

fonts: yay
	yay -S ttf-monaco-nerd-font-git noto-fonts noto-fonts-emoji ttf-noto-nerd

alacritty-install:
	sudo pacman -S alacritty
	mkdir -p ${HOME}/.config/alacritty
	ln -s `pwd`/alacritty.toml ${HOME}/.config/alacritty/alacritty.toml

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

auto-update:
	sudo ln -s $(PWD)/updates/* /etc/systemd/system/
	for file in ./updates/*.timer; do systemctl enable $$(basename $$file); done
