-- TODO: assert that syncQueue is empty

-- Something is broken ... these are not enough entries!

-- getting links!
WITH missing AS (SELECT itemID
                 from itemAttachments
                 WHERE syncState == 1
                   and linkMode == 1)
SELECT *
FROM itemData
         LEFT JOIN itemDataValues on itemData.valueID = itemDataValues.valueID
WHERE itemID IN missing
  AND itemDataValues.value LIKE "http%"
  AND fieldID = 13 -- URL
;