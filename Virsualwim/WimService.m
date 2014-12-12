//
//  WimService.m
//  virsualwim
//
//  Created by pawit on 9/8/2557 BE.
//  Copyright (c) 2557 Department of Highways. All rights reserved.
//

#import "WimService.h"
#import "WimModel.h"
#import "WimDao.h"
#import "StationDao.h"
#import "StationModel.h"
#import "ConfigDao.h"
#import "ConfigModel.h"
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation WimService

-(BOOL) getwimData
{


    //-- Make URL request with server
    
    //NSMutableArray *wimData = [[NSMutableArray alloc] init];
    NSHTTPURLResponse *response = nil;

    
    NSString *jsonUrlString = @"";
    if( [self isLocalWifi] ){
        jsonUrlString = [NSString stringWithFormat:@"http://192.168.105.104/wim_service/WimService/GetWimData?top=5"];
    }else{
        jsonUrlString = [NSString stringWithFormat:@"http://61.19.97.185/wim_service/WimService/GetWimData?top=5"];
    }
    
    
    //NSLog(@"%@",jsonUrlString);
    
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //-- Get request and response though URL
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    //-- JSON Parsing
    NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"Result = %@",result);
    if(result != nil){
    for (NSMutableDictionary *dataDict in result)
    {
        
        WimModel *wim  =[[WimModel alloc] init];
        
        wim.WIMID = [[dataDict objectForKey:@"wimid"] integerValue];
        wim.Image01Name = [self validNullValue:[dataDict objectForKey:@"imgpath"]];
        wim.Image02Name = [self validNullValue:[dataDict objectForKey:@"imgPath2"]];

        wim.StationName= [self validNullValue:[dataDict objectForKey:@"StationName"]];
        wim.StationID= [[dataDict objectForKey:@"StationId"] integerValue];
        wim.TimeStamp = [self validNullValue:[dataDict objectForKey:@"TimeStamp"]];
        wim.TimeStampLong = [self dateStringLong:[dataDict objectForKey:@"TimeStamp"]];
        wim.VehicleNumber = [self validNullValue:[dataDict objectForKey:@"VehicleNumber"]];
        wim.Lane = [self validNullValue:[dataDict objectForKey:@"LaneId"]];
        wim.VehicleClass = [self validNullValue:[dataDict objectForKey:@"VehicleClass"]];
        wim.SortDecision = [self validNullValue:[dataDict objectForKey:@"SortDecision"]];
        wim.MaxGVW = [self validNullValue:[dataDict objectForKey:@"MaxGvw"]];
        wim.GVW= [self validNullValue:[dataDict objectForKey:@"Gvw"]];
    
        wim.LicensePlateNumber= [self validNullValue:[dataDict objectForKey:@"LicensePlateNumber"]];
        wim.ProvinceName= [self validNullValue:[dataDict objectForKey:@"ProvinceName"]];
        
        wim.statusCode = [self validNullValue:[dataDict objectForKey:@"statusCode"]];
        wim.Error = [self validNullValue:[dataDict objectForKey:@"errorCode"]];
        wim.StatusColor= [self validNullValue:[dataDict objectForKey:@"StatusColor"]];
        //--------
        
        wim.Speed          = [self validNullValue:[dataDict objectForKey:@"Speed"]];
        wim.ESAL           = [self validNullValue:[dataDict objectForKey:@"ESAL"]];
        wim.AxleCount      = [self validNullValue:[dataDict objectForKey:@"AxleCount"]];
        wim.Length         = [self validNullValue:[dataDict objectForKey:@"Length"]];
        wim.FrontOverHang  = [self validNullValue:[dataDict objectForKey:@"FrontOverHang"]];
        wim.RearOverHang   = [self validNullValue:[dataDict objectForKey:@"RearOverHang"]];
        
        wim.Axle01Seperation= [self validNullValue:[dataDict objectForKey:@"SeperationCol_1"]];
        wim.Axle02Seperation= [self validNullValue:[dataDict objectForKey:@"SeperationCol_2"]];
        wim.Axle03Seperation= [self validNullValue:[dataDict objectForKey:@"SeperationCol_3"]];
        wim.Axle04Seperation= [self validNullValue:[dataDict objectForKey:@"SeperationCol_4"]];
        wim.Axle05Seperation= [self validNullValue:[dataDict objectForKey:@"SeperationCol_5"]];
        wim.Axle06Seperation= [self validNullValue:[dataDict objectForKey:@"SeperationCol_6"]];
        wim.Axle07Seperation= [self validNullValue:[dataDict objectForKey:@"SeperationCol_7"]];
        //wim.SeperationCol_8= [dataDict objectForKey:@"SeperationCol_8"];
        //wim.SeperationCol_9= [dataDict objectForKey:@"SeperationCol_9"];
        wim.Axle01Group     = [self validNullValue:[dataDict objectForKey:@"GroupCol_1"]];
        wim.Axle02Group     = [self validNullValue:[dataDict objectForKey:@"GroupCol_2"]];
        wim.Axle03Group     = [self validNullValue:[dataDict objectForKey:@"GroupCol_3"]];
        wim.Axle04Group     = [self validNullValue:[dataDict objectForKey:@"GroupCol_4"]];
        wim.Axle05Group     = [self validNullValue:[dataDict objectForKey:@"GroupCol_5"]];
        wim.Axle06Group     = [self validNullValue:[dataDict objectForKey:@"GroupCol_6"]];
        wim.Axle07Group     = [self validNullValue:[dataDict objectForKey:@"GroupCol_7"]];
        //wim.GroupCol_8     = [dataDict objectForKey:@"GroupCol_8"];
        //wim.GroupCol_9     = [dataDict objectForKey:@"GroupCol_9"];
        wim.Axle01Weight    = [self validNullValue:[dataDict objectForKey:@"WeightCol_1"]];
        wim.Axle02Weight    = [self validNullValue:[dataDict objectForKey:@"WeightCol_2"]];
        wim.Axle03Weight    = [self validNullValue:[dataDict objectForKey:@"WeightCol_3"]];
        wim.Axle04Weight    = [self validNullValue:[dataDict objectForKey:@"WeightCol_4"]];
        wim.Axle05Weight    = [self validNullValue:[dataDict objectForKey:@"WeightCol_5"]];
        wim.Axle06Weight    = [self validNullValue:[dataDict objectForKey:@"WeightCol_6"]];
        wim.Axle07Weight    = [self validNullValue:[dataDict objectForKey:@"WeightCol_7"]];
        //wim.WeightCol_8    = [dataDict objectForKey:@"WeightCol_8"];
        //wim.WeightCol_9    = [dataDict objectForKey:@"WeightCol_9"];
        
        //--------
        
        // Add the wim object to the wims Array
        BOOL result = [[WimDao WimDao] isDuplicateWIMID:[[dataDict objectForKey:@"wimid"] integerValue]];
        if(!result){
            [[WimDao WimDao] saveWim:wim];
            NSLog(@"Added wimid: %ldl",(long)wim.WIMID);
        }
    }
    }
    return TRUE;
}

