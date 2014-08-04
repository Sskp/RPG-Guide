//
//  DetalheItemViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 09/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemComum;

@interface DetalheItemViewController : UIViewController{
    
    IBOutlet UILabel *nomeItem;
    IBOutlet UILabel *custoItem;
    IBOutlet UILabel *raridadeItem;
    IBOutlet UILabel *pesoItem;
    IBOutlet UILabel *pvItem;
    IBOutlet UILabel *danoItem;
    IBOutlet UILabel *protecaoItem;
    IBOutlet UILabel *tipoItem;

    
    IBOutlet UILabel *raridadeLabel;
    IBOutlet UILabel *custoLabel;
    IBOutlet UILabel *pesoLabel;
    IBOutlet UILabel *pvLabel;
    IBOutlet UILabel *danoLabel;
    IBOutlet UILabel *protecaoLabel;
    IBOutlet UILabel *tipoLabel;
    IBOutlet UITextView *descricaoItem;

    IBOutlet UIImageView *imageTipo;
    IBOutlet UIImageView *fundoTela;
    IBOutlet UIScrollView *scroller;
    
    NSString *estilo;
    NSString *custoSu;
    NSString *custoPre;
    
    UIImageView *imageView;
    
    ItemComum *itemComum;
}

@property (nonatomic, retain) IBOutlet UILabel *nomeItem;
@property (nonatomic, retain) IBOutlet UILabel *custoItem;
@property (nonatomic, retain) IBOutlet UILabel *raridadeItem;
@property (nonatomic, retain) IBOutlet UILabel *pesoItem;
@property (nonatomic, retain) IBOutlet UILabel *pvItem;
@property (nonatomic, retain) IBOutlet UILabel *danoItem;
@property (nonatomic, retain) IBOutlet UILabel *protecaoItem;
@property (nonatomic, retain) IBOutlet UITextView *descricaoItem;

@property (nonatomic, retain) IBOutlet UIImageView *imageTipo;
@property (nonatomic, retain) IBOutlet UIImageView *fundoTela;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *tipoItem;

@property (nonatomic, retain) NSString *estilo;
@property (nonatomic, retain) NSString *custoSu;
@property (nonatomic, retain) NSString *custoPre;


@property (nonatomic, retain) ItemComum *itemComum;

- (IBAction) mostrarDescricao;
- (void)ajustaCampos:(int) posicao;


@end
