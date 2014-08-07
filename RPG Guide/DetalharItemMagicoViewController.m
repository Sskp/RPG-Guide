//
//  DetalharItemMagicoViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 16/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetalharItemMagicoViewController.h"

#import "ItemMagico.h"
#import "Raridade.h"
#import "Categoria.h"
#import "TipoItem.h"
#import "util.h"

@implementation DetalharItemMagicoViewController

@synthesize nomeItem;
@synthesize custoItem;
@synthesize raridadeItem;
@synthesize pesoItem;
@synthesize pvItem;
@synthesize danoItem;
@synthesize protecaoItem;
@synthesize descricaoItem;
@synthesize poderItem;
@synthesize itemMagico;
@synthesize imageTipo;
@synthesize fundoTela;
@synthesize estilo;
@synthesize custoSu;
@synthesize custoPre;
@synthesize tipoItem;
@synthesize nivelItem;
@synthesize scroller;

@synthesize habilitaSalvar;
@synthesize itemSalvo;

@synthesize imageView;

#pragma mark - View lifecycle

-(void)viewDidAppear:(BOOL)animated{
    //self.estilo = [Util VerificaEstilo];
    [self viewDidLoad];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (habilitaSalvar) {
        UIBarButtonItem *salvarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Salvar" style:UIBarButtonItemStyleBordered target:self action:@selector(salvar)];
        salvarButtonItem.enabled = true;
        self.navigationItem.rightBarButtonItem = salvarButtonItem;
    }
    
    //UIFont *fonte = [Util FonteLabel:estilo];
    
    nomeItem.text = itemMagico.nome;
    custoItem.text = [NSString stringWithFormat:@"%@%@ %@",self.custoPre, itemMagico.custo, self.custoSu];
    pesoItem.text =     itemMagico.peso;
    pvItem.text =       itemMagico.pv;
    danoItem.text =     itemMagico.dano;
    protecaoItem.text = itemMagico.protecao;
    nivelItem.text =    [NSString stringWithFormat:@"%@",itemMagico.nivel];
    descricaoItem.text = itemMagico.descricao;
    poderItem.text =    itemMagico.poder;
    raridadeItem.text = itemMagico.raridade.nome;
    tipoItem.text =     itemMagico.tipoItem.nome;
    
    imageTipo.image = [Util ImagemTipoItem:itemMagico.tipoItem.nome Estilo:estilo];
    
    [descricaoItem sizeToFit];
    [poderItem sizeToFit];
    
    if ([itemMagico.categoria.nome isEqualToString:@"Armas"]){
        danoLabel.hidden = false;
        danoItem.hidden = false;
        protecaoLabel.hidden = true;
        protecaoItem.hidden = true;
//        [self ajustaCampos:202];
        
    }
    else if ([itemMagico.categoria.nome isEqualToString:@"Proteção"]){
        danoLabel.hidden = true;
        danoItem.hidden = true;
        protecaoLabel.hidden = false;
        protecaoItem.hidden = false;
//        [self ajustaCampos:202];
        
    }
    else{
        danoLabel.hidden = true;
        danoItem.hidden = true;
        protecaoLabel.hidden = true;
        protecaoItem.hidden = true;
//        [self ajustaCampos:184];
  
    }
        
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 700)];
    //    [scroller setContentSize:CGSizeMake(320, (230 + descricaoItem.frame.size.height + poderItem.frame.size.height))];
        
//    custoLabel.font = fonte;
//    tipoLabel.font = fonte;
//    raridadeLabel.font = fonte;
//    pesoLabel.font = fonte;
//    pvLabel.font = fonte;
//    danoLabel.font = fonte;
//    protecaoLabel.font = fonte;
//    nivelLabel.font = fonte;
//    poderLaber.font = fonte;
//    
//    custoItem.font = fonte;
//    tipoItem.font = fonte;
//    raridadeItem.font = fonte;
//    pesoItem.font = fonte;
//    pvItem.font = fonte;
//    danoItem.font = fonte;
//    protecaoItem.font = fonte;
//    nivelItem.font = fonte;
    
//    nomeItem.font = [Util FonteTitulo:estilo];
    
    self.itemSalvo = NO;
    
   }

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.itemMagico = nil;
    fundoTela = nil;
    estilo=nil;
    custoPre=nil;
    custoSu=nil;
    tipoItem=nil;
}

- (void) viewWillDisappear:(BOOL)animated
{
    if ((!self.itemSalvo)&&(habilitaSalvar)) {
        [itemMagico.managedObjectContext deleteObject:itemMagico];
        
        NSError *error = nil;
        if (![itemMagico.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }	
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)ajustaCampos:(int)posicao{
    protecaoLabel.frame = CGRectMake(protecaoLabel.frame.origin.x, posicao, protecaoLabel.frame.size.width, protecaoLabel.frame.size.height);
    protecaoItem.frame = CGRectMake(protecaoItem.frame.origin.x, posicao, protecaoItem.frame.size.width, protecaoItem.frame.size.height);
    descricaoLabel.frame = CGRectMake(descricaoLabel.frame.origin.x, posicao+13, descricaoLabel.frame.size.width, descricaoLabel.frame.size.height);
    descricaoItem.frame = CGRectMake(descricaoItem.frame.origin.x,posicao+13, descricaoItem.frame.size.width, descricaoItem.frame.size.height);
    poderLaber.frame = CGRectMake(poderLaber.frame.origin.x, (descricaoItem.frame.origin.y + descricaoItem.frame.size.height), poderLaber.frame.size.width, poderLaber.frame.size.height);
    poderItem.frame = CGRectMake(poderItem.frame.origin.x,(poderLaber.frame.origin.y+10), poderItem.frame.size.width, poderItem.frame.size.height);

}

- (void) salvar{
    NSError *error = nil;
    if (![itemMagico.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    self.navigationItem.rightBarButtonItem.enabled =false;
    self.itemSalvo = YES;
}

@end
