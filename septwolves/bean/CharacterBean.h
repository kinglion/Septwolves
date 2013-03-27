//
//  CharacterBean.h
//  septwolves
//
//  Created by 小才 on 13-3-27.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterBean : NSObject
{
    NSString *index;
    NSArray *list;
    NSInteger _id;
    NSString *imgUrl;
    NSArray *itemInfo;
    NSString *name;
    NSString *num;
}
@property (nonatomic,assign) NSString *index;
@property (nonatomic,copy) NSArray *list;
@property (nonatomic,assign) NSInteger _id;
@property (nonatomic,assign) NSString *imgUrl;
@property (nonatomic,copy) NSArray *itemInfo;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *num;

@end
