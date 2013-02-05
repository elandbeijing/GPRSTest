//
//  ELTableViewCell.h
//  TableView2Pre
//
//  Created by ElandApple01 on 10/10/12.
//  Copyright (c) 2012 ElandApple01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblName;

@property (strong, nonatomic) IBOutlet UILabel *lblAge;

@property (copy,nonatomic) NSString *name;
@property(copy,nonatomic) NSString *age;
@end
