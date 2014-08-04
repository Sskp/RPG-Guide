//
//  TipoItem.h
//  RPG Guide
//
//  Created by Mateus Andrade on 22/07/14.
//  Copyright (c) 2014 Mateus Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Busca, Categoria, ItemComum, ItemMagico;

@interface TipoItem : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSSet *busca;
@property (nonatomic, retain) Categoria *categoria;
@property (nonatomic, retain) NSSet *itemComum;
@property (nonatomic, retain) NSSet *itemMagico;
@end

@interface TipoItem (CoreDataGeneratedAccessors)

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

@end
