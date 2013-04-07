//
//  cTableView.h
//  septwolves
//
//  Created by 小才 on 13-3-1.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cView.h"
#import "RssBean.h"
@class cTableView;
@protocol cTableViewDelegate

- (void)cTableViewAdd:(cTableView *)view;
- (void)cTableViewSelected:(cTableView *)view;

@end


@interface cTableView : UIScrollView<cViewDelegate>
{
    RssBean* products;
    id<cTableViewDelegate> customDelegate;
    NSInteger loadIndex;
}
@property (nonatomic,retain)RssBean* products;
@property (nonatomic,retain)id<cTableViewDelegate> customDelegate;
@property (nonatomic,assign)NSInteger loadIndex;
- (id)initWithFrame:(CGRect)frame products:(RssBean*)productsArr;
//重新更新一个视图的数据
- (void)reloadData;
//清空视图内容
- (void)reSetView;
@end
