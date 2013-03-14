//
//  DateViewController.m
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import "DateViewController.h"
#import "mainViewController.h"
#import <QuartzCore/QuartzCore.h>
#define HEIGHT_VIEW 80.0f
#define TABLE_HEIGHT 120.0f
@interface DateViewController ()

@end

@implementation DateViewController
@synthesize loginFlag = _loginFlag;
@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"品格会";
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

- (BOOL)isLogin
{
    _loginFlag = NO;
    return _loginFlag;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self isLogin];
    UIImage *uiimage = [UIImage imageNamed:@"Character_will_bg.png"];
    UIImageView *imageView =  [[UIImageView alloc]initWithImage:uiimage];
    [imageView setFrame:CGRectMake(0, 0, self.view.frame.size
                                   .width, self.view.frame.size
                                   .height)];
    [self.view addSubview:imageView];
    UITableView *tempTableView = [[UITableView alloc]initWithFrame:self.view.frame];
    tempTableView.dataSource = self;
    tempTableView.delegate = self;
    [self.view addSubview:tempTableView];
    self.tableView = tempTableView;
    [tempTableView release];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 30.0f)];
    textField.text = @"ssssssssssssss";
    [array addObject:textField];
    
    //添加 登陆按钮 和 注册按钮
    if (!_loginFlag)[self addMutilButton:CGRectMake(0.0f, self.view.frame.size.height - TABLE_HEIGHT - HEIGHT_VIEW, WIDTH_SCREEN / 2, HEIGHT_VIEW) rFrame:CGRectMake(WIDTH_SCREEN / 2, self.view.frame.size.height - TABLE_HEIGHT - HEIGHT_VIEW, WIDTH_SCREEN / 2, HEIGHT_VIEW)];
    
    [imageView release];
    //LNView *view = [[LNView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.bounds.size.height - HEIGHT_BAR) backgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:0.5] cornerable:YES floors:array];
    //[self.view addSubview:view];
    // Do any additional setup after loading the view from its nib.
}

- (void)addMutilButton:(CGRect)lFrame rFrame:(CGRect)rFrame
{
    NSLog(@"lFrame.x = %f,lFrame.y = %f,lFrame.width = %f,lFrame.height = %f",lFrame.origin.x,lFrame.origin.y,lFrame.size.width,lFrame.size.height);
    //登陆按钮
    UIButton *l_Button = [[UIButton alloc]initWithFrame:lFrame];
    //[l_Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [l_Button setTitle:@"登陆" forState:UIControlStateNormal];
    [l_Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [l_Button setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0]];
    [l_Button.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [l_Button.layer setBorderWidth:1.0f];
    [l_Button addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:l_Button];
    //注册按钮
    UIButton *r_Button = [[UIButton alloc]initWithFrame:rFrame];
    //[r_Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [r_Button setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0]];
    [r_Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [r_Button.layer setBorderWidth:1.0f];
    [r_Button.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [r_Button setTitle:@"注册" forState:UIControlStateNormal];
    [r_Button addTarget:self action:@selector(regClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:r_Button];
}

- (void)loginClick:(id)sender
{
    NSLog(@"登陆");
}

- (void)regClick:(id)sender
{
    NSLog(@"注册");
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView setFrame:CGRectMake(0, self.view.frame.size.height-self.tableView.contentSize.height, self.view.frame.size.width, self.tableView.contentSize.height)];
    UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:0.6];
    self.tableView.backgroundColor = altCellColor;
    cell.backgroundColor = altCellColor;
    altCellColor = [UIColor colorWithWhite:1 alpha:0];
    cell.textLabel.backgroundColor = altCellColor;
    cell.detailTextLabel.backgroundColor = altCellColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    self.tableView.separatorColor = [UIColor darkGrayColor];
    [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [self.tableView setBounces:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger returnValue;
    if (_loginFlag) {
        returnValue = 3;
    }else{
        returnValue = 2;
    }
    return returnValue;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simple"];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        UIImageView *rightCell = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cellRight.png"]];
        [cell setAccessoryView:rightCell];
        [rightCell release];
        if (_loginFlag) {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"个人信息";
                    break;
                case 1:
                    cell.textLabel.text = @"兑换礼品";
                    break;
                case 2:
                    cell.textLabel.text = @"会员章程";
                    break;
                default:
                    break;
            }
        }else{
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"兑换礼品";
                    break;
                case 1:
                    cell.textLabel.text = @"会员章程";
                    break;
                default:
                    break;
            }
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
