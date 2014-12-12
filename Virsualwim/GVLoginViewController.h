//
//  GVLoginViewController.h
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GVMasterViewController.h"
#import "WimService.h"

@interface GVLoginViewController : UIViewController{
    ConfigDao *configDao;
    WimService *wimService;
}

@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnLogin:(id)sender;
- (IBAction)btnCancel:(id)sender;


@end
