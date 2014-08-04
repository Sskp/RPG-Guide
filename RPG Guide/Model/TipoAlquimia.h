//
//  TipoAlquimia.h
//  RPG Guide
//
//  Created by Mateus Andrade on 22/07/14.
//  Copyright (c) 2014 Mateus Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Alquimia, Busca;

@interface TipoAlquimia : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSSet *alquimia;
@property (nonatomic, retain) NSSet *busca;
@end

@interface TipoAlquimia (CoreDataGeneratedAccessors)

- (void)addAlquimiaObject:(Alquimia *)value;
- (void)removeAlquimiaObject:(Alquimia *)value;
- (void)addAlquimia:(NSSet *)values;
- (void)removeAlquimia:(NSSet *)values;

- (void)addBuscaObject:(Busca *)value;
- (void)removeBuscaObject:(Busca *)value;
- (void)addBusca:(NSSet *)values;
- (void)removeBusca:(NSSet *)values;

@end
