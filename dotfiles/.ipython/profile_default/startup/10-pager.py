from __future__ import print_function
# IPython.core.hooks.show_in_pager doesn't cut it
import IPython.core.page


def page_printer(data, start=0, screen_lines=0, pager_cmd=None):
    if isinstance(data, dict):
        data = data['text/plain']
    print(data)


IPython.core.page.page = page_printer
