//
//  CollectionViewController.m
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import "CollectionViewController.h"
#import "MosaicDataView.h"
#import "MosaicData.h"
#import "ActiveViewController.h"
#import "ChrConsuViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController
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
        UIImage *image = [UIImage imageNamed:@"mannoone.png.png"];
        UIImageView *imageView =  [[UIImageView alloc]initWithImage:image];
        [imageView setFrame:CGRectMake(0, 0, self.view.frame.size
                                       .width, self.view.frame.size
                                       .height)];
        [self.view addSubview:imageView];
        tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [tableView setDataSource:self];
        [tableView setDelegate:self];
        [self.view addSubview:tableView];
        [tableView release];
        [image release];
        [imageView release];
    }
    return self;
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
    UIViewController *singleView;
    switch (indexPath.row) {
        case 0:
            //跳转到品牌动态
            singleView = [[ActiveViewController alloc]init];
            break;
        case 1:
            //名士资讯
            singleView = [[ChrConsuViewController alloc]init];
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:singleView animated:YES];
    [self.navigationController setNavigationBarHidden:NO];
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
