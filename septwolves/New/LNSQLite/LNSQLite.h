//
//  LNSQLite.h
//  septwolves
//
//  Created by 小才 on 13-3-19.
//  Copyright (c) 2013年 uniideas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#define SQL_PATH [NSString stringWithFormat:@"%@/Documents/septwolves.db",NSHomeDirectory()]

@interface LNSQLite : NSObject
{
    sqlite3 *dbHandle;
}
@property (nonatomic) sqlite3 *dbHandle;
@end
