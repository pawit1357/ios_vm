//
//  StationDao.m
//  virsualwim
//
//  Created by pawit on 9/30/2557 BE.
//  Copyright (c) 2557 Department of Highways. All rights reserved.
//

#import "StationDao.h"
#import "StationModel.h"
#import "ConfigModel.h"
#import "ConfigDao.h"

@implementation StationDao

static StationDao *_stationDao = nil;

+(id)StationDao{
    @synchronized(self) {
        
        if (_stationDao == nil)
            _stationDao = [[self alloc] init];
    }
    return _stationDao;
}
- (id)init {
    
    if (self = [super init]) {
        
        // Setup some globals
        databaseName = @"dohwim.sqlite";
        
        // Get the path to the documents directory and append the databaseName
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
        
        // Execute the "checkAndCreateDatabase" function
        [self initDatabase];
    }
    return self;
}

- (void) initDatabase {
    
    BOOL success;
    
    // Create a FileManager object, we will use this to check the status
    // of the database and to copy it over if required
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check if the database has already been created in the users filesystem
    success = [fileManager fileExistsAtPath:databasePath];
    
    // If the database already exists then return without doing anything
    if(success) return;
    
    // If not then proceed to copy the database from the application to the users filesystem
    
    // Get the path to the database in the application package
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
    
    // Copy the database from the package to the users filesystem
    [fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
    
}

- (BOOL) saveStation:(StationModel*)model{
    BOOL success = false;
    
    sqlite3_stmt *statement = NULL;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        //NSLog(@"New data, Insert Please");
        NSString *insertSQL = [NSString stringWithFormat:
                               @"INSERT INTO Station (StationID,StationName) VALUES (%ld, '%@')",
                               (long)model.StationID,
                               model.StationName];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(db, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            success = true;
        }else{
            NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(db));
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(db);
    }
    return success;
}
- (BOOL) deleteAllStation{
    BOOL success = false;
    sqlite3_stmt *statement = NULL;
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        NSLog(@"Exitsing data, Delete Please");
        NSString *deleteSQL = [NSString stringWithFormat:@"delete from Station"];
        
        const char *delete_stmt = [deleteSQL UTF8String];
        sqlite3_prepare_v2(db, delete_stmt, -1, &statement, NULL );
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            success = true;
        }else{
            NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(db));
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(db);
    
    return success;
}

- (NSMutableArray *) getAll
{
    NSMutableArray *configList = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        
        ConfigModel *config = (ConfigModel*)[[ConfigDao ConfigDao] getSingle:1];
        
        NSString *querySQL = [NSString stringWithFormat:@"SELECT StationID, StationName FROM Station where StationID in(%@)",config.monitorStation];
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            
            StationModel *tmp = [[StationModel alloc] init];
            tmp.StationID = 0;
            tmp.StationName=@"- All Station -";
            [configList addObject:tmp];
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                StationModel *model = [[StationModel alloc] init];
                model.StationID = sqlite3_column_int(statement, 0);
                model.StationName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                [configList addObject:model];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(db);
    }
    
    return configList;
}


@end
