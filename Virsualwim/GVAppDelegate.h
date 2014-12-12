//
//  GVAppDelegate.h
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "wimService.h"

@interface GVAppDelegate : UIResponder <UIApplicationDelegate>{
    WimService *wimService;
    NSMutableData *webData;
}
@property (nonatomic) BOOL blockRotation;
@property (nonatomic) BOOL authenticated;
@property (nonatomic) BOOL isFinishGetWim;
@property (strong, nonatomic) UIWindow *window;

@end
