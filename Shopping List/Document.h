#import <Cocoa/Cocoa.h>

@interface Document : NSDocument
{
    IBOutlet NSTableView *shoppingListTableView;
    IBOutlet NSTextField *newItemNameTextField;
    
    NSMutableArray *shoppingListArray;
}

- (IBAction)addNewItemToShoppingList:(id)sender;

@end