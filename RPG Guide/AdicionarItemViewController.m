//
//  AdicionarItemViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 04/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AdicionarItemViewController.h"
#import "ItemComum.h"
#import "RaridadeSelectionViewController.h"
#import "TipoItemSelectionViewController.h"
#import "CategoriaSelectionViewController.h"
#import "util.h"
#import "Categoria.h"
#import "Raridade.h"
#import "TipoItem.h"

@implementation AdicionarItemViewController

@synthesize itemComum;
@synthesize delegate;

@synthesize nomeTextField;
@synthesize custoTextField;
@synthesize pesoTextField;
@synthesize danoTextField;
@synthesize protecaoTextField;
@synthesize pvTextField;
@synthesize descricaoTextField;
@synthesize scroller;

@synthesize tabela;

@synthesize editavel;

@synthesize estilo;

@synthesize catAnterior;

@synthesize keyboardBar;
@synthesize btnAnterior;
@synthesize btnProximo;

#define CATEGORIA_SECTION 0
#define TIPO_SECTION 1
#define RARIDADE_SECTION 2


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationItem.title = @"Novo Item";
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 685)];
        
    self.catAnterior = self.itemComum.categoria;
    
    fundoTela.image = [Util ImagemFundo:estilo];
    
    if (keyboardBar == nil) {
        keyboardBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
        
        btnAnterior = [[UIBarButtonItem alloc] initWithTitle:@"Anterior" style:UIBarButtonItemStyleBordered target:self action:@selector(campoAnterior:)];
        
        btnProximo = [[UIBarButtonItem alloc] initWithTitle:@"Proximo" style:UIBarButtonItemStyleBordered target:self action:@selector(proximoCampo:)];
        
        UIBarButtonItem *extraSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemFlexibleSpace) target:nil action:nil];
        
        UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"OK" style:UIBarButtonItemStyleDone target:self action:@selector(resignKeyboard:)];
        
        [keyboardBar setItems:[[NSArray alloc] initWithObjects:btnAnterior,btnProximo,extraSpace, okButton, nil]];
        
        for (id view in self.groupView.subviews){
            if ([view isKindOfClass:[UITextField class]]) {
                [(UITextField *)view setInputAccessoryView:keyboardBar];
            }
            if ([view isKindOfClass:[UITextView class]]) {
                [(UITextField *)view setInputAccessoryView:keyboardBar];
            }
        }
    }
    
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    nomeTextField.text = itemComum.nome;
    custoTextField.text = [NSString stringWithFormat:@"%@", itemComum.custo];
    pesoTextField.text = itemComum.peso;
    danoTextField.text = itemComum.dano;
    protecaoTextField.text = itemComum.protecao;
    pvTextField.text = itemComum.pv;
    descricaoTextField.text = itemComum.descricao;
    
    if (catAnterior != itemComum.categoria) {
        itemComum.tipoItem = Nil;
        catAnterior = Nil;
    }
    
    [self.tabela reloadData];
    
    if ([itemComum.categoria.nome isEqualToString:@"Armas"]){
        danoLabel.hidden = false;
        danoTextField.hidden = false;
        protecaoLabel.hidden = true;
        protecaoTextField.hidden = true;
        [self ajustaCampos:534];
        
    }
    else if ([itemComum.categoria.nome isEqualToString:@"Proteção"]){
        danoLabel.hidden = true;
        danoTextField.hidden = true;
        protecaoLabel.hidden = false;
        protecaoTextField.hidden = false;
        [self ajustaCampos:534];
        
    }
    else{
        danoLabel.hidden = true;
        danoTextField.hidden = true;
        protecaoLabel.hidden = true;
        protecaoTextField.hidden = true;
        [self ajustaCampos:495];
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload
{
    self.nomeTextField = nil;
    self.custoTextField = nil;
    self.pesoTextField = nil;
    self.danoTextField = nil;
    self.protecaoTextField = nil;
    self.pvTextField = nil;
    self.descricaoTextField = nil;
    self.estilo = nil;
    [super viewDidUnload];
}

- (void)save {
    
    if (self.validaCampos){
        
        itemComum.nome = nomeTextField.text;
        itemComum.custo = [NSNumber numberWithDouble:[custoTextField.text doubleValue]];
        itemComum.peso = pesoTextField.text;
        itemComum.dano = danoTextField.text;
        itemComum.protecao = protecaoTextField.text;
        itemComum.pv = pvTextField.text;
        itemComum.descricao = descricaoTextField.text;
        
        NSError *error = nil;
        if (![itemComum.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }		
        [self.delegate AdicionarItemViewController:self didAddItem:itemComum];
    }
}

- (void)cancel {
	
    if (!editavel){
        
        [itemComum.managedObjectContext deleteObject:itemComum];
        
        NSError *error = nil;
        if (![itemComum.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }	
        editavel = FALSE;
    }
    [self.delegate AdicionarItemViewController:self didAddItem:Nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    switch (section) {
        case CATEGORIA_SECTION:
            title = @"Categoria do Item:";
            break;
        case TIPO_SECTION:
            title = @"Tipo de Item:";
            break;
        case RARIDADE_SECTION:
            title = @"Raridade:";
            break;
        default:
            break;
    }
    return title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // Configure the cell...
        
    switch (indexPath.section) {
        case CATEGORIA_SECTION: // type -- should be selectable -> checkbox
            cell.textLabel.text = [itemComum.categoria valueForKey:@"nome"];
            cell.imageView.image = [Util ImagemCategoriaItem:[itemComum.categoria valueForKey:@"nome"] Estilo:estilo];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        case TIPO_SECTION: // type -- should be selectable -> checkbox
            cell.textLabel.text = [itemComum.tipoItem valueForKey:@"nome"];
            cell.imageView.image = [Util ImagemTipoItem:[itemComum.tipoItem valueForKey:@"nome"] Estilo:estilo];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
            
        case RARIDADE_SECTION: // instructions
            cell.textLabel.text = [itemComum.raridade valueForKey:@"nome"];
//            cell.imageView.image = [Util ImagemTipoItem:[itemComum.raridade valueForKey:@"nome"] Estilo:estilo];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        default:
            break;
    }
    
    //cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    UIViewController *nextViewController = nil;
    
    self.itemComum.nome = nomeTextField.text;
    self.itemComum.custo = [NSNumber numberWithDouble:[custoTextField.text doubleValue]];
    self.itemComum.peso = pesoTextField.text;
    self.itemComum.dano = danoTextField.text;
    self.itemComum.protecao = protecaoTextField.text;
    self.itemComum.pv = pvTextField.text;
    self.itemComum.descricao = descricaoTextField.text;
    
    self.catAnterior = self.itemComum.categoria;
    
    switch (section) {
        case CATEGORIA_SECTION:
            nextViewController = [[CategoriaSelectionViewController alloc] initWithStyle:UITableViewStyleGrouped];
            ((CategoriaSelectionViewController *)nextViewController).itemComum = itemComum;
            ((CategoriaSelectionViewController *)nextViewController).context = self.itemComum.managedObjectContext;
            ((CategoriaSelectionViewController *)nextViewController).fonte = 2;
            ((CategoriaSelectionViewController *)nextViewController).estilo = estilo;
            break;
        case TIPO_SECTION:
            if (itemComum.categoria == Nil) {
                
                [self apresentaAlerta:@"É necessario definir a categoria do item antes de selecionar o seu tipo."];
            }
            else{
            nextViewController = [[TipoItemSelectionViewController alloc] initWithStyle:UITableViewStyleGrouped];
            ((TipoItemSelectionViewController *)nextViewController).itemComum = self.itemComum;
            ((TipoItemSelectionViewController *)nextViewController).context = self.itemComum.managedObjectContext;
            ((TipoItemSelectionViewController *)nextViewController).cat = self.itemComum.categoria;
            ((TipoItemSelectionViewController *)nextViewController).fonte = 2;
            ((TipoItemSelectionViewController *)nextViewController).estilo = estilo;

            }
            break;
			
        case RARIDADE_SECTION:
            nextViewController = [[RaridadeSelectionViewController alloc] initWithStyle:UITableViewStyleGrouped];
            ((RaridadeSelectionViewController *)nextViewController).itemComum = itemComum;
            ((RaridadeSelectionViewController *)nextViewController).context = self.itemComum.managedObjectContext;
            ((RaridadeSelectionViewController *)nextViewController).fonte = 2;
            ((RaridadeSelectionViewController *)nextViewController).estilo = estilo;
            break;
			
			
        default:
            break;
    }
    if (nextViewController) {
        [self.navigationController pushViewController:nextViewController animated:YES];

    }
}

#pragma Outros


- (IBAction)liberaTeclado:(id)sender{
    [sender resignFirstResponder];
    scroller.scrollEnabled = true;
    descricaoTextField.editable =TRUE;
    tabela.hidden = FALSE;
    self.navigationItem.leftBarButtonItem.enabled = TRUE;
    self.navigationItem.rightBarButtonItem.enabled = TRUE;
    
    nomeTextField.enabled = TRUE;
    custoTextField.enabled = TRUE;
    pesoTextField.enabled = TRUE;
    danoTextField.enabled = TRUE;
    protecaoTextField.enabled = TRUE;
    pvTextField.enabled = TRUE;
    
    descricaoTextField.userInteractionEnabled = TRUE;
    
}

- (IBAction)posicionarScroll:(id)sender{
        
//    UITextField *text = sender;
//    
//    if ((custoTextField != text) && (pesoTextField != text) && (danoTextField != text) && (protecaoTextField !=text) && (pvTextField != text)) {
//        scroller.contentOffset = CGPointMake(0, (text.frame.origin.y-40));
//        if (nomeTextField != text) {
//            nomeTextField.enabled = FALSE;
//        }
//        else{
//            descricaoTextField.editable =FALSE;
//            descricaoTextField.userInteractionEnabled = FALSE;
//        }
//    }
//    else{ 
//        scroller.contentOffset = CGPointMake(0, (text.frame.origin.y));
//        
//        if (custoTextField != text) {
//            custoTextField.enabled = FALSE;
//        }
//        if (pesoTextField != text) {
//            pesoTextField.enabled = FALSE;
//        }
//        if (danoTextField != text) {
//            danoTextField.enabled = FALSE;
//        }
//        if (protecaoTextField !=text) {
//            protecaoTextField.enabled = FALSE;
//        }
//        if (pvTextField != text) {
//            pvTextField.enabled = FALSE;
//        }
//        
//        descricaoTextField.editable =FALSE;
//        descricaoTextField.userInteractionEnabled = FALSE;
//
//    }
//        
//    scroller.scrollEnabled = FALSE;
//    tabela.hidden = TRUE;
//    
//    self.navigationItem.leftBarButtonItem.enabled = FALSE;
//    self.navigationItem.rightBarButtonItem.enabled = FALSE;
    
}

-(BOOL) textViewShouldBeginEditing:(UITextView *)textView{
    
    [self posicionarScroll:descricaoTextField];
    [textView setInputAccessoryView:keyboardToolBar];

    return TRUE;
}

- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){
        [self liberaTeclado:descricaoTextField];
        return FALSE;
    }
    return TRUE;
}

- (BOOL)validaCampos{
   
    if (nomeTextField.text == nil || [descricaoTextField.text length] == 0 || itemComum.tipoItem == Nil || itemComum.raridade == Nil ) {
        
        [self apresentaAlerta:@"É necessario definir: o nome, o tipo, a raridade e a descrição, para o cadastro de itens"];
        
        return FALSE;
    }
    else{

    }
        
    return TRUE;
}

-(void)resignKeyboard:(id)sender{
    [self.view endEditing:YES];
}

-(void)proximoCampo:(id)sender{
    int tag = [self retornaTag];
    
    if (tag==1) {
        [btnAnterior setEnabled:true];
    }
    if (tag<4) {
        [btnProximo setEnabled:true];
        UITextField *txtField = (UITextField *)[self.view viewWithTag:(tag+1)];
        [txtField becomeFirstResponder];
    }
    else if (tag==4){
        [btnProximo setEnabled:false];
        UITextView *txtView = (UITextView *)[self.view viewWithTag:(tag+1)];
        [txtView becomeFirstResponder];
    }
    
}

-(void)campoAnterior:(id)sender{
    
    int tag = [self retornaTag];
    
    if (tag==5) {
        [btnProximo setEnabled:true];
    }
    
    UITextView *txtView = (UITextView *)[self.view viewWithTag:(tag-1)];
    [txtView becomeFirstResponder];
    
    if (tag==2) {
        [btnAnterior setEnabled:false];
    }
    
}

-(int)retornaTag{
    
    NSInteger tag = 0;
    
    for (id view in self.groupView.subviews){
        if ([view isKindOfClass:[UITextField class]]) {
            if ([(UITextField *)view isFirstResponder]){
                UITextField *txtField;
                txtField = (UITextField *)view;
                tag = txtField.tag;
            }
        }
        if ([view isKindOfClass:[UITextView class]]) {
            if ([(UITextView *)view isFirstResponder]){
                UITextView *txtField;
                txtField = (UITextView *)view;
                tag = txtField.tag;
            }
        }
    }
    
    return (int)tag;
}

- (void)ajustaCampos:(int)posicao{
    
    protecaoLabel.frame = CGRectMake(protecaoLabel.frame.origin.x, posicao-43, protecaoLabel.frame.size.width, protecaoLabel.frame.size.height);
    protecaoTextField.frame = CGRectMake(protecaoTextField.frame.origin.x, posicao-43, protecaoTextField.frame.size.width, protecaoTextField.frame.size.height);
    descricaoLabel.frame = CGRectMake(descricaoLabel.frame.origin.x, posicao, descricaoLabel.frame.size.width, descricaoLabel.frame.size.height);
    imageview.frame = CGRectMake(imageview.frame.origin.x, posicao+25, imageview.frame.size.width, imageview.frame.size.height);
    descricaoTextField.frame = CGRectMake(descricaoTextField.frame.origin.x,posicao+30, descricaoTextField.frame.size.width, descricaoTextField.frame.size.height);
}

- (void)apresentaAlerta:(NSString *)mensagem{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Atenção!" message:mensagem delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
}

@end
