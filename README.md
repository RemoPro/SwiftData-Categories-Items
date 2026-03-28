# SwiftData Categories Items

- Item has a name
- Category has a name and icon

### All Items view
- Seperate View to see all saved items
- The category name is shown small underneath

### Category view
- Each category uses this view
- shows all items stored in it

### Item view
- shows the details from the item
    - It's name and category
    - only exists to show how to use a seperate view for it

## Edit/Delete
- Menu on category/item
- Only deleted after confirming the alert
- editing with a sheet
    - cancel/save buttons
    - saving disabled when no name
    - when editing items the category can be changed

## Other features
- As it uses SwiftData the categories and items are saved persistent
- Model confirms now to CloudKit (iCloud sync)
- App icon uses the icon file (OS 26+)
