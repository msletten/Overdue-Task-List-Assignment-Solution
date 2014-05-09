//
//  MSDetailTaskViewController.m
//  Overdue Task List Assignment Solution
//
//  Created by Mat Sletten on 5/7/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSDetailTaskViewController.h"


@interface MSDetailTaskViewController ()

@end

@implementation MSDetailTaskViewController

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
	// Do any additional setup after loading the view.
    
    self.taskTitleLabel.text = self.taskDetailObject.taskTitle;
    self.taskDetailLabel.text = self.taskDetailObject.taskDescription;
    NSDateFormatter *detailTaskDateFormatter = [[NSDateFormatter alloc] init];
    [detailTaskDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *detailTaskDate = [detailTaskDateFormatter stringFromDate:self.taskDetailObject.taskDate];
    self.taskDateLabel.text = detailTaskDate;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[MSEditTaskViewController class]])
    {
        MSEditTaskViewController *editTaskVC = segue.destinationViewController;
        editTaskVC.editTaskObject = self.taskDetailObject;
        editTaskVC.editTaskDelegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editTaskButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toEditTaskVCSegue" sender:nil];
}

//Below: After conforming to the edit task delegate, we implement that delegate's method. Then we call the detail delegate's method on that to save the update from the edit vc to the detail vc.
-(void)didSaveUpdate
{
    self.taskTitleLabel.text = self.taskDetailObject.taskTitle;
    self.taskDetailLabel.text = self.taskDetailObject.taskDescription;
    NSDateFormatter *saveUpdateDateFormatter = [[NSDateFormatter alloc] init];
    [saveUpdateDateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *updateTaskDate = [saveUpdateDateFormatter stringFromDate:self.taskDetailObject.taskDate];
    self.taskDateLabel.text = updateTaskDate;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.detailTaskDelegate displayTaskUpdate];
}
@end
