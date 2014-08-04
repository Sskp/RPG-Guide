//
//  ItemComum.h
//  RPG Guide
//
//  Created by Mateus Andrade on 22/07/14.
//  Copyright (c) 2014 Mateus Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Categoria, Raridade, TipoItem;

@interface ItemComum : NSManagedObject

@property (nonatomic, retain) NSNumber * custo;
@property (nonatomic, retain) NSString * dano;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * peso;
@property (nonatomic, retain) NSString * protecao;
@property (nonatomic, retain) NSString * pv;
@property (nonatomic, retain) Categoria *categoria;
@property (nonatomic, retain) Raridade *raridade;
@property (nonatomic, retain) TipoItem *tipoItem;

@end
