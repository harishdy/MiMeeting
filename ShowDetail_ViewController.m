//
//  ShowDetail_ViewController.m
//  MiMeeting
//
//  Created by Harish Yadav on 03/01/16.
//  Copyright © 2016 Harish Yadav. All rights reserved.
//

#import "ShowDetail_ViewController.h"

@interface ShowDetail_ViewController ()

@end

@implementation ShowDetail_ViewController
@synthesize xibList,xibList1,AgendaPoints,ParticipantsList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    AgendaPoints = [[NSMutableArray alloc]init];
//    ParticipantsList = [[NSMutableArray alloc] init];
    _Careter.text = _co;
    _co_creter.text = _cr;
    _starttime.text = _st;
    _Duration.text = _hr;
    self.xibList.layoutType = WTagLayoutVertical;
    self.xibList1.layoutType = WTagLayoutVertical;
    NSArray *temp = [NSArray arrayWithArray:AgendaPoints];
    if(temp.count >0)
    {
        [self.xibList setTags:temp];
    }
    NSArray *temp1 = [NSArray arrayWithArray:ParticipantsList];
    if(temp.count >0)
    {
        [self.xibList1 setTags:temp1];
    }

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

- (IBAction)Back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
