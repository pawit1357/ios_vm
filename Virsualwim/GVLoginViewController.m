//
//  GVLoginViewController.m
//  MasterDetailWithLogin
//
//  Created by Jonathan Engelsma on 9/6/13.
//  Copyright (c) 2013 Jonathan Engelsma. All rights reserved.
//

#import "GVLoginViewController.h"
#import "GVAppDelegate.h"

@interface GVLoginViewController ()

@end

@implementation GVLoginViewController

@synthesize txtUsername,txtPassword;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    wimService = [[WimService alloc]init];
    configDao = [[ConfigDao alloc] init];
    
    GVAppDelegate* shared=[UIApplication sharedApplication].delegate;
    shared.blockRotation=YES;
    /*
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        
                           self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"splash-ipad-portrait.png"]];
        
    }else{
      self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"splash-iphone-gen5-2x.png"]];
    }

    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
           self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"splash-ipad-landcape.png"]];
        }else{
            
        }
    }else{
            self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"splash-ipad-portrait.png"]];
    }
        */

}

-(void)viewWillDisappear:(BOOL)animated{
    GVAppDelegate* shared=[UIApplication sharedApplication].delegate;
    shared.blockRotation=NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnLogin:(id)sender {
    
    if (![txtUsername.text isEqualToString:@""] && ![txtPassword.text isEqualToString:@""]){
        if ( [wimService userAuthenticated:txtUsername.text andWithPassword:txtPassword.text] ){
            
            
            GVAppDelegate *ad = (GVAppDelegate*)[[UIApplication sharedApplication] delegate];
            ad.authenticated = YES;
            [self dismissViewControllerAnimated:NO completion:nil];
        }else{
            UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Login" message:@"Please verify your password." delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
            alert.tag = 1234;
            [alert addButtonWithTitle:@"OK"];
            [alert show];
        }
    }else{
        UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"Login" message:@"Please enter username/password." delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
        alert.tag = 1234;
        [alert addButtonWithTitle:@"OK"];
        [alert show];
    }
    
}

- (IBAction)btnCancel:(id)sender {
    
    [self viewWillAppear:YES];
}
@end
