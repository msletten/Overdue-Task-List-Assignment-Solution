//
//  MSEditTaskViewController.m
//  Overdue Task List Assignment Solution
//
//  Created by Mat Sletten on 5/7/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSEditTaskViewController.h"

@interface MSEditTaskViewController ()

@end

@implementation MSEditTaskViewController

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
    
    self.editTaskTitleText.text = self.editTaskObject.taskTitle;
    self.editTaskDetailText.text = self.editTaskObject.taskDescription;
    self.editTaskDate.date = self.editTaskObject.taskDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveTaskButtonPressed:(UIBarButtonItem *)sender {
}
@end
