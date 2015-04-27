require(['base/js/namespace', 'base/js/events'], function(IPython, events) {
  events.on('app_initialized.NotebookApp', function() {
    IPython.CodeCell.options_default.cm_config.autoCloseBrackets = false;
  });
});

require(['jquery'], function($) {
  $('#header-container').hide();
});
