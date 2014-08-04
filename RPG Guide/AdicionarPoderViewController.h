//
//  AdicionarPoderViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PoderAddDelegate;
@class Poder;

@interface AdicionarPoderViewController : UIViewController <UITextViewDelegate>{

    Poder *poder;
    id <PoderAddDelegate> delegate;
    
    IBOutlet    UITextField     *nomeTextField;
    IBOutlet    UITextField     *nivelTextField;
    IBOutlet    UITextView      *descricaoTextField;
    IBOutlet    UITableView     *tabela;
    IBOutlet    UIScrollView    *scroller;
    IBOutlet    UIImageView     *fundoTela;
    IBOutlet    UIToolbar       *keyboardToolBar;
    
                BOOL editavel;
    
                NSString *estilo;
}

@property (nonatomic, retain) Poder *poder;
@property (nonatomic, retain) id <PoderAddDelegate> delegate;


@property (nonatomic, retain) IBOutlet UITextField *nomeTextField;   
@property (nonatomic, retain) IBOutlet UITextField *nivelTextField;
@property (nonatomic, retain) IBOutlet UITextView *descricaoTextField;
@property (nonatomic, retain) IBOutlet UITableView *tabela;
@property (nonatomic, retain) IBOutlet UIImageView *fundoTela;
@property (nonatomic, retain) IBOutlet UIView *groupView;

@property (retain, nonatomic) IBOutlet UIToolbar *keyboardBar;
@property (retain, nonatomic) UIBarButtonItem *btnAnterior;
@property (retain, nonatomic) UIBarButtonItem *btnProximo;

@property (nonatomic) BOOL editavel;

@property (nonatomic, retain) NSString *estilo;

- (void)resignKeyboard:(id)sender;
- (void)proximoCampo:(id)sender;
- (void)campoAnterior:(id)sender;
- (void)apresentaAlerta:(NSString *)mensagem;

- (void)save;
- (void)cancel;
- (BOOL)validaCampos;
- (IBAction)posicionarScroll:(id)sender;

@end


@protocol PoderAddDelegate <NSObject>
- (void)AdicionarPoderViewController:(AdicionarPoderViewController *) adicionarPoder didAddPoder:(Poder *)poder;
@end