//
//  Alquimia.h
//  RPG Guide
//
//  Created by Mateus Andrade on 22/07/14.
//  Copyright (c) 2014 Mateus Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Raridade, TipoAlquimia;

@interface Alquimia : NSManagedObject

@property (nonatomic, retain) NSNumber * custo;
@property (nonatomic, retain) NSDate * dataCriacao;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSString * duracao;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * preparo;
@property (nonatomic, retain) Raridade *raridade;
@property (nonatomic, retain) TipoAlquimia *tipo;

@end
