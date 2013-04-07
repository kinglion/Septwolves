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

+ (NewBean *)httpRequestNewList:(LNActivityIndicatorView *)indicatorView
{
    NewBean *bean = [[NewBean alloc]init];
    [indicatorView startAnimating];
    NSURL *url = [NSURL URLWithString:DYNAMIC_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"list" forKey:@"act"];
    [request setPostValue:@"septapp" forKey:@"REQUEST_METHOD"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        [indicatorView stopAnimating];
        NSString *response = [request responseString];
        NSLog(@"%@",response);
        NSDictionary *data = [response objectFromJSONString];
        if ([[data objectForKey:@"result"] isEqual:@"000"]) {
            NSMutableArray *tempLists = [[NSMutableArray alloc]init];
            for (NSDictionary *eachMenu in [data objectForKey:@"list"]) {
                NewBean *itemBean = [[NewBean alloc]init];
                itemBean._id = [[eachMenu objectForKey:@"id"] intValue];
                itemBean.imgUrl = [NSString stringWithFormat:@"%@%@",BACK_URL,[eachMenu objectForKey:@"imgUrl"]];
                itemBean.title = [eachMenu objectForKey:@"title"];
                [tempLists addObject:itemBean];
            }
            bean.list = tempLists;
        }
    }

    return bean;
}

+ (NewBean *)httpRequestNewInfo:(LNActivityIndicatorView *)indicatorView id:(NSInteger)_id
{
    NewBean *bean = [[NewBean alloc]init];
    [indicatorView startAnimating];
    NSURL *url = [NSURL URLWithString:DYNAMIC_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"info" forKey:@"act"];
    [request setPostValue:[NSString stringWithFormat:@"%d",_id] forKey:@"id"];
    [request setPostValue:@"septapp" forKey:@"REQUEST_METHOD"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        [indicatorView stopAnimating];
        NSString *response = [request responseString];
        NSLog(@"%@",response);
        NSDictionary *data = [response objectFromJSONString];
        if ([[data objectForKey:@"result"] isEqual:@"000"]) {
            NSDictionary *eachMenu = [data objectForKey:@"item"];
            NSLog(@"%@",[eachMenu objectForKey:@"type"]);
            bean._id = [[eachMenu objectForKey:@"id"] intValue];
            bean.imgUrl = [NSString stringWithFormat:@"%@%@",BACK_URL,[eachMenu objectForKey:@"imgUrl"]];
            bean.time = [eachMenu objectForKey:@"time"];
            bean.type = [eachMenu objectForKey:@"type"];
            bean.content = [eachMenu objectForKey:@"content"];
            bean.title = [eachMenu objectForKey:@"title"];
            NSMutableArray *imgList = [[NSMutableArray alloc]init];
            for (NSDictionary *eachInfo in [eachMenu objectForKey:@"imgList"]) {
                NewBean *infoBean = [[NewBean alloc]init];
                infoBean.stitle = [eachInfo objectForKey:@"stitle"];
                infoBean.url = [NSString stringWithFormat:@"%@%@",BACK_URL,[eachInfo objectForKey:@"url"]];
                [imgList addObject:infoBean];
            }
            bean.imgList = imgList;
        }
    }
    
    return bean;
}

+ (NewBean *)httpRequestChrList:(LNActivityIndicatorView *)indicatorView
{
    NewBean *bean = [[NewBean alloc]init];
    [indicatorView startAnimating];
    NSURL *url = [NSURL URLWithString:INFORMATION_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"list" forKey:@"act"];
    [request setPostValue:@"septapp" forKey:@"REQUEST_METHOD"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        [indicatorView stopAnimating];
        NSString *response = [request responseString];
        NSLog(@"%@",response);
        NSDictionary *data = [response objectFromJSONString];
        if ([[data objectForKey:@"result"] isEqual:@"000"]) {
            NSMutableArray *tempLists = [[NSMutableArray alloc]init];
            for (NSDictionary *eachMenu in [data objectForKey:@"list"]) {
                NewBean *itemBean = [[NewBean alloc]init];
                itemBean._id = [[eachMenu objectForKey:@"id"] intValue];
                itemBean.imgUrl = [NSString stringWithFormat:@"%@%@",BACK_URL,[eachMenu objectForKey:@"imgUrl"]];
                itemBean.title = [eachMenu objectForKey:@"title"];
                [tempLists addObject:itemBean];
            }
            bean.list = tempLists;
        }
    }
    
    return bean;
}

