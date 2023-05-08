# Install Fusion Studio watcher
all: fusion resolve

prerequisites:
	sudo apt install xdotool

fusion:
	cp ./Fusion/fusion-studio-wakatime.lua ~/.local/bin/fusion-studio-wakatime.lua
	cp ./Fusion/fusion-studio-wakatime.service ~/.config/systemd/user/
	cp ./Fusion/fusion-studio-wakatime.timer ~/.config/systemd/user/
	systemctl --user daemon-reload
	systemctl --user enable fusion-studio-wakatime.service
	systemctl --user enable fusion-studio-wakatime.timer
	systemctl --user start fusion-studio-wakatime.timer

resolve:
	cp ./Resolve/davinci-resolve-wakatime.lua ~/.local/bin/davinci-resolve-wakatime.lua
	cp ./Resolve/davinci-resolve-wakatime.service ~/.config/systemd/user/
	cp ./Resolve/davinci-resolve-wakatime.timer ~/.config/systemd/user/
	systemctl --user daemon-reload
	systemctl --user enable davinci-resolve-wakatime.service
	systemctl --user enable davinci-resolve-wakatime.timer
	systemctl --user start davinci-resolve-wakatime.timer
