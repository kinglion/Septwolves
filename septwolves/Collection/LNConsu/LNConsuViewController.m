//
//  LNConsuViewController.m
//  septwolves
//
//  Created by  Lion on 13-3-17.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNConsuViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define IMAGE_DIS_TOP_AND_BOTTOM 40.0f
#define IMAGE_DIS_LEFT_AND_RIGHT 20.0f
#define WIDTH_LIST 140.0f

@interface LNConsuViewController ()

@end

@implementation LNConsuViewController
@synthesize mainScrollView;
@synthesize listTableView;
@synthesize pageLabel;
@synthesize lists;
@synthesize mainView;

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
        [backImage release];
        
        UIImage* listImage = [UIImage imageNamed:@"right_item_bg.png"];
        CGRect listframe = CGRectMake(0, 0, 20, 18);
        UIButton *listButton = [[UIButton alloc]initWithFrame:listframe];
        [listButton setBackgroundImage:listImage forState:UIControlStateNormal];
        [listButton setTitle:@"" forState:UIControlStateNormal];
        listButton.titleLabel.font=[UIFont systemFontOfSize:13];
        [listButton addTarget:self action:@selector(doClickListAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:listButton];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        [rightBarButtonItem release];
        [listButton release];
        [listImage release];
    }
    return self;
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doClickListAction:(id)sender
{
    if (isListOpen) {
        [UIView animateWithDuration:1 animations:^{
            [self.listTableView setFrame:CGRectMake(WIDTH_SCREEN, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
        }];
        isListOpen = NO;
    }else{
        [UIView animateWithDuration:1 animations:^{
            [self.listTableView setFrame:CGRectMake(WIDTH_SCREEN - WIDTH_LIST, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
        }];
        isListOpen = YES;
    }
}

- (UIScrollView *)creatImageScroll:(NSMutableArray *)images
{
    int imagesCount = [images count];
    allPage = imagesCount;
    UIScrollView *tempScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT_SUB_BAR)];
    [tempScroll setContentSize:CGSizeMake(self.view.frame.size.width * imagesCount, HEIGHT_SUB_BAR)];
    [tempScroll setDelegate:self];
    [tempScroll setShowsHorizontalScrollIndicator:NO];
    int index = 0;
    [self updateLabelDisplay:1];
    for (NSString* url in images) {
        UIImageView *tempImageView = [[[UIImageView alloc]initWithFrame:CGRectMake(IMAGE_DIS_LEFT_AND_RIGHT + index *self.view.frame.size.width, IMAGE_DIS_TOP_AND_BOTTOM, self.view.frame.size.width - 2*IMAGE_DIS_LEFT_AND_RIGHT, HEIGHT_SUB_BAR - 2*IMAGE_DIS_TOP_AND_BOTTOM)] autorelease];
        [tempImageView setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if (error) {
                NSLog(@"some thing worry!must be happened");
            }
        }];
        [tempImageView setContentMode:UIViewContentModeScaleAspectFit];
        [tempScroll addSubview:tempImageView];
        index++;
    }
    [tempScroll setPagingEnabled:YES];
    return tempScroll;
}

- (UITableView*)creatListTableView:(NSMutableArray *)lists
{
    UITableView *tempTableView = [[UITableView alloc]initWithFrame:CGRectMake(WIDTH_SCREEN - WIDTH_LIST, 0, WIDTH_LIST, HEIGHT_SUB_BAR) style:UITableViewStylePlain];
    [UIView animateWithDuration:1 animations:^{
        [tempTableView setFrame:CGRectMake(WIDTH_SCREEN, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
    }];
    isListOpen = NO;
    [tempTableView setDataSource:self];
    [tempTableView setDelegate:self];
    return tempTableView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH_SCREEN, HEIGHT_SUB_BAR)];
    [self.view addSubview:tempView];
    self.mainView = tempView;
    [tempView release];
    NSMutableArray *images = [[NSMutableArray alloc]initWithObjects:@"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg",@"http://www.fzlol.com/upimg/allimg/130226/2132T93M4.jpg", nil];
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(IMAGE_DIS_LEFT_AND_RIGHT, HEIGHT_SUB_BAR - IMAGE_DIS_TOP_AND_BOTTOM, self.view.frame.size.width - 2*IMAGE_DIS_LEFT_AND_RIGHT, 20.0f)];
    tempLabel.text = [NSString stringWithFormat:@"%d / %d",1,[images count]];
    [tempLabel setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0]];
    [tempLabel setTextColor:[UIColor whiteColor]];
    [tempLabel setTextAlignment:NSTextAlignmentRight];
    self.pageLabel = tempLabel;
    self.mainScrollView = [self creatImageScroll:images];
    [self.mainView addSubview:self.mainScrollView];
    [self.view addSubview:tempLabel];
    [tempLabel release];
    NSMutableArray *templists = [[NSMutableArray alloc]initWithObjects:@"《周杰伦》",@"《蔡依林》", nil];
    self.lists = templists;
    self.listTableView = [self creatListTableView:templists];
    [self.view addSubview:self.listTableView];
    [templists release];
	// Do any additional setup after loading the view.
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = scrollView.bounds.size.width ;
    float fractionalPage = scrollView.contentOffset.x / pageWidth ;
	NSInteger nearestNumber = lround(fractionalPage) + 1;
	[self updateLabelDisplay:nearestNumber];
}

- (void)clear
{
    if(self.mainScrollView){
        [self.mainScrollView removeFromSuperview];
        self.mainScrollView = nil;
    }
}

- (void)updateLabelDisplay:(NSInteger)currentNum
{
    if(self.pageLabel)self.pageLabel.text = [NSString stringWithFormat:@"%d / %d",currentNum,allPage];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:1];
    self.listTableView.backgroundColor = altCellColor;
    cell.backgroundColor = altCellColor;
    altCellColor = [UIColor colorWithWhite:1 alpha:0];
    cell.textLabel.backgroundColor = altCellColor;
    [cell.textLabel setFont:[UIFont fontWithName:@"黑体" size:20]];
    [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    cell.detailTextLabel.backgroundColor = altCellColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    self.listTableView.separatorColor = [UIColor darkGrayColor];
    [self.listTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [lists count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simple"];
        cell.textLabel.text = lists[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中！");
    [self.listTableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableArray *images = [[NSMutableArray alloc]initWithObjects:@"http://www.fzlol.com/upimg/allimg/130226/2132T96443.jpg",@"http://www.fzlol.com/upimg/allimg/130226/2132T93M4.jpg", nil];
    [UIView animateWithDuration:1 animations:^{
        [self.listTableView setFrame:CGRectMake(WIDTH_SCREEN, 0, WIDTH_LIST, HEIGHT_SUB_BAR)];
    }];
    isListOpen = NO;
    [self clear];
    self.mainScrollView = [self creatImageScroll:images];
    [self.mainView  addSubview:self.mainScrollView];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
