//
//  GetAlarmsViewController.m
//  T2
//
//  Created by Brammanand on 25/12/14.
//  Copyright (c) 2014 Telibrahma. All rights reserved.
//

#import "GetAlarmsViewController.h"
#import "AppDelegate.h"

@interface GetAlarmsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSDateFormatter *dateFormatter;
}
@property (weak, nonatomic) IBOutlet UILabel *noAlarmLabel;

@property (nonatomic, strong) NSArray *scheduledAlarmArray;
@property (weak, nonatomic) IBOutlet UITableView *alarmsViewController;

@end

@implementation GetAlarmsViewController
@synthesize noAlarmLabel;
@synthesize alarmsViewController,scheduledAlarmArray;

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
    // Do any additional setup after loading the view from its nib.
    self.title = @"Alarms";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStylePlain target:self action:@selector(clearAlarms)];
    
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    self.scheduledAlarmArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    if (self.scheduledAlarmArray.count > 0) {
        self.noAlarmLabel.hidden = YES;
    }
    else {
        self.noAlarmLabel.hidden = NO;
        [self.navigationItem setRightBarButtonItem:nil];
    }
}

- (void)viewDidUnload
{
    [self setAlarmsViewController:nil];
    [self setNoAlarmLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)clearAlarms
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alarm" message:@"Are you sure to clear all alarms ?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Clear", nil];
    [alert show];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.scheduledAlarmArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    UILocalNotification *schduledlarm = (UILocalNotification *)[self.scheduledAlarmArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [schduledlarm.userInfo objectForKey:kAlarmNotificationKey];
    cell.detailTextLabel.text = [dateFormatter stringFromDate:schduledlarm.fireDate];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UILocalNotification *alarmNotif = (UILocalNotification *)[self.scheduledAlarmArray objectAtIndex:indexPath.row];
        [[UIApplication sharedApplication] cancelLocalNotification:alarmNotif];
        self.scheduledAlarmArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark - UIAlertViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
