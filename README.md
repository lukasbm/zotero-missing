# Zotero Fix

This repo can be used to download missing attachments from arxiv etc. (assuming the attachment is already there, but the
file was not synced for whatever reason)

In the future it could also be used to update the files, in case a new version is available.

## Usage

> [!WARNING]
> Liunx only!

Only uses default packages included in every python install:

Assuming a standard zotero install
```
python download.py
```

> [!NOTE]
> This script does not touch the database, nor overwrite existing files. NO CORRUPTION RISK


## Reverse Engineer the Database

Idk if there is a official description of the database scheme so i reverse engineered it.

Relevant Tables: `itemAttachments` and `items`

Relevant fields in `itemAttachments`:

- `linkMode`: says if it is an embedded pdf (1) or some other type of link (irrelevant)
- `syncState`: indicates if it is present:
    - 0: Kinda Present?
    - 1: Not Present!
    - 2: Present

If syncState is 1, then the other fields like "recent modified" is also not present

Right now there are 30 values where `syncState` is 1 and `linkMode` is 1. These are the ones that are not present.

Need to find out where the arxiv links are stored???
Its in `itemDataValues`
References by `itemData`

There is also `syncCache` with some information
Also make sure `syncQueue` is empty before running all of these!


