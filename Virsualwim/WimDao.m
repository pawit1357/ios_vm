//
//  WimDao.m
//  virsualwim
//
//  Created by pawit on 10/1/2557 BE.
//  Copyright (c) 2557 Department of Highways. All rights reserved.
//

#import "WimDao.h"
#import "WimModel.h"

@implementation WimDao

static WimDao *_wimDao = nil;


//@synthesize databasePath;

+(id)WimDao{
    @synchronized(self) {
        
        if (_wimDao == nil)
            _wimDao = [[self alloc] init];
    }
    return _wimDao;
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

- (BOOL) saveWim:(WimModel*)model{
        BOOL success = false;
        
        sqlite3_stmt *statement = NULL;
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &db) == SQLITE_OK)
        {
            //NSLog(@"New data, Insert Please");
            NSString *insertSQL = [NSString stringWithFormat:
                                   @"INSERT INTO WIM"
                                   "(WIMID,StationID"
                                   ",TimeStamp"
                                   ",VehicleNumber"
                                   ",Lane"
                                   ",Error"
                                   ",StatusCode"
                                   ",GVW"
                                   ",MaxGVW"
                                   ",ESAL"
                                   ",Speed"
                                   ",AxleCount"
                                   ",Axle01Seperation"
                                   ",Axle01Weight"
                                   ",Axle01Max"
                                   ",Axle01Group"
                                   ",Axle01TireCode"
                                   ",Axle02Seperation"
                                   ",Axle02Weight"
                                   ",Axle02Max"
                                   ",Axle02Group"
                                   ",Axle02TireCode"
                                   ",Axle03Seperation"
                                   ",Axle03Weight"
                                   ",Axle03Max"
                                   ",Axle03Group"
                                   ",Axle03TireCode"
                                   ",Axle04Seperation"
                                   ",Axle04Weight"
                                   ",Axle04Max"
                                   ",Axle04Group"
                                   ",Axle04TireCode"
                                   ",Axle05Seperation"
                                   ",Axle05Weight"
                                   ",Axle05Max"
                                   ",Axle05Group"
                                   ",Axle05TireCode"
                                   ",Axle06Seperation"
                                   ",Axle06Weight"
                                   ",Axle06Max"
                                   ",Axle06Group"
                                   ",Axle06TireCode"
                                   ",Axle07Seperation"
                                   ",Axle07Weight"
                                   ",Axle07Max"
                                   ",Axle07Group"
                                   ",Axle07TireCode"
                                   ",Axle08Seperation"
                                   ",Axle08Weight"
                                   ",Axle08Max"
                                   ",Axle08Group"
                                   ",Axle08TireCode"
                                   ",Axle09Seperation"
                                   ",Axle09Weight"
                                   ",Axle09Max"
                                   ",Axle09Group"
                                   ",Axle09TireCode"
                                   ",Axle10Seperation"
                                   ",Axle10Weight"
                                   ",Axle10Max"
                                   ",Axle10Group"
                                   ",Axle10TireCode"
                                   ",Axle11Seperation"
                                   ",Axle11Weight"
                                   ",Axle11Max"
                                   ",Axle11Group"
                                   ",Axle11TireCode"
                                   ",Axle12Seperation"
                                   ",Axle12Weight"
                                   ",Axle12Max"
                                   ",Axle12Group"
                                   ",Axle12TireCode"
                                   ",Axle13Seperation"
                                   ",Axle13Weight"
                                   ",Axle13Max"
                                   ",Axle13Group"
                                   ",Axle13TireCode"
                                   ",Axle14Seperation"
                                   ",Axle14Weight"
                                   ",Axle14Max"
                                   ",Axle14Group"
                                   ",Axle14TireCode"
                                   ",Length"
                                   ",FrontOverHang"
                                   ",RearOverHang"
                                   ",VehicleType"
                                   ",VehicleClass"
                                   ",RecordType"
                                   ",ImageCount"
                                   ",Image01Name"
                                   ",Image02Name"
                                   ",Image03Name"
                                   ",Image04Name"
                                   ",Image05Name"
                                   ",Image06Name"
                                   ",Image07Name"
                                   ",Image08Name"
                                   ",Image09Name"
                                   ",Image10Name"
                                   ",SortDecision"
                                   ",LicensePlateNumber"
                                   ",LicensePlateProvinceID"
                                   ",LicensePlateImageName"
                                   ",LicensePlateConfidence,StatusColor,ProvinceName,StationName,TimeStampLong)"
                                   "VALUES"
                                   "(%ld,%ld"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@'"
                                   ",'%@','%@','%@','%@','%@')"
                                   ,
                                   (long)model.WIMID,
                                   (long)model.StationID,
                                   model.TimeStamp,
                                   model.VehicleNumber,
                                   model.Lane,
                                   model.Error,
                                   model.StatusCode,
                                   model.GVW,
                                   model.MaxGVW,
                                   model.ESAL,
                                   model.Speed,
                                   model.AxleCount,
                                   model.Axle01Seperation,
                                   model.Axle01Weight,
                                   model.Axle01Max,
                                   model.Axle01Group,
                                   model.Axle01TireCode,
                                   model.Axle02Seperation,
                                   model.Axle02Weight,
                                   model.Axle02Max,
                                   model.Axle02Group,
                                   model.Axle02TireCode,
                                   model.Axle03Seperation,
                                   model.Axle03Weight,
                                   model.Axle03Max,
                                   model.Axle03Group,
                                   model.Axle03TireCode,
                                   model.Axle04Seperation,
                                   model.Axle04Weight,
                                   model.Axle04Max,
                                   model.Axle04Group,
                                   model.Axle04TireCode,
                                   model.Axle05Seperation,
                                   model.Axle05Weight,
                                   model.Axle05Max,
                                   model.Axle05Group,
                                   model.Axle05TireCode,
                                   model.Axle06Seperation,
                                   model.Axle06Weight,
                                   model.Axle06Max,
                                   model.Axle06Group,
                                   model.Axle06TireCode,
                                   model.Axle07Seperation,
                                   model.Axle07Weight,
                                   model.Axle07Max,
                                   model.Axle07Group,
                                   model.Axle07TireCode,
                                   model.Axle08Seperation,
                                   model.Axle08Weight,
                                   model.Axle08Max,
                                   model.Axle08Group,
                                   model.Axle08TireCode,
                                   model.Axle09Seperation,
                                   model.Axle09Weight,
                                   model.Axle09Max,
                                   model.Axle09Group,
                                   model.Axle09TireCode,
                                   model.Axle10Seperation,
                                   model.Axle10Weight,
                                   model.Axle10Max,
                                   model.Axle10Group,
                                   model.Axle10TireCode,
                                   model.Axle11Seperation,
                                   model.Axle11Weight,
                                   model.Axle11Max,
                                   model.Axle11Group,
                                   model.Axle11TireCode,
                                   model.Axle12Seperation,
                                   model.Axle12Weight,
                                   model.Axle12Max,
                                   model.Axle12Group,
                                   model.Axle12TireCode,
                                   model.Axle13Seperation,
                                   model.Axle13Weight,
                                   model.Axle13Max,
                                   model.Axle13Group,
                                   model.Axle13TireCode,
                                   model.Axle14Seperation,
                                   model.Axle14Weight,
                                   model.Axle14Max,
                                   model.Axle14Group,
                                   model.Axle14TireCode,
                                   model.Length,
                                   model.FrontOverHang,
                                   model.RearOverHang,
                                   model.VehicleType,
                                   model.VehicleClass,
                                   model.RecordType,
                                   model.ImageCount,
                                   model.Image01Name,
                                   model.Image02Name,
                                   model.Image03Name,
                                   model.Image04Name,
                                   model.Image05Name,
                                   model.Image06Name,
                                   model.Image07Name,
                                   model.Image08Name,
                                   model.Image09Name,
                                   model.Image10Name,
                                   model.SortDecision,
                                   model.LicensePlateNumber,
                                   model.LicensePlateProvinceID,
                                   model.LicensePlateImageName,
                                   model.LicensePlateConfidence,
                                   model.StatusColor,model.ProvinceName,model.StationName,model.TimeStampLong];
            
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

-(NSMutableArray *) getAll;
{
    
    NSMutableArray *configList = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
    
        NSString *querySQL = @"select  *  from wim order by TimeStamp desc";
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {

                WimModel *wim  =[[WimModel alloc] init];
                wim.WIMID = sqlite3_column_int(statement, 0);
                wim.StationID = sqlite3_column_int(statement, 1);
                wim.TimeStamp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                wim.VehicleNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                wim.Lane = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                wim.Error = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                wim.StatusCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                wim.GVW = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                wim.MaxGVW = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                wim.ESAL = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                wim.Speed = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                wim.AxleCount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
                wim.Axle01Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
                wim.Axle01Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 13)];
                wim.Axle01Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 14)];
                wim.Axle01Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 15)];
                wim.Axle01TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 16)];
                wim.Axle02Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 17)];
                wim.Axle02Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 18)];
                wim.Axle02Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 19)];
                wim.Axle02Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 20)];
                wim.Axle02TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 21)];
                wim.Axle03Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 22)];
                wim.Axle03Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 23)];
                wim.Axle03Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 24)];
                wim.Axle03Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 25)];
                wim.Axle03TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 26)];
                wim.Axle04Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 27)];
                wim.Axle04Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 28)];
                wim.Axle04Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 29)];
                wim.Axle04Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 30)];
                wim.Axle04TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 31)];
                wim.Axle05Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 32)];
                wim.Axle05Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 33)];
                wim.Axle05Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 34)];
                wim.Axle05Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 35)];
                wim.Axle05TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 36)];
                wim.Axle06Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 37)];
                wim.Axle06Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 38)];
                wim.Axle06Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 39)];
                wim.Axle06Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 40)];
                wim.Axle06TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 41)];
                wim.Axle07Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 42)];
                wim.Axle07Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 43)];
                wim.Axle07Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 44)];
                wim.Axle07Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 45)];
                wim.Axle07TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 46)];
                wim.Axle08Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 47)];
                wim.Axle08Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 48)];
                wim.Axle08Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 49)];
                wim.Axle08Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 50)];
                wim.Axle08TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 51)];
                wim.Axle09Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 52)];
                wim.Axle09Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 53)];
                wim.Axle09Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 54)];
                wim.Axle09Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 55)];
                wim.Axle09TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 56)];
                wim.Axle10Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 57)];
                wim.Axle10Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 58)];
                wim.Axle10Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 59)];
                wim.Axle10Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 60)];
                wim.Axle10TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 61)];
                wim.Axle11Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 62)];
                wim.Axle11Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 63)];
                wim.Axle11Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 64)];
                wim.Axle11Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 65)];
                wim.Axle11TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 66)];
                wim.Axle12Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 67)];
                wim.Axle12Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 68)];
                wim.Axle12Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 69)];
                wim.Axle12Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 70)];
                wim.Axle12TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 71)];
                wim.Axle13Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 72)];
                wim.Axle13Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 73)];
                wim.Axle13Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 74)];
                wim.Axle13Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 75)];
                wim.Axle13TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 76)];
                wim.Axle14Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 77)];
                wim.Axle14Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 78)];
                wim.Axle14Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 79)];
                wim.Axle14Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 80)];
                wim.Axle14TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 81)];
                wim.Length = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 82)];
                wim.FrontOverHang = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 83)];
                wim.RearOverHang = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 84)];
                wim.VehicleType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 85)];
                wim.VehicleClass = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 86)];
                wim.RecordType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 87)];
                wim.ImageCount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 88)];
                wim.Image01Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 89)];
                wim.Image02Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 90)];
                wim.Image03Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 91)];
                wim.Image04Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 92)];
                wim.Image05Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 93)];
                wim.Image06Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 94)];
                wim.Image07Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 95)];
                wim.Image08Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 96)];
                wim.Image09Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 97)];
                wim.Image10Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 98)];
                wim.SortDecision = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 99)];
                wim.LicensePlateNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 100)];
                wim.LicensePlateProvinceID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 101)];
                wim.LicensePlateImageName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 102)];
                wim.LicensePlateConfidence = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 103)];
                wim.StatusColor = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 104)];
                wim.ProvinceName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 105)];
                wim.StationName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 106)];
                wim.TimeStampLong = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 107)];
                [configList addObject:wim];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(db);
    }
    
    return configList;
}


