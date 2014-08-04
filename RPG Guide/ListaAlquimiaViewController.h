//
//  ListaAlquimia.h
//  DM Compendium
//
//  Created by Mateus Andrade on 18/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdicionarAlquimiaViewController.h"

@class Alquimia;

@interface ListaAlquimiaViewController: UITableViewController <AlquimiaAddDelegate, NSFetchedResultsControllerDelegate, UISearchBarDelegate>{

    
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

@property (nonatomic, retain) Alquimia *alquimiaSelecionada;

- (void)resetSearch; 
- (void)handleSearchForTerm:(NSString *)searchTerm;

@end
