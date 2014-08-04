//
//  DetalheAlquimiaViewController.h
//  DM Compendium
//
//  Created by Mateus Andrade on 06/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Alquimia;

@interface DetalheAlquimiaViewController : UIViewController{
    IBOutlet    UILabel     *nomeAlquimia;
    IBOutlet    UILabel     *custoAlquimia;
    IBOutlet    UILabel     *raridadeAlquimia;
    IBOutlet    UILabel     *duracaoAlquimia;
    IBOutlet    UILabel     *preparoAlquimia;
    IBOutlet    UITextView  *descricaoAlquimia;
    
    IBOutlet    UILabel     *labelCustoAlquimia;
    IBOutlet    UILabel     *labelRaridadeALquimia;
    IBOutlet    UILabel     *labelDuracaoAlquimia;
    IBOutlet    UILabel     *labelPreparoAlquimia;
    
    IBOutlet    UIImageView *imageTipo;
    IBOutlet    UIImageView *fundoTela;
    IBOutlet    UIScrollView *scroller;
    
                NSString    *estilo;
                NSString    *custoSu;
                NSString    *custoPre;
    
                UIImageView *imageView;
    
                Alquimia    *alquimia;
}

@property (nonatomic, retain) IBOutlet UILabel *nomeAlquimia;
@property (nonatomic, retain) IBOutlet UILabel *custoAlquimia;
@property (nonatomic, retain) IBOutlet UILabel *raridadeAlquimia;
@property (nonatomic, retain) IBOutlet UILabel *duracaoAlquimia;
@property (nonatomic, retain) IBOutlet UILabel *preparoAlquimia;
@property (nonatomic, retain) IBOutlet UITextView *descricaoAlquimia;

@property (nonatomic, retain) IBOutlet UILabel *labelCustoAlquimia;
@property (nonatomic, retain) IBOutlet UILabel *labelRaridadeALquimia;
@property (nonatomic, retain) IBOutlet UILabel *labelDuracaoAlquimia;
@property (nonatomic, retain) IBOutlet UILabel *labelPreparoAlquimia;

@property (nonatomic, retain) IBOutlet UIImageView *imageTipo;
@property (nonatomic, retain) IBOutlet UIImageView *fundoTela;
@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic, retain) NSString *estilo;
@property (nonatomic, retain) NSString *custoSu;
@property (nonatomic, retain) NSString *custoPre;


@property (nonatomic, retain) Alquimia *alquimia; 

@end