-(NSMutableArray *) getWimByCondition:(NSInteger) stationId andLane:(NSString*)lane;
{
    

    NSMutableArray *configList = [[NSMutableArray alloc] init];
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &db) == SQLITE_OK)
    {
        
        NSString *querySQL = @"";
        
        if( stationId != 0){
            if( [lane isEqualToString:@"0"]){
                querySQL = [NSString stringWithFormat:@"select * from wim where StationID=%ld order by TimeStampLong desc limit 10",(long)stationId];
            }else{
                querySQL = [NSString stringWithFormat:@"select * from wim where StationID=%ld and Lane='%@' order by TimeStampLong desc limit 10",(long)stationId,lane];
            }
        }else{
            if( [lane isEqualToString:@"0"]){
                querySQL = [NSString stringWithFormat:@"select * from wim  order by TimeStampLong desc limit 10"];
            }else{
                querySQL = [NSString stringWithFormat:@"select * from wim where Lane='%@' order by TimeStampLong desc limit 10",lane];
            }
        }
        
        
        const char *query_stmt = [querySQL UTF8String];
        
        NSLog(@"::::%@",querySQL);
        if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            while (sqlite3_step(statement) == SQLITE_ROW)
            {
                
                WimModel *wim  =[[WimModel alloc] init];
                wim.WIMID = sqlite3_column_int(statement, 0);
                wim.StationID = sqlite3_column_int(statement, 1);
                wim.TimeStamp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                wim.VehicleNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                wim.Lane = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                wim.Error = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];
                wim.StatusCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 6)];
                wim.GVW = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 7)];
                wim.MaxGVW = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 8)];
                wim.ESAL = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 9)];
                wim.Speed = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 10)];
                wim.AxleCount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 11)];
                wim.Axle01Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 12)];
                wim.Axle01Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 13)];
                wim.Axle01Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 14)];
                wim.Axle01Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 15)];
                wim.Axle01TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 16)];
                wim.Axle02Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 17)];
                wim.Axle02Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 18)];
                wim.Axle02Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 19)];
                wim.Axle02Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 20)];
                wim.Axle02TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 21)];
                wim.Axle03Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 22)];
                wim.Axle03Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 23)];
                wim.Axle03Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 24)];
                wim.Axle03Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 25)];
                wim.Axle03TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 26)];
                wim.Axle04Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 27)];
                wim.Axle04Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 28)];
                wim.Axle04Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 29)];
                wim.Axle04Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 30)];
                wim.Axle04TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 31)];
                wim.Axle05Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 32)];
                wim.Axle05Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 33)];
                wim.Axle05Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 34)];
                wim.Axle05Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 35)];
                wim.Axle05TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 36)];
                wim.Axle06Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 37)];
                wim.Axle06Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 38)];
                wim.Axle06Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 39)];
                wim.Axle06Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 40)];
                wim.Axle06TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 41)];
                wim.Axle07Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 42)];
                wim.Axle07Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 43)];
                wim.Axle07Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 44)];
                wim.Axle07Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 45)];
                wim.Axle07TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 46)];
                wim.Axle08Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 47)];
                wim.Axle08Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 48)];
                wim.Axle08Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 49)];
                wim.Axle08Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 50)];
                wim.Axle08TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 51)];
                wim.Axle09Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 52)];
                wim.Axle09Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 53)];
                wim.Axle09Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 54)];
                wim.Axle09Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 55)];
                wim.Axle09TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 56)];
                wim.Axle10Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 57)];
                wim.Axle10Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 58)];
                wim.Axle10Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 59)];
                wim.Axle10Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 60)];
                wim.Axle10TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 61)];
                wim.Axle11Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 62)];
                wim.Axle11Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 63)];
                wim.Axle11Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 64)];
                wim.Axle11Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 65)];
                wim.Axle11TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 66)];
                wim.Axle12Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 67)];
                wim.Axle12Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 68)];
                wim.Axle12Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 69)];
                wim.Axle12Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 70)];
                wim.Axle12TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 71)];
                wim.Axle13Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 72)];
                wim.Axle13Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 73)];
                wim.Axle13Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 74)];
                wim.Axle13Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 75)];
                wim.Axle13TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 76)];
                wim.Axle14Seperation = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 77)];
                wim.Axle14Weight = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 78)];
                wim.Axle14Max = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 79)];
                wim.Axle14Group = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 80)];
                wim.Axle14TireCode = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 81)];
                wim.Length = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 82)];
                wim.FrontOverHang = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 83)];
                wim.RearOverHang = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 84)];
                wim.VehicleType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 85)];
                wim.VehicleClass = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 86)];
                wim.RecordType = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 87)];
                wim.ImageCount = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 88)];
                wim.Image01Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 89)];
                wim.Image02Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 90)];
                wim.Image03Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 91)];
                wim.Image04Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 92)];
                wim.Image05Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 93)];
                wim.Image06Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 94)];
                wim.Image07Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 95)];
                wim.Image08Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 96)];
                wim.Image09Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 97)];
                wim.Image10Name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 98)];
                wim.SortDecision = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 99)];
                wim.LicensePlateNumber = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 100)];
                wim.LicensePlateProvinceID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 101)];
                wim.LicensePlateImageName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 102)];
                wim.LicensePlateConfidence = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 103)];
                wim.StatusColor = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 104)];
                wim.ProvinceName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 105)];
                wim.StationName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 106)];
                wim.TimeStampLong = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 107)];
                [configList addObject:wim];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(db);
    }
    
    return configList;
}


-(BOOL) isDuplicateWIMID:(NSInteger)wimid{
    
    BOOL success = false;
        NSMutableArray *resultList = [[NSMutableArray alloc] init];
        const char *dbpath = [databasePath UTF8String];
        sqlite3_stmt    *statement;
        
        if (sqlite3_open(dbpath, &db) == SQLITE_OK)
        {
            NSString *querySQL = [NSString stringWithFormat:@"select wimid from wim where wimid=%ld",(long)wimid];
            
            const char *query_stmt = [querySQL UTF8String];
            if (sqlite3_prepare_v2(db, query_stmt, -1, &statement, NULL) == SQLITE_OK)
            {
                while (sqlite3_step(statement) == SQLITE_ROW)
                {
                    WimModel *model = [[WimModel alloc] init];
                    model.WIMID= sqlite3_column_int(statement, 0);
 
                    [resultList addObject:model];
                }
                sqlite3_finalize(statement);
            }else{
                NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(db));
            }
            sqlite3_close(db);
        }
    if(resultList.count>0){
        //NSLog(@"WIMID %ld already added.",wimid);
        success = true;
    }
    return success;
}

@end
