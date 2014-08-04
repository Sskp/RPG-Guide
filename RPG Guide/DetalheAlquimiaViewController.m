//
//  DetalheAlquimiaViewController.m
//  DM Compendium
//
//  Created by Mateus Andrade on 06/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DetalheAlquimiaViewController.h"
#import "Alquimia.h"
#import "Raridade.h"
#import "TipoAlquimia.h"
#import "util.h"

@implementation DetalheAlquimiaViewController

@synthesize nomeAlquimia;
@synthesize custoAlquimia;
@synthesize raridadeAlquimia;
@synthesize duracaoAlquimia;
@synthesize preparoAlquimia;
@synthesize descricaoAlquimia;

@synthesize labelCustoAlquimia;
@synthesize labelRaridadeALquimia;
@synthesize labelDuracaoAlquimia;
@synthesize labelPreparoAlquimia;

@synthesize alquimia;
@synthesize imageTipo;
@synthesize fundoTela;
@synthesize estilo;
@synthesize custoSu;
@synthesize custoPre;

@synthesize imageView;



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

-(void)viewDidAppear:(BOOL)animated{
//    [self viewDidLoad];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    UIFont *fonte = [Util FonteLabel:estilo];

    nomeAlquimia.text = alquimia.nome;
    custoAlquimia.text = [NSString stringWithFormat:@"%@%@ %@",self.custoPre, alquimia.custo, self.custoSu];
    duracaoAlquimia.text = alquimia.duracao;
    preparoAlquimia.text = alquimia.preparo;
    descricaoAlquimia.text = alquimia.descricao;
    
    [descricaoAlquimia sizeToFit];

    Raridade *raridade = alquimia.raridade;
    raridadeAlquimia.text = raridade.nome;
    
    imageTipo.image = [Util ImagemTipoAlquimia:alquimia.tipo.nome Estilo:estilo];
    
    
//    [scroller setScrollEnabled:YES];
//    [scroller setContentSize:CGSizeMake(320, (215 + descricaoAlquimia.frame.size.height))];
    
// Configura a interface    
    
//    fundoTela.image = [Util ImagemFundo:estilo];
//    
//    nomeAlquimia.font = [Util FonteTitulo:estilo];
//    custoAlquimia.font = fonte;
//    raridadeALquimia.font = fonte;
//    duracaoAlquimia.font = fonte;
//    preparoAlquimia.font = fonte;
//    labelCustoAlquimia.font = fonte;
//    labelRaridadeALquimia.font = fonte;
//    labelDuracaoAlquimia.font = fonte;
//    labelPreparoAlquimia.font = fonte;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.alquimia = nil;
    fundoTela = nil;
    
    estilo=nil;
    custoPre=nil;
    custoSu=nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)buttonTouched:(id)sender{

    //[imageView startAnimating];
}

@end
