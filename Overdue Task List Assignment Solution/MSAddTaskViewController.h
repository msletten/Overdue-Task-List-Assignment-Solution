//
//  MSAddTaskViewController.h
//  Overdue Task List Assignment Solution
//
//  Created by Mat Sletten on 5/7/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTaskObject.h"

@protocol MSAddTaskViewControllerDelegate <NSObject>

@required
-(void)didCancel;
-(void)didAddTask:(MSTaskObject *)addedTask;

@end

@interface MSAddTaskViewController : UIViewController <UITextViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) id <MSAddTaskViewControllerDelegate> addTaskDelegate;

@property (strong, nonatomic) IBOutlet UITextField *addTaskTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *addTaskDetailText;
@property (strong, nonatomic) IBOutlet UIDatePicker *addTaskDate;

- (IBAction)completeAddTaskButtonPressed:(UIButton *)sender;

- (IBAction)cancelAddTaskButtonPressed:(UIButton *)sender;

@end
