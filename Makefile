.PHONY: update-list check-list help ship test graph

help:
	@echo "Proggie Archive Management"
	@echo "=========================="
	@echo ""
	@echo "Available targets:"
	@echo "  ship         - Git-ship: branch → validate → commit → merge → push"
	@echo "  test         - Run pytest suite"
	@echo "  graph        - Rebuild code graph"
	@echo "  update-list  - Update proggie-list-sorted.txt"
	@echo "  check-list   - Check if list is up to date"
	@echo "  help         - Show this help"
	@echo ""
	@echo "Ship usage:"
	@echo "  make ship BRANCH=feat/xxx MSG=\"feat: description\" FILES=\"file1.py file2.py\""
	@echo ""
	@echo "Note: GitHub Actions will auto-update on push"

ship:
ifndef BRANCH
	$(error BRANCH is required. Usage: make ship BRANCH=feat/xxx MSG="commit msg" FILES="file1 file2")
endif
ifndef MSG
	$(error MSG is required. Usage: make ship BRANCH=feat/xxx MSG="commit msg" FILES="file1 file2")
endif
	bash tools/git-ship.sh $(BRANCH) "$(MSG)" $(FILES) $(FLAGS)

test:
	python3 -m pytest tests/ -v --tb=short

graph:
	python3 tools/code-graph/build_graph.py

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
