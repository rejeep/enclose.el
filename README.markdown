# Enclose [![Build Status](https://api.travis-ci.org/rejeep/enclose.png?branch=master)](http://travis-ci.org/rejeep/enclose)
Enclose is a minor mode for Emacs that encloses cursor within
punctuation pairs. For example, hitting the key `(` will insert `()`
and place the cursor in between.

[<img src="http://img.youtube.com/vi/zAPQ_WgVySw/0.jpg">](https://www.youtube.com/watch?v=zAPQ_WgVySw)

## Installation
I recommend installing via ELPA, but manual installation is simple as well:

    (add-to-list 'load-path "/path/to/enclose")
    (require 'enclose)

## Usage
Start `enclose-mode` using.

    (enclose-mode t)
    
or

    M-x enclose-mode

Now try pressing any of the following keys: `"`, `'`, `(`, `{`, `[`.

For more information, see comments in `enclose.el`.

## Contribution
Contribution is much welcome! Enclose is tested using [Ecukes](http://ecukes.info). When
adding new features, please write tests for them!

Install [cask](https://github.com/rejeep/cask.el) if you haven't
already, then:

    $ cd /path/to/enclose
    $ cask

Run all tests with:

    $ make
