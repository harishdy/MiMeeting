//
//  Hy_HomeScreen_ViewController.m
//  MiMeeting
//
//  Created by Harish Yadav on 31/12/15.
//  Copyright © 2015 Harish Yadav. All rights reserved.
//

#import "Hy_HomeScreen_ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Participent_AViewController.h"
#import "ShowDetail_ViewController.h"

@interface Hy_HomeScreen_ViewController ()

@end

@implementation Hy_HomeScreen_ViewController
@synthesize listOfAgenda_arr;

NSString *date;
NSDateComponents* components1;

-(void)compare :(NSString*)serverdate :(int)index
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSDate * _date = [NSDate date];
    [df setDateFormat:@"dd/MM/yyyy"];
     NSString *todaydate = [df stringFromDate:_date];
    NSDate * enddate = [df dateFromString:todaydate];
    
    
    NSDate *startdete = [df dateFromString:serverdate];
    
    
    switch ([enddate compare:startdete]){
        case NSOrderedAscending:
           //upcoming
            NSLog(@"NSOrderedAscending");
            [_Upcoming_Agenda_arr addObject:[listOfAgenda_arr objectAtIndex:index]];
            
            break;
        case NSOrderedSame:
            //today
            NSLog(@"NSOrderedSame");
            [_Today_Agenda_arr addObject:[listOfAgenda_arr objectAtIndex:index]];
            break;
        case NSOrderedDescending:
            //Past away
            NSLog(@"NSOrderedDescending");
            break;
    }
