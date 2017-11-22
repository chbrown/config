/**
Hide the header, which doesn't convey any useful information.

We could set #header-container { display: none !important } in custom.css,
but then we couldn't "Toggle Header" from the menu even if we wanted.
Calling the 'hide-header' action is more like clicking "Toggle Header" whenever
entering a notebook.
*/
jQuery(() => {
  Jupyter.actions.call('jupyter-notebook:hide-header')
})

/**
Load the sublime keymap and set the CodeMirror default config keymap to use it.

This is surprisingly unreliable.

See also: https://jupyter-notebook.readthedocs.io/en/stable/extending/keymaps.html
*/
require(['notebook/js/cell', 'codemirror/keymap/sublime'], (cell, _) => {
  // this causes the 'sublime' keyMap to be loaded internally, which is necessary,
  // but the require itself actually results in `undefined`
  cell.Cell.options_default.cm_config.keyMap = 'sublime'
  console.log('notebook/js/cell.Cell.options_default.cm_config.keyMap set to "sublime"')
})
