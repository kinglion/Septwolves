//
//  eachMenuBean.h
//  septwolves
//
//  Created by 小才 on 13-3-25.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface eachMenuBean : NSObject
{
    NSArray *bgImgList;
    NSArray *menu;
    NSString *title;
    NSString *stitle;
    NSInteger typeid;
}
@property (nonatomic,retain) NSArray *bgImgList;
@property (nonatomic,retain) NSArray *menu;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *stitle;
@property (nonatomic,assign) NSInteger typeid;
@end
