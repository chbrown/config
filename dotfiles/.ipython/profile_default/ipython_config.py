# Don't prompt for confirmation when exiting with Ctrl-D
c.TerminalInteractiveShell.confirm_exit = False
# If the last statement is an assignment with a single symbol on the LHS, print it:
c.InteractiveShell.ast_node_interactivity = 'last_expr_or_assign'
# Decrease maximum shown items of sequence from default of 1000
c.PlainTextFormatter.max_seq_length = 100  # requires Jupyter Lab restart to take effect
