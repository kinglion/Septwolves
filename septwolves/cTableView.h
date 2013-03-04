//
//  cTableView.h
//  septwolves
//
//  Created by 小才 on 13-3-1.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "product.h"

@interface cTableView : UIView
{
    NSMutableArray* products;
}
@property (nonatomic,retain)NSMutableArray* products;
- (id)initWithFrame:(CGRect)frame products:(NSMutableArray*)products;
//设置view的数据
- (void)setProducts:(NSMutableArray*)products;
//返回view的数据
- (NSMutableArray*)getProducts;
//重新更新一个视图的数据
- (void)reloadData;
//清空视图内容
- (void)reSetView;
@end
