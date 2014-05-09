//
//  MSEditTaskViewController.h
//  Overdue Task List Assignment Solution
//
//  Created by Mat Sletten on 5/7/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTaskObject.h"

@protocol MSEditTaskViewControllerDelegate <NSObject>


-(void)didSaveUpdate;

@end

@interface MSEditTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id <MSEditTaskViewControllerDelegate> editTaskDelegate;
@property (strong,nonatomic) MSTaskObject *editTaskObject;

@property (strong, nonatomic) IBOutlet UITextField *editTaskTitleText;
@property (strong, nonatomic) IBOutlet UITextView *editTaskDetailText;
@property (strong, nonatomic) IBOutlet UIDatePicker *editTaskDate;

- (IBAction)saveTaskButtonPressed:(UIBarButtonItem *)sender;

@end
