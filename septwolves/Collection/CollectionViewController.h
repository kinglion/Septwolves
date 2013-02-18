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


@interface CollectionViewController : UIViewController<MosaicViewDatasourceProtocol,MosaicViewDelegateProtocol,UITableViewDataSource,UITableViewDelegate>
{
    MosaicView *mosaicView;
    NSMutableArray *elements;
}

@property (nonatomic,retain) UIImageView *frontView;
@property (nonatomic, retain) UITableView *tableView;
@end
