//
//  ChrConsuViewController.m
//  septwolves
//
//  Created by 小才 on 13-2-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//  名士资讯

#import "ChrConsuViewController.h"
#import "ChrConsuView.h"
#import "LNConsuViewController.h"

#define LISTHEIGHT 200.0f
#define LISTDIS 10.0f
#define TOPBARHEIGHT 44.0f

@interface ChrConsuViewController ()

@end

@implementation ChrConsuViewController
@synthesize scrollView = _scrollView;
@synthesize indicatorView;
@synthesize bean;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor blackColor]];
        UIImage* backImage = [UIImage imageNamed:@"backButton.png"];
        CGRect backframe = CGRectMake(0,0,30,19);
        UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
        [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
        [backButton setTitle:@"" forState:UIControlStateNormal];
        backButton.titleLabel.font=[UIFont systemFontOfSize:13];
        [backButton addTarget:self action:@selector(doClickBackAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        [leftBarButtonItem release];
        [backButton release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    LNActivityIndicatorView *tempIndicatorView = [[LNActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
    _scrollView = [self creatTable];
    [self.view addSubview:_scrollView];
    [self.view addSubview:tempIndicatorView];
    self.indicatorView = tempIndicatorView;
    self.bean = [LNconst httpRequestChrList:self.indicatorView];
    array = [NSMutableArray arrayWithArray:self.bean.list];
    [tempIndicatorView release];
    
    int arrCount = [array count];
    if (arrCount > 0) {
        [self creatList:_scrollView];
    }
    
    if (_refreshHeaderView == nil) {
		NSLog(@"scrollView.bounds.size.height:%f",self.scrollView.bounds.size.height);
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc]initWithFrame:CGRectMake(0.0f, -self.scrollView.bounds.size.height, self.view.frame.size.width, self.scrollView.bounds.size.height)];
		view.delegate = self;
		[self.scrollView addSubview:view];
		_refreshHeaderView = view;
        //[view release];
	}
    if (_refreshFooterView == nil) {
        LoadMoreTableFooterView *footview = [[LoadMoreTableFooterView alloc]initWithFrame:CGRectMake(0.0f, self.scrollView.bounds.size.height, self.view.frame.size.width, self.scrollView.bounds.size.height)];
        footview.delegate = self;
        [self.scrollView addSubview:footview];
        _refreshFooterView = footview;
        //[footview release];
    }
    [self updateScrollView:_scrollView];
	[_scrollView release];
    [_refreshHeaderView refreshLastUpdatedDate];
	// Do any additional setup after loading the view.
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGFloat visibleTableDiffBoundsHeight = (self.scrollView.bounds.size.height - MIN(self.scrollView.bounds.size.height, self.scrollView.contentSize.height));
    
    CGRect loadMoreFrame = _refreshFooterView.frame;
    loadMoreFrame.origin.y = self.scrollView.contentSize.height + visibleTableDiffBoundsHeight;
    _refreshFooterView.frame = loadMoreFrame;
}

//创建外围scrollView
-(UIScrollView*)creatTable
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scrollView setDelegate:self];
    scrollView.showsVerticalScrollIndicator = NO;
    return scrollView;
}



//加载列表
-(void)creatList:(UIView*)view
{
    int arrCount = [array count];
    for (NSInteger i = 0; i<arrCount; i++) {
        ChrConsuView *cview = [[ChrConsuView alloc]initWithFrame:CGRectMake(0.0f, i * (LISTHEIGHT + LISTDIS), self.view.frame.size.width, LISTHEIGHT) imageUrl:[[array objectAtIndex:i] imgUrl] title:[[array objectAtIndex:i] title]];
        [cview setDelegate:self];
        [view addSubview:cview];
        [cview release];
    }
}

//更新scrollview的contentsize
-(void)updateScrollView:(UIScrollView*)scrollView
{
    int arrCount = [array count];
    [scrollView setContentSize:CGSizeMake(self.view.frame.size.width, arrCount * (LISTHEIGHT + LISTDIS)+TOPBARHEIGHT)];
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Status Propreties

@synthesize pullTableIsRefreshing;
@synthesize pullTableIsLoadingMore;

- (void)setPullTableIsRefreshing:(BOOL)isRefreshing
{
    if(!pullTableIsRefreshing && isRefreshing) {
        // If not allready refreshing start refreshing
        [_refreshHeaderView startAnimatingWithScrollView:self.scrollView];
        pullTableIsRefreshing = YES;
    } else if(pullTableIsRefreshing && !isRefreshing) {
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
        pullTableIsRefreshing = NO;
    }
}

- (void)setPullTableIsLoadingMore:(BOOL)isLoadingMore
{
    if(!pullTableIsLoadingMore && isLoadingMore) {
        // If not allready loading more start refreshing
        [_refreshFooterView startAnimatingWithScrollView:self.scrollView];
        pullTableIsLoadingMore = YES;
    } else if(pullTableIsLoadingMore && !isLoadingMore) {
        [_refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
        pullTableIsLoadingMore = NO;
    }
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	pullTableIsRefreshing = YES;
	[_refreshFooterView egoRefreshScrollViewDidScroll:self.scrollView];
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	pullTableIsRefreshing = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	[_refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return pullTableIsRefreshing; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

#pragma mark - LoadMoreTableViewDelegate

- (void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTableFooterView *)view
{
    pullTableIsLoadingMore = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现cViewController的触碰
- (void)touchEvent:(ChrConsuView *)view
{
    LNConsuViewController *viewController = [[LNConsuViewController alloc]init:[[self.bean.list objectAtIndex:view.tag] _id] beanList:self.bean];
    NSLog(@"xxxxxx:%d",[[self.bean.list objectAtIndex:view.tag] _id]);
    [viewController setTitle:view.label.text];
    [self.navigationController pushViewController:viewController animated:YES];
    [view setAlpha:1.0f];
    [viewController release];
    NSLog(@"%@",@"sss");
}

- (void)dealloc
{
    [super dealloc];
}

@end
