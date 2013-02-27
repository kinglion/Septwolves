//
//  ChrConsuViewController.m
//  septwolves
//
//  Created by 小才 on 13-2-26.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//  名士资讯

#import "ChrConsuViewController.h"
#import "JSONKit.h"
#import "ChrConsuView.h"
#import "detailViewController.h"

#define LISTHEIGHT 200.0f
#define LISTDIS 10.0f
#define TOPBARHEIGHT 44.0f

@interface ChrConsuViewController ()

@end

@implementation ChrConsuViewController
@synthesize scrollView = _scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self.view setBackgroundColor:[UIColor blackColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    str = @"{\"list\":[{\"id\":123,\"name\":\"《周杰伦》\", \"imgArr\":[\"http://img1.cache.cdqss.com/images/ent/content/attachement/jpg/site2/20100412/00173152bd7b0d2c430425.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T91491.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95612.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T93M4.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T963K.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95D6.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tb1C.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96048.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T921E.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T954410.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tca11.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132U012312.jpg\"]},{\"id\":123,\"name\":\"《王力宏》\",\"imgArr\":[\"http://i2.sinaimg.cn/book/2010/0430/2010430181756.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T91491.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95612.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T93M4.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T963K.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95D6.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tb1C.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96048.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T921E.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T954410.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tca11.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132U012312.jpg\"]},{\"id\":123,\"name\":\"《蔡依林》\",\"imgArr\":[\"http://images.rednet.cn/articleimage/2010/08/24/1529361601.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T91491.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95612.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T93M4.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T963K.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T95D6.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tb1C.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T96048.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T921E.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132T954410.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132Tca11.jpg\",\"http://www.fzlol.com/upimg/allimg/130226/2132U012312.jpg\"]}]}";
    NSDictionary *data = [str objectFromJSONString];
    array = [NSMutableArray arrayWithArray:[data objectForKey:@"list"]];
    NSLog(@"%@",data);
    _scrollView = [self creatTable];
    int arrCount = [array count];
    if (arrCount > 0) {
        [self creatList:_scrollView];
    }
    if (_refreshHeaderView == nil) {
		NSLog(@"scrollView.bounds.size.height:%f",self.scrollView.bounds.size.height);
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.scrollView.bounds.size.height, self.view.frame.size.width, self.scrollView.bounds.size.height)];
		view.delegate = self;
		[self.scrollView addSubview:view];
		_refreshHeaderView = view;
        [view release];
	}
    [self.view addSubview:_scrollView];
    [self updateScrollView:_scrollView];
    [_scrollView release];
    [_refreshHeaderView refreshLastUpdatedDate];
	// Do any additional setup after loading the view.
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
    NSMutableArray *imageArr;
    for (NSInteger i = 0; i<arrCount; i++) {
        imageArr = [NSMutableArray arrayWithArray:[[array objectAtIndex:i] objectForKey:@"imgArr"]];
        ChrConsuView *cview = [[ChrConsuView alloc]initWithFrame:CGRectMake(0.0f, i * (LISTHEIGHT + LISTDIS), self.view.frame.size.width, LISTHEIGHT) imageArr:imageArr title:[[array objectAtIndex:i] objectForKey:@"name"]];
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

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//实现cViewController的触碰
- (void)touchEvent:(ChrConsuView *)view
{
    detailViewController *viewController = [[detailViewController alloc]initWithNibName:@"detailViewController" bundle:nil];
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
