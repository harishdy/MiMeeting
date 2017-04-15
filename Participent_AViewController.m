//
//  Participent_AViewController.m
//  MiMeeting
//
//  Created by Harish Yadav on 01/01/16.
//  Copyright © 2016 Harish Yadav. All rights reserved.
//

#import "Participent_AViewController.h"

@interface Participent_AViewController ()

@end

@implementation Participent_AViewController
@synthesize Starttime,hourPicker,Meeting_List;

NSMutableArray *hour_arr;

- (NSString*)readStringFromFile {
    
    // Build the path...
    NSString* filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* fileName = @"MiMeeting.json";
    NSString* fileAtPath = [filePath stringByAppendingPathComponent:fileName];
    
    // The main act...
    return [[NSString alloc] initWithData:[NSData dataWithContentsOfFile:fileAtPath] encoding:NSUTF8StringEncoding];
}

- (IBAction)addNewTag:(id)sender {
    NSString *text = self.points.text;
    if (text.length) {
        int i =0;
       if(_AgendaPoints.count>0)
       {
           int j = _AgendaPoints.count+1;
               i = j;
           
       }
        else
        {
            i =1;
        }
        NSString *temp = [NSString stringWithFormat:@"%i.%@",i,self.points.text];
        [_AgendaPoints addObject:temp];
         [self.xibList addTag:temp];
    }
    self.points.text = @"";
    
    if([sender isKindOfClass:[UIButton class]])
        [self removeKeyboard:nil];
    else
        [self.points performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.5];
}

- (IBAction)NewTag:(id)sender {
    NSString *text = self.Participant.text;
    if (text.length) {
        int i =0;
        if(_ParticipantsList.count>0)
        {
            int j = _ParticipantsList.count+1;
            i = j;
            
        }
        else
        {
            i =1;
        }
        NSString *temp = [NSString stringWithFormat:@"%i.%@",i,self.Participant.text];
        [_ParticipantsList addObject:temp];
        [self.xibList1 addTag:temp];
    }
    self.Participant.text = @"";
    
    if([sender isKindOfClass:[UIButton class]])
        [self removeKeyboard:nil];
    else
        [self.Participant performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0.5];
}

- (IBAction)save:(id)sender {
    [self readDataFromFile];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _AgendaPoints = [[NSMutableArray alloc] init];
    _ParticipantsList = [[NSMutableArray alloc] init];
    self.xibList.layoutType = WTagLayoutVertical;
    self.xibList1.layoutType = WTagLayoutVertical;
    
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
   hour_arr = [[NSMutableArray alloc]initWithObjects:@"None",@"0 minutes",@"5 minutes",@"10 minutes",@"15 minutes",@"30 minutes",@"1 Hour(s)",@"2 Hour(s)",@"3 Hour(s)",@"4 Hour(s)",@"5 Hour(s)",@"6 Hour(s)",@"6 Hour(s)",@"7 Hour(s)",@"8 Hour(s)",@"9 Hour(s)",@"10 Hour(s)",@"11 Hour(s)",@"0.5 day",@"1 day",@"2 day",@"3 day",@"4 day",@"1 Week",@"2 Week", nil];
    //[self readDataFromFile];
}

-(void) removeKeyboard:(id) sender {
    [self.view endEditing:NO];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)StartDateSelected:(id)sender
{
    UIDatePicker * datePicker = (UIDatePicker*)Starttime;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@" hh:mm a "];
    
    NSString *sttile = [df stringFromDate:datePicker.date];
    
    _timetxt.text = sttile;
    [popoverContent dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)SelectStartdateTime:(id)sender
{
    //build our custom popover view
    UIView *v = [[UIView alloc] init];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,320, 40)];
    UIBarButtonItem *buttonOne = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(CancelSDatePiker)];
    
    UIBarButtonItem *buttonTwo = [[UIBarButtonItem alloc] initWithTitle:@"Select" style:UIBarButtonItemStyleBordered target:self action:@selector(StartDateSelected:)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    
    NSArray *buttons = [NSArray arrayWithObjects: buttonOne,flexibleSpace, buttonTwo, nil];
    [toolBar setItems: buttons animated:NO];
    
//    [v addSubview:toolBar];
//    toolBar.backgroundColor = [UIColor redColor];
    
    
    
    CGRect pickerFrame = CGRectMake(0, 40, 320, 216);
    Starttime=[[UIDatePicker alloc] initWithFrame:pickerFrame];
    Starttime.datePickerMode = UIDatePickerModeTime;
    [Starttime addTarget:self
                  action:@selector(toolbarButtonPressed2:)
        forControlEvents:UIControlEventValueChanged];
    [v addSubview:Starttime];
    
    
    
//    popoverContent = [[UIViewController alloc]init];
//    popoverContent.view = v;
//
//    
//    popoverContent.modalPresentationStyle = UIModalPresentationPopover;
//    popoverContent.popoverPresentationController.sourceView = sender;
//    [self presentViewController:popoverContent animated:YES completion:nil];
    
    UIViewController *popoverContent = [[UIViewController alloc]init];
    popoverContent.view = v;
    popoverContent.contentSizeForViewInPopover = CGSizeMake(320, 216);
    //create a popover controller with my DatePickerViewController in it
    UIPopoverController *popoverControllerForStartDate = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
    //Set the delegate to self to receive the data of the Datepicker in the popover
    popoverControllerForStartDate.delegate = self;
    //Present the popover
    [popoverControllerForStartDate presentPopoverFromRect:[sender frame]
                                                   inView:self.view
                                 permittedArrowDirections:UIPopoverArrowDirectionAny
                                                 animated:YES];

    
    
}
-(void)toolbarButtonPressed2:(id)sender
{
    UIDatePicker * datePicker = (UIDatePicker*)sender;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@" hh:mm a "];
    
    NSString *sttile = [df stringFromDate:datePicker.date];
     _timetxt.text = sttile;
   
}

