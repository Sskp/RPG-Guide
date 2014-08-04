//
//  ListaItemComumViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 05/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListaItemComumViewController.h"

#import "ItemComum.h"
#import "TipoItem.h"
#import "DetalheItemViewController.h"
#import "AdicionarItemViewController.h"
#import "util.h"

@implementation ListaItemComumViewController

@synthesize managedObjectContext, fetchedResultsController;
@synthesize mySearchBar;

@synthesize estilo;
@synthesize prefixo;
@synthesize sufixo;

@synthesize itemSelecionado;

#pragma mark -
#pragma mark UIViewController overrides

- (void)viewDidUnload{
    estilo = nil;
    sufixo = nil;
    prefixo = nil;
}

- (void)viewDidLoad {
    
    self.title = @"Lista de Itens";
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.title = @"Editar";
    
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
    self.mySearchBar.delegate = self;
    
    //self.estilo = [Util VerificaEstilo];
    
    NSDictionary *config = [Util RetornaConfig];
    
    self.sufixo = [config valueForKey:@"CustoSu"];
    self.prefixo = [config valueForKey:@"CustoPre"];

//    NSArray *buttonTitles = [[NSArray alloc] initWithObjects:@"Nome",@"Categoria",@"Raridade",@"Custo", nil];
//    self.mySearchBar.showsScopeBar = true;
//    self.mySearchBar.scopeButtonTitles = buttonTitles;
//    
//    self.tableView.tableHeaderView = self.mySearchBar;
    
}

- (void)viewDidAppear:(BOOL)animated{
}

-(void)viewWillAppear:(BOOL)animated{
    
    //self.estilo = [Util VerificaEstilo];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
	
    [mySearchBar resignFirstResponder]; 
    
    if ([self.navigationItem.rightBarButtonItem.title isEqualToString:@"Done"]) {
        UIBarButtonItem *addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add:)];
        self.navigationItem.leftBarButtonItem = addButtonItem;
        
    } 
    else{
        self.navigationItem.leftBarButtonItem = nil;
        
        
    }
}

#pragma mark -
#pragma mark Recipe support

- (void)add:(id)sender {
    
    [mySearchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"AdicionarItem" sender:self];
    
}

- (void)edit:(id)sender indexPath:(NSIndexPath *)indexPath{
    
    [mySearchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"EditarItem" sender:self];

}

- (void) AdicionarItemViewController:(AdicionarItemViewController *)adicionarItem didAddItem:(ItemComum *)itemComum{
    
    [self dismissViewControllerAnimated:YES completion:Nil];

    if (itemComum) {
        
        itemSelecionado = itemComum;
        [self performSegueWithIdentifier:@"DetalharItem" sender:self];
        
    }
    
    [self.tableView reloadData];
    
}

