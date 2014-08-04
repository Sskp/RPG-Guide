//
//  Categoria.h
//  RPG Guide
//
//  Created by Mateus Andrade on 22/07/14.
//  Copyright (c) 2014 Mateus Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Busca, ItemComum, ItemMagico, TipoItem;

@interface Categoria : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSSet *busca;
@property (nonatomic, retain) NSSet *itemComum;
@property (nonatomic, retain) NSSet *itemMagico;
@property (nonatomic, retain) NSSet *tipoItem;
@end

@interface Categoria (CoreDataGeneratedAccessors)

- (void)addBuscaObject:(Busca *)value;
- (void)removeBuscaObject:(Busca *)value;
- (void)addBusca:(NSSet *)values;
- (void)removeBusca:(NSSet *)values;

- (void)addItemComumObject:(ItemComum *)value;
- (void)removeItemComumObject:(ItemComum *)value;
- (void)addItemComum:(NSSet *)values;
- (void)removeItemComum:(NSSet *)values;

- (void)addItemMagicoObject:(ItemMagico *)value;
- (void)removeItemMagicoObject:(ItemMagico *)value;
- (void)addItemMagico:(NSSet *)values;
- (void)removeItemMagico:(NSSet *)values;

- (void)addTipoItemObject:(TipoItem *)value;
- (void)removeTipoItemObject:(TipoItem *)value;
- (void)addTipoItem:(NSSet *)values;
- (void)removeTipoItem:(NSSet *)values;

@end
