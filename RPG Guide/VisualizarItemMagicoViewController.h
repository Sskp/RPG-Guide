//
//  VisualizarItemMagicoViewController.h
//  RPG Guide
//
//  Created by Mateus Andrade on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisualizarItemMagicoViewController : UIViewController<UIScrollViewDelegate>{
    
    NSFetchedResultsController *fetchedResults;
    NSIndexPath *index;
    NSInteger kNumberOfPage;
    
    BOOL pageControlUsed;
    
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIScrollView *scrollView;
    
    NSString *estilo;
    NSString *custoSu;
    NSString *custoPre;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResults;
@property (nonatomic, retain) NSIndexPath *index;
@property (nonatomic, retain) IBOutlet UIPageControl *pageControl;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic) NSInteger kNumberOfPages;

@property (nonatomic, retain) NSString *estilo;
@property (nonatomic, retain) NSString *custoSu;
@property (nonatomic, retain) NSString *custoPre;

- (IBAction)changeView:(id)sender;
- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

@end
