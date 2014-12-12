//
//  GVDetailViewController.m
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import "GVDetailViewController.h"
#import "GVLoginViewController.h"
#import "GVLoadingDetailViewController.h"
#import "GVAppDelegate.h"
#import "WimDao.h"
#import "ShowWimDetailController.h"

@interface GVDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation GVDetailViewController

@synthesize tvWim;
#pragma mark - Managing the detail item

- (void)setStationItem:(StationModel*)stationItem
{
    if (_stationItem != stationItem) {
        _stationItem = stationItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.stationItem) {
        //Timer to get new data
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(updateTable) userInfo:nil repeats:YES];
    }
}

- (void)updateTable
{

        self.wimData = [[WimDao WimDao] getWimByCondition:self.stationItem.StationID andLane:[NSString stringWithFormat:@"%ld", (long)_layoutSegmented.selectedSegmentIndex]];
    
        [tvWim reloadData];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Do any additional setup after loading the view, typically from a nib.
    fileManager = [NSFileManager defaultManager];
    NSArray   *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [paths objectAtIndex:0];
    
    wimService = [[WimService alloc] init];
    
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        // if we are in portrait mode and we are not authenticated, we need to invoke the login screen.
        // Note that this is necessary because in portrait mode, the master view's viewWillAppear will not
        // be called until its popover is displayed.
        if(UIInterfaceOrientationIsPortrait(self.interfaceOrientation)
           && ![(GVAppDelegate*)[[UIApplication sharedApplication] delegate] authenticated])
        {
            // display login screen if we are not authenticated.
            NSLog(@"Not authenticated and in portrait, put up login screen.");
            GVLoginViewController *vc =  (GVLoginViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
            [vc setModalPresentationStyle:UIModalPresentationFullScreen];
            [self presentViewController:vc animated:NO completion:nil];
            
        }
    

        /*
        else if(self.stationItem == nil) {
            // display the alternate view if we have no data.
            NSLog(@"No data! loading detail view will appear as alternate until we have data.");
            DetailViewManager* dvm = (DetailViewManager*)self.splitViewController.delegate;
            dvm.detailViewController = dvm.loadingDetailViewController;
        }
         */
    }else{
        [[UIDevice currentDevice] setValue:
         [NSNumber numberWithInteger: UIInterfaceOrientationLandscapeLeft]
                                    forKey:@"orientation"];
    }
     
}
-(void)viewWillDisappear:(BOOL)animated{
    
    
    [[UIDevice currentDevice] setValue:@(UIInterfaceOrientationPortrait)
                                forKey:@"orientation"];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark SubstitutableDetailViewController

// -------------------------------------------------------------------------------
//	setNavigationPaneBarButtonItem:
//  Custom implementation for the navigationPaneBarButtonItem setter.
//  In addition to updating the _navigationPaneBarButtonItem ivar, it
//  reconfigures the toolbar to either show or hide the
//  navigationPaneBarButtonItem.
// -------------------------------------------------------------------------------
- (void)setNavigationPaneBarButtonItem:(UIBarButtonItem *)navigationPaneBarButtonItem
{
    [self.navigationItem setLeftItemsSupplementBackButton:YES];
    if (navigationPaneBarButtonItem != _navigationPaneBarButtonItem) {
        if (navigationPaneBarButtonItem) {
            [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObject:navigationPaneBarButtonItem]  animated:NO];
        } else {
            [self.navigationItem setLeftBarButtonItem:nil animated:NO];
        }
        _navigationPaneBarButtonItem = navigationPaneBarButtonItem;
    }
}



