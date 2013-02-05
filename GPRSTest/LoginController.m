//
//  LoginController.m
//  GPRSTest
//
//  Created by ElandApple02 on 13. 1. 31..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import "LoginController.h"
#import "MapInfoController.h"
#import "ELTableViewCell.h"

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return accountDataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSString *identifier=@"mainTableView";
    //        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    //    if(cell==nil)
    //    {
    //        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    //    }
    //    NSString *title= [dataSourceTableView objectAtIndex:[indexPath row] ];
    //    cell.textLabel.text=title;
    //    cell.detailTextLabel.text=title;
    //    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    //    return cell;
    static NSString *identifier = @"CellTableIdentifier";
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"MyCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        nibsRegistered = YES;
    }
    
    ELTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSString *title= [accountDataSource objectAtIndex:[indexPath row] ];
    cell.name=title;
    cell.age=title;
    cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

@end
