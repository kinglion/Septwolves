//
//  DataDetailViewController.h
//  septwolves
//
//  Created by 小才 on 13-3-22.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewViewController.h"
#import "dataBean.h"
#import "DataAddViewController.h"
#import "LNActivityIndicatorView.h"
#import "LNconst.h"

@interface DataDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *mainTableView;
    UILabel *themeLabel;
    UILabel *addrLabel;
    UILabel *externLabel;
    UILabel *dateLabel;
    LNSQLite *sql;
    dataBean *bean;
    dataBean *imgBean;
    LNActivityIndicatorView *indicatorView;
    UIView *imgView;
}
@property (nonatomic,retain) UITableView *mainTableView;
@property (nonatomic,retain) UILabel *themeLabel;
@property (nonatomic,retain) UILabel *addrLabel;
@property (nonatomic,retain) UILabel *externLabel;
@property (nonatomic,retain) UILabel *dateLabel;
@property (nonatomic,retain) dataBean *bean;
@property (nonatomic,retain) dataBean *imgBean;
@property (nonatomic,retain) LNSQLite *sql;
@property (nonatomic,retain) LNActivityIndicatorView *indicatorView;
@property (nonatomic,retain) UIView *imgView;
@end
