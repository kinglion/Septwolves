//
//  NewBean.h
//  septwolves
//
//  Created by 小才 on 13-3-27.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewBean : NSObject
{
    NSInteger _id;
    NSArray *list;
    NSArray *item;
    NSString *imgUrl;
    NSString *title;
    NSString *time;
    NSString *type;
    NSString *content;
    NSArray *imgList;
    NSString *stitle;
    NSString *url;
    NSString *vedioUrl;
}
@property (nonatomic,assign) NSInteger _id;
@property (nonatomic,copy) NSArray *list;
@property (nonatomic,copy) NSArray *item;
@property (nonatomic,copy) NSString *imgUrl;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSArray *imgList;
@property (nonatomic,copy) NSString *stitle;
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *vedioUrl;
@end
