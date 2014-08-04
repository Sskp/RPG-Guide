//
//  AdicionarPoderViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AdicionarPoderViewController.h"
#import "Poder.h"
#import "util.h"

@implementation AdicionarPoderViewController

@synthesize poder;
@synthesize delegate;

@synthesize nomeTextField;
@synthesize nivelTextField;
@synthesize descricaoTextField;
@synthesize tabela;
@synthesize fundoTela;
@synthesize groupView;

@synthesize keyboardBar;
@synthesize btnProximo;
@synthesize btnAnterior;

@synthesize editavel;

@synthesize estilo;

#define TIPO_ARMA 0
#define TIPO_ARMADURA 1
#define TIPO_GERAL 2


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationItem.title = @"Novo Poder";
    
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

    
    poder.arma=[NSNumber numberWithBool:FALSE];
    poder.armadura=[NSNumber numberWithBool:FALSE];
    poder.geral=[NSNumber numberWithBool:FALSE];

    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    self.nomeTextField = nil;
    self.nivelTextField = nil;
    self.descricaoTextField = nil;
    self.estilo = nil;
    [super viewDidUnload];
}

- (void)save {
    
    if (self.validaCampos){
        
        poder.nome = nomeTextField.text;
        poder.nivel = [NSNumber numberWithDouble:[nivelTextField.text doubleValue]];
        poder.descricao = descricaoTextField.text;
             
        NSError *error = nil;
        if (![poder.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }		
        [self.delegate AdicionarPoderViewController:self didAddPoder:poder];
    }
}


- (void)cancel {
	
    if (!editavel){
        
        [poder.managedObjectContext deleteObject:poder];
        
        NSError *error = nil;
        if (![poder.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }	
        editavel = FALSE;
    }
    [self.delegate AdicionarPoderViewController:self didAddPoder:Nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    nomeTextField.text = poder.nome;    
    nivelTextField.text = [NSString stringWithFormat:@"%@", poder.nivel];
    descricaoTextField.text = poder.descricao;   
    
    [self.tabela reloadData];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
        
    switch (indexPath.row) {
        case TIPO_ARMA:
            if ([poder.arma boolValue]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            cell.textLabel.text = @"Arma";
            break;
        case TIPO_ARMADURA: 
            if ([poder.armadura boolValue]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            cell.textLabel.text = @"Armadura";
            break;
        case TIPO_GERAL: 
            if ([poder.geral boolValue]) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else{
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            cell.textLabel.text = @"Geral";
            break;
        default:
            break;
    }
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case TIPO_ARMA:
            if([poder.arma boolValue] == TRUE){
                poder.arma=[NSNumber numberWithBool:FALSE];
            }
            else{
                poder.arma=[NSNumber numberWithBool:TRUE];
            }
            break;
			
        case TIPO_ARMADURA:
            if([poder.armadura boolValue] == TRUE){
                poder.armadura=[NSNumber numberWithBool:FALSE];
            }
            else{
                poder.armadura=[NSNumber numberWithBool:TRUE];
            }
            break;
			
        case TIPO_GERAL:
            if([poder.geral boolValue] == TRUE){
                poder.geral=[NSNumber numberWithBool:FALSE];
            }
            else{
                poder.geral=[NSNumber numberWithBool:TRUE];
            }

            break;
        default:
            break;
    }
    [self.tabela reloadData];
}

#pragma Outros

- (IBAction)liberaTeclado:(id)sender{
    [sender resignFirstResponder];
    scroller.scrollEnabled = true;
    nomeTextField.enabled = TRUE;
    nivelTextField.enabled = TRUE;
    descricaoTextField.editable =TRUE;
    descricaoTextField.userInteractionEnabled = TRUE;
    tabela.userInteractionEnabled = TRUE;
    self.navigationItem.leftBarButtonItem.enabled = TRUE;
    self.navigationItem.rightBarButtonItem.enabled = TRUE;
}

- (IBAction)posicionarScroll:(id)sender{
    
//    UITextField *text = sender;
//    scroller.contentOffset = CGPointMake(0, (text.frame.origin.y-50));
//
//    if (nomeTextField == text) {
//        nivelTextField.enabled = FALSE;
//        descricaoTextField.userInteractionEnabled = FALSE;
//        descricaoTextField.editable = FALSE;
//    } 
//    else if (nivelTextField == text){
//        nomeTextField.enabled = FALSE;
//        descricaoTextField.userInteractionEnabled = FALSE;
//        descricaoTextField.editable = FALSE;
//    }
//    else{
//        nomeTextField.enabled = FALSE;
//        nivelTextField.enabled = FALSE;
//    }
//    
//    scroller.scrollEnabled = FALSE;
//    tabela.userInteractionEnabled = FALSE;
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
    if (nomeTextField.text == nil || [descricaoTextField.text length] == 0 ||  nivelTextField.text == nil || ((poder.arma==FALSE)&&(poder.armadura==FALSE)&&(poder.geral==FALSE))) {
        
        [self apresentaAlerta:@"É necessario definir: o nome, o nivel, a categoria e a descrição, para o cadastro de um novo poder"];
        
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