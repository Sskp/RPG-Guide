//
//  SelecionaItemViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 16/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdicionarItemMagicoViewController.h"

@protocol AddExistenteDelegate;
@class ItemComum;

@interface SelecionaItemViewController : UITableViewController <ItemMagicoAddDelegate, NSFetchedResultsControllerDelegate, UISearchBarDelegate>{
    
    id <AddExistenteDelegate> delegate;
    
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    
    UISearchBar	*mySearchBar;   
    
    NSString *estilo;
    NSString *prefixo;
    NSString *sufixo;
    
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) id <AddExistenteDelegate> delegate;

@property (nonatomic, retain) IBOutlet UISearchBar *mySearchBar;

@property (nonatomic, retain) NSString *estilo;
@property (nonatomic, retain) NSString *prefixo;
@property (nonatomic, retain) NSString *sufixo;

- (void)resetSearch; 
- (void)handleSearchForTerm:(NSString *)searchTerm;

@end

@protocol AddExistenteDelegate <NSObject>
- (void)SelecionarItemViewController:(SelecionaItemViewController *)selecionarItem didAddItem:(ItemMagico *)itemMagico;

@end


