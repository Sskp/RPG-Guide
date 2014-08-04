//
//  ListaPoderViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdicionarPoderViewController.h"

@class Poder;

@interface ListaPoderViewController : UITableViewController <PoderAddDelegate,NSFetchedResultsControllerDelegate, UISearchBarDelegate>{
    
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    
    UISearchBar	*mySearchBar;   
    
    NSString *estilo;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) IBOutlet UISearchBar *mySearchBar;

@property (nonatomic, retain) NSString *estilo;

@property (nonatomic, retain) Poder *poderSelecionado;

@property (retain, nonatomic) IBOutlet UIToolbar *keyboardBar;

- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *)searchTerm;

@end

