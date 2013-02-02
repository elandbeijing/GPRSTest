//
//  MTTimeViewController.h
//  GPRSTest
//
//  Created by ElandApple02 on 13. 2. 2..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MTTimeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIButton *leftbtn;
- (IBAction)startOrstop:(id)sender;
- (IBAction)resetOrLap:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end
