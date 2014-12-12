//
//  StationModel.h
//  virsualwim
//
//  Created by pawit on 9/30/2557 BE.
//  Copyright (c) 2557 Department of Highways. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StationModel : NSObject{
    NSInteger StationID;
    NSString *StationName;
}
@property (nonatomic) NSInteger StationID;
@property (nonatomic, retain) NSString *StationName;

@end