- (BOOL) downloadStation{
    
    //NSMutableArray *wimData = [[NSMutableArray alloc] init];
    NSHTTPURLResponse *response = nil;
    NSString *jsonUrlString = @"";
    if( [self isLocalWifi] ){
        jsonUrlString = [NSString stringWithFormat:@"http://192.168.105.104/wim_service/WimService/GetStation"];
    }else{
        jsonUrlString = [NSString stringWithFormat:@"http://61.19.97.185/wim_service/WimService/GetStation"];
    }

    
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //-- Get request and response though URL
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    if ( responseData != nil ){
    //-- JSON Parsing
    NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"Result = %@",result);
    if(result != nil){
        if([[[StationDao StationDao]getAll] count]!= result.count){
            
            [[StationDao StationDao] deleteAllStation];
            
        for (NSMutableDictionary *dataDict in result)
        {
            StationModel *station  =[[StationModel alloc] init];
            station.StationID = [[dataDict objectForKey:@"StationID"] integerValue];
            station.StationName = [dataDict objectForKey:@"StationName"];

            // Add the wim object to the wims Array
            [[StationDao StationDao] saveStation:station];

        }
        }
    }
        
    }
    return true;
}


- (BOOL) userAuthenticated:(NSString*) userName andWithPassword:(NSString*) password{
    BOOL userAuthenticated = FALSE;
    
    //ConfigDao *configDao = [[ConfigDao alloc] init] get;
    //NSMutableArray *wimData = [[NSMutableArray alloc] init];
    NSHTTPURLResponse *response = nil;
    
    NSString *jsonUrlString = @"";
    if( [self isLocalWifi] ){
        jsonUrlString = [NSString stringWithFormat:@"http://192.168.105.104/wim_service/WimService/GetLogin?user=%@&pass=%@",userName,password];
    }else{
        jsonUrlString = [NSString stringWithFormat:@"http://61.19.97.185/wim_service/WimService/GetLogin?user=%@&pass=%@",userName,password];
    }
    
    
    NSURL *url = [NSURL URLWithString:[jsonUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //-- Get request and response though URL
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    //-- JSON Parsing
    NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    //NSLog(@"Result = %@",result);
    if(result != nil){
        
        ConfigModel *config = (ConfigModel*)[[ConfigDao ConfigDao] getSingle:1];
        
        for (NSMutableDictionary *dataDict in result)
        {
            config.monitorStation = [dataDict objectForKey:@"MonitorStation"];
            userAuthenticated = TRUE;
            
        }
        if ( userAuthenticated ){
            [[ConfigDao ConfigDao] updateModel:config];
            
        }
    }
    
    return userAuthenticated;
}

-(NSString*) validNullValue:(NSString*) value{
    NSString * returnValue = value;
    if(value == nil){
        returnValue = @"-";
    }
    return returnValue;
}
-(NSString*) dateStringLong:(NSString*) value{
    
    NSArray *dat = [value componentsSeparatedByString:@" "];
    
    NSArray *dateAr = [[dat objectAtIndex:0] componentsSeparatedByString: @","];
    NSArray *timeAr = [[dat objectAtIndex:1] componentsSeparatedByString: @","];
    
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@", [dateAr objectAtIndex:2],[dateAr objectAtIndex:1],[dateAr objectAtIndex:0],[timeAr objectAtIndex:0],[timeAr objectAtIndex:1],[timeAr objectAtIndex:2]];
}


-(BOOL)isLocalWifi{
    BOOL isLocal = FALSE;
    
    NSArray *ipAr = [[self getIPAddress] componentsSeparatedByString:@"."];
    
    if ( [[ipAr objectAtIndex:0] isEqualToString:@"192" ] && [[ipAr objectAtIndex:1] isEqualToString:@"168" ] && [[ipAr objectAtIndex:2] isEqualToString:@"105" ]    ) {
        isLocal = true;
    }
    
    return isLocal;
}


- (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}


@end