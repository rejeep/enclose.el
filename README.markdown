# Enclose
Enclose is a minor mode for Emacs that encloses cursor within
punctuation pairs. For example, hitting the key `(` will insert `()`
and place the cursor in between.

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

To fetch Ecukes:

    $ cd /path/to/enclose
    $ git submodule init
    $ git submodule update
    
Run the tests with:

    $ ./util/ecukes/ecukes features