//[_TaskTable reloadData];
}
- (void)readStringFromFile {
    
    // Build the path...
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"MiMeeting.json";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    NSString *temo= [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
    
    NSDictionary *result =  [NSJSONSerialization JSONObjectWithData:[temo dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    listOfAgenda_arr = [listOfAgenda_arr mutableCopy];
    [listOfAgenda_arr removeAllObjects];
    _Upcoming_Agenda_arr = [_Upcoming_Agenda_arr mutableCopy];
    [_Upcoming_Agenda_arr removeAllObjects];
    _Today_Agenda_arr = [_Today_Agenda_arr mutableCopy];
    [_Today_Agenda_arr removeAllObjects];
    listOfAgenda_arr= [result objectForKey:@"MainAgenda"];
    for(int i = 0 ;i<listOfAgenda_arr.count;i++)
    {
        NSString *serverdate = [[listOfAgenda_arr objectAtIndex:i] objectForKey:@"MeetingDate"];
        [self compare:serverdate :i];
    }
    // The main act...
    //return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    listOfAgenda_arr = [[NSMutableArray alloc]init];
    _Upcoming_Agenda_arr = [[NSMutableArray alloc]init];
   _Today_Agenda_arr = [[NSMutableArray alloc]init];
    [self readStringFromFile];
    // Do any additional setup after loading the view.
//    _calendar = [[VRGCalendarView alloc]initWithFrame:CGRectMake(_calendar.frame.origin.x, _calendar.frame.origin.y, _calendar.frame.size.width, _calendar.frame.size.height)
//                                            scrollDirection:ScrollDirectionVertical
//                                              pagingEnabled:NO];
//    
//    _calendar.backgroundColor = [UIColor clearColor];
//    
//    _calendar.delegate = self;
//    [self.view addSubview:_calendar];
    
    
    
   VRGCalendarView* calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    _calendar.backgroundColor = [UIColor clearColor];
    [_calendar addSubview:calendar];
    
    
    _TaskTable.backgroundColor = [UIColor clearColor];
    [_TaskTable reloadData];

}
-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if(_Today_Agenda_arr.count>0)
    {
        NSInteger month1 = 0;
        NSMutableArray *day_arr = [[NSMutableArray alloc] init];
        NSMutableArray *colour_arr = [[NSMutableArray alloc] init];
        for (int i = 0 ;i<_Today_Agenda_arr.count;i++)
        {
            NSDateFormatter *df = [[NSDateFormatter alloc] init];
            [df setDateFormat:@"dd/MM/yyyy"];
            
            NSDate *currentDate = [df dateFromString:[[_Today_Agenda_arr objectAtIndex:i] objectForKey:@"MeetingDate"]];
            NSCalendar* calendar = [NSCalendar currentCalendar];
            NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
            
            month1 = [components month]; //gives you month
            NSInteger day = [components day];
            [day_arr addObject:[NSNumber numberWithInt:day]];
            [colour_arr addObject:[UIColor greenColor]];
        }
        if (month==month1) {
            
            
            NSArray *dates = [NSArray arrayWithArray:day_arr];
            NSArray *color = [NSArray arrayWithArray:colour_arr];
            [calendarView markDates:dates withColors:color];
        }
        
        
        
    }
    if(_Upcoming_Agenda_arr.count>0)
    {
        NSInteger month1 = 0;
        NSMutableArray *day_arr = [[NSMutableArray alloc] init];
        NSMutableArray *colour_arr = [[NSMutableArray alloc] init];
        
        for (int i = 0 ;i<_Upcoming_Agenda_arr.count;i++)
        {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy"];
        
        NSDate *currentDate = [df dateFromString:[[_Upcoming_Agenda_arr objectAtIndex:i] objectForKey:@"MeetingDate"]];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    components1 = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
    
     month1 = [components1 month]; //gives you month
           
            
            
            if (month==month1 ) {
                
                NSInteger day = [components1 day];
                [day_arr addObject:[NSNumber numberWithInt:day]];
                [colour_arr addObject:[UIColor redColor]];
                NSArray *dates = [NSArray arrayWithArray:day_arr];
                NSArray *color = [NSArray arrayWithArray:colour_arr];
                [calendarView markDates:dates withColors:color];
            }
            }
    if (month==month1) {
        NSInteger day = [components1 day];
        [day_arr addObject:[NSNumber numberWithInt:day]];
        [colour_arr addObject:[UIColor redColor]];
        
            NSArray *dates = [NSArray arrayWithArray:day_arr];
            NSArray *color = [NSArray arrayWithArray:colour_arr];
            [calendarView markDates:dates withColors:color];
            }
        
        
        
    }
}
-(BOOL)compare1 :(NSString*)serverdate :(int)index
{
    
    BOOL che =NO;
    for(int i =0 ; i<listOfAgenda_arr.count;i++)
    {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSDate * _date = [NSDate date];
    [df setDateFormat:@"dd/MM/yyyy"];
    NSString *todaydate = [df stringFromDate:_date];
    NSDate * enddate = [df dateFromString:[[listOfAgenda_arr objectAtIndex:i] objectForKey:@"MeetingDate"]];
    
    
    NSDate *startdete = [df dateFromString:serverdate];
    
    
    if  ([enddate compare:startdete]== NSOrderedAscending){
        che  = YES;
    }
        else
        {
            che  = NO;
        }
    }
    //[_TaskTable reloadData];
    return che;
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    NSLog(@"Selected date = %@",date);
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    
    date = [df stringFromDate:date];
//    BOOL ch = [self compare1:date :0];
//    if(ch == NO)
//    {
    [self performSegueWithIdentifier:@"showDetail" sender:[_Upcoming_Agenda_arr objectAtIndex:0]];
//    }
//    else
//    {
//        UIAlertController * alert=   [UIAlertController
//                                      alertControllerWithTitle:@"E-Agenda"
//                                      message:@"No meetings scheduled"
//                                      preferredStyle:UIAlertControllerStyleAlert];
//        
//        UIAlertAction* ok = [UIAlertAction
//                             actionWithTitle:@"OK"
//                             style:UIAlertActionStyleDefault
//                             handler:^(UIAlertAction * action)
//                             {
//                                 //Do some thing here
//                                // [self dismissViewControllerAnimated:YES completion:nil];
//                                 
//                             }];
//        [alert addAction:ok];
//        
//        [self presentViewController:alert animated:YES completion:nil];
//    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell     forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section ==0)
    {
        return _Today_Agenda_arr.count;
    }
    if(section ==1)
    {
        return _Upcoming_Agenda_arr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
        
    }
    if(indexPath.section == 0)
    {
    cell.textLabel.text =[[_Today_Agenda_arr objectAtIndex:indexPath.row] objectForKey:@"Meetingtitles"];
        cell.detailTextLabel.text = [[_Today_Agenda_arr objectAtIndex:indexPath.row] objectForKey:@"MeetingDate"];
    }
    if(indexPath.section == 1)
    {
        cell.textLabel.text =[[_Upcoming_Agenda_arr objectAtIndex:indexPath.row] objectForKey:@"Meetingtitles"];
        cell.detailTextLabel.text = [[_Upcoming_Agenda_arr objectAtIndex:indexPath.row] objectForKey:@"MeetingDate"];
    }
    // Configure the cell...
    
    return cell;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    if(section ==0)
    {
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label1 setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string =@"Today";
    /* Section header is in 0th index... */
    [label1 setText:string];
    [view addSubview:label1];
    }
    if(section ==1)
    {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
        [label1 setFont:[UIFont boldSystemFontOfSize:12]];
        NSString *string =@"Upcoming Meetings";
        /* Section header is in 0th index... */
        [label1 setText:string];
        [view addSubview:label1];
    }
    [view setBackgroundColor:[UIColor colorWithRed:166/255.0 green:177/255.0 blue:186/255.0 alpha:1.0]]; //your background color...
    return view;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = @"Today";
            break;
        case 1:
            sectionName = @"Upcoming Meetings";
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section ==0)
    {
        [self performSegueWithIdentifier:@"showDetail" sender:[_Today_Agenda_arr objectAtIndex:indexPath.row]];
    }
    if(indexPath.section ==1)
    {
        [self performSegueWithIdentifier:@"showDetail" sender:[_Upcoming_Agenda_arr objectAtIndex:indexPath.row]];
    }
 
}
-(IBAction)Back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void) SACalendar:(SACalendar*)calendar didSelectDate:(int)day month:(int)month year:(int)year
{
    //NSLog(@"Date Selected : %02i/%02i/%04i",day,month,year);
    
    date = [NSString stringWithFormat:@"%02i/%02i/%04i",day,month,year];
    
    [self performSegueWithIdentifier:@"Next" sender:self];
    
    
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetail"])
    {
        ShowDetail_ViewController *controller = (ShowDetail_ViewController *)segue.destinationViewController;
        controller.st = [sender objectForKey:@"StartTime"];
        controller.cr = [sender objectForKey:@"Createdby"];
        controller.hr = [sender objectForKey:@"Duration"];
        controller.ParticipantsList = [sender objectForKey:@"ParticipantsList"];
        controller.AgendaPoints = [sender objectForKey:@"AgendaPoints"];
        controller.co = [sender objectForKey:@"Co-Creater"];
    }
    else
    {
    Participent_AViewController *controller = (Participent_AViewController *)segue.destinationViewController;
    controller.Meeting_List = listOfAgenda_arr;
    controller.date = date;
    }
}
/**
 *  Delegate method : get called user has scroll to a new month
 */

-(void) SACalendar:(SACalendar *)calendar didDisplayCalendarForMonth:(int)month year:(int)year{
    //NSLog(@"Displaying : %@ %04i",[DateUtil getMonthString:month],year);
}
-(void)viewWillAppear:(BOOL)animated
{
    [self readStringFromFile];
    [_TaskTable reloadData];
}
@end
