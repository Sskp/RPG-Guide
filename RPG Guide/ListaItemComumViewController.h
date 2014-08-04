//
//  ListaItemComumViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 05/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdicionarItemViewController.h"

@class itemComum;

@interface ListaItemComumViewController : UITableViewController <ItemAddDelegate, NSFetchedResultsControllerDelegate, UISearchBarDelegate>{
    
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    
    UISearchBar	*mySearchBar;   
    
    NSString *estilo;
    NSString *prefixo;
    NSString *sufixo;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UISearchBar *mySearchBar;

@property (nonatomic, retain) NSString *estilo;
@property (nonatomic, retain) NSString *prefixo;
@property (nonatomic, retain) NSString *sufixo;

@property (nonatomic, retain) ItemComum *itemSelecionado;

- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *)searchTerm;

@end

