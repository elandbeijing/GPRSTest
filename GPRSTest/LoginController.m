//
//  LoginController.m
//  GPRSTest
//
//  Created by ElandApple02 on 13. 1. 31..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import "LoginController.h"
#import "MapInfoController.h"

@interface LoginController ()
{
    NSArray *accountDataSource;
}

@end

@implementation LoginController

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
    self.navigationItem.title=@"Account";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"newbalance"]];
    _accountTableView.delegate=self;
    
    
    _btnRunning.backgroundColor=[UIColor redColor];
    //accountDataSource=[[NSArray alloc] initWithObjects:@"",@"",@"", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)jumpMap:(id)sender {
    
    MapInfoController *mapController=[[MapInfoController alloc] initWithNibName:@"MapInfoView" bundle:nil];
    [self.navigationController pushViewController:mapController animated:YES];
    

    
}
@end
