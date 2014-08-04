//
//  DetalharPoderViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 21/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Poder;

@interface DetalharPoderViewController : UIViewController{

    UILabel *nomePoder;
    IBOutlet UILabel *nivelPoder;
    IBOutlet UILabel *nivelLabel;
    IBOutlet UILabel *categoriaLavel;
    IBOutlet UILabel *descricaoLabel;
    IBOutlet UITextView *descricaoPoder;
    IBOutlet UIImageView *fundoTela;
    IBOutlet UIScrollView *scroller;
    IBOutlet UITableView *tabela;
    
    NSString *estilo;
        
    Poder *poder;
}

@property (nonatomic, retain) IBOutlet UILabel *nomePoder;
@property (nonatomic, retain) IBOutlet UILabel *nivelPoder;
@property (nonatomic, retain) IBOutlet UITextView *descricaoPoder;
@property (nonatomic, retain) IBOutlet UIImageView *fundoTela;
@property (nonatomic, retain) NSString *estilo;
@property (nonatomic, retain) Poder *poder; 
@property (nonatomic, retain) IBOutlet UITableView *tabela;

@end

