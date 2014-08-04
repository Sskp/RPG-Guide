//
//  TipoItemSelectionViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 09/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TipoItemSelectionViewController.h"
#import "ItemComum.h"
#import "ItemMagico.h"
#import "TipoItem.h"
#import "Categoria.h"
#import "Busca.h"
#import "util.h"

@interface TipoItemSelectionViewController()
@property (nonatomic, retain) NSArray *listaTipo;
@end

@implementation TipoItemSelectionViewController

@synthesize itemMagico;
@synthesize itemComum;
@synthesize listaTipo;
@synthesize busca;
@synthesize fonte;
@synthesize context;
@synthesize cat;
@synthesize estilo;


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
    listaTipo = Nil;
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    	
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"TipoItem" inManagedObjectContext:context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.categoria == %@",cat];
    [fetchRequest setPredicate:predicate];
    
	
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nome" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [fetchRequest setSortDescriptors:sortDescriptors];
	
	NSError *error = nil;
	NSArray *tipo = [context executeFetchRequest:fetchRequest error:&error];
	self.listaTipo = tipo;

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
    return [listaTipo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    
	TipoItem *tipo = [listaTipo objectAtIndex:indexPath.row];
    
    if (tipo == itemMagico.tipoItem || tipo == itemComum.tipoItem) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    cell.textLabel.text = [tipo valueForKey:@"nome"];
    cell.imageView.image = [Util ImagemTipoItem:[tipo valueForKey:@"nome"]Estilo:estilo];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[Util ImagemCelula:estilo]];
    cell.backgroundView = imageV;    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	TipoItem *tipo = Nil;
    
    switch (fonte) {
        case 2:
            tipo = itemComum.tipoItem;
            
            break;
        case 3:
            tipo = itemMagico.tipoItem;
            
            break;
        case 4:
            tipo = busca.tipoItem;
            break;
        default:
            break;
    }
    
    if (tipo != nil) {
		NSInteger index = [listaTipo indexOfObject:tipo];
		NSIndexPath *selectionIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:selectionIndexPath];
        checkedCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Set the checkmark accessory for the selected row.
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];    
    
    // Update the type of the recipe instance
    
    switch (fonte) {
        case 2:
            itemComum.tipoItem = [listaTipo objectAtIndex:indexPath.row];
            
            break;
        case 3:
            itemMagico.tipoItem = [listaTipo objectAtIndex:indexPath.row];
            
            break;
        case 4:
            busca.tipoItem = [listaTipo objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    // Deselect the row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
