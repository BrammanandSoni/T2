//
//  ViewController.m
//  T2
//
//  Created by Brammanand on 25/12/14.
//  Copyright (c) 2014 Telibrahma. All rights reserved.
//

#import "ViewController.h"
#import "GetAlarmsViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *alarmTextField;

- (IBAction)setAlarmPressed:(UIButton *)sender;


@end

@implementation ViewController
@synthesize alarmTextField;
@synthesize datePicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.title = @"Set Alarm";
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:10];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Alarms" style:UIBarButtonItemStylePlain target:self action:@selector(getAlarms)];
}

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [self setAlarmTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)getAlarms
{
    GetAlarmsViewController *alarmVC = [[GetAlarmsViewController alloc] initWithNibName:@"GetAlarmsViewController" bundle:nil];
    [self.navigationController pushViewController:alarmVC animated:YES];
}

- (IBAction)setAlarmPressed:(UIButton *)sender {
    if (self.alarmTextField.text.length > 0) {
        [self scheduleAlarmWithText:alarmTextField.text andDate:[datePicker date]];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Field missing !" message:@"Please enter alarm title" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)scheduleAlarmWithText:(NSString *)text andDate:(NSDate *)date
{
    UILocalNotification *notif = [[UILocalNotification alloc] init];
    notif.fireDate = date;
    notif.timeZone = [NSTimeZone defaultTimeZone];
    notif.alertBody = text;
    notif.alertAction = @"Snooze";
    notif.soundName = @"alarm.wav";
    notif.userInfo = [NSDictionary dictionaryWithObject:alarmTextField.text forKey:kAlarmNotificationKey];
    [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    NSLog(@"notification = %@",notif);
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
