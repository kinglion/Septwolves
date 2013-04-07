//
//  dataBean.h
//  septwolves
//
//  Created by 小才 on 13-3-19.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dataBean : NSObject
{
    NSInteger _id;
    NSString *timesp;
    NSString *title;
    NSInteger type;
    NSString *theme;
    NSString *content;
    NSArray *item;
    NSString *imgUrl;
    NSArray *itemInfo;
    NSString *name;
    NSInteger num;
}
@property (nonatomic,assign)NSInteger _id;
@property (nonatomic,copy)NSString *timesp;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,assign)NSInteger type;
@property (nonatomic,copy)NSString *theme;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,retain)NSArray *item;
@property (nonatomic,copy)NSString *imgUrl;
@property (nonatomic,retain)NSArray *itemInfo;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)NSInteger num;
@end
