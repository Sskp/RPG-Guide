//
//  TipoAlquimiaSelectionViewController.h
//  DM Compendium
//
//  Created by Mateus Andrade on 19/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Alquimia;
@class Busca;

@interface TipoAlquimiaSelectionViewController : UITableViewController{

    Alquimia *alquimia;
    Busca *busca;
    NSArray *listaTipoAlquimia;
    NSString *estilo;
    NSManagedObjectContext *context;
    
    int fonte;

}

@property (nonatomic, retain) Alquimia *alquimia;
@property (nonatomic, retain) Busca *busca;
@property (nonatomic, retain, readonly) NSArray *listaTipoAlquimia;
@property (nonatomic, retain) NSString *estilo;
@property (nonatomic, retain) NSManagedObjectContext *context;

@property (nonatomic, assign) int fonte;


@end
