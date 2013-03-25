//
//  const.m
//  septwolves
//
//  Created by  Lion on 13-1-6.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import "LNconst.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"


@implementation LNconst

#define BASE_URL @"http://uniideas.net/septapp/"
#define MAIN_PAGE @"main.php"
#define MEN_PAGE @"pgnz.php"
#define DYNAMIC_PAGE @"ppdt.php"
#define INFORMATION_PAGE @"mszx.php"
#define VIP_HISTORY_PAGE @"hyzc.php"
#define GIFT_PAGE @"lpdh.php"
#define USER_PAGE @"user.php"

#define MAIN_URL [NSString stringWithFormat:@"%@%@",BASE_URL,MAIN_PAGE]
#define MEN_URL [NSString stringWithFormat:@"%@%@",BASE_URL,MEN_PAGE]
#define DYNAMIC_URL [NSString stringWithFormat:@"%@%@",BASE_URL,DYNAMIC_PAGE]
#define INFORMATION_URL [NSString stringWithFormat:@"%@%@",BASE_URL,INFORMATION_PAGE]
#define VIP_HISTORY_URL [NSString stringWithFormat:@"%@%@",BASE_URL,VIP_HISTORY_PAGE]
#define GIFT_URL [NSString stringWithFormat:@"%@%@",BASE_URL,GIFT_PAGE]
#define USER_URL [NSString stringWithFormat:@"%@%@",BASE_URL,USER_PAGE]

+ (menuBean *)httpRequestMenu:(LNActivityIndicatorView *)indicatorView
{
    [indicatorView startAnimating];
    menuBean *bean = [[menuBean alloc]init];
    NSURL *url = [NSURL URLWithString:MAIN_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"main" forKey:@"act"];
    [request setPostValue:@"septapp" forKey:@"REQUEST_METHOD"];
    [request startSynchronous];
    
    NSError *error = [request error];
    
    if (!error) {
        [indicatorView stopAnimating];
        NSString *response = [request responseString];
        NSLog(@"%@",response);
        NSDictionary *data = [response objectFromJSONString];
        if ([[data objectForKey:@"result"] isEqual:@"000"]) {
            bean.bgImgList = [data objectForKey:@"bgImgList"];
            NSMutableArray *tempLists = [[NSMutableArray alloc]init];
            for (NSDictionary *eachMenu in [data objectForKey:@"menu"]) {
                menuBean *itemBean = [[menuBean alloc]init];
                NSDictionary *item = [[eachMenu allValues]objectAtIndex:0];
                itemBean.menuName = [[eachMenu allKeys]objectAtIndex:0];
                itemBean.title = [item objectForKey:@"title"];
                itemBean.imgUrl = [item objectForKey:@"imgUrl"];
                [tempLists addObject:itemBean];
            }
            bean.menu = tempLists;
        }
    }
    return bean;
}

+ (eachMenuBean *)httpRequestEachMenu:(LNActivityIndicatorView *)indicatorView action:(NSString *)action
{
    eachMenuBean *bean = [[eachMenuBean alloc]init];
    return bean;
}




@end
