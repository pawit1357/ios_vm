//
//  ShowWimDetailController.h
//  virsualwim
//
//  Created by pawit on 9/14/2557 BE.
//  Copyright (c) 2557 Department of Highways. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowWimDetailController : UIViewController{
    NSFileManager *fileManager;
    NSString *documentsDirectory;
}

@property (strong, nonatomic) NSArray *wimDetailItem;

@property (weak, nonatomic) IBOutlet UIImageView *imgCamera1;
@property (weak, nonatomic) IBOutlet UIImageView *imgCamera2;
@property (weak, nonatomic) IBOutlet UILabel *lbWimId;

@property (weak, nonatomic) IBOutlet UILabel *lbStation;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbVehicleNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbLane;
@property (weak, nonatomic) IBOutlet UILabel *lbVehicleClass;
@property (weak, nonatomic) IBOutlet UILabel *lbAxleCount;
@property (weak, nonatomic) IBOutlet UILabel *lbSpeed;
@property (weak, nonatomic) IBOutlet UILabel *lbESAL;

@property (weak, nonatomic) IBOutlet UILabel *lbWimGvw;
@property (weak, nonatomic) IBOutlet UILabel *lbMaxGvw;
@property (weak, nonatomic) IBOutlet UILabel *lbLength;
@property (weak, nonatomic) IBOutlet UILabel *lbFrontOverHang;
@property (weak, nonatomic) IBOutlet UILabel *lbRearOverHang;
@property (weak, nonatomic) IBOutlet UILabel *lbLicensePlate;
@property (weak, nonatomic) IBOutlet UILabel *lbProvince;
@property (weak, nonatomic) IBOutlet UILabel *lbError;
@property (weak, nonatomic) IBOutlet UILabel *lbSortDecition;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgVehicleClass;

@property (weak, nonatomic) IBOutlet UILabel *lbSep1;
@property (weak, nonatomic) IBOutlet UILabel *lbSep2;
@property (weak, nonatomic) IBOutlet UILabel *lbSep3;
@property (weak, nonatomic) IBOutlet UILabel *lbSep4;
@property (weak, nonatomic) IBOutlet UILabel *lbSep5;
@property (weak, nonatomic) IBOutlet UILabel *lbSep6;
@property (weak, nonatomic) IBOutlet UILabel *lbSep7;
@property (weak, nonatomic) IBOutlet UILabel *lbSep8;

@property (weak, nonatomic) IBOutlet UILabel *lbGroup1;
@property (weak, nonatomic) IBOutlet UILabel *lbGroup2;
@property (weak, nonatomic) IBOutlet UILabel *lbGroup3;
@property (weak, nonatomic) IBOutlet UILabel *lbGroup4;
@property (weak, nonatomic) IBOutlet UILabel *lbGroup5;
@property (weak, nonatomic) IBOutlet UILabel *lbGroup6;
@property (weak, nonatomic) IBOutlet UILabel *lbGroup7;
@property (weak, nonatomic) IBOutlet UILabel *lbGroup8;

@property (weak, nonatomic) IBOutlet UILabel *lbWeight1;
@property (weak, nonatomic) IBOutlet UILabel *lbWeight2;
@property (weak, nonatomic) IBOutlet UILabel *lbWeight3;
@property (weak, nonatomic) IBOutlet UILabel *lbWeight4;
@property (weak, nonatomic) IBOutlet UILabel *lbWeight5;
@property (weak, nonatomic) IBOutlet UILabel *lbWeight6;
@property (weak, nonatomic) IBOutlet UILabel *lbWeight7;
@property (weak, nonatomic) IBOutlet UILabel *lbWeight8;

@end
