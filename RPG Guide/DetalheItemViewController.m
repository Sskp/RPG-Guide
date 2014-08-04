//
//  DetalheItemViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 09/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetalheItemViewController.h"
#import "ItemComum.h"
#import "Raridade.h"
#import "Categoria.h"
#import "TipoItem.h"
#import "util.h"

@implementation DetalheItemViewController

@synthesize nomeItem;
@synthesize custoItem;
@synthesize raridadeItem;
@synthesize pesoItem;
@synthesize pvItem;
@synthesize danoItem;
@synthesize protecaoItem;
@synthesize descricaoItem;
@synthesize itemComum;
@synthesize imageTipo;
@synthesize fundoTela;
@synthesize estilo;
@synthesize custoSu;
@synthesize custoPre;
@synthesize tipoItem;

@synthesize imageView;


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void)viewDidAppear:(BOOL)animated{
    //self.estilo = [Util VerificaEstilo];
    [self viewDidLoad];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIFont *fonte = [Util FonteLabel:estilo];
    
    nomeItem.text = itemComum.nome;
    custoItem.text = [NSString stringWithFormat:@"%@%@ %@",self.custoPre, itemComum.custo, self.custoSu];
    pesoItem.text = itemComum.peso;
    pvItem.text = itemComum.pv;
    danoItem.text = itemComum.dano;
    protecaoItem.text = itemComum.protecao;
    imageTipo.image = [Util ImagemTipoItem:itemComum.tipoItem.nome Estilo:estilo];
    descricaoItem.text = itemComum.descricao;
    raridadeItem.text = itemComum.raridade.nome;
    tipoItem.text = itemComum.tipoItem.nome;
    
//    descricaoItem.opaque = NO;
//    descricaoItem.backgroundColor = [UIColor clearColor];
//
//    NSString *string = [itemComum.descricao stringByReplacingOccurrencesOfString:@"\n" withString:@"<br>"];
//
//    [descricaoItem loadHTMLString:[NSString stringWithFormat:@"<div align='justify' font size=1><font size='2' face='%@'>%@</font><div>",fonte.fontName,string] baseURL:nil];
    

    
    if ([itemComum.categoria.nome isEqualToString:@"Armas"]){
        danoLabel.hidden = false;
        danoItem.hidden = false;
        protecaoLabel.hidden = true;
        protecaoItem.hidden = true;
//        [self ajustaCampos:202];
        
    }
    else if ([itemComum.categoria.nome isEqualToString:@"Proteção"]){
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

    [descricaoItem sizeToFit];
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 500)];
//    [scroller setContentSize:CGSizeMake(320, (220 + descricaoItem.frame.size.height))];
    
    // Configura interface
    
    nomeItem.font = [Util FonteTitulo:estilo];
    
    raridadeLabel.font = fonte;
    custoLabel.font = fonte;
    pesoLabel.font = fonte;
    pvLabel.font = fonte;
    danoLabel.font = fonte;
    protecaoLabel.font = fonte;
    tipoLabel.font = fonte;
    
    raridadeItem.font = fonte;
    custoItem.font = fonte;
    pesoItem.font = fonte;
    pvItem.font = fonte;
    danoItem.font = fonte;
    protecaoItem.font = fonte;
    tipoItem.font = fonte;
    
    fundoTela.image = [Util ImagemFundo:estilo];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.itemComum = nil;
    fundoTela = nil;
    estilo=nil;
    custoPre=nil;
    custoSu=nil;
    tipoItem=nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)mostrarDescricao{
    NSLog(@"ok!");
}

- (void)ajustaCampos:(int)posicao{
    protecaoLabel.frame = CGRectMake(protecaoLabel.frame.origin.x, posicao, protecaoLabel.frame.size.width, protecaoLabel.frame.size.height);
    protecaoItem.frame = CGRectMake(protecaoItem.frame.origin.x, posicao, protecaoItem.frame.size.width, protecaoItem.frame.size.height);
    //descricaoLabel.frame = CGRectMake(descricaoLabel.frame.origin.x, posicao+13, descricaoLabel.frame.size.width, descricaoLabel.frame.size.height);
    descricaoItem.frame = CGRectMake(descricaoItem.frame.origin.x,posicao+13, descricaoItem.frame.size.width, descricaoItem.frame.size.height);
}

- (void)buttonTouched:(id)sender{
    
    //[imageView startAnimating];
}

@end
