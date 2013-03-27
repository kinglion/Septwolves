//
//  CollectionViewController.h
//  septwolves
//
//  Created by  Lion on 12-12-18.
//  Copyright (c) 2012年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MosaicViewDatasourceProtocol.h"
#import "MosaicView.h"
#import "LNActivityIndicatorView.h"
#import "eachMenuBean.h"
#import "LNconst.h"
#import "JBKenBurnsView.h"


@interface SecondViewController : UIViewController<MosaicViewDatasourceProtocol,MosaicViewDelegateProtocol,UITableViewDataSource,UITableViewDelegate>
{
    MosaicView *mosaicView;
    NSMutableArray *elements;
    LNActivityIndicatorView *indicatorView;
    eachMenuBean *bean;
    KenBurnsView *kenBurnsView;
}

@property (nonatomic,retain) UIImageView *frontView;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic,retain) LNActivityIndicatorView *indicatorView;
@property (nonatomic,retain) eachMenuBean *bean;
@property (nonatomic , retain) KenBurnsView *kenBurnsView;
@end
