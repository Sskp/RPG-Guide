//
//  MainViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 22/07/14.
//  Copyright (c) 2014 Mateus Andrade. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) NSString *estilo;
@property (nonatomic, retain) NSString *prefixo;
@property (nonatomic, retain) NSString *sufixo;

@end
