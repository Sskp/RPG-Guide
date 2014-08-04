//
//  CategoriaSelectionViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 06/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemComum;
@class ItemMagico;
@class Busca;

@interface CategoriaSelectionViewController : UITableViewController{
    
    ItemComum *itemComum;
    ItemMagico *itemMagico;
    Busca *busca;
    NSArray *listaCategoria;
    NSManagedObjectContext *context;
    
    int fonte;
    NSString *estilo;
}

@property (nonatomic, retain) ItemMagico *itemMagico;
@property (nonatomic, retain) ItemComum *itemComum;
@property (nonatomic, retain) Busca *busca;

@property (nonatomic, retain, readonly) NSArray *listaCategoria;
@property (nonatomic, retain) NSManagedObjectContext *context;

@property (nonatomic, assign) int fonte;
@property (nonatomic, retain) NSString *estilo;

@end