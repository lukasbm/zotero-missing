import os
import sqlite3
from typing import NamedTuple
from urllib.request import urlretrieve

base = "/home/lukas/Zotero/storage"

con = sqlite3.connect("/home/lukas/Zotero/zotero.sqlite")

cur = con.cursor()

with open("find.sql") as f:
    res = cur.execute(f.read())


# order is really important here!
class Entry(NamedTuple):
    key: str
    item_id: int
    url: str
    filename: str


res = [Entry(*r) for r in res]

# download it!
for r in res:
    try:
        print(r)
        urlretrieve(r.url, os.path.join(base, r.filename.removeprefix("storage:")))
    except Exception as e:
        print(e)
        print(r)
        print("====")
        continue
