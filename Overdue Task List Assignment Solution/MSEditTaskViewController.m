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
    
    self.editTaskDetailText.delegate = self;
    self.editTaskTitleText.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//Below we use the button and delegate to run our method and then save the new details to the detailVC, to which we've conformed to the EditVC delegate
- (IBAction)saveTaskButtonPressed:(UIBarButtonItem *)sender
{
    [self updateTask];
    [self.editTaskDelegate didSaveUpdate];
}
//Here we set the updated task equal to the fields in the Task Objects details.
-(void)updateTask
{
    self.editTaskObject.taskTitle = self.editTaskTitleText.text;
    self.editTaskObject.taskDescription = self.editTaskDetailText.text;
    self.editTaskObject.taskDate = self.editTaskDate.date;
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.editTaskTitleText resignFirstResponder];
    return YES;
}

#pragma mark - UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [self.editTaskDetailText resignFirstResponder];
        return NO;
    }
    return YES;
}


@end
