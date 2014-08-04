//
//  AdicionarItemViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 04/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ItemAddDelegate;
@class ItemComum;
@class Categoria;

@interface AdicionarItemViewController : UIViewController <UITextViewDelegate>{
    
    IBOutlet    UITextField     *nomeTextField;
    IBOutlet    UITextField     *custoTextField;
    IBOutlet    UITextField     *pesoTextField;
    IBOutlet    UITextField     *danoTextField;
    IBOutlet    UITextField     *protecaoTextField;
    IBOutlet    UITextField     *pvTextField;
    IBOutlet    UITextView      *descricaoTextField;
    IBOutlet    UITableView     *tabela;
    IBOutlet    UIScrollView    *scroller;
    IBOutlet    UILabel         *danoLabel;
    IBOutlet    UILabel         *protecaoLabel;
    IBOutlet    UILabel         *descricaoLabel;
    IBOutlet    UIImageView     *imageview;
    IBOutlet    UIImageView     *fundoTela;
    IBOutlet    UIToolbar       *keyboardToolBar;

                BOOL editavel;
                NSString *estilo;
    
                Categoria *catAnterior;
                ItemComum *itemComum;
                id <ItemAddDelegate> delegate;

}

@property (nonatomic, retain) ItemComum *itemComum;
@property (nonatomic, retain) id <ItemAddDelegate> delegate;

@property (nonatomic, retain) UITextField * custoTextField;
@property (nonatomic, retain) UITextField * danoTextField;
@property (nonatomic, retain) UITextView * descricaoTextField;
@property (nonatomic, retain) UITextField * nomeTextField;
@property (nonatomic, retain) UITextField * pesoTextField;
@property (nonatomic, retain) UITextField * protecaoTextField;
@property (nonatomic, retain) UITextField * pvTextField;
@property (nonatomic, retain) IBOutlet UITableView *tabela;
@property (nonatomic, retain) IBOutlet UIScrollView *scroller;
@property (nonatomic, retain) IBOutlet UIView *groupView;

@property (nonatomic) BOOL editavel;

@property (nonatomic, retain) NSString *estilo;

@property (nonatomic, retain) Categoria *catAnterior;

@property (retain, nonatomic) IBOutlet UIToolbar *keyboardBar;
@property (retain, nonatomic) UIBarButtonItem *btnAnterior;
@property (retain, nonatomic) UIBarButtonItem *btnProximo;

- (void)resignKeyboard:(id)sender;
- (void)proximoCampo:(id)sender;
- (void)campoAnterior:(id)sender;
- (void)apresentaAlerta:(NSString *)mensagem;

- (void)save;
- (void)cancel;
- (void)ajustaCampos:(int) posicao;
- (BOOL)validaCampos;
- (IBAction)posicionarScroll:(id)sender;

@end


@protocol ItemAddDelegate <NSObject>
- (void)AdicionarItemViewController:(AdicionarItemViewController *) adicionarItem didAddItem:(ItemComum *)itemComum;
@end