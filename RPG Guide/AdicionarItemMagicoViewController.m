//
//  AdicionarItemMagicoViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 16/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AdicionarItemMagicoViewController.h"

#import "ItemMagico.h"
#import "ItemComum.h"
#import "RaridadeSelectionViewController.h"
#import "TipoItemSelectionViewController.h"
#import "CategoriaSelectionViewController.h"
#import "SelecionaItemViewController.h"
#import "SelecionaPoderViewController.h"
#import "util.h"
#import "Categoria.h"
#import "TipoItem.h"
#import "Raridade.h"

@implementation AdicionarItemMagicoViewController

@synthesize itemMagico;
@synthesize itemComum;
@synthesize delegate;

@synthesize nomeTextField;
@synthesize custoTextField;
@synthesize pesoTextField;
@synthesize danoTextField;
@synthesize protecaoTextField;
@synthesize pvTextField;
@synthesize descricaoTextField;
@synthesize poderTextField;
@synthesize nivelTextField;

@synthesize tabela;
@synthesize scroller;
@synthesize groupView;

@synthesize keyboardBar;
@synthesize btnAnterior;
@synthesize btnProximo;

@synthesize editavel;

@synthesize managedObjectContext, fetchedResultsController;

@synthesize estilo;
@synthesize textoPoderes;

@synthesize catAnterior;

#define CATEGORIA_SECTION 0
#define TIPO_SECTION 1
#define RARIDADE_SECTION 2

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationItem.title = @"Novo Item Mágico";
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    [scroller setScrollEnabled:YES];
//    [scroller setContentSize:CGSizeMake(320, 890)];
    
//    self.estilo = [Util VerificaEstilo];
    
    if (itemComum != Nil) {
        nomeTextField.text = itemComum.nome;
        custoTextField.text = [NSString stringWithFormat:@"%@", itemComum.custo];
        pesoTextField.text = itemComum.peso;
        danoTextField.text = itemComum.dano;
        protecaoTextField.text = itemComum.protecao;
        pvTextField.text = itemComum.pv;
        descricaoTextField.text = itemComum.descricao;

        
        itemMagico.nome = itemComum.nome;
        itemMagico.descricao = itemComum.descricao;
        itemMagico.custo = itemComum.custo;
        itemMagico.peso = itemComum.peso;
        itemMagico.pv = itemComum.pv;
        itemMagico.dano = itemComum.dano;
        itemMagico.protecao = itemComum.protecao;
        itemMagico.raridade = itemComum.raridade;
        itemMagico.tipoItem = itemComum.tipoItem;
        itemMagico.categoria = itemComum.categoria;
        
        itemComum = Nil;
    }  

    self.catAnterior = self.itemMagico.categoria;
    
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
    
    if (itemComum == Nil) {
        
        nomeTextField.text = itemMagico.nome;    
        custoTextField.text = [NSString stringWithFormat:@"%@", itemMagico.custo];
        pesoTextField.text = itemMagico.peso;
        danoTextField.text = itemMagico.dano;
        protecaoTextField.text = itemMagico.protecao;
        pvTextField.text = itemMagico.pv;
        descricaoTextField.text = itemMagico.descricao;
        poderTextField.text = itemMagico.poder;
        nivelTextField.text = [NSString stringWithFormat:@"%@", itemMagico.nivel];
        
    }
    else{
        itemComum = Nil;
    }
    
    if (catAnterior != itemMagico.categoria) {
        itemMagico.tipoItem = Nil;
        catAnterior = Nil;
    }
    
    [self.tabela reloadData];
    
    if ([itemMagico.categoria.nome isEqualToString:@"Armas"]){
        danoLabel.hidden = false;
        danoTextField.hidden = false;
        protecaoLabel.hidden = true;
        protecaoTextField.hidden = true;
//        [self ajustaCampos:564];
        
    }
    else if ([itemMagico.categoria.nome isEqualToString:@"Proteção"]){
        danoLabel.hidden = true;
        danoTextField.hidden = true;
        protecaoLabel.hidden = false;
        protecaoTextField.hidden = false;
//        [self ajustaCampos:564];
        
    }
    else{
        danoLabel.hidden = true;
        danoTextField.hidden = true;
        protecaoLabel.hidden = true;
        protecaoTextField.hidden = true;
//        [self ajustaCampos:525];
    }
    
