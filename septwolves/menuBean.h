//
//  menuBean.h
//  septwolves
//
//  Created by 小才 on 13-3-25.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface menuBean : NSObject
{
    NSArray *bgImgList;
    NSArray *menu;
    NSString *menuName;
    NSString *title;
    NSString *imgUrl;
}
@property (nonatomic,retain) NSArray *bgImgList;
@property (nonatomic,retain) NSArray *menu;
@property (nonatomic,retain) NSString *menuName;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *imgUrl;
@end
