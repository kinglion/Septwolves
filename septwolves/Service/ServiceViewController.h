//
//  ServiceViewController.h
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cTableView.h"
#import "ReaderVC.h"
#import "RssBean.h"
#import "LNActivityIndicatorView.h"
#import "LNconst.h"
@interface ServiceViewController : UIViewController<UISearchDisplayDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,cTableViewDelegate>
{
    cTableView *ctableView;
    NSString *str;
    NSMutableArray *allArr;
    NSMutableArray *resultArr;
    NSMutableArray *allTitleArr;
    NSMutableArray *filterTitleArr;
    BOOL isListOpen;
    RssBean *bean;
    UITableView *listTableView;
    LNActivityIndicatorView *indicatorView;
    UIView *mainView;
}
@property (nonatomic, retain)NSMutableArray *allTitleArr;
@property (nonatomic, retain)NSMutableArray *filterTitleArr;
@property (nonatomic, retain)cTableView *ctableView;
@property (nonatomic,retain)NSMutableArray *allArr;
@property (nonatomic,retain)NSMutableArray *resultArr;
@property (nonatomic,copy)NSString* str;
@property (nonatomic,retain)UITableView *listTableView;
@property (nonatomic,retain)RssBean *bean;
@property (nonatomic,retain)LNActivityIndicatorView *indicatorView;
@property (nonatomic,retain)UIView *mainView;
@end
