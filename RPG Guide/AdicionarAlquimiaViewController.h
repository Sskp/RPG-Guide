//
//  AdicionarAlquimiaViewController.h
//  DM Compendium
//
//  Created by Mateus Andrade on 19/09/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlquimiaAddDelegate;
@class Alquimia;

@interface AdicionarAlquimiaViewController : UIViewController <UITextViewDelegate>{

    Alquimia *alquimia;
    id <AlquimiaAddDelegate> delegate;

    IBOutlet    UITextField     *nomeTextField;
    IBOutlet    UITextField     *custoTextField;
    IBOutlet    UITextField     *duracaoTextField;
    IBOutlet    UITextField     *preparoTextField;
    IBOutlet    UITextView      *descricaoTextField;
    IBOutlet    UITableView     *tabela;
    IBOutlet    UIScrollView    *scroller;
    IBOutlet    UIImageView     *fundoTela;
    IBOutlet    UIToolbar       *keyboardToolBar;
                NSString        *estilo;

                BOOL            editavel;
    
    
}

    @property (nonatomic, retain) Alquimia *alquimia;
    @property (nonatomic, retain) id <AlquimiaAddDelegate> delegate;


    @property (nonatomic, retain) IBOutlet UITextField *nomeTextField;   
    @property (nonatomic, retain) IBOutlet UITextField *custoTextField;
    @property (nonatomic, retain) IBOutlet UITextField *duracaoTextField;
    @property (nonatomic, retain) IBOutlet UITextField *preparoTextField;
    @property (nonatomic, retain) IBOutlet UITextView *descricaoTextField;
    @property (nonatomic, retain) IBOutlet UITableView *tabela;
    @property (nonatomic, retain) IBOutlet UIImageView *fundoTela;
    @property (nonatomic, retain) IBOutlet UIScrollView *scroller;
    @property (nonatomic, retain) IBOutlet UIView *groupView;

    @property (nonatomic) BOOL editavel;

    @property (nonatomic, retain) NSString *estilo;

    @property (retain, nonatomic) IBOutlet UIToolbar *keyboardBar;
    @property (retain, nonatomic) UIBarButtonItem *btnAnterior;
    @property (retain, nonatomic) UIBarButtonItem *btnProximo;

- (void)resignKeyboard:(id)sender;
- (void)proximoCampo:(id)sender;
- (void)campoAnterior:(id)sender;
- (void)apresentaAlerta:(NSString *)mensagem;

- (void)save;
- (void)cancel;
- (BOOL)validaCampos;
- (IBAction)liberaTeclado:(id) sender;
- (IBAction)posicionarScroll:(id)sender;
   
@end


@protocol AlquimiaAddDelegate <NSObject>
- (void)AdicionarAlquimiaViewController:(AdicionarAlquimiaViewController *) adicionarAlquimia didAddAlquimia:(Alquimia *)alquimia;
@end