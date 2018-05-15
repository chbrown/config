# Don't prompt for confirmation when exiting with Ctrl-D
c.TerminalInteractiveShell.confirm_exit = False
# If the last statement is an assignment with a single symbol on the LHS, print it:
c.InteractiveShell.ast_node_interactivity = 'last_expr_or_assign'