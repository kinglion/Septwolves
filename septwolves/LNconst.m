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
            bean.bgImgList = [self formatWithBaseUrl:[data objectForKey:@"bgImgList"]];
            NSMutableArray *tempLists = [[NSMutableArray alloc]init];
            for (NSDictionary *eachMenu in [data objectForKey:@"menu"]) {
                menuBean *itemBean = [[menuBean alloc]init];
                NSDictionary *item = [[eachMenu allValues]objectAtIndex:0];
                itemBean.menuName = [[eachMenu allKeys]objectAtIndex:0];
                itemBean.title = [item objectForKey:@"title"];
                itemBean.imgUrl = [NSString stringWithFormat:@"%@%@",BACK_URL,[item objectForKey:@"imgUrl"]];
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

+ (NSArray *)formatWithBaseUrl:(NSArray *)urlList
{
    int length = [urlList count];
    NSMutableArray *tempList = [[NSMutableArray alloc]initWithArray:urlList];
    for (int i = 0; i < length; i++) {
        NSString *url = [urlList objectAtIndex:i];
        url = [NSString stringWithFormat:@"%@%@",BACK_URL,urlList[i]];
        tempList[i] = url;
    }
    urlList = tempList;
    return urlList;
}

@end
