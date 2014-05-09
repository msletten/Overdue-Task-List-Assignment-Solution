//
//  MSDetailTaskViewController.h
//  Overdue Task List Assignment Solution
//
//  Created by Mat Sletten on 5/7/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSTaskObject.h"
#import "MSEditTaskViewController.h"

@interface MSDetailTaskViewController : UIViewController

@property (strong, nonatomic) MSTaskObject *taskDetailObject;

@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDetailLabel;

- (IBAction)editTaskButtonPressed:(UIBarButtonItem *)sender;

@end
