//
//  IndexViewController.h
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBKenBurnsView.h"
#import "LNActivityIndicatorView.h"
#import "LNconst.h"
#import "eachMenuBean.h"
@interface FristViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    LNActivityIndicatorView *indicatorView;
    eachMenuBean *bean;
    KenBurnsView *kenBurnsView;
}
@property (nonatomic,retain) UITableView *typeTable;
@property (nonatomic,retain) IBOutlet UIView *frontview;
@property (nonatomic,retain) LNActivityIndicatorView *indicatorView;
@property (nonatomic,retain) eachMenuBean *bean;
@property (nonatomic , retain) KenBurnsView *kenBurnsView;
@end
