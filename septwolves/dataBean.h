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
    NSString *timesp;
    NSString *title;
    NSInteger *type;
    NSString *theme;
    NSString *content;
}
@property (nonatomic,copy)NSString *timesp;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,assign)NSInteger *type;
@property (nonatomic,copy)NSString *theme;
@property (nonatomic,copy)NSString *content;
@end
