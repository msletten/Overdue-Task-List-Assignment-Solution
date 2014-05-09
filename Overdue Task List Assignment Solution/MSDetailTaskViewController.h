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

@protocol MSDetailTaskViewControllerDelegate <NSObject>

-(void)displayTaskUpdate;

@end

@interface MSDetailTaskViewController : UIViewController <MSEditTaskViewControllerDelegate>

@property (weak, nonatomic) id <MSDetailTaskViewControllerDelegate> detailTaskDelegate;
@property (strong, nonatomic) MSTaskObject *taskDetailObject;


@property (strong, nonatomic) IBOutlet UILabel *taskTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDateLabel;
@property (strong, nonatomic) IBOutlet UILabel *taskDetailLabel;

- (IBAction)editTaskButtonPressed:(UIBarButtonItem *)sender;

@end