- (IBAction)layoutSegmented:(id)sender {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WimModel *wim = (WimModel *)[self.wimData objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UILabel *lbStationName = (UILabel *)[cell viewWithTag:1];
    lbStationName.text = wim.StationName;
    
    UILabel *lbTimeSamp = (UILabel *)[cell viewWithTag:2];
    lbTimeSamp.text = wim.TimeStamp;
    
    //col 1
    UILabel *lbVehicleNumber = (UILabel *)[cell viewWithTag:3];
    lbVehicleNumber.text = wim.VehicleNumber;
    UILabel *lbLane = (UILabel *)[cell viewWithTag:4];
    lbLane.text = wim.Lane;
    
    UILabel *lbClass = (UILabel *)[cell viewWithTag:5];
    lbClass.text = wim.VehicleClass;
    //col 2
    UILabel *lbSortDecision = (UILabel *)[cell viewWithTag:6];
    lbSortDecision.text = wim.SortDecision;
    
    UILabel *lbMaxGvw = (UILabel *)[cell viewWithTag:7];
    lbMaxGvw.text = wim.MaxGVW;
    UILabel *lbGvw = (UILabel *)[cell viewWithTag:8];
    lbGvw.text = wim.GVW;
    //col 3
    UILabel *lbLicensePlate = (UILabel *)[cell viewWithTag:9];
    lbLicensePlate.text = wim.LicensePlateNumber;
    UILabel *lbProvince = (UILabel *)[cell viewWithTag:10];
    lbProvince.text = wim.ProvinceName;
    
    
    UIView *lvView = (UIView *)[cell viewWithTag:19];
    if([wim.StatusColor isEqualToString:@"Color [LawnGreen]"]){
        lvView.backgroundColor = [UIColor greenColor];
        
    }else
    {
        lvView.backgroundColor = [UIColor redColor];
    }
    
   

    
    if(![wim.Image01Name isEqualToString:@"-"]){
        
        UIImageView *img1 = (UIImageView *)[cell viewWithTag:112];
        
        UIActivityIndicatorView *spinner1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner1 setCenter:CGPointMake(CGRectGetWidth(img1.bounds)/2, CGRectGetHeight(img1.bounds)/2)];
        [spinner1 setColor:[UIColor grayColor]];
        
        [img1 addSubview:spinner1];
        
        [spinner1 startAnimating];
        
        CGSize rect = CGSizeMake(112,90);
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[wim.Image01Name lastPathComponent]];
        if ([fileManager fileExistsAtPath:filePath]){
            
            img1.image =[self imageWithImage:[UIImage imageWithContentsOfFile:filePath] scaledToSize:rect];
            [spinner1 stopAnimating];
        }else{
            // download the image asynchronously
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //NSLog(@"Books: Downloading Started");
                NSURL  *url = [NSURL URLWithString:wim.Image01Name];
                NSLog(@"img url:%@",url);
                NSData *urlData = [NSData dataWithContentsOfURL:url];
                if ( urlData )
                {
                    //saving is done on main thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [urlData writeToFile:filePath atomically:YES];
                        //NSLog(@"Books: File Saved !");
                        
                        

                        img1.image = [self imageWithImage:[UIImage imageWithData:urlData]scaledToSize:rect];
                        
                        [spinner1 stopAnimating];
                    });
                }
            }
                           );}
        
    }
    
    if(![wim.Image02Name isEqualToString:@"-"]){
        
        UIImageView *img2 = (UIImageView *)[cell viewWithTag:113];
        
        UIActivityIndicatorView *spinner1 = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner1 setCenter:CGPointMake(CGRectGetWidth(img2.bounds)/2, CGRectGetHeight(img2.bounds)/2)];
        [spinner1 setColor:[UIColor grayColor]];
        
        [img2 addSubview:spinner1];
        
        [spinner1 startAnimating];
        
        CGSize rect = CGSizeMake(112,90);
        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,[wim.Image02Name lastPathComponent]];
        if ([fileManager fileExistsAtPath:filePath]){
            
            img2.image =[self imageWithImage:[UIImage imageWithContentsOfFile:filePath] scaledToSize:rect];
            [spinner1 stopAnimating];
        }else{
            // download the image asynchronously
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //NSLog(@"Books: Downloading Started");
                NSURL  *url = [NSURL URLWithString:wim.Image02Name];
                NSLog(@"img url:%@",url);
                NSData *urlData = [NSData dataWithContentsOfURL:url];
                if ( urlData )
                {
                    //saving is done on main thread
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [urlData writeToFile:filePath atomically:YES];
                        //NSLog(@"Books: File Saved !");
                        
                        
                        
                        img2.image = [self imageWithImage:[UIImage imageWithData:urlData]scaledToSize:rect];
                        
                        [spinner1 stopAnimating];
                    });
                }
            }
                           );}
        
    }
    
    // Assign our own background image for the cell
    
    //UIImage *background = [self cellBackgroundForRowAtIndexPath:indexPath];
    
    //UIImageView *cellBackgroundView = [[UIImageView alloc] initWithImage:background];
    //cellBackgroundView.image = background;
    //cell.backgroundView = cellBackgroundView;
    
    return cell;
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/*
- (UIImage *)cellBackgroundForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger rowCount = [self tableView:[self wimData] numberOfRowsInSection:0];
    NSInteger rowIndex = indexPath.row;
    UIImage *background = nil;
    
    if (rowIndex == 0) {
        background = [UIImage imageNamed:@"tableRow.jpg"];
    } else if (rowIndex == rowCount - 1) {
        background = [UIImage imageNamed:@"tableRow.jpg"];
    } else {
        background = [UIImage imageNamed:@"tableRow.jpg"];
    }
    
    return background;
    
}
*/


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ShowWimDetailController *transferViewController = segue.destinationViewController;
    
    NSLog(@"prepareForSegue: %@", segue.identifier);
    if([segue.identifier isEqualToString:@"showWimDetail"])
    {
        
        NSIndexPath *indexPath = [self.tvWim indexPathForSelectedRow];
        NSArray *info = self.wimData[indexPath.row];
        
        [transferViewController setWimDetailItem:info];
    }
    
}
#pragma mark -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.wimData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}

@end
