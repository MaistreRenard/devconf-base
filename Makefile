.PHONY: linux prepare_host setup_ssh 

prepare_host: setup_ssh
	@echo "Preparing host environment..."
	@sudo apt update && sudo apt install -y git
	@echo "Git installed"

setup_ssh:
	@sudo apt update && sudo apt install -y openssh-server
	@echo "SSH server installed"

	@echo "Setting up SSH access..."
	@sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
	@sudo systemctl restart sshd
	@echo "SSH configured - Root login enabled"

	@echo "Generating SSH key..."
	@ssh-keygen -t ed25519 -C "nicolas.wirth7@gmail.ch" -f ~/.ssh/id_ed25519 -N ""
	@echo "SSH key generated"
	
	@echo "Your public SSH key:"
	@cat ~/.ssh/id_ed25519.pub
	@echo "LXC preparation complete!"

linux:
	@echo "🐧 Running Linux setup script..."
	@chmod +x setup_linux.sh
	@./setup_linux.sh
	@echo "✅ Linux setup complete!"
