//
//  TipoAlquimiaSelectionViewController.m
//  DM Compendium
//
//  Created by Mateus Andrade on 19/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TipoAlquimiaSelectionViewController.h"
#import "Alquimia.h"
#import "Busca.h"
#import "TipoAlquimia.h"
#import "util.h"

@interface TipoAlquimiaSelectionViewController()
@property (nonatomic, retain) NSArray *listaTipoAlquimia;
@end

@implementation TipoAlquimiaSelectionViewController

@synthesize alquimia;
@synthesize busca;
@synthesize listaTipoAlquimia;
@synthesize estilo;
@synthesize context;

@synthesize fonte;

#define FONTE_ALQUIMIA 1
#define FONTE_BUSCA 4


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"TipoAlquimia" inManagedObjectContext:context]];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nome" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	NSError *error = nil;
	NSArray *tipos = [context executeFetchRequest:fetchRequest error:&error];
	self.listaTipoAlquimia = tipos;
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[Util ImagemFundo:estilo]];
    
    self.tableView.backgroundView = imageV;
    
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    listaTipoAlquimia = Nil;
    context = Nil;
    [super viewDidUnload];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [listaTipoAlquimia count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	TipoAlquimia *listaAlquimia = [listaTipoAlquimia objectAtIndex:indexPath.row];
    
    if ((listaAlquimia == alquimia.tipo)||(listaAlquimia == busca.tipoAlquimia)) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    cell.textLabel.text = [listaAlquimia valueForKey:@"nome"];
    cell.imageView.image = [Util ImagemTipoAlquimia:[listaAlquimia valueForKey:@"nome"] Estilo:estilo];
    cell.backgroundColor = [UIColor clearColor];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[Util ImagemCelula:estilo]];
    cell.backgroundView = imageV;

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	TipoAlquimia *tipoAtual = Nil;
    
    switch (fonte) {
        case FONTE_ALQUIMIA:
            tipoAtual = alquimia.tipo;
            break;
            
        case FONTE_BUSCA:
            tipoAtual = busca.tipoAlquimia;
            break;
            
        default:
            break;
    }
	
    if (tipoAtual != nil) {
		NSInteger index = [listaTipoAlquimia indexOfObject:tipoAtual];
		NSIndexPath *selectionIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:selectionIndexPath];
        checkedCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Set the checkmark accessory for the selected row.
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];    
    
    
    if (fonte == FONTE_ALQUIMIA){
        alquimia.tipo = [listaTipoAlquimia objectAtIndex:indexPath.row];
    }
    else{
        busca.tipoAlquimia = [listaTipoAlquimia objectAtIndex:indexPath.row];
    }
    
    // Deselect the row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end