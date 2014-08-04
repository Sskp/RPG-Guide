//
//  Poder.h
//  RPG Guide
//
//  Created by Mateus Andrade on 22/07/14.
//  Copyright (c) 2014 Mateus Andrade. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Poder : NSManagedObject

@property (nonatomic, retain) NSNumber * arma;
@property (nonatomic, retain) NSNumber * armadura;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSNumber * geral;
@property (nonatomic, retain) NSNumber * nivel;
@property (nonatomic, retain) NSString * nome;

@end
