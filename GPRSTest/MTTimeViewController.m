//
//  MTTimeViewController.m
//  GPRSTest
//
//  Created by ElandApple02 on 13. 2. 2..
//  Copyright (c) 2013년 ElandApple02. All rights reserved.
//

#import "MTTimeViewController.h"

@interface MTTimeViewController ()
{

    NSTimer *timer;
    BOOL checked;
    NSString *timestr;
    float time;
    float time_lap;
    NSString *timestr_lap;
    NSArray *list_time;
    NSArray *list_lap;
}

@end

@implementation MTTimeViewController

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
    _tableview.delegate=self;
    _tableview.dataSource=self;
    
    checked=YES;
    [_label setText:@"00:00:00"];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) startOrstop:(UIButton *)sender
{
    //点击切换按钮背景图
   // UIImage *newImage = (checked) ? [UIImage imageNamed:@"red.png"] : [UIImage imageNamed:@"green.png"];
   // [_leftbtn setBackgroundImage:newImage forState:UIControlStateNormal];
    
    NSString *titlel = (checked) ? (@"Stop") : (@"Start");
    [_leftbtn setTitle:titlel forState:UIControlStateNormal];
    NSString *titler = (checked) ? (@"Lap") : (@"Reset");
    [_rightBtn setTitle:titler forState:UIControlStateNormal];
    
    
    if (checked)   //start
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    }else {        //stop
        [timer invalidate];
    }
    
    checked = !checked;
}



- (IBAction) resetOrLap:(UIButton *)sender
{
    static NSInteger count = 1;
    
    if (checked) //reset
    {
        time = time_lap = 0.0;
        timestr = [NSString stringWithFormat:@"00:00:00"];
        [_label setText:timestr];
        list_time = list_lap = nil;
        count = 1;
        [_tableview reloadData];
        
    }else {      //lap
        if (list_time == nil) {
            list_time = [[NSArray alloc]initWithObjects:timestr_lap, nil];
            list_lap = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",count++], nil];
        }else {

            NSArray *array = [[NSArray alloc]initWithObjects:timestr_lap, nil];
            list_time = [array arrayByAddingObjectsFromArray:list_time];
            array = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",count++], nil];
            list_lap = [array arrayByAddingObjectsFromArray:list_lap];

        }
        time_lap = 0;
        [_tableview reloadData];
    }
}

- (float) updateTime
{
    time+=0.01;
    time_lap +=0.01;
    timestr = [NSString stringWithFormat:@"%02d:%05.2f",(int)(time / 60) ,time - ( 60 * (int)( time / 60 ) )];
    timestr_lap = [NSString stringWithFormat:@"%02d:%05.2f",(int)(time_lap / 60) ,time_lap - ( 60 * (int)( time_lap / 60 ) )];
    timestr=[timestr stringByReplacingOccurrencesOfString:@"." withString:@":"];
    timestr_lap=[timestr_lap stringByReplacingOccurrencesOfString:@"." withString:@":"];
    [_label setText:timestr];
    return time;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [list_time count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableViewIdentifier = @"tableViewIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:tableViewIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    
    cell.detailTextLabel.text = [list_time objectAtIndex:row];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:25.0];
    cell.detailTextLabel.textAlignment = UITextAlignmentCenter;
    
    NSString *text = [[NSString alloc]initWithFormat:@"lap %@", [list_lap objectAtIndex:row]];
    cell.textLabel.text = text;
    return cell;
}

- (void)viewDidUnload {
    [self setLeftbtn:nil];
    [self setRightBtn:nil];
    [self setLabel:nil];
    [self setTableview:nil];
    [super viewDidUnload];
}

@end
