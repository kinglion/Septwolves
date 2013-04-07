//
//  RssBean.h
//  septwolves
//
//  Created by  Lion on 13-4-6.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RssBean : NSObject
{
    NSInteger _id;
    NSInteger type;
    NSString *title;
    NSString *icon;
    NSString *addr;
    NSArray *list;
}
@property (nonatomic) NSInteger _id;
@property (nonatomic) NSInteger type;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *addr;
@property (nonatomic,copy) NSArray *list;
@end
