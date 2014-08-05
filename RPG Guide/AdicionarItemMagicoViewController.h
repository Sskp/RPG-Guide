//
//  AdicionarItemMagicoViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 16/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelecionaPoderViewController.h"

@protocol ItemMagicoAddDelegate;

@class ItemMagico;
@class ItemComum;
@class Categoria;

@interface AdicionarItemMagicoViewController : UIViewController<UITextViewDelegate, poderDelegate>{
        
    ItemMagico *itemMagico;
    ItemComum *itemComum;
    id <ItemMagicoAddDelegate> delegate;
    
    IBOutlet    UITextField     *nomeTextField;
    IBOutlet    UITextField     *custoTextField;
    IBOutlet    UITextField     *pesoTextField;
    IBOutlet    UITextField     *danoTextField;
    IBOutlet    UITextField     *protecaoTextField;
    IBOutlet    UITextField     *pvTextField;
    IBOutlet    UITextField     *nivelTextField;
    IBOutlet    UITextView      *descricaoTextField;
    IBOutlet    UITextView      *poderTextField;
    IBOutlet    UITableView     *tabela;
    IBOutlet    UIScrollView    *scroller;
    IBOutlet    UILabel         *danoLabel;
    IBOutlet    UILabel         *protecaoLabel;
    IBOutlet    UILabel         *descricaoLabel;
    IBOutlet    UILabel         *poderLabel;
    IBOutlet    UIImageView     *imageview;
    IBOutlet    UIImageView     *imageViewPoder;
    IBOutlet    UIImageView     *fundoTela;
    IBOutlet    UIToolbar       *keyboardToolBar;
    IBOutlet    UIButton        *btnPoder;
    
    BOOL editavel;
    
    NSManagedObjectContext *managedObjectContext;
    NSFetchedResultsController  *fetchedResultsController;
    
    NSString *estilo;
    NSString *textoPoderes;
    
    Categoria *catAnterior;
    
}

@property (nonatomic, retain) ItemMagico *itemMagico;
@property (nonatomic, retain) ItemComum *itemComum;

@property (nonatomic, retain) id <ItemMagicoAddDelegate> delegate;

@property (nonatomic, retain) UITextField * custoTextField;
@property (nonatomic, retain) UITextField * danoTextField;
@property (nonatomic, retain) UITextView * descricaoTextField;
@property (nonatomic, retain) UITextView * poderTextField;
@property (nonatomic, retain) UITextField * nomeTextField;
@property (nonatomic, retain) UITextField * pesoTextField;
@property (nonatomic, retain) UITextField * protecaoTextField;
@property (nonatomic, retain) UITextField * pvTextField;
@property (nonatomic, retain) UITextField * nivelTextField;
@property (nonatomic, retain) IBOutlet UITableView *tabela;
@property (nonatomic, retain) IBOutlet UIScrollView *scroller;
@property (nonatomic, retain) IBOutlet UIView *groupView;

@property (nonatomic) BOOL editavel;

@property (nonatomic, retain) NSString *estilo;
@property (nonatomic, retain) NSString *textoPoderes;

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController  *fetchedResultsController;

@property (nonatomic, retain) Categoria *catAnterior;

@property (retain, nonatomic) IBOutlet UIToolbar *keyboardBar;
@property (retain, nonatomic) UIBarButtonItem *btnAnterior;
@property (retain, nonatomic) UIBarButtonItem *btnProximo;

- (void)save;
- (void)cancel;
- (void)ajustaCampos:(int) posicao;
- (BOOL)validaCampos;
- (IBAction)posicionarScroll:(id)sender;
- (IBAction)selecionaPoder:(id)sender;

- (void)resignKeyboard:(id)sender;
- (void)proximoCampo:(id)sender;
- (void)campoAnterior:(id)sender;
- (void)apresentaAlerta:(NSString *)mensagem;

@end

@protocol ItemMagicoAddDelegate <NSObject>
- (void)AdicionarItemMagicoViewController:(AdicionarItemMagicoViewController *) adicionarItem didAddItem:(ItemMagico *)itemMagico;
@end