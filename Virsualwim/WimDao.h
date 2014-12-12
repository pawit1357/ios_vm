//
//  WimDao.h
//  virsualwim
//
//  Created by pawit on 10/1/2557 BE.
//  Copyright (c) 2557 Department of Highways. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "WimModel.h"

@interface WimDao :NSObject{
    sqlite3 *db;
    
    NSString *databaseName;
    NSString *databasePath;
}
+(id)WimDao;

-(void) initDatabase;
-(BOOL) saveWim:(WimModel*)model;
-(NSMutableArray *) getAll;
-(NSMutableArray *) getWimByCondition:(NSInteger) stationId andLane:(NSString*)lane;

-(BOOL) isDuplicateWIMID:(NSInteger)wimid;
@end
