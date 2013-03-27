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
    [indicatorView startAnimating];
    NSURL *url = [NSURL URLWithString:MAIN_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:action forKey:@"act"];
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
                eachMenuBean *itemBean = [[eachMenuBean alloc]init];
                itemBean.title = [eachMenu objectForKey:@"title"];
                itemBean.stitle = [eachMenu objectForKey:@"stitle"];
                itemBean.typeid = [[eachMenu objectForKey:@"typeid"] intValue];
                [tempLists addObject:itemBean];
            }
            bean.menu = tempLists;
        }
    }
    return bean;
}

+ (CharacterBean *)httpRequestCharacterMenu:(LNActivityIndicatorView *)indicatorView action:(NSString *)action
{
    CharacterBean *bean = [[CharacterBean alloc]init];
    [indicatorView startAnimating];
    NSURL *url = [NSURL URLWithString:MEN_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"list" forKey:@"act"];
    [request setPostValue:action forKey:@"type"];
    [request setPostValue:@"septapp" forKey:@"REQUEST_METHOD"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        [indicatorView stopAnimating];
        NSString *response = [request responseString];
        NSLog(@"%@",response);
        NSDictionary *data = [response objectFromJSONString];
        if ([[data objectForKey:@"result"] isEqual:@"000"]) {
            bean.index = [self stringFormatWithBaseUrl:[data objectForKey:@"index"]];
            NSMutableArray *tempLists = [[NSMutableArray alloc]init];
            for (NSDictionary *eachMenu in [data objectForKey:@"list"]) {
                CharacterBean *itemBean = [[CharacterBean alloc]init];
                itemBean._id = [[eachMenu objectForKey:@"id"] intValue];
                itemBean.imgUrl = [NSString stringWithFormat:@"%@%@",BACK_URL,[eachMenu objectForKey:@"imgUrl"]];
                NSMutableArray *infoLists = [[NSMutableArray alloc]init];
                for (NSDictionary *eachInfo in [eachMenu objectForKey:@"itemInfo"]) {
                    CharacterBean *infoBean = [[CharacterBean alloc]init];
                    infoBean.name = [eachInfo objectForKey:@"name"];
                    infoBean.num = [eachInfo objectForKey:@"num"];
                    [infoLists addObject:infoBean];
                }
                itemBean.itemInfo = infoLists;
                [tempLists addObject:itemBean];
            }
            bean.list = tempLists;
        }
    }
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

+ (NSString *)stringFormatWithBaseUrl:(NSString *)url
{
    NSString *tempStr;
    tempStr = [NSString stringWithFormat:@"%@%@",BACK_URL,url];
    return tempStr;
}

@end
