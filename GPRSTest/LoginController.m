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
#import "UserInfo.h"

@interface LoginController ()
{
    NSMutableArray *accountDataSource;
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
    _accountTableView.dataSource=self;
    
    accountDataSource=[[NSMutableArray alloc] init];
    UserInfo *userInfo=[[UserInfo alloc] init];
    userInfo.title=@"height";
    userInfo.subTitle=@"1.75m";
    
    UserInfo *userInfo1=[[UserInfo alloc] init];
    userInfo1.title=@"weight";
    userInfo1.subTitle=@"64kg";
    
    UserInfo *userInfo2=[[UserInfo alloc] init];
    userInfo2.title=@"sex";
    userInfo2.subTitle=@"male";
    [accountDataSource addObject:userInfo];
    [accountDataSource addObject:userInfo1];
    [accountDataSource addObject:userInfo2];
    
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
    static NSString *identifier = @"CellTableIdentifier";
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered)
    {
        UINib *nib = [UINib nibWithNibName:@"MyCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        nibsRegistered = YES;
    }
    
    ELTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    UserInfo *userInfo= [accountDataSource objectAtIndex:[indexPath row] ];
    cell.name=userInfo.title;
    cell.age=userInfo.subTitle;
    cell.accessoryType=UITableViewCellAccessoryNone;
    return cell;
}

@end
