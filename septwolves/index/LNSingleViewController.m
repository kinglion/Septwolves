//
//  LNSingleViewController.m
//  septwolves
//
//  Created by  Lion on 13-1-6.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNSingleViewController.h"
#import "FPPopoverController.h"
#import "JSONKit.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LNSingleViewController ()

@property (nonatomic,assign) UIButton *tarBtn;

@end

@implementation LNSingleViewController
@synthesize tarBtn;
@synthesize pageControl;
@synthesize scrollView = _scrollView;
@synthesize array = _array;
@synthesize currentNum;
@synthesize type_id;
@synthesize indicatorView;
@synthesize bean;
- (id)init:(NSInteger)typeid
{
    self = [super init];
    if (self) {
        NSLog(@"我先运行");
        self.type_id = typeid;
        currentNum = 0;
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
        [_scrollView setUserInteractionEnabled:YES];
        [_scrollView setPagingEnabled:YES];
        [_scrollView setDelegate:self];
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [self.view addSubview:_scrollView];
        
        // Custom initialization
        //addSubView UIpageControl
        pageControl = [[UIPageControl alloc]init];
        [pageControl setCurrentPage:0];
        [pageControl setCenter:CGPointMake(self.view.center.x, self.view.frame.size.height - 40.0f)];
        [self.view addSubview:pageControl];
        LNActivityIndicatorView *tempIndicatorView = [[LNActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SCREEN)];
        [self.view addSubview:tempIndicatorView];
        self.indicatorView = tempIndicatorView;
        NSLog(@"%d",self.type_id);
        if (self.type_id) {
            self.bean = [LNconst httpRequestCharacterMenu:self.indicatorView action:[NSString stringWithFormat:@"%d",type_id]];
            int arrCount = [bean.list count];
            [pageControl setNumberOfPages:arrCount + 1];
            [pageControl setFrame:CGRectMake((self.view.frame.size.width - pageControl.frame.size.width)*0.5,self.view.frame.size.height - 30.0f,16*(arrCount-1)+16,16)];
            [pageControl setBounds:CGRectMake(0,0,16*(arrCount-1)+16,16)]; //页面控件上的圆点间距基本在16左右。
            [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width * (arrCount + 1), self.view.frame.size.height)];
            UIImageView *indexIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT_SCREEN)];
            [indexIV setImageWithURL:[NSURL URLWithString:bean.index]];
            [indexIV setContentMode:UIViewContentModeScaleAspectFit];
            [_scrollView addSubview:indexIV];
            for (int i = 0; i < arrCount; i++) {
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width * (i+1), 0, self.view.frame.size.width, HEIGHT_SCREEN)];
                CharacterBean *item = [self.bean.list objectAtIndex:i];
                [imageView setImageWithURL:[NSURL URLWithString:item.imgUrl]];
                [imageView setContentMode:UIViewContentModeScaleAspectFit];
                [_scrollView addSubview:imageView];
                [imageView setUserInteractionEnabled:YES];
                //生成触摸点
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setImage:[UIImage imageNamed:@"03.png"] forState:UIControlStateNormal];
                [button setFrame:CGRectMake(self.view.frame.size.width - 74,10, 64, 64)];
                [button addTarget:self action:@selector(onClickPop:) forControlEvents:UIControlEventTouchUpInside];
                [imageView addSubview:button];
                [imageView release];
            }
            
        }
        [tempIndicatorView release];
        [_scrollView release];

    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"西装服饰";
        [self.view setBackgroundColor:[UIColor blackColor]];
        //navigationBarItem
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


- (void)onClickPop:(id)sender
{
    NSLog(@"点击");
    SBTableAlert *alert	= [[SBTableAlert alloc] initWithTitle:nil cancelButtonTitle:@"取消" messageFormat:nil];
    [alert setType:SBTableAlertTypeMultipleSelct];
    [alert setStyle:SBTableAlertStyleApple];
    [alert.view addButtonWithTitle:@"购买"];
    [alert setDelegate:self];
	[alert setDataSource:self];
	[alert show];
    [alert release];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)scrollViewDidScroll:(UIScrollView *)ascrollView
{
	CGFloat pageWidth = ascrollView.bounds.size.width ;
    float fractionalPage = ascrollView.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) ;
	
	if (pageControl.currentPage != nearestNumber)
	{
		pageControl.currentPage = nearestNumber;
		self.currentNum = nearestNumber - 1;
		// if we are dragging, we want to update the page control directly during the drag
		if (ascrollView.dragging)
			[pageControl updateCurrentPageDisplay] ;
	}
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
	// if we are animating (triggered by clicking on the page control), we update the page control
	[pageControl updateCurrentPageDisplay] ;
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SBTableAlertDelegate

- (void)tableAlert:(SBTableAlert *)tableAlert didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (tableAlert.type == SBTableAlertTypeMultipleSelct) {
		UITableViewCell *cell = [tableAlert.tableView cellForRowAtIndexPath:indexPath];
		if (cell.accessoryType == UITableViewCellAccessoryNone)
			[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
		else
			[cell setAccessoryType:UITableViewCellAccessoryNone];
		
		[tableAlert.tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

- (void)tableAlert:(SBTableAlert *)tableAlert didDismissWithButtonIndex:(NSInteger)buttonIndex {
	NSLog(@"Dismissed: %i", buttonIndex);
	
	[tableAlert release];
}

#pragma mark - SBTableAlertDataSource

- (UITableViewCell *)tableAlert:(SBTableAlert *)tableAlert cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell;
	
	if (tableAlert.view.tag == 0 || tableAlert.view.tag == 1) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil] autorelease];
        CharacterBean *item = [[[self.bean.list objectAtIndex:currentNum] itemInfo]objectAtIndex:indexPath.row];
        [cell.textLabel setText:item.name];
        [cell.detailTextLabel setText:item.num];
	} else {
		// Note: SBTableAlertCell
		cell = [[[SBTableAlertCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil] autorelease];
        CharacterBean *item = [[[self.bean.list objectAtIndex:currentNum] itemInfo]objectAtIndex:indexPath.row];
        [cell.textLabel setText:item.name];
        [cell.detailTextLabel setText:item.num];
	}
	
	return cell;
}

- (NSInteger)tableAlert:(SBTableAlert *)tableAlert numberOfRowsInSection:(NSInteger)section {
	if (tableAlert.type == SBTableAlertTypeSingleSelect)
		return 3;
	else
		return [[[self.bean.list objectAtIndex:currentNum] itemInfo] count];
}

- (NSInteger)numberOfSectionsInTableAlert:(SBTableAlert *)tableAlert {
	if (tableAlert.view.tag == 3)
		return 2;
	else
		return 1;
}

- (NSString *)tableAlert:(SBTableAlert *)tableAlert titleForHeaderInSection:(NSInteger)section {
	if (tableAlert.view.tag == 3)
		return [NSString stringWithFormat:@"Section Header %d", section];
	else
		return nil;
}



@end
