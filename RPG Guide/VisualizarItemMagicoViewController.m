//
//  VisualizarItemMagicoViewController.m
//  RPG Guide
//
//  Created by Mateus Andrade on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "VisualizarItemMagicoViewController.h"
#import "DetalharItemMagicoViewController.h"

@implementation VisualizarItemMagicoViewController

@synthesize fetchedResults;
@synthesize index;
@synthesize kNumberOfPages;

@synthesize pageControl;
@synthesize scrollView;

@synthesize estilo;
@synthesize custoSu;
@synthesize custoPre;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];

    NSInteger pagina = index.row;
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResults sections] objectAtIndex:0];
    self.kNumberOfPages = [sectionInfo numberOfObjects];
    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * self.kNumberOfPages, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    pageControl.numberOfPages = self.kNumberOfPages;
    pageControl.currentPage = pagina;
    
    //
    // desenvolver controle dependendo da posição que for escolhida
    //
        
    [self loadScrollViewWithPage:(int)pagina];
    [self loadScrollViewWithPage:(int)(pagina + 1)];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//- (UIView *)view
//{
//    return self.scrollView;
//}

- (void) changeView:(id)sender{
    
//    int page = pageControl.currentPage;
//	
//    [self loadScrollViewWithPage:page - 1];
//    [self loadScrollViewWithPage:page];
//    [self loadScrollViewWithPage:page + 1];
//    
//    CGRect frame = scrollView.frame;
//    frame.origin.x = frame.size.width * page;
//    frame.origin.y = 0;
//    [scrollView scrollRectToVisible:frame animated:YES];
//    
//    pageControlUsed = YES;
}

- (void)loadScrollViewWithPage:(int)page{
    
    if (page < 0)
        return;
    if (page >= self.kNumberOfPages)
        return;
    
    // replace the placeholder if necessary
    //    MyViewController *controller = [viewControllers objectAtIndex:page];
    //    if ((NSNull *)controller == [NSNull null])
    //    {
    //        controller = [[MyViewController alloc] initWithPageNumber:page];
    //        [viewControllers replaceObjectAtIndex:page withObject:controller];
    //        [controller release];
    //    }
    
    // add the controller's view to the scroll view
    
    ItemMagico *itemMagico = (ItemMagico *)[fetchedResults objectAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0]];
    
    DetalharItemMagicoViewController *detailViewController = [DetalharItemMagicoViewController alloc];
    detailViewController.itemMagico = itemMagico;
    detailViewController.estilo = self.estilo;
    detailViewController.custoSu = self.custoSu;
    detailViewController.custoPre = self.custoPre;
    detailViewController.habilitaSalvar = NO;
    
    
    if (detailViewController.view.superview == nil)
    {
//        CGRect frame = scrollView.frame;
//        frame.origin.x = frame.size.width * page;
//        frame.origin.y = 0;
//        detailViewController.view.frame = frame;
        [self.scrollView addSubview:detailViewController.view];
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)sender{
    if (pageControlUsed)
    {
        return;
    }
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControlUsed = NO;
}


@end
