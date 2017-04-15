//
//  ShowDetail_ViewController.h
//  MiMeeting
//
//  Created by Harish Yadav on 03/01/16.
//  Copyright © 2016 Harish Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTagList.h"

@interface ShowDetail_ViewController : UIViewController<WTagListDelegate>
@property (strong, nonatomic) IBOutlet WTagList *xibList1;
@property (strong, nonatomic) IBOutlet WTagList *xibList;
@property (strong, nonatomic)NSMutableArray*AgendaPoints;
@property (strong, nonatomic)NSMutableArray* ParticipantsList;
@property (strong, nonatomic) IBOutlet UILabel *starttime;
@property (strong, nonatomic) IBOutlet UILabel *Duration;
@property (strong, nonatomic) IBOutlet UILabel *co_creter;
@property (strong, nonatomic) IBOutlet UILabel *Careter;
@property(nonatomic,retain) NSString *co;
@property(nonatomic,retain) NSString *cr;
@property(nonatomic,retain) NSString *st;
@property(nonatomic,retain) NSString *hr;
- (IBAction)Back:(id)sender;

@end
