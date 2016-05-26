# vim move

It's annoying to delete and paste parts of a text just to move it up and down a
bit. There is the `:m[ove]` command but it is quite awkward to use by todays
standards. vim-move is a Vim plugin that moves lines and selections in a more
visual manner. Out of the box, the following keys are mapped in visual and
normal mode:

    <C-k>   Move selection up
    <C-j>   Move selection down

The mappings can be prefixed with a count, e.g. `5<C-k>` will move the selection
up by 5 lines.

See this short demo for a first impression:

![vim-move demo](http://i.imgur.com/RMv8KsJ.gif)


## Installation

vim-move is compatible with all major plugin managers. To install it using
Vundle, add

```vim
Bundle 'KhoaRB/vim-move'
```

to your `.vimrc`.


## Customization

Use `g:move_key_modifier` to set a custom modifier for key bindings. For
example,

```vim
let g:move_key_modifier = 'A'
```

which will create the following key bindings:

    <A-k>   Move selections up
    <A-j>   Move selections down

## License

This plugin is licensed under MIT license.
