//
//  GVAppDelegate.m
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import "GVAppDelegate.h"
#import "DetailViewManager.h"
#import "GVMasterViewController.h"
#import "WimModel.h"
#import "WimDao.h"
#include <ifaddrs.h>
#include <arpa/inet.h>


@implementation GVAppDelegate

-(NSUInteger)application:(UIApplication *)application       supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (self.blockRotation) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.authenticated = NO;
    self.isFinishGetWim = YES;
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;        
        UINavigationController *navigationController = [splitViewController.viewControllers firstObject];
        GVMasterViewController* mvc = (GVMasterViewController*)navigationController.topViewController;
        splitViewController.delegate = mvc.detailViewManager;
        mvc.detailViewManager.splitViewController = splitViewController;
    }
    
    //syn data
    wimService = [[WimService alloc] init];
    [wimService downloadStation];
    
    //Timer to get new data
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(synWimData) userInfo:nil repeats:YES];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/* CALL WEBSERVICE */

- (void) synWimData{
    
    if ( self.isFinishGetWim ){
        
        self.isFinishGetWim = NO;
        
        NSURL *url = nil;
        if( [self isLocalWifi] ){
            url = [NSURL URLWithString:@"http://192.168.105.104/wim_service/WimService/GetWimData?top=5"];
        }else{
            url = [NSURL URLWithString:@"http://61.19.97.185/wim_service/WimService/GetWimData?top=5"];
        }
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        
        NSURLConnection *theConnection =
        [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        
        if( theConnection )
        {
            webData = [NSMutableData data] ;
            NSLog(@"Connected.");
        }
        else
        {
            NSLog(@"theConnection is NULL ");
        }
        
    }
}


-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"didReceiveResponse");
    [webData setLength: 0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSLog(@"didReceiveData");
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError");
    self.authenticated = YES;
    
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    
    NSLog(@"DONE. Received Bytes: %lu", (unsigned long)[webData length]);
    
    NSString *theXML = [[NSString alloc] initWithBytes:
                        [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
    
    NSData *myData = [theXML dataUsingEncoding:NSUTF8StringEncoding];
    
    if( myData != nil ){
        
        //-- JSON Parsing
        NSMutableArray *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
        
        if(result != nil){
            
            for (NSMutableDictionary *dataDict in result)
            {
                
                
                WimModel *wim  =[[WimModel alloc] init];
                
                wim.WIMID = [[dataDict objectForKey:@"wimid"] integerValue];
                wim.Image01Name = [wimService validNullValue:[dataDict objectForKey:@"imgpath"]];
                wim.Image02Name = [wimService validNullValue:[dataDict objectForKey:@"imgPath2"]];
                
                wim.StationName= [wimService validNullValue:[dataDict objectForKey:@"StationName"]];
                wim.StationID= [[dataDict objectForKey:@"StationId"] integerValue];
                wim.TimeStamp = [wimService validNullValue:[dataDict objectForKey:@"TimeStamp"]];
                wim.VehicleNumber = [wimService validNullValue:[dataDict objectForKey:@"VehicleNumber"]];
                wim.Lane = [wimService validNullValue:[dataDict objectForKey:@"LaneId"]];
                wim.VehicleClass = [wimService validNullValue:[dataDict objectForKey:@"VehicleClass"]];
                wim.SortDecision = [wimService validNullValue:[dataDict objectForKey:@"SortDecision"]];
                wim.MaxGVW = [wimService validNullValue:[dataDict objectForKey:@"MaxGvw"]];
                wim.GVW= [wimService validNullValue:[dataDict objectForKey:@"Gvw"]];
                
                wim.LicensePlateNumber= [wimService validNullValue:[dataDict objectForKey:@"LicensePlateNumber"]];
                wim.ProvinceName= [wimService validNullValue:[dataDict objectForKey:@"ProvinceName"]];
                
                wim.statusCode = [wimService validNullValue:[dataDict objectForKey:@"statusCode"]];
                wim.Error = [wimService validNullValue:[dataDict objectForKey:@"errorCode"]];
                wim.StatusColor= [wimService validNullValue:[dataDict objectForKey:@"StatusColor"]];
                //--------
                
                wim.Speed          = [wimService validNullValue:[dataDict objectForKey:@"Speed"]];
                wim.ESAL           = [wimService validNullValue:[dataDict objectForKey:@"ESAL"]];
                wim.AxleCount      = [wimService validNullValue:[dataDict objectForKey:@"AxleCount"]];
                wim.Length         = [wimService validNullValue:[dataDict objectForKey:@"Length"]];
                wim.FrontOverHang  = [wimService validNullValue:[dataDict objectForKey:@"FrontOverHang"]];
                wim.RearOverHang   = [wimService validNullValue:[dataDict objectForKey:@"RearOverHang"]];
                
                wim.Axle01Seperation= [wimService validNullValue:[dataDict objectForKey:@"SeperationCol_1"]];
                wim.Axle02Seperation= [wimService validNullValue:[dataDict objectForKey:@"SeperationCol_2"]];
                wim.Axle03Seperation= [wimService validNullValue:[dataDict objectForKey:@"SeperationCol_3"]];
                wim.Axle04Seperation= [wimService validNullValue:[dataDict objectForKey:@"SeperationCol_4"]];
                wim.Axle05Seperation= [wimService validNullValue:[dataDict objectForKey:@"SeperationCol_5"]];
                wim.Axle06Seperation= [wimService validNullValue:[dataDict objectForKey:@"SeperationCol_6"]];
                wim.Axle07Seperation= [wimService validNullValue:[dataDict objectForKey:@"SeperationCol_7"]];
                //wim.SeperationCol_8= [dataDict objectForKey:@"SeperationCol_8"];
                //wim.SeperationCol_9= [dataDict objectForKey:@"SeperationCol_9"];
                wim.Axle01Group     = [wimService validNullValue:[dataDict objectForKey:@"GroupCol_1"]];
                wim.Axle02Group     = [wimService validNullValue:[dataDict objectForKey:@"GroupCol_2"]];
                wim.Axle03Group     = [wimService validNullValue:[dataDict objectForKey:@"GroupCol_3"]];
                wim.Axle04Group     = [wimService validNullValue:[dataDict objectForKey:@"GroupCol_4"]];
                wim.Axle05Group     = [wimService validNullValue:[dataDict objectForKey:@"GroupCol_5"]];
                wim.Axle06Group     = [wimService validNullValue:[dataDict objectForKey:@"GroupCol_6"]];
                wim.Axle07Group     = [wimService validNullValue:[dataDict objectForKey:@"GroupCol_7"]];
                //wim.GroupCol_8     = [dataDict objectForKey:@"GroupCol_8"];
                //wim.GroupCol_9     = [dataDict objectForKey:@"GroupCol_9"];
                wim.Axle01Weight    = [wimService validNullValue:[dataDict objectForKey:@"WeightCol_1"]];
                wim.Axle02Weight    = [wimService validNullValue:[dataDict objectForKey:@"WeightCol_2"]];
                wim.Axle03Weight    = [wimService validNullValue:[dataDict objectForKey:@"WeightCol_3"]];
                wim.Axle04Weight    = [wimService validNullValue:[dataDict objectForKey:@"WeightCol_4"]];
                wim.Axle05Weight    = [wimService validNullValue:[dataDict objectForKey:@"WeightCol_5"]];
                wim.Axle06Weight    = [wimService validNullValue:[dataDict objectForKey:@"WeightCol_6"]];
                wim.Axle07Weight    = [wimService validNullValue:[dataDict objectForKey:@"WeightCol_7"]];
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
            self.isFinishGetWim = YES;
        }else{
            self.isFinishGetWim = YES;
        }
    }
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
