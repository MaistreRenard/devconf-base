.PHONY: linux

linux:
	@echo "🐧 Running Linux setup script..."
	@chmod +x setup_linux.sh
	@./setup_linux.sh
	@echo "✅ Linux setup complete!"
