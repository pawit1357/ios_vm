//
//  ShowWimDetailController.m
//  virsualwim
//
//  Created by pawit on 9/14/2557 BE.
//  Copyright (c) 2557 Department of Highways. All rights reserved.
//

#import "ShowWimDetailController.h"
#import "WimModel.h"

@interface ShowWimDetailController ()

@end

@implementation ShowWimDetailController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    fileManager = [NSFileManager defaultManager];
    NSArray   *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    
    
    // Do any additional setup after loading the view.
     [self configureView];
    
}

-(void) setWimDetailItem:(id)newWimDetailItem{
    
    if(_wimDetailItem != newWimDetailItem){
        _wimDetailItem = newWimDetailItem;
    }
    
        [self configureView];
}

-(void) configureView{
    if(_wimDetailItem){
        
        WimModel *model = (WimModel*)_wimDetailItem;
        /*
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // retrive image on global queue
            UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgpath]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // assign cell image on main thread
                self.imgCamera1.image = img;
                self.imgCamera2.image = img;
            });
        });
        */
        
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[model.Image01Name lastPathComponent]];
        if ([fileManager fileExistsAtPath:filePath]){
            
            self.imgCamera1.image =[UIImage imageWithContentsOfFile:filePath];
        }
        
        filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[model.Image02Name lastPathComponent]];
        if ([fileManager fileExistsAtPath:filePath]){
            
            self.imgCamera2.image =[UIImage imageWithContentsOfFile:filePath];
        }
    
        NSString *iVCPath = [NSString stringWithFormat:@"class%@.jpg",model.VehicleClass ];
        
        NSString *trimmed = [iVCPath stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        self.imgVehicleClass.image =[UIImage imageNamed:trimmed];
        
        self.lbWimId.text = [NSString stringWithFormat:@"%ld", (long)model.WIMID] ;
        self.lbStation.text = model.StationName;
        
        NSRange rangeDate = NSMakeRange(0,10);
        NSRange rangeTime = NSMakeRange(11,8);
       
        self.lbDate.text =  [model.TimeStamp  substringWithRange:rangeDate];
        self.lbTime .text = [model.TimeStamp  substringWithRange:rangeTime];
        self.lbVehicleNumber.text = model.VehicleNumber;
        self.lbLane.text = model.Lane;
        self.lbVehicleClass.text = model.VehicleClass;
        self.lbSortDecition.text = model.SortDecision;
        self.lbMaxGvw.text = model.MaxGVW;
        self.lbWimGvw.text = model.GVW;
        self.lbLicensePlate.text = model.LicensePlateNumber;
        self.lbProvince.text = model.ProvinceName;
        self.lbStatus.text = model.StatusCode;
        
        self.lbSpeed.text = model.Speed;
        self.lbESAL.text = [model.ESAL substringWithRange:NSMakeRange(0,7)];
        self.lbAxleCount.text = model.AxleCount;
        self.lbLength.text = model.Length;
        self.lbFrontOverHang.text = model.FrontOverHang;
        self.lbRearOverHang.text = model.RearOverHang;
        
        
        
        self.lbSep1.text = model.Axle01Seperation;
        self.lbSep2.text = model.Axle02Seperation;
        self.lbSep3.text = model.Axle03Seperation;
        self.lbSep4.text = model.Axle04Seperation;
        self.lbSep5.text = model.Axle05Seperation;
        self.lbSep6.text = model.Axle06Seperation;
        self.lbSep7.text = model.Axle07Seperation;
        self.lbSep8.text = model.Axle08Seperation;

        self.lbGroup1.text = model.Axle01Group;
        self.lbGroup2.text = model.Axle02Group;
        self.lbGroup3.text = model.Axle03Group;
        self.lbGroup4.text = model.Axle04Group;
        self.lbGroup5.text = model.Axle05Group;
        self.lbGroup6.text = model.Axle06Group;
        self.lbGroup7.text = model.Axle07Group;
        self.lbGroup8.text = model.Axle08Group;
   
        self.lbWeight1.text = model.Axle01Weight;
        self.lbWeight2.text = model.Axle02Weight;
        self.lbWeight3.text = model.Axle03Weight;
        self.lbWeight4.text = model.Axle04Weight;
        self.lbWeight5.text = model.Axle05Weight;
        self.lbWeight6.text = model.Axle06Weight;
        self.lbWeight7.text = model.Axle07Weight;
        self.lbWeight8.text = model.Axle08Weight;
        
    }
}

@end
