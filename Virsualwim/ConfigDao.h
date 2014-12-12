//
//  ConfigDao.h
//  virsualwim
//
//  Created by pawit on 9/14/2557 BE.
//  Copyright (c) 2557 Department of Highways. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ConfigModel.h"

@interface ConfigDao : NSObject{

sqlite3 *db;
    
    NSString *databaseName;
    NSString *databasePath;
    
}

+(id)ConfigDao;

- (void) initDatabase;

- (BOOL) saveModel:(ConfigModel *)config;
- (BOOL) updateModel:(ConfigModel *)config;
- (BOOL) deleteModel:(ConfigModel *)config;
- (NSMutableArray *) getAll;
- (NSArray *) getSingle:(NSInteger) id;

@end