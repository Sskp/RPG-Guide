//
//  Busca.h
//  RPG Guide
//
//  Created by Mateus Andrade on 22/07/14.
//  Copyright (c) 2014 Mateus Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categoria, Raridade, TipoAlquimia, TipoItem;

@interface Busca : NSManagedObject

@property (nonatomic, retain) Categoria *categoria;
@property (nonatomic, retain) Raridade *raridade;
@property (nonatomic, retain) TipoAlquimia *tipoAlquimia;
@property (nonatomic, retain) TipoItem *tipoItem;

@end
