.PHONY: update-list check-list help

help:
	@echo "Proggie List Management"
	@echo "======================="
	@echo ""
	@echo "Available targets:"
	@echo "  update-list  - Update proggie-list-sorted.txt"
	@echo "  check-list   - Check if list is up to date"
	@echo "  help         - Show this help"
	@echo ""
	@echo "Note: GitHub Actions will auto-update on push"

update-list:
	@./update-proggie-list.sh

check-list:
	@echo "Checking if proggie-list-sorted.txt is up to date..."
	@./update-proggie-list.sh
	@if git diff --quiet proggie-list-sorted.txt; then \
		echo "✓ List is up to date"; \
	else \
		echo "✗ List is out of date. Run 'make update-list' and commit changes."; \
		exit 1; \
	fi
