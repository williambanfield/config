i3:
	sudo pacman -S i3 i3-wm i3status

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

languages-all: python
	sudo pacman -S go

cli-tools: 
	sudo pacman -S wget tree jq the_silver_searcher

applications: pacaur
	sudo pacman -S chromium 
	pacaur -S chromium
