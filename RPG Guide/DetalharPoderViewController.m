//
//  DetalharPoderViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetalharPoderViewController.h"
#import "Poder.h"
#import "util.h"

@implementation DetalharPoderViewController

@synthesize nomePoder;
@synthesize nivelPoder;
@synthesize descricaoPoder;
@synthesize poder;
@synthesize fundoTela;
@synthesize estilo;
@synthesize tabela;

#define TIPO_ARMA 0
#define TIPO_ARMADURA 1
#define TIPO_GERAL 2

#pragma mark - View lifecycle

-(void)viewDidAppear:(BOOL)animated{
    //self.estilo = [Util VerificaEstilo];
    [self viewDidLoad];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIFont *fonte = [Util FonteLabel:estilo];
    
    nomePoder.text = poder.nome;
    nivelPoder.text = [NSString stringWithFormat:@"%@",poder.nivel];
    descricaoPoder.text = poder.descricao;
    
//    [descricaoPoder sizeToFit];
    
    fundoTela.image = [Util ImagemFundo:estilo];
    
//    nivelPoder.font = fonte;
//    nivelLabel.font = fonte;
//    categoriaLavel.font = fonte;
//    descricaoLabel.font = fonte;
    
    nomePoder.font = [Util FonteTitulo:estilo];
    
    [scroller setScrollEnabled:YES];
//    [scroller setContentSize:CGSizeMake(320, 700)];

//    [scroller setContentSize:CGSizeMake(320, (290 + descricaoPoder.frame.size.height))];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.poder = nil;
    fundoTela = nil;
    
    estilo=nil;
    
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
    cell.textLabel.font = [Util FonteLabel:estilo];
    
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


@end
