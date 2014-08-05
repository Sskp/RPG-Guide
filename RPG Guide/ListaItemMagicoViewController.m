//
//  ListaItemMagicoViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 16/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ListaItemMagicoViewController.h"

#import "ItemMagico.h"
#import "ItemComum.h"
#import "TipoItem.h"
#import "Poder.h"
#import "Categoria.h"
#import "DetalharItemMagicoViewController.h"
#import "AdicionarItemMagicoViewController.h"
#import "SelecionaItemViewController.h"
#import "VisualizarItemMagicoViewController.h"
#import "Util.h"

@implementation ListaItemMagicoViewController

@synthesize managedObjectContext, fetchedResultsController;
@synthesize mySearchBar;
@synthesize estilo;
@synthesize prefixo;
@synthesize sufixo;
@synthesize itemMagicoSelecionado;

#pragma mark -
#pragma mark UIViewController overrides

- (void)viewDidUnload{
    estilo = nil;
    sufixo = nil;
    prefixo = nil;
}


- (void)viewDidLoad {
    
    self.title = @"Itens Mágicos";
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.title = @"Editar";
    
    self.tableView.rowHeight = 44.0;
    
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
//    NSArray *buttonTitles = [[NSArray alloc] initWithObjects:@"Nome",@"Categoria",@"Raridade",@"Custo",@"Nivel", nil];


    //self.estilo = [Util VerificaEstilo];
    
    NSDictionary *config = [Util RetornaConfig];
    
    self.sufixo = [config valueForKey:@"CustoSu"];
    self.prefixo = [config valueForKey:@"CustoPre"];
    
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


-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark Recipe support

- (void)add:(id)sender {
    
    [mySearchBar resignFirstResponder];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Escolha" message:@"Definição para item mágico:" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Novo item",@"Usar item existente",@"Criar Automatico e editar",@"Criar Automatico e visualizar",nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    [mySearchBar resignFirstResponder];
    
    if (buttonIndex !=0){
        
        if (buttonIndex == 1){
            
            [self performSegueWithIdentifier:@"AdicionarItemMagico" sender:self];
            
//            AdicionarItemMagicoViewController *addController = [[AdicionarItemMagicoViewController alloc] initWithNibName:@"AdicionarItemMagicoViewController" bundle:nil];
//            addController.delegate = self;
//            addController.managedObjectContext = self.managedObjectContext;
//            addController.fetchedResultsController = self.fetchedResultsController;
//            addController.estilo = self.estilo;
//        
//            ItemMagico *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"ItemMagico" inManagedObjectContext:self.managedObjectContext];
//            addController.itemMagico = newItem;
//            
//            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
//            [self presentModalViewController:navigationController animated:YES];
            


        }
        else if (buttonIndex == 2){
            
            [self performSegueWithIdentifier:@"SelecionarItemMagico" sender:self];
            
//            SelecionaItemViewController *listaItem =[SelecionaItemViewController alloc];
//            listaItem.delegate = self;
//            listaItem.estilo = self.estilo;
//            listaItem.managedObjectContext = self.managedObjectContext;
//            
//            [self.navigationController pushViewController:listaItem animated:YES];

        }
        else if (buttonIndex == 3){
            
            [self performSegueWithIdentifier:@"CriarItemMagico" sender:self];
            
//            ItemMagico *im = [self gerarItemMagico];
//            if (im) {
//                AdicionarItemMagicoViewController *addController = [[AdicionarItemMagicoViewController alloc] initWithNibName:@"AdicionarItemMagicoViewController" bundle:nil];
//                addController.delegate = self;
//                addController.managedObjectContext = self.managedObjectContext;
//                addController.fetchedResultsController = self.fetchedResultsController;
//                addController.estilo = self.estilo;
//            
//                ItemMagico *newItem = [self gerarItemMagico];
//                addController.itemMagico = newItem;
//            
//                UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
//                [self presentModalViewController:navigationController animated:YES];
//
//            }
            
        }
        else if (buttonIndex == 4){
            
//            ItemMagico *im = [self gerarItemMagico];
//            if (im) {
//                [self showItem:im animated:YES novo:YES];
//            }
            
        }
    }
}


- (void)edit:(id)sender indexPath:(NSIndexPath *)indexPath{
    
    [mySearchBar resignFirstResponder];
    [self performSegueWithIdentifier:@"EditarItemMagico" sender:self];
    
//    AdicionarItemMagicoViewController *addController = [[AdicionarItemMagicoViewController alloc] initWithNibName:@"AdicionarItemMagicoViewController" bundle:nil];
//    addController.delegate = self;
//    addController.managedObjectContext = self.managedObjectContext;
//    addController.fetchedResultsController = self.fetchedResultsController;
//    addController.estilo = self.estilo;
//    
//    ItemMagico *itemM = (ItemMagico *)[fetchedResultsController objectAtIndexPath:indexPath];
//    
//	addController.itemMagico = itemM;
//    addController.editavel = TRUE;
//    
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
//    [self presentModalViewController:navigationController animated:YES];

}

- (void) AdicionarItemMagicoViewController:(AdicionarItemMagicoViewController *)adicionarItem didAddItem:(ItemMagico *)itemMagico{
    
    if (itemMagico) {
        
        itemMagicoSelecionado = itemMagico;
        [self performSegueWithIdentifier:@"DetalharItemMagico" sender:self];
    
    }
    
//    [self dismissModalViewControllerAnimated:YES];
    [self.tableView reloadData];
    
}

- (void) SelecionarItemViewController:(SelecionaItemViewController *)selecionarItem didAddItem:(ItemMagico *)itemMagico{
    
    if (itemMagico) {
        
        itemMagicoSelecionado = itemMagico;
        [self performSegueWithIdentifier:@"DetalharItemMagico" sender:self];
    }
    
//    [self dismissModalViewControllerAnimated:YES];
    [self.tableView reloadData];
    
}

//- (void) showItem:(ItemMagico *)itemMagico animated:(BOOL)animated novo:(BOOL)novo{
//    
//    DetalharItemMagicoViewController *detailViewController = [DetalharItemMagicoViewController alloc];
//    detailViewController.itemMagico = itemMagico;
//    detailViewController.estilo = self.estilo;
//    detailViewController.custoSu = self.sufixo;
//    detailViewController.custoPre = self.prefixo;
//    detailViewController.habilitaSalvar = novo;
//    
//    [self.navigationController pushViewController:detailViewController animated:animated];
//    [detailViewController release];
//}


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
            NSString *nomeSecao = @"";
            
            if (self.mySearchBar.selectedScopeButtonIndex == 3) {
                custoPre = prefixo;
                custoSu = sufixo;
            }
            
            id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
            
            if (self.mySearchBar.selectedScopeButtonIndex == 4) {
                nomeSecao = [NSString stringWithFormat:@"Nivel %@",[sectionInfo name]];
            }
            else{
                nomeSecao = [sectionInfo name];
            }
            
            if ([sectionInfo numberOfObjects] == 1) {
                sectionName = [NSString stringWithFormat:@"%@%@ %@ (1 item)",custoPre,nomeSecao,custoSu];
            }
            else{
                sectionName = [NSString stringWithFormat:@"%@%@ %@ (%lu itens)",custoPre,nomeSecao, custoSu, (unsigned long)[sectionInfo numberOfObjects]];
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
    
    ItemMagico *itemMagico = (ItemMagico *)[fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = itemMagico.nome;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@%@ %@",self.prefixo, itemMagico.custo, self.sufixo];

    cell.imageView.image = [Util ImagemTipoItem:itemMagico.tipoItem.nome Estilo:estilo];

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

        itemMagicoSelecionado = (ItemMagico *)[fetchedResultsController objectAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"DetalharItemMagico" sender:self];

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
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"ItemMagico" inManagedObjectContext:managedObjectContext];
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
            case 4:
                ordenacao  = @"nivel";
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


/**
 Delegate methods of NSFetchedResultsController to respond to additions, removals and so on.
 */

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
    
    // ação do botão cancelar
    
    //    isSearching = NO;
    mySearchBar.text = @"";
    [self resetSearch];
    [self.tableView reloadData];
    [mySearchBar resignFirstResponder];
}

- (ItemMagico *)gerarItemMagico{
        
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Categoria" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"nome" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];  
    
    NSError *error = nil;
	NSArray *listaCategoria = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    entity = [NSEntityDescription entityForName:@"ItemComum" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSMutableArray *query = [[NSMutableArray alloc]init];
    NSPredicate *predicate = Nil;
    
    predicate = [NSPredicate predicateWithFormat:@"categoria == %@",[listaCategoria objectAtIndex:0]]; 
    [query addObject:predicate];
    
    predicate = [NSPredicate predicateWithFormat:@"categoria == %@",[listaCategoria objectAtIndex:1]];
        [query addObject:predicate];

    predicate = [NSPredicate predicateWithFormat:@"categoria == %@",[listaCategoria objectAtIndex:2]];
    [query addObject:predicate];
    
    predicate = [NSPredicate predicateWithFormat:@"categoria == %@",[listaCategoria objectAtIndex:5]];
    [query addObject:predicate];
    
    predicate = [NSCompoundPredicate orPredicateWithSubpredicates:query];
    
    [fetchRequest setPredicate:predicate];
        
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:Nil cacheName:Nil];
    
    aFetchedResultsController.delegate = self;

    error = nil;
	if (![aFetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[aFetchedResultsController sections] objectAtIndex:0];
    NSInteger numberOfRows = [sectionInfo numberOfObjects];
    
    int x = 0;
    
    if (numberOfRows) {
        x = arc4random()%numberOfRows;
    
        ItemComum *itc = (ItemComum *)[aFetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:x inSection:0]];
        
        ItemMagico *itm = [NSEntityDescription insertNewObjectForEntityForName:@"ItemMagico" inManagedObjectContext:self.managedObjectContext];

        itm.nome = [NSString stringWithFormat:@"++ %@ ++", itc.nome];
        itm.descricao = itc.descricao;
        itm.custo = itc.custo;
        itm.peso = itc.peso;
        itm.pv = itc.pv;
        itm.dano = itc.dano;
        itm.protecao = itc.protecao;
        itm.raridade = itc.raridade;
        itm.tipoItem = itc.tipoItem;
        itm.categoria = itc.categoria;
    
        entity = [NSEntityDescription entityForName:@"Poder" inManagedObjectContext:managedObjectContext];
        [fetchRequest setEntity:entity];
    
        [fetchRequest setSortDescriptors:sortDescriptors];        
    
        NSPredicate *pred;
    
        if ([itm.categoria.nome isEqualToString:@"Armas"]) {
            pred = [NSPredicate predicateWithFormat:@"arma = 1"];
        }
        else if ([itm.categoria.nome isEqualToString:@"Proteção"]){
            pred = [NSPredicate predicateWithFormat:@"armadura == 1"];
        }
        else{
            pred = [NSPredicate predicateWithFormat:@"geral == 1"];
        }
    
        [fetchRequest setPredicate:pred];
    
    
        aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:Nil cacheName:Nil];
    
        NSError *error2 = nil;
        if (![aFetchedResultsController performFetch:&error2]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    
        aFetchedResultsController.delegate = self;

        sectionInfo = [[aFetchedResultsController sections] objectAtIndex:0];
        numberOfRows = [sectionInfo numberOfObjects];
    
        if (numberOfRows){
            int percentualNivel = arc4random()%100+1;
            int totalNivel;
    
            if (percentualNivel<=30) {
                totalNivel = 1;
            }
            else if ((percentualNivel>30) && (percentualNivel<=45)){
                totalNivel = 2;
            }
            else if ((percentualNivel>45) && (percentualNivel<=60)){
                totalNivel = 3;
            }
            else if ((percentualNivel>60) && (percentualNivel<=70)){
                totalNivel = 4;
            }
            else if ((percentualNivel>70) && (percentualNivel<=80)){
                totalNivel = 5;
            }
            else if ((percentualNivel>80) && (percentualNivel<=85)){
                totalNivel = 6;
            }
            else if ((percentualNivel>85) && (percentualNivel<=90)){
                totalNivel = 7;
            }
            else if ((percentualNivel>90) && (percentualNivel<=95)){
                totalNivel = 8;
            }
            else if ((percentualNivel>95) && (percentualNivel<=99)){
                totalNivel = 9;
            }
            else if (percentualNivel==100){
                totalNivel = 10;
            }
    
            NSInteger custoNivel = 0;
    
            NSMutableArray *listaPoderes = [[NSMutableArray alloc] init];
            Poder *poder;
    
            int numeroTentativas= 0;
    
            do {
                x = arc4random()%numberOfRows;
        
                poder = [aFetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:x inSection:0]];
                if (![listaPoderes containsObject:poder]) {
                    if (!(custoNivel + [poder.nivel integerValue] > totalNivel)){
                    [listaPoderes addObject:poder];
                    custoNivel = custoNivel + [poder.nivel integerValue];
                    }
                    numeroTentativas = numeroTentativas +1;
                } 
            } while ((custoNivel<totalNivel) && (numeroTentativas<20));
    
            poder = [listaPoderes objectAtIndex:0];
    
            NSString *texto = [NSString stringWithFormat:@"%@: %@",poder.nome,poder.descricao];
    
            int totalArray = (int)[listaPoderes count];
    
            for (int i=1; i<totalArray; i++) {
                poder = [listaPoderes objectAtIndex:i];
        
                texto = [texto stringByAppendingFormat:@"\n"];
                texto = [NSString stringWithFormat:@"%@%@: %@",texto,poder.nome,poder.descricao];
            }
        
            itm.poder = texto;
            itm.nivel = [NSNumber numberWithInt:(int)custoNivel];
        }
        else{
            itm.poder = @"";
            itm.nivel = 0;
        }
        return itm;
    }
    else{      
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Aviso" message:@"Não foi encontrado nenhum item comum para gerar o item mágico" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    return nil;
}

#pragma mark Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DetalharItemMagico"]) {
        
        DetalharItemMagicoViewController *detailViewController = segue.destinationViewController;
        detailViewController.itemMagico = itemMagicoSelecionado;
        detailViewController.estilo = self.estilo;
        detailViewController.custoSu = self.sufixo;
        detailViewController.custoPre = self.prefixo;
        
    }
    if ([[segue identifier] isEqualToString:@"AdicionarItemMagico"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        AdicionarItemMagicoViewController *addController = (AdicionarItemMagicoViewController *)navigationController.topViewController;
        
        addController.delegate = self;
        addController.estilo = self.estilo;
        
        ItemMagico *newItem = [NSEntityDescription insertNewObjectForEntityForName:@"ItemMagico" inManagedObjectContext:self.managedObjectContext];
        
        addController.itemMagico = newItem;
        
    }
    if ([[segue identifier] isEqualToString:@"EditarItemMagico"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        AdicionarItemMagicoViewController *addController = (AdicionarItemMagicoViewController *)navigationController.topViewController;
        
        addController.delegate = self;
        addController.estilo = self.estilo;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ItemComum *newItem = (ItemComum *)[fetchedResultsController objectAtIndexPath:indexPath];
        
        addController.itemComum = newItem;
        
    }
}


@end
