//
//  CategoriaSelectionViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 06/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoriaSelectionViewController.h"
#import "ItemComum.h"
#import "ItemMagico.h"
#import "Categoria.h"
#import "Busca.h"
#import "util.h"

@interface CategoriaSelectionViewController()
@property (nonatomic, retain) NSArray *listaCategoria;
@end

@implementation CategoriaSelectionViewController

@synthesize itemMagico;
@synthesize itemComum;
@synthesize listaCategoria;
@synthesize busca;
@synthesize fonte;
@synthesize context;
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
    listaCategoria = Nil;
    
    [super viewDidUnload];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[NSEntityDescription entityForName:@"Categoria" inManagedObjectContext:context]];
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nome" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	NSError *error = nil;
	NSArray *categoria = [context executeFetchRequest:fetchRequest error:&error];
	self.listaCategoria = categoria;

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
    return [listaCategoria count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	Categoria *cat = [listaCategoria objectAtIndex:indexPath.row];

    if (cat == itemMagico.categoria || cat == itemComum.categoria) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    cell.textLabel.text = [cat valueForKey:@"nome"];
    cell.imageView.image = [Util ImagemCategoriaItem:[cat valueForKey:@"nome"] Estilo:estilo];
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[Util ImagemCelula:estilo]];
    cell.backgroundView = imageV;    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Categoria *categoria = Nil;
    switch (fonte) {
        case 2:
            categoria =  itemComum.categoria;
            
            break;
        case 3:
            categoria = itemMagico.categoria;
            
            break;
        case 4:
            categoria = busca.categoria;
            break;
        default:
            break;
    }
	
    if (categoria != nil) {
		NSInteger index = [listaCategoria indexOfObject:categoria];
		NSIndexPath *selectionIndexPath = [NSIndexPath indexPathForRow:index inSection:0];
        UITableViewCell *checkedCell = [tableView cellForRowAtIndexPath:selectionIndexPath];
        checkedCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];    
        
    switch (fonte) {
        case 2:
            itemComum.categoria = [listaCategoria objectAtIndex:indexPath.row];

            break;
        case 3:
            itemMagico.categoria = [listaCategoria objectAtIndex:indexPath.row];

            break;
        case 4:
            busca.categoria = [listaCategoria objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }

    // Deselect the row.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
