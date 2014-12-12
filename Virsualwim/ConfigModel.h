//
//  ConfigModel.h
//  virsualwim
//
//  Created by pawit on 9/14/2557 BE.
//  Copyright (c) 2557 Department of Highways. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfigModel : NSObject
    
@property (nonatomic) NSInteger id;
@property (nonatomic, strong) NSString *stationId;
@property (nonatomic, strong) NSString *lane;
@property (nonatomic, strong) NSString *monitorStation;
@end
