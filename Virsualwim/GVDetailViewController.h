//
//  GVDetailViewController.h
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "DetailViewManager.h"
#import "StationModel.h"
#import "WimService.h"

@interface GVDetailViewController : UIViewController <SubstitutableDetailViewController,UITableViewDataSource,UITableViewDelegate>{
    NSFileManager *fileManager;
    NSString *documentsDirectory;
    WimService *wimService;
}
@property (weak, nonatomic) IBOutlet UITableView *tvWim;
@property (weak, nonatomic) IBOutlet UISegmentedControl *layoutSegmented;

- (IBAction)layoutSegmented:(id)sender;

@property (strong, nonatomic) NSMutableArray *wimData;
@property (strong, nonatomic) StationModel *stationItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

/// SubstitutableDetailViewController
@property (nonatomic, retain) UIBarButtonItem *navigationPaneBarButtonItem;
@end
