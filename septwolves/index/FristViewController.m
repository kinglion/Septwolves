//
//  IndexViewController.m
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import "FristViewController.h"
#import "CustomNavigationBar.h"
#import "LNSingleViewController.h"
#import "mainViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface FristViewController ()

@end

@implementation FristViewController
@synthesize frontview;
@synthesize typeTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = @"品格男装";
        UIImage *uiimage = [UIImage imageNamed:@"pingeBg.png"];
        UIImageView *imageView =  [[UIImageView alloc]initWithImage:uiimage];
        [imageView setFrame:CGRectMake(0, 0, self.view.frame.size
                                       .width, self.view.frame.size
                                       .height)];
        [self.view addSubview:imageView];
        typeTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [typeTable setDelegate:self];
        [typeTable setDataSource:self];
        [self.view addSubview:typeTable];
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
        /*UIBarButtonItem *backItem = [[UIBarButtonItem alloc]init];
        [backItem setWidth:20.0f];
        [backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        self.navigationItem.leftBarButtonItem = backItem; 
        [backItem release];*/
        [uiimage release];
        [imageView release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self){
        
    }
    // Do any additional setup after loading the view from its nib.
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

- (void)viewDidAppear:(BOOL)animated
{
    if (self) {
        // Custom initialization
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    //画面消失
    NSLog(@"顶部导航消失！");
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.typeTable setFrame:CGRectMake(0, self.view.frame.size.height-self.typeTable.contentSize.height, self.view.frame.size.width, self.typeTable.contentSize.height)];
    UIColor *altCellColor = [UIColor colorWithWhite:0 alpha:0.6];
    typeTable.backgroundColor = altCellColor;
    cell.backgroundColor = altCellColor;
    altCellColor = [UIColor colorWithWhite:0.5 alpha:0];
    cell.textLabel.backgroundColor = altCellColor;
    cell.detailTextLabel.backgroundColor = altCellColor;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    typeTable.separatorColor = [UIColor darkGrayColor];
    [typeTable setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    [typeTable setBounces:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simple"];
        cell.textLabel.text = @"男式服装";
        cell.detailTextLabel.text = @"摩登,进取,都市时间";
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LNSingleViewController *singleView = [[LNSingleViewController alloc]init];
    [self.navigationController pushViewController:singleView animated:YES];
    [singleView release];
}

- (void)didReceiveMemoryWarning
{
    self.typeTable = nil;
    self.frontview = nil;
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)shouldAutomaticallyForwardAppearanceMethods{
    return NO;
}

-(void)dealloc
{
    [typeTable release];
    [frontview release];
    [super dealloc];
}

@end
