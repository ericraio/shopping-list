#import "Document.h"

@implementation Document

- (id)init
{
    self = [super init];
    if (self) {
        shoppingListArray = [[NSMutableArray alloc] initWithObjects:@"Milk", @"Eggs", @"Butter", nil];
    }
    return self;
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    [shoppingListArray replaceObjectAtIndex:rowIndex withObject:anObject];
}

- (IBAction)addNewItemToShoppingList:(id)sender
{
    NSString *itemToAdd = [newItemNameTextField stringValue];
    for (NSString *eachItem in shoppingListArray) {
        if ( [eachItem isEqualToString:itemToAdd] )
        {
            NSAlert *alert = [[NSAlert alloc] init];
            [alert addButtonWithTitle:@"Duplicate"];
            [alert addButtonWithTitle:@"Cancel"];
            [alert setMessageText:@"This item already exists in your shopping list."];
            [alert setInformativeText:@"Do you really want to add a duplicate item?"];
            [alert setAlertStyle:NSWarningAlertStyle];
            
            long int returnValue = [alert runModal];
            if (returnValue == NSAlertFirstButtonReturn) {
                break;
            } else {
                return;
            }
        }
    }
    
    
    [shoppingListArray addObject:itemToAdd];
    [newItemNameTextField setStringValue:@""];
    [shoppingListTableView reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
    return [shoppingListArray count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    return [shoppingListArray objectAtIndex:rowIndex];
}

- (NSString *)windowNibName
{
    return @"Document";
}

- (void)windowControllerDidLoadNib:(NSWindowController *)aController
{
    [super windowControllerDidLoadNib:aController];
}

+ (BOOL)autosavesInPlace
{
    return YES;
}

- (BOOL)writeToURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError
{
    return [shoppingListArray writeToURL:url atomically:YES];
}

- (BOOL)readFromURL:(NSURL *)url ofType:(NSString *)typeName error:(NSError **)outError
{
    shoppingListArray = [[NSMutableArray alloc] initWithContentsOfURL:url];
    
    [shoppingListTableView reloadData];
    
    return YES;
}

- (IBAction)removeItemFromShoppingList:(id)sender;
{
    long int selectedItemIndex = [shoppingListTableView selectedRow];
    if (selectedItemIndex == -1) return;
    
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"Delete"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert setMessageText:@"Delete the shopping list item?"];
    [alert setInformativeText:@"Deleted items cannot be restored."];
    [alert setAlertStyle:NSWarningAlertStyle];
    [alert setAlertStyle:NSWarningAlertStyle];
    
    long int returnValue = [alert runModal];
    if (returnValue == NSAlertFirstButtonReturn) {
        [shoppingListArray removeObjectAtIndex:selectedItemIndex];
        [shoppingListTableView reloadData];
    }
}

@end