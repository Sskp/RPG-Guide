//
//  TipoItemSelectionViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 09/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemComum;
@class ItemMagico;
@class Busca;
@class Categoria;

@interface TipoItemSelectionViewController : UITableViewController{

    ItemComum *itemComum;
    ItemMagico *itemMagico;
    Busca *busca;
    Categoria *cat;
    
    NSArray *listaTipo;
    NSManagedObjectContext *context;

    int fonte;
    NSString *estilo;
}

@property (nonatomic, retain) ItemMagico *itemMagico;
@property (nonatomic, retain) ItemComum *itemComum;
@property (nonatomic, retain) Busca *busca;
@property (nonatomic, retain) Categoria *cat;

@property (nonatomic, retain, readonly) NSArray *listaTipo;
@property (nonatomic, retain) NSManagedObjectContext *context;

@property (nonatomic, assign) int fonte;
@property (nonatomic, retain) NSString *estilo;
@end