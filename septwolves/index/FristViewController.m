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
