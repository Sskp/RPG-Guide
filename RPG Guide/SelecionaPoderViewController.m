//
//  SelecionaPoderViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 26/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelecionaPoderViewController.h"
#import "Poder.h"
#import "DetalharPoderViewController.h"
#import "util.h"

@implementation SelecionaPoderViewController

@synthesize poderesSelecionados;
@synthesize nivel;
@synthesize estilo;
@synthesize managedObjectContext, fetchedResultsController;
@synthesize mySearchBar;
@synthesize categoria;
@synthesize delegate;

#pragma mark -
#pragma mark UIViewController overrides

- (void)viewDidUnload{
    estilo = nil;
}

- (void)viewDidLoad {
    
    fetchedResultsController = nil;
    
    poderesSelecionados = [[NSMutableArray alloc] init];
    
    self.title = @"Seleção de Poderes";
    
    self.tableView.rowHeight = 44.0;
    
    if ([categoria isEqualToString:@"Armas"]) {
        pred = [NSPredicate predicateWithFormat:@"arma = 1"];
    }
    else if ([categoria isEqualToString:@"Proteção"]){
        pred = [NSPredicate predicateWithFormat:@"armadura == 1"];
    }
    else{
        pred = [NSPredicate predicateWithFormat:@"geral == 1"];
        
    }
    [self.fetchedResultsController.fetchRequest setPredicate:pred];
    
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
    self.mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 88.0)];
    
	self.mySearchBar.delegate = self;
	self.mySearchBar.showsCancelButton = YES;
	self.mySearchBar.autocorrectionType = UITextAutocorrectionTypeNo;	
    
    NSArray *buttonTitles = [[NSArray alloc] initWithObjects:@"Nome",@"Nivel", nil];
    
    self.mySearchBar.showsScopeBar = true;
    self.mySearchBar.scopeButtonTitles = buttonTitles;
    
    self.tableView.tableHeaderView = self.mySearchBar;

}


-(void)viewWillDisappear:(BOOL)animated{

    if (flag) {
        NSInteger totalArray = [poderesSelecionados count];        
        if (totalArray > 0) {
            
            NSString *texto;
            NSNumber *valorNivel;

            Poder *poder = [poderesSelecionados objectAtIndex:0];
            
            texto = [NSString stringWithFormat:@"%@: %@",poder.nome,poder.descricao];
            
            valorNivel = poder.nivel;
            
            for (int i=1; i<totalArray; i++) {
                poder = [poderesSelecionados objectAtIndex:i];
                
                texto = [texto stringByAppendingFormat:@"\n"];
                texto = [NSString stringWithFormat:@"%@%@: %@",texto,poder.nome,poder.descricao];
                valorNivel = [NSNumber numberWithFloat:([valorNivel floatValue] + [poder.nivel floatValue])];
            }
                        
            [self.delegate IncluirPoder:texto valorNivel:valorNivel];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated{
    flag = (BOOL)TRUE;
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
            
            id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
            
            if ([sectionInfo numberOfObjects] == 1) {
                sectionName = [NSString stringWithFormat:@"%@ (1 item)",[sectionInfo name]];
            }
            else{
                sectionName = [NSString stringWithFormat:@"%@ (%lu itens)",[sectionInfo name],(unsigned long)[sectionInfo numberOfObjects]];
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
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:[Util ImagemCelula:estilo]];
    
    cell.backgroundView = imageV;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.detailTextLabel.backgroundColor = [UIColor clearColor];

    
    Poder *poder = (Poder *)[fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = poder.nome;

    if (self.mySearchBar.selectedScopeButtonIndex == 0){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Nivel %@",poder.nivel];
    }
    
    else{
        cell.detailTextLabel.text = nil;
    }
    
    //cell.imageView.image = [Util ImagemTipoItem:itemComum.nome Estilo:estilo];
    
    if ([poderesSelecionados containsObject:poder]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;

    }
    else{
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{

    flag = (BOOL)FALSE;
    
    DetalharPoderViewController *detailViewController = [DetalharPoderViewController alloc];
    detailViewController.poder = [fetchedResultsController objectAtIndexPath:indexPath];
    detailViewController.estilo = self.estilo;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Poder *poder = [fetchedResultsController objectAtIndexPath:indexPath];
    if ([poderesSelecionados containsObject:poder]) {
        [poderesSelecionados removeObject:poder];
        nivel = nivel - (int)poder.nivel;

    }
    else{
        [poderesSelecionados addObject:poder];
        nivel = nivel + (int)poder.nivel;
    }
    [self.tableView reloadData];
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
    
    if ([categoria isEqualToString:@"Armas"]) {
        pred = [NSPredicate predicateWithFormat:@"arma = 1"];
    }
    else if ([categoria isEqualToString:@"Proteção"]){
        pred = [NSPredicate predicateWithFormat:@"armadura == 1"];
    }
    else{
        pred = [NSPredicate predicateWithFormat:@"geral == 1"];
        
    }
    [self.fetchedResultsController.fetchRequest setPredicate:pred];
    
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
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithObjects:pred,predicate, nil];
    
    predicate = [NSCompoundPredicate andPredicateWithSubpredicates:array];
    
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
        
    NSArray *array = [[NSArray alloc]initWithObjects:pred,predicate, nil];
    
    predicate = [NSCompoundPredicate andPredicateWithSubpredicates:array];
    
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

@end
