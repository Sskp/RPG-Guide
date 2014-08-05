//
//  SelecionaItemViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 16/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelecionaItemViewController.h"

#import "ItemComum.h"
#import "TipoItem.h"
#import "DetalharItemMagicoViewController.h"
#import "AdicionarItemMagicoViewController.h"
#import "util.h"

@implementation SelecionaItemViewController

@synthesize managedObjectContext, fetchedResultsController;
@synthesize mySearchBar;
@synthesize estilo;
@synthesize prefixo;
@synthesize sufixo;

@synthesize delegate;

#pragma mark -
#pragma mark UIViewController overrides

- (void)viewDidUnload{
    estilo = nil;
    sufixo = nil;
    prefixo = nil;
}

- (void)viewDidLoad {
    
    self.title = @"Seleção de Itens Mágicos";
        
    self.tableView.rowHeight = 44.0;
    
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
//    NSArray *buttonTitles = [[NSArray alloc] initWithObjects:@"Nome",@"Categoria",@"Raridade",@"Custo", nil];
    
//    self.estilo = [Util VerificaEstilo];
    
    NSDictionary *config = [Util RetornaConfig];
    
    self.sufixo = [config valueForKey:@"CustoSu"];
    self.prefixo = [config valueForKey:@"CustoPre"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //self.estilo = [Util VerificaEstilo];
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Table view methods

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.allowsSelectionDuringEditing = NO;
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
    // Dequeue or if necessary create a RecipeTableViewCell, then set its recipe to the recipe for the current row.
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if ([estilo isEqual:@"2"]) {
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        
    }
    else{
        
        cell.backgroundView = nil;
    
    }
    
    ItemComum *itemComum = (ItemComum *)[fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = itemComum.nome;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@ %@",self.prefixo, itemComum.custo, self.sufixo];
    cell.imageView.image = [Util ImagemTipoItem:itemComum.tipoItem.nome Estilo:estilo];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[Util ImagemCelula:estilo]];
    cell.backgroundView = imageV;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [mySearchBar resignFirstResponder]; 
    
    AdicionarItemMagicoViewController *addController = [[AdicionarItemMagicoViewController alloc] initWithNibName:@"AdicionarItemMagicoViewController" bundle:nil];
    addController.delegate = self;
    addController.estilo = self.estilo;
    addController.managedObjectContext = self.managedObjectContext;
    addController.fetchedResultsController = self.fetchedResultsController;
    
    ItemComum *itemComum = (ItemComum *)[fetchedResultsController objectAtIndexPath:indexPath];
    addController.itemComum = itemComum;
    
    ItemMagico *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"ItemMagico" inManagedObjectContext:self.managedObjectContext];
    addController.itemMagico = newItem;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
//    [self presentModalViewController:navigationController animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (fetchedResultsController == nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ItemComum" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];

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
//                [self dismissModalViewControllerAnimated:YES];
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

#pragma mark -
#pragma mark Custom

- (void) AdicionarItemMagicoViewController:(AdicionarItemMagicoViewController *)adicionarItem didAddItem:(ItemMagico *)itemMagico{

    [self.delegate SelecionarItemViewController:self didAddItem:itemMagico];
    
}


@end
