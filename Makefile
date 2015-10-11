all: test

test:
	cask exec ecukes features

.PHONY: all test
