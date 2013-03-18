//
//  Channel.h
//  septwolves
//
//  Created by 小才 on 13-3-18.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject
{
    NSInteger _id;
    NSString *rssUrl;
    NSString *imageUrl;
    NSString *name;
    NSString *s_name;
    BOOL *is_select;
}
@property (nonatomic,assign) NSInteger _id;
@property (nonatomic,copy) NSString *rssUrl;
@property (nonatomic,copy) NSString *imageUrl;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *s_name;
@property (nonatomic) BOOL *is_select;
@end
