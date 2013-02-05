//
//  ELTableViewCell.m
//  TableView2Pre
//
//  Created by ElandApple01 on 10/10/12.
//  Copyright (c) 2012 ElandApple01. All rights reserved.
//

#import "ELTableViewCell.h"

@implementation ELTableViewCell
@synthesize lblName=_lblName;
@synthesize lblAge=_lblAge;
@synthesize  name=_name;
@synthesize age=_age;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)n
{
           // _lblName.text = n;
    if (![n isEqualToString:_name]) {
        _name = [n copy];
        _lblName.text = _name;
    }
}

- (void)setAge:(NSString *)c
{
    if (![c isEqualToString:_age]) {
        _age = [c copy];
        _lblAge.text = _age;
    }
}
@end
