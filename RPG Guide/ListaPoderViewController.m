//
//  ListaPoderViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListaPoderViewController.h"
#import "Poder.h"
#import "DetalharPoderViewController.h"
#import "AdicionarPoderViewController.h"
#import "util.h"

@implementation ListaPoderViewController

@synthesize managedObjectContext, fetchedResultsController;
@synthesize mySearchBar;
@synthesize estilo;
@synthesize poderSelecionado;
@synthesize keyboardBar;


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title = @"Lista de Poderes";
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.title = @"Editar";

    
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
//  NSArray *buttonTitles = [[NSArray alloc] initWithObjects:@"Nome",@"Nivel", nil];

    
//  self.estilo = [Util VerificaEstilo];
    
    if (keyboardBar == nil) {
        keyboardBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil];
        
        UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard:)];
        
        [keyboardBar setItems:[[NSArray alloc] initWithObjects:extraSpace, okButton, nil]];
        
        [mySearchBar setInputAccessoryView:keyboardBar];
        
    }

    
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.estilo = nil;
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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Poder support

- (void)add:(id)sender {
    
    [mySearchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"AdicionarPoder" sender:self];
}

- (void)edit:(id)sender indexPath:(NSIndexPath *)indexPath{
    
    [mySearchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"EditarPoder" sender:self];
}

- (void) AdicionarPoderViewController:(AdicionarPoderViewController *)adicionarPoder didAddPoder:(Poder *)poder{
    
    [self dismissViewControllerAnimated:YES completion:Nil];
    
    if (poder) {
        
        poderSelecionado = poder;
        [self performSegueWithIdentifier:@"DetalharPoder" sender:self];
        
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
            
            id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
            
            if ([sectionInfo numberOfObjects] == 1) {
                sectionName = [NSString stringWithFormat:@"Nível %@ (1 item)",[sectionInfo name]];
            }
            else{
                sectionName = [NSString stringWithFormat:@"Nível %@ (%lu itens)",[sectionInfo name], (unsigned long)[sectionInfo numberOfObjects]];
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
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[Util ImagemCelula:estilo]];
    cell.backgroundView = imageV;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];
    
    Poder *poder = (Poder *)[fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = poder.nome;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (self.mySearchBar.selectedScopeButtonIndex == 0){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Nível %@",poder.nivel];
    }
    else{
        cell.detailTextLabel.text = nil;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mySearchBar resignFirstResponder]; 
    
    if (self.tableView.isEditing){
        [self edit:self indexPath:indexPath];
    }
    else{
        poderSelecionado = (Poder *)[fetchedResultsController objectAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"DetalharPoder" sender:self];
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
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Poder" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
        

        NSString *ordenacao = Nil;
        NSString *nomeSection = Nil;
        
        switch (self.mySearchBar.selectedScopeButtonIndex) {
            case 0:
                ordenacao = @"nome";
                break;
            case 1:
                ordenacao = @"nivel";
                nomeSection = @"nivel";
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
    //reseta a busca, coloca os dados na forma original
    
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
    // lida com a busca dos dados
    
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
    
    mySearchBar.text = @"";
    [self resetSearch];
    [self.tableView reloadData];
    [mySearchBar resignFirstResponder];
}

#pragma mark Keyboard

-(void)resignKeyboard:(id)sender{
    [self.view endEditing:YES];
}

#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DetalharPoder"]) {
        
        DetalharPoderViewController *detailViewController = segue.destinationViewController;
        detailViewController.poder = poderSelecionado;
        detailViewController.estilo = self.estilo;
        
    }
    if ([[segue identifier] isEqualToString:@"AdicionarPoder"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        AdicionarPoderViewController *addController = (AdicionarPoderViewController *)navigationController.topViewController;
        
        addController.delegate = self;
        addController.estilo = self.estilo;
        Poder *newPoder = [NSEntityDescription insertNewObjectForEntityForName:@"Poder" inManagedObjectContext:self.managedObjectContext];
        addController.poder = newPoder;
        
    }
    if ([[segue identifier] isEqualToString:@"EditarPoder"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        AdicionarPoderViewController *addController = (AdicionarPoderViewController *)navigationController.topViewController;
        
        addController.delegate = self;
        addController.estilo = self.estilo;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Poder *newPoder = (Poder *)[fetchedResultsController objectAtIndexPath:indexPath];
        
        addController.poder = newPoder;
        
    }
}

@end
