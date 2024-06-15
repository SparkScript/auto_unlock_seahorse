from threading import Thread
import os
import sys
import secretstorage

connection = secretstorage.dbus_init()
collection = secretstorage.get_default_collection(connection)

def unlock_parallel():
    try:
        collection.unlock()
    except:
        print("released")

if collection.is_locked():
    popup = Thread(target = unlock_parallel)
    popup.start()
    password = sys.argv[1]
    dotool = sys.argv[2]
    os.system(f"echo type {password} | {dotool}")
    os.system(f"echo key enter | dotool")
