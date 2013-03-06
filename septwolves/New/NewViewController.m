//
//  NewViewController.m
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import "NewViewController.h"
#import "mainViewController.h"

@interface NewViewController ()
//读取储存在本地的日常管理数据
- (NSArray *)loadLocalData;
//加载日常管理界面
- (void)addSubDataView;
//加载穿搭管理界面
- (void)addSubOutfitView;
//清空界面
- (void)clearView;
@end

@implementation NewViewController
@synthesize dataView,outfitView;
@synthesize calendarView;
@synthesize dataTableView,outfitTableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"品格着装顾问";
        UIImage* backImage = [UIImage imageNamed:@"backButton.png"];
        CGRect backframe = CGRectMake(0,0,30,19);
        UIButton* backButton= [[UIButton alloc] initWithFrame:backframe];
        [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
        [backButton setTitle:@"" forState:UIControlStateNormal];
        backButton.titleLabel.font=[UIFont systemFontOfSize:13];
        [backButton addTarget:self action:@selector(doClickBackAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = leftBarButtonItem;
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"日常管理",@"穿搭管理", nil]];
        [segmentedControl setFrame:CGRectMake(0, 0, 120, 35)];
        self.navigationItem.titleView = segmentedControl;
        segmentedControl.selectedSegmentIndex = 0;
        [segmentedControl addTarget:self action:@selector(selectSegment:) forControlEvents:UIControlEventValueChanged];
        [leftBarButtonItem release];
        [backButton release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self clearView];
    [self addSubDataView];
    // Do any additional setup after loading the view from its nib.
}

- (void)selectSegment:(id)sender
{
    UISegmentedControl *sc = sender;
    [self clearView];
    switch (sc.selectedSegmentIndex) {
        case 0:
            [self addSubDataView];
            break;
        case 1:
            [self addSubOutfitView];
            break;
        default:
            break;
    }
    NSLog(@"%d",sc.selectedSegmentIndex);
}

- (NSArray *)loadLocalData
{
    NSArray* arr = [NSArray arrayWithObject:nil];
    return arr;
}

- (void)addSubDataView
{
    dataView = [[UIView alloc]initWithFrame:self.view.frame];
    calendarView = [[VRGCalendarView alloc]init];
    calendarView.delegate = self;
    dataTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 30, self.view.frame.size.width, self.view.frame.size.height)];
    [dataView addSubview:calendarView];
    [dataView addSubview:dataTableView];
    [self.view addSubview:dataView];
    [calendarView release];
    [dataTableView release];
    [dataView release];
}

- (void)addSubOutfitView
{
    outfitView = [[UIView alloc]initWithFrame:self.view.frame];
    UIImage *image = [UIImage imageNamed:@"mannoone.png"];
    UIImageView *imageView =  [[UIImageView alloc]initWithImage:image];
    [imageView setFrame:CGRectMake(0, 0, self.view.frame.size
                                       .width, self.view.frame.size
                                       .height)];
    [outfitView addSubview:imageView];
    outfitTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        outfitTableView.delegate = self;
        outfitTableView.dataSource = self;
    [outfitView addSubview:outfitTableView];
    [imageView release];
    [outfitTableView release];
    [self.view addSubview:outfitView];
    
}

- (void)clearView
{
    if (dataView) {
        [dataView removeFromSuperview];
    }
    if (outfitView) {
        [outfitView removeFromSuperview];
    }
}

- (void)doClickBackAction:(id)sender
{
    if (self.parentViewController) {
        CGRect rect = [[UIScreen mainScreen] bounds];
        mainViewController *parentVC = (mainViewController *)self.parentViewController.parentViewController;
        [parentVC transitionFromViewController:parentVC.navController toViewController:parentVC.rootController duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
            [parentVC.navController.view setCenter:CGPointMake(rect.size.width * 1.5, rect.size.height/2)];
            [parentVC.rootController.view setCenter:CGPointMake(rect.size.width/2, rect.size.height/2)];
        } completion:^(BOOL finished) {
            [parentVC.navController removeFromParentViewController];
        }];
    }
    /*[self.parentViewController transitionFromViewController:self toViewController:self.parentViewController.rootController duration:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
     [rootController.view setCenter:CGPointMake(-self.view.frame.size.width/2, self.view.frame.size.height/2)];
     [navController.view setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
     } completion:^(BOOL finished) {
     //
     }];*/
    
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [self.calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView setFrame:CGRectMake(0, self.view.frame.size.height-tableView.contentSize.height, self.view.frame.size.width, tableView.contentSize.height)];
    UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:0.6];
    tableView.backgroundColor = altCellColor;
    cell.backgroundColor = altCellColor;
    altCellColor = [UIColor colorWithWhite:1 alpha:0];
    cell.textLabel.backgroundColor = altCellColor;
    cell.detailTextLabel.backgroundColor = altCellColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    tableView.separatorColor = [UIColor darkGrayColor];
    [tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [tableView setBounces:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simple"];
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"都市商务";
                break;
            case 1:
                cell.textLabel.text = @"重要会议";
                break;
            case 2:
                cell.textLabel.text = @"运动场所";
                break;
            case 3:
                cell.textLabel.text = @"休闲场所";
                break;
            default:
                break;
        }
        UIImageView *rightCell = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellRight.png"]];
        [cell setAccessoryView:rightCell];
        [rightCell release];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"选中！");
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //UIViewController *singleView;
    switch (indexPath.row) {
        case 0:
            //都市商务
            //singleView = [[ActiveViewController alloc]init];
            break;
        case 1:
            //重要会议
            //singleView = [[ChrConsuViewController alloc]init];
            break;
        default:
            break;
    }
    //[self.navigationController pushViewController:singleView animated:YES];
   // [singleView release];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
