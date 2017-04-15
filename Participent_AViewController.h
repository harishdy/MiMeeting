//
//  Participent_AViewController.h
//  MiMeeting
//
//  Created by Harish Yadav on 01/01/16.
//  Copyright © 2016 Harish Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTagList.h"

@interface Participent_AViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,WTagListDelegate>
{
    UIViewController *popoverContent;
    
}
@property (strong, nonatomic) IBOutlet UILabel *timetxt;
@property (strong, nonatomic) IBOutlet UILabel *hours;
@property (strong, nonatomic) IBOutlet UITextField *points;
@property (strong, nonatomic) IBOutlet UITextField *Creater;
@property (strong, nonatomic) IBOutlet UITextField *co_crester;
@property (strong, nonatomic) IBOutlet UITextField *Participant;
@property (strong, nonatomic) IBOutlet WTagList *xibList;
@property (strong, nonatomic) IBOutlet WTagList *xibList1;
@property (strong, nonatomic) IBOutlet NSString *date;
- (IBAction)Back:(id)sender;
-(IBAction)SelectStartdateTime:(id)sender;
- (IBAction)addNewTag:(id)sender;
- (IBAction)NewTag:(id)sender;
- (IBAction)save:(id)sender;

-(IBAction)TilleHour:(id)sender;
@property (nonatomic,retain) NSMutableArray *Meeting_List;
@property (nonatomic,retain) NSMutableArray *AgendaPoints;
@property (nonatomic,retain) NSMutableArray *ParticipantsList;

@property (nonatomic,retain) UIDatePicker *Starttime;
@property (nonatomic,retain) UIPickerView *hourPicker;
@end
