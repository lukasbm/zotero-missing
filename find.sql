-- TODO: assert that syncQueue is empty

-- Something is broken ... these are not enough entries!

-- getting links!
WITH missing AS (SELECT itemID
                 from itemAttachments
                 WHERE syncState == 1
                   and linkMode == 1)
SELECT items.key, items.itemId, itemDataValues.value, itemAttachments.path
FROM itemData
         LEFT JOIN itemDataValues on itemData.valueID = itemDataValues.valueID
         LEFT JOIN items on itemData.itemID = items.itemID
         LEFT JOIN itemAttachments on items.itemID = itemAttachments.itemID
WHERE itemData.itemID IN missing
  AND itemDataValues.value LIKE "http%" -- all links, although only arxiv might be smarter
  AND fieldID = 13 -- URL
;
