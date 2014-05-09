//
//  MSAddTaskViewController.m
//  Overdue Task List Assignment Solution
//
//  Created by Mat Sletten on 5/7/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSAddTaskViewController.h"

@interface MSAddTaskViewController ()

@end

@implementation MSAddTaskViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)completeAddTaskButtonPressed:(UIButton *)sender
{
        [self.addTaskDelegate didAddTask:[self returnNewTask]];
}

- (IBAction)cancelAddTaskButtonPressed:(UIButton *)sender
{
    [self.addTaskDelegate didCancel];
}

- (MSTaskObject *)returnNewTask
{
    MSTaskObject *addTask = [[MSTaskObject alloc] init];
    addTask.taskTitle = self.addTaskTitleTextField.text;
    addTask.taskDate = self.addTaskDate.date;
    addTask.taskDescription = self.addTaskDetailText.text;
    addTask.isCompleted = NO;
    
    return addTask;
}
@end
