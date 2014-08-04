//
//  AdicionarAlquimiaViewController.m
//  DM Compendium
//
//  Created by Mateus Andrade on 19/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AdicionarAlquimiaViewController.h"
#import "Alquimia.h"
#import "TipoAlquimia.h"
#import "Raridade.h"
#import "TipoAlquimiaSelectionViewController.h"
#import "RaridadeSelectionViewController.h"
#import "util.h"

@implementation AdicionarAlquimiaViewController

@synthesize alquimia;
@synthesize delegate;

@synthesize nomeTextField;
@synthesize custoTextField;
@synthesize duracaoTextField;
@synthesize preparoTextField;
@synthesize descricaoTextField;
@synthesize tabela;
@synthesize fundoTela;
@synthesize scroller;
@synthesize groupView;

@synthesize editavel;

@synthesize estilo;

@synthesize btnAnterior;
@synthesize btnProximo;
@synthesize keyboardBar;

#define TIPO_SECTION 0
#define RARIDADE_SECTION 1


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationItem.title = @"Nova Alquimia";
    
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelButtonItem;
    
    UIBarButtonItem *saveButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStyleDone target:self action:@selector(save)];
    self.navigationItem.rightBarButtonItem = saveButtonItem;
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 685)];
    
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
    
    nomeTextField.text = alquimia.nome;
    custoTextField.text = [NSString stringWithFormat:@"%@", alquimia.custo];
    preparoTextField.text = alquimia.preparo;
    duracaoTextField.text = alquimia.duracao;
    descricaoTextField.text = alquimia.descricao;
    [self.tabela reloadData];
    
}

- (void)viewDidUnload
{
    self.nomeTextField = nil;
    self.custoTextField = nil;
    self.preparoTextField = nil;
    self.duracaoTextField = nil;
    self.descricaoTextField = nil;
    self.estilo = nil;
    [super viewDidUnload];
}

- (void)save {
    
    if (self.validaCampos){
        
    alquimia.nome = nomeTextField.text;
    alquimia.custo = [NSNumber numberWithDouble:[custoTextField.text doubleValue]];
    alquimia.preparo = preparoTextField.text;
    alquimia.duracao = duracaoTextField.text;
    alquimia.descricao = descricaoTextField.text;
    
	NSError *error = nil;
	if (![alquimia.managedObjectContext save:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
	}		
    [self.delegate AdicionarAlquimiaViewController:self didAddAlquimia:alquimia];
    }
}


- (void)cancel {
	
    if (!editavel){
        
     [alquimia.managedObjectContext deleteObject:alquimia];
    
        NSError *error = nil;
        if (![alquimia.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }	
        editavel = FALSE;
    }
    [self.delegate AdicionarAlquimiaViewController:self didAddAlquimia:Nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    switch (section) {
        case TIPO_SECTION:
            title = @"Categoria:";
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
        case TIPO_SECTION: 
            text = [alquimia.tipo valueForKey:@"nome"];
            if (![text length] ==0) {
                cell.imageView.image = [Util ImagemTipoAlquimia:text Estilo:estilo];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case RARIDADE_SECTION: // instructions
            text = [alquimia.raridade valueForKey:@"nome"];
            if (![text length]== 0) {
                cell.imageView.image = [Util ImagemRaridade:[alquimia.raridade valueForKey:@"nome"] Estilo:estilo];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        default:
            break;
    }    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = text;
return cell;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section = indexPath.section;
    UIViewController *nextViewController = nil;
    
    self.alquimia.nome = nomeTextField.text;
    self.alquimia.custo = [NSNumber numberWithDouble:[custoTextField.text doubleValue]];
    self.alquimia.preparo = preparoTextField.text;
    self.alquimia.duracao = duracaoTextField.text;
    self.alquimia.descricao = descricaoTextField.text;
    
    switch (section) {
        case TIPO_SECTION:
            nextViewController = [[TipoAlquimiaSelectionViewController alloc] initWithStyle:UITableViewStyleGrouped];
            ((TipoAlquimiaSelectionViewController *)nextViewController).alquimia = alquimia;
            ((TipoAlquimiaSelectionViewController *)nextViewController).estilo = self.estilo;
            ((TipoAlquimiaSelectionViewController *)nextViewController).context = alquimia.managedObjectContext;
            ((TipoAlquimiaSelectionViewController *)nextViewController).fonte = 1;
            
            break;
			
        case RARIDADE_SECTION:
            nextViewController = [[RaridadeSelectionViewController alloc] initWithStyle:UITableViewStyleGrouped];
            ((RaridadeSelectionViewController *)nextViewController).alquimia = self.alquimia;
            ((RaridadeSelectionViewController *)nextViewController).context = self.alquimia.managedObjectContext;
            ((RaridadeSelectionViewController *)nextViewController).fonte = 1;
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
    nomeTextField.enabled = TRUE;
    custoTextField.enabled = TRUE;
    duracaoTextField.enabled = TRUE;
    preparoTextField.enabled = TRUE;
    descricaoTextField.editable =TRUE;
    tabela.hidden = FALSE;
    self.navigationItem.leftBarButtonItem.enabled = TRUE;
    self.navigationItem.rightBarButtonItem.enabled = TRUE;
}

- (IBAction)posicionarScroll:(id)sender{
    
//    //scroller.contentOffset = CGPointMake(0, 280);
//
//    UITextView *text = sender;
//    
//    scroller.contentOffset = CGPointMake(0, (text.frame.origin.y - 50 ));
//    
//    scroller.scrollEnabled = FALSE;
//    //duracaoTextField.enabled = FALSE;
//    
//    descricaoTextField.editable =FALSE;
//    tabela.hidden = TRUE;
//    self.navigationItem.leftBarButtonItem.enabled = FALSE;
//    self.navigationItem.rightBarButtonItem.enabled = FALSE;
    
    UITextField *text = sender;
    
    if ((custoTextField != text) && (duracaoTextField != text) && (preparoTextField != text)) {
        scroller.contentOffset = CGPointMake(0, (text.frame.origin.y-50));
        if (nomeTextField != text) {
            nomeTextField.enabled = FALSE;
        }
        else{
            descricaoTextField.editable =FALSE;
        }
    }
    else{ 
        scroller.contentOffset = CGPointMake(0, (text.frame.origin.y-50));
        
        if (custoTextField != text) {
            custoTextField.enabled = FALSE;
        }
        if (duracaoTextField != text) {
            duracaoTextField.enabled = FALSE;
        }
        if (preparoTextField != text) {
            preparoTextField.enabled = FALSE;
        }
        
        descricaoTextField.editable =FALSE;
        
    }
    
    scroller.scrollEnabled = FALSE;
    tabela.hidden = TRUE;
    
    self.navigationItem.leftBarButtonItem.enabled = FALSE;
    self.navigationItem.rightBarButtonItem.enabled = FALSE;


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
    if (nomeTextField.text == nil || [descricaoTextField.text length] == 0 || alquimia.tipo == Nil || alquimia.raridade == Nil ) {
        
        [self apresentaAlerta:@"É necessario definir: o nome, o tipo, a raridade e a descrição, para o cadastro da alquimia"];
        
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

- (void)apresentaAlerta:(NSString *)mensagem{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Atenção!" message:mensagem delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
    
}
                                     
@end
