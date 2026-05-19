# $ make format
format:
	stylua .

# $ make format-check
format-check:
	stylua --check .

# $ format-changed
format-changed:
	stylua $(shell git diff --name-only -- '*.lua')