#pragma mark -
#pragma mark Table view methods

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.allowsSelectionDuringEditing = YES;
    return YES;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    NSString *sectionName = Nil;
    
    if (fetchedResultsController.sections.count > 0) {
        
        if (self.mySearchBar.selectedScopeButtonIndex != 0){
            
            NSString *custoPre = @"";
            NSString *custoSu = @"";
            
            if (self.mySearchBar.selectedScopeButtonIndex == 3) {
                custoPre = prefixo;
                custoSu = sufixo;
            }
            
            id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
            
            if ([sectionInfo numberOfObjects] == 1) {
                sectionName = [NSString stringWithFormat:@"%@%@ %@ (1 item)",custoPre,[sectionInfo name],custoSu];
            }
            else{
                sectionName = [NSString stringWithFormat:@"%@%@ %@ (%lu itens)",custoPre,[sectionInfo name], custoSu, (unsigned long)[sectionInfo numberOfObjects]];
            }
        }
        
    }
    
    return sectionName;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    NSInteger count = [[fetchedResultsController sections] count];
    
	if (count == 0) {
		count = 1;
	}
	
    return count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger numberOfRows = 0;
	
    if ([[fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    ItemComum *itemComum = (ItemComum *)[fetchedResultsController objectAtIndexPath:indexPath];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[Util ImagemCelula:estilo]];
    
    cell.backgroundView = imageV;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        
    cell.textLabel.text = itemComum.nome;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@ %@",self.prefixo, itemComum.custo, self.sufixo];
    
    cell.imageView.image = [Util ImagemTipoItem:itemComum.tipoItem.nome Estilo:estilo];

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mySearchBar resignFirstResponder]; 
    
    if (self.tableView.isEditing){
        [self edit:self indexPath:indexPath];
    }
    else{
        
        itemSelecionado = (ItemComum *)[fetchedResultsController objectAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"DetalharItem" sender:self];
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
		[context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
		
		NSError *error;
		if (![context save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
	}   
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
		[context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
        [context insertObject:[fetchedResultsController objectAtIndexPath:indexPath]];
        
		NSError *error;
		if (![context save:&error]) {
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
		}
        
	}   
}


#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ItemComum" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        
        
        // Codigo original sem seção
        //NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:Nil];
        
        // Codigo original com seção
        NSString *ordenacao = Nil;
        NSString *nomeSection = Nil;
        
        switch (self.mySearchBar.selectedScopeButtonIndex) {
            case 0:
                ordenacao = @"nome";
                break;
            case 1:
                ordenacao = @"tipoItem.nome";
                nomeSection = @"tipoItem.nome";
                break;
            case 2:
                ordenacao  = @"raridade.nome";
                nomeSection = @"raridade.nome";
                break;  
            case 3:
                ordenacao  = @"custo";
                nomeSection = @"custo";
                break; 
            default:
                break;
        }
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:ordenacao ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];        
        
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:nomeSection cacheName:Nil];
        
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
    
    }
	
	return fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
	[self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
	UITableView *tableView = self.tableView;
	
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
			break;
			
        case NSFetchedResultsChangeUpdate:
			
            break;
            
		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
	}
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	switch(type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
			
		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
	[self.tableView endUpdates];
}

#pragma mark - 
#pragma mark Search Bar Delegate Methods 


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchTerm = [searchBar text]; 
    [self handleSearchForTerm:searchTerm];
    [self.mySearchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchTerm {
    if ([searchTerm length] == 0) { 
        [self resetSearch]; 
        //[table reloadData]; 
        return;
    } 
    [self handleSearchForTerm:searchTerm];
}

-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    
    fetchedResultsController = nil;
    
    NSError *error = nil;
    BOOL success = [self.fetchedResultsController performFetch:&error];
    NSAssert2(success, @"Unhandled error performing fetch at SongsViewController.m, line %d: %@", __LINE__, [error localizedDescription]);    
    
    [self.tableView reloadData];
}


#pragma mark - 
#pragma mark Custom Methods

- (void)resetSearch {    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"1=1"];
    
    [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![[self fetchedResultsController]performFetch:&error]) {
        NSLog(@"Unresolved error %@,%@",error, [error userInfo]);
        exit(-1);
    }
    
    [self.tableView reloadData];
}

- (void)handleSearchForTerm:(NSString *)searchTerm { 
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"nome contains[cd] %@",searchTerm];
    
    [self.fetchedResultsController.fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    if (![[self fetchedResultsController]performFetch:&error]) {
        NSLog(@"Unresolved error %@,%@",error, [error userInfo]);
        exit(-1);
    }
    
    [self.tableView reloadData];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    // ação do botão cancelar
    
    //    isSearching = NO;
    mySearchBar.text = @"";
    [self resetSearch];
    [self.tableView reloadData];
    [mySearchBar resignFirstResponder];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DetalharItem"]) {
        
        DetalheItemViewController *detailViewController = segue.destinationViewController;
        detailViewController.itemComum = itemSelecionado;
        detailViewController.estilo = self.estilo;
        detailViewController.custoSu = self.sufixo;
        detailViewController.custoPre = self.prefixo;
        
    }
    if ([[segue identifier] isEqualToString:@"AdicionarItem"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        AdicionarItemViewController *addController = (AdicionarItemViewController *)navigationController.topViewController;
        
        addController.delegate = self;
        addController.estilo = self.estilo;
        
        ItemComum *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"ItemComum" inManagedObjectContext:self.managedObjectContext];
        
        addController.itemComum = newItem;
        
    }
    if ([[segue identifier] isEqualToString:@"EditarItem"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        AdicionarItemViewController *addController = (AdicionarItemViewController *)navigationController.topViewController;
        
        addController.delegate = self;
        addController.estilo = self.estilo;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ItemComum *newItem = (ItemComum *)[fetchedResultsController objectAtIndexPath:indexPath];
        
        addController.itemComum = newItem;
        
    }
}


@end
