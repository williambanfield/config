UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S), Darwin)
    OS := mac
    PKG := brew install
    PKG_CASK := brew install --cask
else
    DISTRO := $(shell . /etc/os-release && echo $$ID)
    ifeq ($(DISTRO), arch)
        OS := arch
        PKG := sudo pacman -S
    else
        OS := debian
        PKG := sudo apt-get install -y
    endif
endif

.PHONY: i3
i3:
ifeq ($(OS), arch)
	sudo pacman -S i3-gaps i3-wm i3status dmenu
	yay -S polybar
	ln -s `pwd`/i3 ~/.config/i3
else
	$(error i3 is only supported on Arch Linux)
endif

gcc:
ifeq ($(OS), arch)
	sudo pacman -S gcc
else ifeq ($(OS), debian)
	sudo apt-get install -y gcc
else
	$(PKG) gcc
endif

.PHONY: yay
yay: gcc
ifeq ($(OS), arch)
	sudo pacman -S fakeroot
	rm -rf yay
	git clone https://aur.archlinux.org/yay.git
	cd yay && makepkg -si
	rm -rf yay
else
	$(error yay is only supported on Arch Linux)
endif

gptscripts:
	mkdir -p repos
	git clone github.com/williambanfield:gptscripts.git "$(HOME)/repos/gptscripts"
	ln -s "$(HOME)/repos/gptscripts" "$(HOME)/.gptscripts"

npm:
ifeq ($(OS), arch)
	sudo pacman -S npm
	sudo chown -R `whoami` /usr/lib/node_modules
else ifeq ($(OS), debian)
	sudo apt-get install -y npm
else
	$(PKG) node
endif

# yarn is required for instant-markdown/vim-instant-markdown
yarn:
ifeq ($(OS), arch)
	sudo pacman -S yarn
	sudo chown -R `whoami` /usr/lib/node_modules/yarn
else ifeq ($(OS), debian)
	sudo apt-get install -y yarn
else
	$(PKG) yarn
endif

instant-markdown:
	#this required sudo, not sure how to change that at the moment. this program is a much nicer alternative to livedown!
	npm -g install instant-markdown-d

vim-install:
ifeq ($(OS), arch)
	sudo pacman -S neovim tree-sitter
else ifeq ($(OS), debian)
	sudo apt-get install -y neovim
	sudo apt-get install -y npm && sudo npm install -g tree-sitter-cli
else
	$(PKG) neovim
	$(PKG) tree-sitter
endif
vim-config:
	mkdir -p ~/.config/
	ln -sf `pwd`/nvim ~/.config/nvim

vim-plugin-install:
	nvim --headless -c 'Lazy sync' -c 'qa'

vim: vim-install vim-config vim-plugin-install

git:
	ln -s `pwd`/gitconfig ~/.gitconfig
	ln -s `pwd`/gitignore ~/.gitignore

.PHONY: tmux
tmux:
ifeq ($(OS), arch)
	sudo pacman -S tmux xclip
else ifeq ($(OS), debian)
	sudo apt-get install -y tmux
else
	$(PKG) tmux
endif
	ln -s `pwd`/tmux/tmux.conf ~/.tmux.conf

gnome:
ifeq ($(OS), arch)
	sudo pacman -S gdm gnome
	systemctl enable gdm.service
else
	$(error gnome target is only supported on Arch Linux)
endif

network-manager:
ifeq ($(OS), arch)
	sudo pacman -S networkmanager
	systemctl enable NetworkManager
else
	$(error network-manager target is only supported on Arch Linux)
endif

python:
ifeq ($(OS), arch)
	sudo pacman -S python3 python-pip python-virtualenv
else ifeq ($(OS), debian)
	sudo apt-get install -y python3 python3-pip python3-virtualenv
else
	$(PKG) python3
	pip3 install virtualenv
endif
	pip install --upgrade pip
	pip install ptpython

go:
ifeq ($(OS), arch)
	sudo pacman -S go
else ifeq ($(OS), debian)
	sudo apt-get install -y golang
else
	$(PKG) go
endif
	mkdir -p ~/godev
	nvim --headless +GoInstallBinaries +qa

languages-all: python go

cli-tools:
ifeq ($(OS), arch)
	sudo pacman -S wget tree jq ripgrep fzf man
	yay -S 1password-cli
else ifeq ($(OS), debian)
	sudo apt-get install -y wget tree jq ripgrep fzf man
else
	$(PKG) wget tree jq ripgrep fzf
	$(PKG) 1password-cli
endif

applications:
ifeq ($(OS), arch)
	yay -S google-chrome
else
	$(PKG_CASK) google-chrome
endif

xorg:
ifeq ($(OS), arch)
	sudo pacman -S xorg-xinit xorg-server
	ln -s `pwd`/xinitrc ~/.xinitrc
	ln -s `pwd`/Xresources ~/.Xresources
else
	$(error xorg is only supported on Arch Linux)
endif

fonts:
ifeq ($(OS), arch)
	yay -S ttf-monaco-nerd-font-git noto-fonts noto-fonts-emoji ttf-noto-nerd
else
	$(PKG_CASK) font-monaco-nerd-font font-noto-nerd-font
endif

alacritty-install:
	$(PKG) alacritty
	mkdir -p ${HOME}/.config/alacritty
	ln -s `pwd`/alacritty.toml ${HOME}/.config/alacritty/alacritty.toml

terminal: xorg fonts alacritty-install

github-cli:
ifeq ($(OS), arch)
	sudo pacman -S github-cli
else ifeq ($(OS), debian)
	sudo apt-get install -y gh
else
	$(PKG) gh
endif

github-login: github-cli
	mkdir -p ~/.ssh
	ssh-keygen -t ed25519 -C "wbanfield@gmail.com" -f ~/.ssh/github-key
	gh auth login
	ssh -i ~/.ssh/github-key git@github.com

docker:
ifeq ($(OS), arch)
	sudo pacman -S docker
	sudo systemctl enable docker.service
else ifeq ($(OS), debian)
	sudo apt-get install -y docker.io
	sudo systemctl enable docker.service
else
	$(PKG_CASK) docker
endif

docker-user:
	sudo usermod -aG docker `whoami`

docker-all: docker docker-user

auto-update:
ifeq ($(OS), arch)
	sudo ln -s $(PWD)/updates/* /etc/systemd/system/
	for file in ./updates/*.timer; do systemctl enable $$(basename $$file); done
else
	$(error auto-update is only supported on Arch Linux)
endif
