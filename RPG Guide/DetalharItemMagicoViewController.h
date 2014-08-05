//
//  DetalharItemMagicoViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 16/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemMagico;

@interface DetalharItemMagicoViewController : UIViewController{

    UILabel *nomeItem;
    IBOutlet UILabel *custoItem;
    IBOutlet UILabel *custoLabel;
    IBOutlet UILabel *tipoItem;
    IBOutlet UILabel *tipoLabel;
    IBOutlet UILabel *raridadeItem;
    IBOutlet UILabel *raridadeLabel;
    IBOutlet UILabel *pesoItem;
    IBOutlet UILabel *pesoLabel;
    IBOutlet UILabel *pvItem;
    IBOutlet UILabel *pvLabel;
    IBOutlet UILabel *danoItem;
    IBOutlet UILabel *danoLabel;
    IBOutlet UILabel *protecaoItem;
    IBOutlet UILabel *protecaoLabel;
    IBOutlet UILabel *nivelItem;
    IBOutlet UILabel *nivelLabel;
    IBOutlet UITextView *descricaoItem;
    IBOutlet UILabel *descricaoLabel;
    IBOutlet UITextView *poderItem;
    IBOutlet UILabel *poderLaber;
    IBOutlet UIImageView *imageTipo;
    IBOutlet UIImageView *fundoTela;
    IBOutlet UIScrollView *scroller;

    NSString *estilo;
    NSString *custoSu;
    NSString *custoPre;
    
    BOOL habilitaSalvar;
    BOOL itemSalvo;

    UIImageView *imageView;

    ItemMagico *itemMagico;
}

@property (nonatomic, retain) IBOutlet UILabel *nomeItem;
@property (nonatomic, retain) IBOutlet UILabel *custoItem;
@property (nonatomic, retain) IBOutlet UILabel *raridadeItem;
@property (nonatomic, retain) IBOutlet UILabel *pesoItem;
@property (nonatomic, retain) IBOutlet UILabel *pvItem;
@property (nonatomic, retain) IBOutlet UILabel *danoItem;
@property (nonatomic, retain) IBOutlet UILabel *protecaoItem;
@property (nonatomic, retain) IBOutlet UILabel *nivelItem;
@property (nonatomic, retain) IBOutlet UITextView *descricaoItem;
@property (nonatomic, retain) IBOutlet UITextView *poderItem;
@property (nonatomic, retain) IBOutlet UIImageView *imageTipo;
@property (nonatomic, retain) IBOutlet UIImageView *fundoTela;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UILabel *tipoItem;
@property (nonatomic, retain) IBOutlet UIScrollView *scroller;

@property (nonatomic, retain) NSString *estilo;
@property (nonatomic, retain) NSString *custoSu;
@property (nonatomic, retain) NSString *custoPre;

@property (nonatomic) BOOL habilitaSalvar;
@property (nonatomic) BOOL itemSalvo;

@property (nonatomic, retain) ItemMagico *itemMagico;

- (void)ajustaCampos:(int) posicao;
- (void)salvar;

@end
