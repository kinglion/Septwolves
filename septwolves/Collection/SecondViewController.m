//
//  CollectionViewController.m
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import "SecondViewController.h"
#import "MosaicDataView.h"
#import "MosaicData.h"
#import "ActiveViewController.h"
#import "ChrConsuViewController.h"
#import "mainViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize frontView;
@synthesize tableView;

#pragma mark - Private

static UIImageView *captureSnapshotOfView(UIView *targetView){
    UIImageView *retVal = nil;
    NSLog(@"长度:%f",targetView.frame.size.height);
    UIGraphicsBeginImageContextWithOptions(targetView.bounds.size, YES, 0);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    [[targetView layer] renderInContext:currentContext];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    retVal = [[UIImageView alloc] initWithImage:image];
    retVal.frame = [targetView frame];
    
    return retVal;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"男人不止一面";
        UIImage *image = [UIImage imageNamed:@"mannoone.png"];
        UIImageView *imageView =  [[UIImageView alloc]initWithImage:image];
        [imageView setFrame:CGRectMake(0, 0, self.view.frame.size
                                       .width, self.view.frame.size
                                       .height)];
        [self.view addSubview:imageView];
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [tableView setDataSource:self];
        [tableView setDelegate:self];
        [self.view addSubview:tableView];
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
        [tableView release];
        [image release];
        [imageView release];
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

-(void)mosaicViewDidTap:(MosaicDataView *)aModule
{
    NSLog(@"#DEBUG Tapped %@", aModule.module);
}
-(void)mosaicViewDidDoubleTap:(MosaicDataView *)aModule
{
    NSLog(@"#DEBUG Double Tapped %@", aModule.module);
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
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"simple"];
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"品牌动态";
                break;
            case 1:
                cell.textLabel.text = @"名士资讯";
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *singleView = nil;
    switch (indexPath.row) {
        case 0:
            //跳转到品牌动态
            singleView = [[ActiveViewController alloc]init];
            singleView.title = @"品牌动态";
            break;
        case 1:
            //名士资讯
            singleView = [[ChrConsuViewController alloc]init];
            singleView.title = @"名士资讯";
            break;
    }
    [self.navigationController pushViewController:singleView animated:YES];
    [singleView release];
}


#pragma mark - MosaicViewDatasourceProtocol

-(NSArray *)mosaicElements{
    NSArray *retVal = elements;
    return retVal;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
