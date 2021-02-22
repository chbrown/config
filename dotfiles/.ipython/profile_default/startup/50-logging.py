import logging

# WARNING = 30
logging.getLogger("matplotlib").setLevel(logging.WARNING)
logging.getLogger("paramiko.transport").setLevel(logging.WARNING)

# INFO = 20
logging.getLogger("botocore").setLevel(logging.INFO)
logging.getLogger("smart_open").setLevel(logging.INFO)
logging.getLogger("urllib3").setLevel(logging.INFO)
