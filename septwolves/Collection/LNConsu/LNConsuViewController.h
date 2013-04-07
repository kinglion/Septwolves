//
//  LNConsuViewController.h
//  septwolves
//
//  Created by  Lion on 13-3-17.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LNconst.h"
#import "LNActivityIndicatorView.h"
@interface LNConsuViewController : UIViewController<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView *mainScrollView;
    UITableView *listTableView;
    UILabel *pageLabel;
    NSInteger allPage;
    BOOL isListOpen;
    NSMutableArray *lists;
    UIView *mainView;
    NewBean *beanList;
    NewBean *bean;
    LNActivityIndicatorView *indicatorView;
    NSInteger _id;
}
@property (nonatomic,retain)UIScrollView *mainScrollView;
@property (nonatomic,retain)UIView *mainView;
@property (nonatomic,retain)UITableView *listTableView;
@property (nonatomic,retain)UILabel *pageLabel;
@property (nonatomic,retain)NSMutableArray *lists;
@property (nonatomic,retain)NewBean *beanList;
@property (nonatomic,retain)NewBean *bean;
@property (nonatomic,retain) LNActivityIndicatorView *indicatorView;
@property (nonatomic,assign) NSInteger _id;
- (id)init:(NSInteger)ID beanList:(NewBean *)BeanList;
@end
