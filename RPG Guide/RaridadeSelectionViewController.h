//
//  RaridadeSelectionViewController.h
//  DM Compendium
//
//  Created by Mateus Andrade on 20/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Alquimia;
@class ItemComum;
@class ItemMagico;
@class Busca;


@interface RaridadeSelectionViewController : UITableViewController{
    Alquimia *alquimia;
    ItemComum *itemComum;
    ItemMagico *itemMagico;
    Busca *busca;
    NSArray *listaRaridade;
    
    int fonte;
    NSString *estilo;
    
    NSManagedObjectContext *context;
}

@property (nonatomic, retain) Alquimia *alquimia;
@property (nonatomic, retain) ItemComum *itemComum;
@property (nonatomic, retain) ItemMagico *itemMagico;
@property (nonatomic, retain) Busca *busca;

@property (nonatomic, assign) int fonte;
@property (nonatomic, retain) NSString *estilo;

@property (nonatomic, retain) NSManagedObjectContext *context;

@property (nonatomic, retain, readonly) NSArray *listaRaridade;

@end