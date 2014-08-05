//
//  SelecionaPoderViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 26/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol poderDelegate;
@class Categoria;

@interface SelecionaPoderViewController : UITableViewController<NSFetchedResultsControllerDelegate, UISearchBarDelegate>{
        
    id <poderDelegate> delegate;
    
    NSFetchedResultsController  *fetchedResultsController;
    NSManagedObjectContext      *managedObjectContext;
        
    UISearchBar     *mySearchBar;   
        
    NSString        *estilo;
    NSString        *categoria;
        
    NSMutableArray  *poderesSelecionados;
    
    int             nivel;
        
    NSPredicate     *pred;
    
    BOOL            flag;
}
    
@property (nonatomic, retain) id<poderDelegate> delegate;

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
    
@property (nonatomic, retain) UISearchBar *mySearchBar;
    
@property (nonatomic, retain) NSString *estilo;

@property (nonatomic, retain) NSMutableArray *poderesSelecionados;

@property (nonatomic, assign) int nivel;

@property (nonatomic, retain) NSString *categoria;

- (void)resetSearch; 
- (void)handleSearchForTerm:(NSString *)searchTerm;
    
@end

@protocol poderDelegate <NSObject>
- (void)IncluirPoder:(NSString *)texto valorNivel:(NSNumber *)valorNivel;
@end
    
