//
//  LoginController.h
//  GPRSTest
//
//  Created by ElandApple02 on 13. 1. 31..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *accountTableView;

- (IBAction)jumpMap:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *btnRunning;

@end
