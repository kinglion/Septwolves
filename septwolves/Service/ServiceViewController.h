//
//  ServiceViewController.h
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cTableView.h"
@interface ServiceViewController : UIViewController<UISearchDisplayDelegate,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    cTableView *ctableView;
    NSString *str;
    NSMutableArray *allArr;
    NSMutableArray *resultArr;
}
@property (nonatomic, retain)cTableView *ctableView;
@property (nonatomic,retain)NSMutableArray *allArr;
@property (nonatomic,retain)NSMutableArray *resultArr;
@property (nonatomic,copy)NSString* str;
@end
