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
    NSString *newItem = [newItemNameTextField stringValue];
    
    [shoppingListArray addObject:newItem];
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

@end