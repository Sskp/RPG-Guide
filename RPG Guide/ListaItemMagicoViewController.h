//
//  ListaItemMagicoViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 16/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdicionarItemMagicoViewController.h"
#import "SelecionaItemViewController.h"

@class ItemMagico;

@interface ListaItemMagicoViewController : UITableViewController <ItemMagicoAddDelegate, AddExistenteDelegate, UIAlertViewDelegate,
    NSFetchedResultsControllerDelegate, UISearchBarDelegate>{
    
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

@property (nonatomic, retain) ItemMagico *itemMagicoSelecionado;

- (void)resetSearch;
- (void)handleSearchForTerm:(NSString *)searchTerm;
- (ItemMagico *)gerarItemMagico;

@end