+ (NewBean *)httpRequestChrInfo:(LNActivityIndicatorView *)indicatorView id:(NSInteger)_id
{
    NewBean *bean = [[NewBean alloc]init];
    [indicatorView startAnimating];
    NSURL *url = [NSURL URLWithString:INFORMATION_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"info" forKey:@"act"];
    [request setPostValue:[NSString stringWithFormat:@"%d",_id] forKey:@"id"];
    [request setPostValue:@"septapp" forKey:@"REQUEST_METHOD"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        [indicatorView stopAnimating];
        NSString *response = [request responseString];
        NSLog(@"%@",response);
        NSDictionary *data = [response objectFromJSONString];
        if ([[data objectForKey:@"result"] isEqual:@"000"]) {
            NSMutableArray *imgList = [[NSMutableArray alloc]init];
            for (NSDictionary *eachInfo in [data objectForKey:@"list"]) {
                NewBean *infoBean = [[NewBean alloc]init];
                infoBean.simg = [NSString stringWithFormat:@"%@%@",BACK_URL,[eachInfo objectForKey:@"simg"]];
                infoBean.bimg = [NSString stringWithFormat:@"%@%@",BACK_URL,[eachInfo objectForKey:@"bimg"]];
                [imgList addObject:infoBean];
            }
            bean.list = imgList;
        }
    }
    
    return bean;
}

+ (dataBean *)httpRequestAdviserList:(LNActivityIndicatorView *)indicatorView type:(NSInteger)type num:(NSInteger)num
{
    dataBean *bean = [[dataBean alloc]init];
    [indicatorView startAnimating];
    NSURL *url = [NSURL URLWithString:ADVITER_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"list" forKey:@"act"];
    [request setPostValue:@"septapp" forKey:@"REQUEST_METHOD"];
    switch (type) {
        case 0:
            type = 36;
            break;
        case 1:
            type = 37;
            break;
        case 2:
            type = 38;
            break;
        case 3:
            type = 39;
            break;
        default:
            break;
    }
    [request setPostValue:[NSString stringWithFormat:@"%d",type] forKey:@"type"];
    [request setPostValue:[NSString stringWithFormat:@"%d",num] forKey:@"returnNum"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        [indicatorView stopAnimating];
        NSString *response = [request responseString];
        NSLog(@"%@",response);
        NSDictionary *data = [response objectFromJSONString];
        if ([[data objectForKey:@"result"] isEqual:@"000"]) {
            NSMutableArray *tempLists = [[NSMutableArray alloc]init];
            for (NSDictionary *eachMenu in [data objectForKey:@"item"]) {
                dataBean *itemBean = [[dataBean alloc]init];
                itemBean._id = [[eachMenu objectForKey:@"id"] intValue];
                itemBean.imgUrl = [NSString stringWithFormat:@"%@%@",BACK_URL,[eachMenu objectForKey:@"imgUrl"]];
                itemBean.name = [eachMenu objectForKey:@"title"];
                NSMutableArray *tempArr = [[NSMutableArray alloc]init];
                for (NSDictionary *item in [eachMenu objectForKey:@"itemInfo"]) {
                    dataBean *bean = [[dataBean alloc]init];
                    bean.name = [item objectForKey:@"name"];
                    bean.num = [[item objectForKey:@"num"]intValue];
                    [tempArr addObject:bean];
                }
                itemBean.itemInfo = tempArr;
                [tempLists addObject:itemBean];
            }
            bean.item = tempLists;
        }
    }
    
    return bean;
}

+ (RssBean *)httpRequestRssList:(LNActivityIndicatorView *)indicatorView type:(NSInteger)type
{
    RssBean *bean = [[RssBean alloc]init];
    [indicatorView startAnimating];
    NSURL *url = [NSURL URLWithString:RSS_URL];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"list" forKey:@"act"];
    if (type) [request setPostValue:[NSString stringWithFormat:@"%d",type] forKey:@"type"];
    [request setPostValue:@"septapp" forKey:@"REQUEST_METHOD"];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        [indicatorView stopAnimating];
        NSString *response = [request responseString];
        NSLog(@"%@",response);
        NSDictionary *data = [response objectFromJSONString];
        if ([[data objectForKey:@"result"] isEqual:@"000"]) {
            NSMutableArray *tempLists = [[NSMutableArray alloc]init];
            for (NSDictionary *eachMenu in [data objectForKey:@"list"]) {
                RssBean *itemBean = [[RssBean alloc]init];
                itemBean._id = [[eachMenu objectForKey:@"id"] intValue];
                itemBean.title = [eachMenu objectForKey:@"title"];
                itemBean.icon = [NSString stringWithFormat:@"%@%@",BACK_URL,[eachMenu objectForKey:@"icon"]];
                itemBean.addr = [eachMenu objectForKey:@"addr"];
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