-(IBAction)TilleHour:(id)sender
{
    //
    
    //build our custom popover view
    UIView *v = [[UIView alloc] init];
    CGRect pickerFrame = CGRectMake(0, 160, 320, 100);
    hourPicker =[[UIPickerView alloc] initWithFrame:pickerFrame];
    
    [v addSubview:hourPicker];
    
    UIViewController *popoverContent = [[UIViewController alloc]init];
    popoverContent.view = v;
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(100, 10, 300, 60)];
    title.textColor = [UIColor purpleColor];
    title.text = @"Select Duration";
    //[title setCenter:popoverContent.view.center];
    [popoverContent.view addSubview:title];
    
    popoverContent.contentSizeForViewInPopover = CGSizeMake(320, 100);
    hourPicker.delegate = self;
    hourPicker.dataSource = self;
    //create a popover controller with my DatePickerViewController in it
    UIPopoverController *popoverControllerForDate = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
    //Set the delegate to self to receive the data of the Datepicker in the popover
    popoverControllerForDate.delegate = self;
    //Present the popover
    [popoverControllerForDate presentPopoverFromRect:[sender frame]
                                              inView:self.view
                            permittedArrowDirections:UIPopoverArrowDirectionAny
                                            animated:YES];
    
    
}
-(int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return hour_arr.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return hour_arr[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _hours.text = [hour_arr objectAtIndex:row];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)readDataFromFile
{
    NSDate *createdate = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    
    NSString *edtile = [df stringFromDate:createdate];
    
    NSMutableDictionary *Temp_Main_Dic = [[NSMutableDictionary alloc]init];


    [Temp_Main_Dic setObject:_Creater.text forKey:@"Createdby"];
    [Temp_Main_Dic setObject:edtile forKey:@"CreatedDate"];
    [Temp_Main_Dic setObject:_date forKey:@"MeetingDate"];
    [Temp_Main_Dic setObject:_timetxt.text forKey:@"StartTime"];
    [Temp_Main_Dic setObject:_co_crester.text forKey:@"Co-Creater"];
    [Temp_Main_Dic setObject:_hours.text forKey:@"Duration"];
    NSArray *te1 = [NSArray arrayWithArray:_ParticipantsList];
    NSArray *te = [NSArray arrayWithArray:_AgendaPoints];
    
    [Temp_Main_Dic setObject:te1 forKey:@"ParticipantsList"];//Arr
    [Temp_Main_Dic setObject:te forKey:@"AgendaPoints"];//Arr
    if(Meeting_List.count>0)
    {
    Meeting_List = [Meeting_List mutableCopy];
    [Meeting_List addObject:Temp_Main_Dic];
    }
    else
    {
        Meeting_List = [[NSMutableArray alloc]init];
          [Meeting_List addObject:Temp_Main_Dic];
    }
    NSMutableDictionary *test = [NSMutableDictionary new];
    [test setObject:Meeting_List forKey:@"MainAgenda"];

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"MiMeeting.json"];
    
    NSLog(@"filePath %@", filePath);
    NSString *jsonString;
    if(!_AgendaPoints || _AgendaPoints.count ==0)
    {
        jsonString = @"[""]";
    }
    else
    {
        NSError *error= nil;
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:test
                                                           options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        

        
        //NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:_AgendaPoints options:NSJSONWritingPrettyPrinted error:&error];
        //jsonString = [[NSString alloc] initWithData:jsonData2 encoding:NSUTF8StringEncoding];
        NSLog(@"%@",jsonString);
    }

    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) { // if file is not exist, create it.
        NSString *helloStr = @"";
        NSError *error;
        [helloStr writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    
    if ([[NSFileManager defaultManager] isWritableFileAtPath:filePath]) {
        NSLog(@"Writable");
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:test
                                                           options:NSJSONWritingPrettyPrinted error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [jsonString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];

    }else {
        NSLog(@"Not Writable");
    }

    
    
  
}


-(IBAction)Back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
