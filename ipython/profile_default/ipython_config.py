# disable pager
from __future__ import print_function
from IPython.core import page
page.page = print

c = get_config()
# we can do this easily with `alias ipy='ipython --no-confirm-exit`
# but what if we drop into the IPython REPL from a Python script?
c.InteractiveShell.confirm_exit = False