//    if (textoPoderes!=nil) {
//        if ([poderTextField.text length] == 0) {
//            poderTextField.text = textoPoderes;
//        }
//        else{
//            poderTextField.text = [poderTextField.text stringByAppendingFormat:@"/n"];
//            poderTextField.text = [NSString stringWithFormat:@"%@%@",poderTextField.text,textoPoderes];
//        }
//        textoPoderes = nil;
//    }
    
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
    self.poderTextField = nil;
    self.nivelTextField = nil;
    self.estilo = nil;
    [super viewDidUnload];
}

- (void)save {
    
    if (self.validaCampos){
        
        itemMagico.nome = nomeTextField.text;
        itemMagico.custo = [NSNumber numberWithDouble:[custoTextField.text doubleValue]];
        itemMagico.peso = pesoTextField.text;
        itemMagico.dano = danoTextField.text;
        itemMagico.protecao = protecaoTextField.text;
        itemMagico.pv = pvTextField.text;
        itemMagico.descricao = descricaoTextField.text;
        itemMagico.poder = poderTextField.text;
        itemMagico.nivel = [NSNumber numberWithDouble:[nivelTextField.text doubleValue]];

        
        NSError *error = nil;
        if (![itemMagico.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }		
        [self.delegate AdicionarItemMagicoViewController:self didAddItem:itemMagico];
    }
}


- (void)cancel {
	
    if (!editavel){
        
        [itemMagico.managedObjectContext deleteObject:itemMagico];
        
        NSError *error = nil;
        if (![itemMagico.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }	
        editavel = FALSE;
    }
    [self.delegate AdicionarItemMagicoViewController:self didAddItem:Nil];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.itemMagico.nome = nomeTextField.text;
    self.itemMagico.custo = [NSNumber numberWithDouble:[custoTextField.text doubleValue]];
    self.itemMagico.peso = pesoTextField.text;
    self.itemMagico.dano = danoTextField.text;
    self.itemMagico.protecao = protecaoTextField.text;
    self.itemMagico.pv = pvTextField.text;
    self.itemMagico.descricao = descricaoTextField.text;
    self.itemMagico.poder = poderTextField.text;
    self.itemMagico.nivel = [NSNumber numberWithDouble:[nivelTextField.text doubleValue]];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    
    NSString *text = nil;
    
    switch (indexPath.section) {
        case CATEGORIA_SECTION: // type -- should be selectable -> checkbox
            text = [itemMagico.categoria valueForKey:@"nome"];
            cell.imageView.image = [Util ImagemCategoriaItem:text Estilo:estilo];
            break;
        case TIPO_SECTION: // type -- should be selectable -> checkbox
            text = [itemMagico.tipoItem valueForKey:@"nome"];
            cell.imageView.image = [Util ImagemTipoItem:text Estilo:estilo];
            break;
        case RARIDADE_SECTION: // instructions
            text = [itemMagico.raridade valueForKey:@"nome"];
            cell.imageView.image = [Util ImagemRaridade:text Estilo:estilo];
            break;
        default:
            break;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = text;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    UIViewController *nextViewController = nil;
    
    self.itemMagico.nome = nomeTextField.text;
    self.itemMagico.custo = [NSNumber numberWithDouble:[custoTextField.text doubleValue]];
    self.itemMagico.peso = pesoTextField.text;
    self.itemMagico.dano = danoTextField.text;
    self.itemMagico.protecao = protecaoTextField.text;
    self.itemMagico.pv = pvTextField.text;
    self.itemMagico.descricao = descricaoTextField.text;
    self.itemMagico.poder = poderTextField.text;
    self.itemMagico.nivel = [NSNumber numberWithDouble:[nivelTextField.text doubleValue]];

    self.catAnterior = self.itemMagico.categoria;
    
    switch (section) {
        case CATEGORIA_SECTION:
            nextViewController = [[CategoriaSelectionViewController alloc] initWithStyle:UITableViewStyleGrouped];
            ((CategoriaSelectionViewController *)nextViewController).itemMagico = itemMagico;
            ((CategoriaSelectionViewController *)nextViewController).context = self.itemMagico.managedObjectContext;
            ((CategoriaSelectionViewController *)nextViewController).fonte = 3;
            ((CategoriaSelectionViewController *)nextViewController).estilo = estilo;
            break;
        case TIPO_SECTION:
            if (itemMagico.categoria == Nil) {
                
                [self apresentaAlerta:@"É necessario definir a categoria do item antes de selecionar o seu tipo."];
                
            }
            else{
                nextViewController = [[TipoItemSelectionViewController alloc] initWithStyle:UITableViewStyleGrouped];
                ((TipoItemSelectionViewController *)nextViewController).itemMagico = self.itemMagico;
                ((TipoItemSelectionViewController *)nextViewController).context = self.itemMagico.managedObjectContext;
                ((TipoItemSelectionViewController *)nextViewController).cat = self.itemMagico.categoria;
                ((TipoItemSelectionViewController *)nextViewController).fonte = 3;
                ((TipoItemSelectionViewController *)nextViewController).estilo = estilo;
            }
            break;
			
        case RARIDADE_SECTION:
            nextViewController = [[RaridadeSelectionViewController alloc] initWithStyle:UITableViewStyleGrouped];
            ((RaridadeSelectionViewController *)nextViewController).itemMagico = itemMagico;
            ((RaridadeSelectionViewController *)nextViewController).fonte = 3;
            ((RaridadeSelectionViewController *)nextViewController).context = self.itemMagico.managedObjectContext;
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

//- (IBAction)liberaTeclado:(id)sender{
//    [sender resignFirstResponder];
//    scroller.scrollEnabled = true;
//    descricaoTextField.editable = true;
//    poderTextField.editable = true;
//    btnPoder.enabled = true;
//    tabela.hidden = FALSE;
//    self.navigationItem.leftBarButtonItem.enabled = TRUE;
//    self.navigationItem.rightBarButtonItem.enabled = TRUE;
//    
//    nomeTextField.enabled = TRUE;
//    custoTextField.enabled = TRUE;
//    pesoTextField.enabled = TRUE;
//    danoTextField.enabled = TRUE;
//    protecaoTextField.enabled = TRUE;
//    pvTextField.enabled = TRUE;
//    nivelTextField.enabled = TRUE;
//    
//    descricaoTextField.userInteractionEnabled=TRUE;
//    poderTextField.userInteractionEnabled=TRUE;
//    
//    [scroller bounces];
//    
//}

- (IBAction)posicionarScroll:(id)sender{
        
    UITextField *text = sender;
    
    if ((custoTextField != text) && (pesoTextField != text) && (danoTextField != text) && (protecaoTextField !=text) && (pvTextField != text) && (nomeTextField != text)&&(nivelTextField != text)) {

        UITextView *text2 = sender;
        scroller.contentOffset = CGPointMake(0, (text2.frame.origin.y-40));
        if (poderTextField != text2) {
            poderTextField.editable = FALSE;
        }
        else{
            descricaoTextField.editable = FALSE;
        }
        btnPoder.enabled = FALSE;
    }
    else{ 
        if (nomeTextField == text) {
            scroller.contentOffset = CGPointMake(0, (text.frame.origin.y-40));

        }else{
            scroller.contentOffset = CGPointMake(0, (text.frame.origin.y));
        }
        
        if (nomeTextField != text) {
            nomeTextField.enabled = FALSE;
        }
        
        if (custoTextField != text) {
            custoTextField.enabled = FALSE;
        }
        if (pesoTextField != text) {
            pesoTextField.enabled = FALSE;
        }
        if (danoTextField != text) {
            danoTextField.enabled = FALSE;
        }
        if (protecaoTextField !=text) {
            protecaoTextField.enabled = FALSE;
        }
        if (pvTextField != text) {
            pvTextField.enabled = FALSE;
        }
        if (nivelTextField != text) {
            nivelTextField.enabled = FALSE;
        }
        
        descricaoTextField.editable =FALSE;
        poderTextField.editable = FALSE;
        descricaoTextField.userInteractionEnabled=FALSE;
        poderTextField.userInteractionEnabled=FALSE;
        
    }
    
    scroller.scrollEnabled = FALSE;
    tabela.hidden = TRUE;
    
    self.navigationItem.leftBarButtonItem.enabled = FALSE;
    self.navigationItem.rightBarButtonItem.enabled = FALSE;
    
}

- (IBAction)selecionaPoder:(id)sender{
    
    if (itemMagico.categoria != nil) {
        
        itemMagico.poder = poderTextField.text;
    
        SelecionaPoderViewController *telaPoder =[SelecionaPoderViewController alloc];
        telaPoder.estilo = self.estilo;
        telaPoder.managedObjectContext = self.managedObjectContext;
        telaPoder.fetchedResultsController = self.fetchedResultsController;
        telaPoder.categoria = itemMagico.categoria.nome;
        telaPoder.delegate = self;
        [self.navigationController pushViewController:telaPoder animated:YES];
        
    }
    else{

        [self apresentaAlerta:@"É necessario definir o tipo de item antes de selecionar os poderes!" ];
    
    }

}
-(BOOL) textViewShouldBeginEditing:(UITextView *)textView{
    if (descricaoTextField == textView) {
        [self posicionarScroll:descricaoTextField];
    }
    else{
        [self posicionarScroll:poderTextField];
    }
    [textView setInputAccessoryView:keyboardToolBar];
    
    return TRUE;
}

//- (BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    
//    if ([text isEqualToString:@"\n"]){
//        if (descricaoTextField == textView){
//            [self liberaTeclado:descricaoTextField];
//        }
//        else{
//            [self liberaTeclado:poderTextField];
//        }
//        return FALSE;
//    }
//    
//    return TRUE;
//}

- (BOOL)validaCampos{
    if (nomeTextField.text == nil || [descricaoTextField.text length] == 0 || [poderTextField.text length] == 0 || itemMagico.tipoItem == Nil || itemMagico.raridade == Nil ) {
        
        [self apresentaAlerta:@"É necessario definir: o nome, o tipo, a raridade, a descrição e o poder para o cadastro de Itens Mágicos"];
        
        return FALSE;
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
    protecaoLabel.frame = CGRectMake(protecaoLabel.frame.origin.x, posicao-39, protecaoLabel.frame.size.width, protecaoLabel.frame.size.height);
    protecaoTextField.frame = CGRectMake(protecaoTextField.frame.origin.x, posicao-39, protecaoTextField.frame.size.width, protecaoTextField.frame.size.height);
    descricaoLabel.frame = CGRectMake(descricaoLabel.frame.origin.x, posicao, descricaoLabel.frame.size.width, descricaoLabel.frame.size.height);
    imageview.frame = CGRectMake(imageview.frame.origin.x, posicao+25, imageview.frame.size.width, imageview.frame.size.height);
    descricaoTextField.frame = CGRectMake(descricaoTextField.frame.origin.x,posicao+30, descricaoTextField.frame.size.width, descricaoTextField.frame.size.height);
    poderLabel.frame = CGRectMake(poderLabel.frame.origin.x, posicao+180, poderLabel.frame.size.width, poderLabel.frame.size.height);
    imageViewPoder.frame = CGRectMake(imageViewPoder.frame.origin.x, posicao+205, imageViewPoder.frame.size.width, imageViewPoder.frame.size.height);
    poderTextField.frame = CGRectMake(poderTextField.frame.origin.x,posicao+210, poderTextField.frame.size.width, poderTextField.frame.size.height);
    btnPoder.frame = CGRectMake(btnPoder.frame.origin.x, (poderLabel.frame.origin.y-5), btnPoder.frame.size.width, btnPoder.frame.size.height);
    [scroller setContentSize:CGSizeMake(320, posicao+365)];
}

#pragma protocolo
- (void)IncluirPoder:(NSString *)texto valorNivel:(NSNumber *)valorNivel{
    
    NSString *textoPoder = itemMagico.poder;
    if ([textoPoder length] != 0 ) {
        textoPoder = [textoPoder stringByAppendingFormat:@"\n"];
        texto = [NSString stringWithFormat:@"%@%@",textoPoder,texto];
    }
    itemMagico.poder = texto;
    
    if ([nivelTextField.text length] != 0){
        itemMagico.nivel = [NSNumber numberWithInt:([nivelTextField.text intValue]+[valorNivel intValue])];
    }
    else{
        itemMagico.nivel = valorNivel;
    }
}

- (void)apresentaAlerta:(NSString *)mensagem{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Atenção!" message:mensagem delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
}

@end
