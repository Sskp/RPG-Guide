//
//  MainViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 22/07/14.
//  Copyright (c) 2014 Mateus Andrade. All rights reserved.
//

#import "MainViewController.h"

#import "ListaAlquimiaViewController.h"
#import "ListaItemComumViewController.h"
#import "ListaItemMagicoViewController.h"
#import "ListaPoderViewController.h"
#import "Util.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated{
    NSDictionary *config = [Util RetornaConfig];
    
    self.sufixo = [config valueForKey:@"CustoSu"];
    self.prefixo = [config valueForKey:@"CustoPre"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ApresentaAlquimia"]) {
        ListaAlquimiaViewController *alquimiaController = segue.destinationViewController;
        alquimiaController.managedObjectContext = self.managedObjectContext;
    }
    if ([[segue identifier] isEqualToString:@"ApresentaItem"]) {
        ListaItemComumViewController *itemController = segue.destinationViewController;
        itemController.managedObjectContext = self.managedObjectContext;
        itemController.sufixo = self.sufixo;
        itemController.prefixo = self.prefixo;
    }
    if ([[segue identifier] isEqualToString:@"ApresentaItemMagico"]) {
        ListaItemMagicoViewController *itemMagicoController = segue.destinationViewController;
        itemMagicoController.managedObjectContext = self.managedObjectContext;
        itemMagicoController.sufixo = self.sufixo;
        itemMagicoController.prefixo = self.prefixo;
    }
    if ([[segue identifier] isEqualToString:@"ApresentaPoder"]) {
        ListaPoderViewController *poderController = segue.destinationViewController;
        poderController.managedObjectContext = self.managedObjectContext;
    }

}


@end
