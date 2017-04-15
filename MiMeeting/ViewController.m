//
//  ViewController.m
//  MiMeeting
//
//  Created by Harish Yadav on 31/12/15.
//  Copyright © 2015 Harish Yadav. All rights reserved.
//

#import "ViewController.h"
#import "Hy_HomeScreen_ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Home_Screen:(id)sender
{
//    Hy_HomeScreen_ViewController *HHSVC = [[Hy_HomeScreen_ViewController alloc]initWithNibName:@"Hy_HomeScreen_ViewController" bundle:nil];
//    [self presentViewController:HHSVC animated:YES completion:nil];
    //[self performSegueWithIdentifier:@"Homescreen" sender:nil];
//    UIViewController *myController = [self.storyboard instantiateViewControllerWithIdentifier:@"Homescreen"];
//    [self.navigationController pushViewController: myController animated:YES];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Hy_HomeScreen_ViewController"];
//    [self presentViewController:vc animated:YES completion:nil];
    
    //[self performSegueWithIdentifier:@"Go" sender:self];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Go"]){
        //UINavigationController *navController = (UINavigationController *)segue.destinationViewController;
        if([_domaintxt.text isEqualToString:@"demo.com"])
        {
                    if([_usertxt.text isEqualToString:@"demo"] && [_Passtxt.text isEqualToString:@"demo"])
                    {
                        _domaintxt.text = @"";
                        _Passtxt.text = @"";
                        _usertxt.text = @"";
                        Hy_HomeScreen_ViewController *controller = [segue destinationViewController];

                    }
            else
            {
                UIAlertController * alert=   [UIAlertController
                                              alertControllerWithTitle:@"Error"
                                              message:@"Enter Right User Credentials"
                                              preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction
                                     actionWithTitle:@"OK"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction * action)
                                     {
                                         //Do some thing here
                                         [self dismissViewControllerAnimated:YES completion:nil];
                                         
                                     }];
                [alert addAction:ok];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
        else
        {
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@"Wrong Domain"
                                          message:@"Enter Right User Credentials"
                                          preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     //Do some thing here
                                     [self dismissViewControllerAnimated:YES completion:nil];
                                     
                                 }];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
       

    }
}
@end
