//
//  NewViewController.m
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import "NewViewController.h"
#import "mainViewController.h"
#import "LNconst.h"
#define HEADHEIGHT 30.0f

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
@synthesize isCalendarHide;
@synthesize allDataLists,toDayLists;
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
        [segmentedControl setFrame:CGRectMake(0, 0, 160, 30)];
        [segmentedControl setSegmentedControlStyle:UISegmentedControlStyleBar];
        [segmentedControl setTintColor:[UIColor grayColor]];
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

- (void)viewDidAppear:(BOOL)animated
{
    LNSQLite *sql = [[LNSQLite alloc]init];
    self.allDataLists = [sql selectSQLAll];
    if(self.dataTableView)[self.dataTableView reloadData];
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
    LNSQLite *sql = [[LNSQLite alloc]init];
    self.allDataLists = [sql selectSQLAll];
    dataView = [[UIView alloc]initWithFrame:self.view.frame];
    calendarView = [[VRGCalendarView alloc]init];
    calendarView.delegate = self;
    dataTableView = [[CustomTableView alloc]initWithFrame:CGRectMake(0, HEIGHT_BAR - 5, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [dataTableView setDelegate:self];
    [dataTableView setDataSource:self];
    [dataView addSubview:calendarView];
    //dataSelectBtn
    UIButton *dataSelectBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 80, 5, 30, 30)];
    [dataSelectBtn setBackgroundImage:[UIImage imageNamed:@"data_week_button_bg.png"] forState:UIControlStateNormal];
    [dataSelectBtn addTarget:self action:@selector(dataSelectClick:) forControlEvents:UIControlEventTouchUpInside];
    //addDataBtn
    UIButton *addDataBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 40, 5, 30, 30)];
    [addDataBtn setBackgroundImage:[UIImage imageNamed:@"data_add_button_bg.png"] forState:UIControlStateNormal];
    [addDataBtn addTarget:self action:@selector(addDataClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [dataView addSubview:dataSelectBtn];
    [dataView addSubview:addDataBtn];
    [dataView addSubview:dataTableView];
    [self.view addSubview:dataView];
    isCalendarHide = YES;
    [dataTableView release];
    [calendarView release];
    //[dataView release];
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
    if (tableView == self.outfitTableView) {
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
    }else{
        UIColor *altCellColor = [UIColor colorWithWhite:1 alpha:1];
        cell.textLabel.backgroundColor = altCellColor;
        cell.textLabel.textColor = [UIColor blackColor];
        tableView.separatorColor = [UIColor colorWithWhite:0.7 alpha:1];
        UIImageView *tempImageView = [[UIImageView alloc]initWithFrame:tableView.frame];
        UIGraphicsBeginImageContext(tempImageView.frame.size);
        [tempImageView.image drawInRect:CGRectMake(0, 0, tempImageView.frame.size.width, tempImageView.frame.size.height)];
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 0.5);
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.5, 0.5, 0.5, 1.0);
        CGContextBeginPath(UIGraphicsGetCurrentContext());
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), WIDTH_TIME - 1, 0);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), WIDTH_TIME - 1, tempImageView.frame.size.height - 4);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        tempImageView.image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [tableView setBackgroundView:tempImageView];
        [tempImageView release];
        [tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.outfitTableView){
        return 4; 
    }else{
        NSInteger length = [self.allDataLists count];
        if (length != 0) {
            return length;
        }
        return 1;
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.outfitTableView) {
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
    }else{
        CustomCell *cell = nil;
        if(cell == nil){
            cell = [[CustomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simple"];
            if ([allDataLists count] != 0) {
                dataBean *bean = allDataLists[indexPath.row];
                NSTimeInterval time=[bean.timesp doubleValue];
                NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:time];
                NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
                [formatter setDateFormat:@"HH:mm"];
                NSString *timeStr = [formatter stringFromDate:timeDate];
                cell.timeLabel.text = timeStr;
                cell.mainLabel.text = bean.title;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }else{
                cell.mainLabel.text = @"添加事情请点击右上\"+\"按钮";
            }
            
        }
        return cell;
    }
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

- (void)dataSelectClick:(id)sender
{
    if(isCalendarHide){
        [UIView beginAnimations:@"animate" context:nil];
        [UIView setAnimationDuration:0.5f];
        [dataTableView setFrame:CGRectMake(0,calendarView.frame.size.height, dataTableView.frame.size.width, dataTableView.frame.size.height)];
        [UIView commitAnimations];
        isCalendarHide = NO;
    }else{
        [UIView beginAnimations:@"animate" context:nil];
        [UIView setAnimationDuration:0.5f];
        [dataTableView setFrame:CGRectMake(0, HEIGHT_BAR - 5, dataTableView.frame.size.width, dataTableView.frame.size.height)];
        [UIView commitAnimations];
        isCalendarHide = YES;
    }
}

- (void)addDataClick:(id)sender
{
    DataAddViewController *singleViewController = [[DataAddViewController alloc]init];
    [self.navigationController pushViewController:singleViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
