//
//  GVMasterViewController.m
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import "GVMasterViewController.h"
#import "GVDetailViewController.h"
#import "GVLoginViewController.h"
#import "GVLoadingDetailViewController.h"
#import "GVAppDelegate.h"
#import "StationDao.h"
#import "StationModel.h"
#import "GVAppDelegate.h"

@interface GVMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation GVMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        self.detailViewManager = [[DetailViewManager alloc] init];
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    configDao = [[ConfigDao alloc] init];
    self.stationList  = [[StationDao StationDao] getAll];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
        // store the "normal" detail view and its containing nav controller as props for future convenience.
        self.detailViewManager.loadedDetailViewController = (GVDetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
        self.detailViewManager.detailNavCtrl = (UINavigationController *) [self.splitViewController.viewControllers lastObject];
        
        // tell the mgr about the detail, so buttons get added if needed.  We default with the loadedDetailViewController.
        self.detailViewManager.detailViewController = self.detailViewManager.loadedDetailViewController;
        
        // load up the alternate loading detail... we'll need it shortly!
        self.detailViewManager.loadingDetailViewController = (GVLoadingDetailViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"LoadingDetailViewController"];
        [self.detailViewManager.loadingDetailViewController view]; // force the outlets to be bound.
    }
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(![(GVAppDelegate*)[[UIApplication sharedApplication] delegate] authenticated])
    {
        NSLog(@"not authenticated, put up login screen.");
        UIStoryboard *storyboard;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil];
        } else {
            storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
        }
        GVLoginViewController *vc =  (GVLoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [vc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:vc animated:NO completion:nil];
    }


}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        StationModel *station = self.stationList[indexPath.row];
        [[segue destinationViewController] setStationItem:station];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    
    GVLoginViewController *vc =  (GVLoginViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
    [vc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:vc animated:NO completion:nil];
    
    GVAppDelegate* shared=[UIApplication sharedApplication].delegate;
    shared.blockRotation=YES;
    
 /*
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // on iPad, when we add our first item we want to force the detail page
    // to reload if necessary.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        if(_objects.count == 1) {
            self.detailViewManager.loadedDetailViewController.stationItem = [_objects objectAtIndex:0];
            self.detailViewManager.detailViewController = self.detailViewManager.loadedDetailViewController;
        }
    }
    */
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stationList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // TODO: do we really need this?
    // on iPad, replace the loading detail view if we now have  data.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        UIViewController *vc = [self.splitViewController.viewControllers lastObject];
        if((_objects.count > 0) && ([vc class] ==  [GVLoadingDetailViewController class])) {
            NSLog(@"We have data, replacing detail view with normal view.");
            self.detailViewManager.detailViewController = self.detailViewManager.loadedDetailViewController;
        }
    }
    NSDate *object = _objects[indexPath.row];
    cell.textLabel.text = [object description];
    */
    
    StationModel *station = (StationModel *)[self.stationList objectAtIndex:indexPath.row];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = station.StationName;
    cell.detailTextLabel.text = @" ";
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 22.0)];
    
    // create the button object
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.highlightedTextColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:10];
    headerLabel.frame = CGRectMake(0.0, 0.0, 320.0, 22.0);
    
    
    headerLabel.text = @"  SELECT STATION :"; // i.e. array element
    
    [customView addSubview:headerLabel];
    
    return customView;
}
/*
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        // on iPad, after delete if we have no data, we switch back to our loading detail view.
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            if(_objects.count == 0 )
            {
                self.detailViewManager.detailViewController = self.detailViewManager.loadingDetailViewController;
            }
        }
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
*/
/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.detailViewManager.loadedDetailViewController.stationItem = self.stationList[indexPath.row];
    }
}


@end
