//
//  ServiceViewController.h
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cTableView.h"
@interface ServiceViewController : UIViewController<UISearchDisplayDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate,cTableViewDelegate>
{
    cTableView *ctableView;
    NSString *str;
    NSMutableArray *allArr;
    NSMutableArray *resultArr;
    NSMutableArray *allTitleArr;
    NSMutableArray *filterTitleArr;
    BOOL isListOpen;
    UITableView *listTableView;
}
@property (nonatomic, retain)NSMutableArray *allTitleArr;
@property (nonatomic, retain)NSMutableArray *filterTitleArr;
@property (nonatomic, retain)cTableView *ctableView;
@property (nonatomic,retain)NSMutableArray *allArr;
@property (nonatomic,retain)NSMutableArray *resultArr;
@property (nonatomic,copy)NSString* str;
@property (nonatomic,retain)UITableView *listTableView;
@end
