//
//  Hy_HomeScreen_ViewController.h
//  MiMeeting
//
//  Created by Harish Yadav on 31/12/15.
//  Copyright © 2015 Harish Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SACalendar.h"
#import "DateUtil.h"
#import "VRGCalendarView.h"

@interface Hy_HomeScreen_ViewController : UIViewController<SACalendarDelegate,VRGCalendarViewDelegate>
@property(nonatomic,retain) IBOutlet UITableView *TaskTable;
@property(nonatomic,retain) IBOutlet    UIView *calendar;
@property (nonatomic,retain) IBOutlet NSMutableArray *listOfAgenda_arr;
@property (nonatomic,retain) IBOutlet NSMutableArray *Today_Agenda_arr;
@property (nonatomic,retain) IBOutlet NSMutableArray *Upcoming_Agenda_arr;
-(IBAction)Back:(id)sender;
@end
