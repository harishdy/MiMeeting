//
//  ViewController.h
//  MiMeeting
//
//  Created by Harish Yadav on 31/12/15.
//  Copyright © 2015 Harish Yadav. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(nonatomic,retain) IBOutlet UITextField *domaintxt;
@property(nonatomic,retain) IBOutlet UITextField *usertxt;
@property(nonatomic,retain) IBOutlet UITextField *Passtxt;
@property(nonatomic,retain) IBOutlet UIButton    *Loginbtn;

-(IBAction)Home_Screen:(id)sender;


@end

