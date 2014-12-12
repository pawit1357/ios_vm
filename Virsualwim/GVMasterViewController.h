//
//  GVMasterViewController.h
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewManager.h"
#import "ConfigDao.h"

@interface GVMasterViewController : UITableViewController{
    ConfigDao *configDao;
}
@property (strong, nonatomic) DetailViewManager *detailViewManager;
@property (strong, nonatomic) NSMutableArray *stationList;
@end
