//
//  RaridadeSelectionViewController.m
//  DM Compendium
//
//  Created by Mateus Andrade on 20/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RaridadeSelectionViewController.h"
#import "Alquimia.h"
#import "ItemComum.h"
#import "ItemMagico.h"
#import "Raridade.h"
#import "Busca.h"
#import "util.h"


@interface RaridadeSelectionViewController()
@property (nonatomic, retain) NSArray *listaRaridade;
@end

@implementation RaridadeSelectionViewController

@synthesize context;
@synthesize alquimia;
@synthesize itemComum;
@synthesize itemMagico;
@synthesize listaRaridade;
@synthesize busca;

@synthesize fonte;
@synthesize estilo;

#define FONTE_ALQUIMIA 1
#define FONTE_ITEMCOMUM 2
#define FONTE_ITEMMAGICO 3
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
    [super viewDidLoad];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[Util ImagemFundo:estilo]];
    self.tableView.backgroundView = imageV;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Raridade" inManagedObjectContext:context]];
	
	NSError *error = nil;
	NSArray *raridades = [context executeFetchRequest:fetchRequest error:&error];
	self.listaRaridade = raridades;
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
    return [listaRaridade count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	Raridade *rari = [listaRaridade objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [rari valueForKey:@"nome"];
    cell.imageView.image = [Util ImagemRaridade:[rari valueForKey:@"nome"] Estilo:estilo];
    if (rari == alquimia.raridade || rari == itemComum.raridade || rari == itemMagico.raridade || rari == busca.raridade) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[Util ImagemCelula:estilo]];
    cell.backgroundView = imageV;    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Raridade *raridade = Nil;
    
    switch (fonte) {
        case FONTE_ALQUIMIA:
            raridade = alquimia.raridade;
            break;
            
        case FONTE_ITEMCOMUM:
            raridade = itemComum.raridade;
            break;
            
        case FONTE_ITEMMAGICO:
            raridade = itemMagico.raridade;
            break;
            
        case FONTE_BUSCA:
            raridade = busca.raridade;
            break;
            
        default:
            break;
    }
    
    	
    if (raridade != nil) {
		NSInteger index = [listaRaridade indexOfObject:raridade];
		NSIndexPath *selectionIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:selectionIndexPath];
        checkedCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Set the checkmark accessory for the selected row.
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];    
    
    // Update the type of the recipe instance

    
    switch (fonte) {
        case FONTE_ALQUIMIA:
            alquimia.raridade = [listaRaridade objectAtIndex:indexPath.row];
            break;
            
        case FONTE_ITEMCOMUM:
            itemComum.raridade = [listaRaridade objectAtIndex:indexPath.row];
            break;
            
        case FONTE_ITEMMAGICO:
            itemMagico.raridade = [listaRaridade objectAtIndex:indexPath.row];
            break;
            
        case FONTE_BUSCA:
            busca.raridade = [listaRaridade objectAtIndex:indexPath.row];

            break;
            
        default:
            break;
    }
        
    // Deselect the row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end