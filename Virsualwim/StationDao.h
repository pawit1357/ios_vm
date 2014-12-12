//
//  StationDao.h
//  virsualwim
//
//  Created by pawit on 9/30/2557 BE.
//  Copyright (c) 2557 Department of Highways. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "StationModel.h"

@interface StationDao : NSObject{
    sqlite3 *db;
    
    NSString *databaseName;
    NSString *databasePath;
}
+(id)StationDao;

- (void) initDatabase;
- (BOOL) saveStation:(StationModel*)model;
- (BOOL) deleteAllStation;
- (NSMutableArray *) getAll;

@end
