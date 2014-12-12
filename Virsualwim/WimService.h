//
//  WimService.h
//  virsualwim
//
//  Created by pawit on 9/8/2557 BE.
//  Copyright (c) 2557 Department of Highways. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WimService : NSObject


- (BOOL) getwimData;
- (BOOL) downloadStation;
- (BOOL) userAuthenticated:(NSString*) userName andWithPassword:(NSString*) password;
-(NSString*) validNullValue:(NSString*) value;
@end
