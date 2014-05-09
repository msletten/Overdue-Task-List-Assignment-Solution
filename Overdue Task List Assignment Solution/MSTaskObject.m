//
//  MSTaskObject.m
//  Overdue Task List Assignment Solution
//
//  Created by Mat Sletten on 5/7/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSTaskObject.h"

@implementation MSTaskObject


-(id)initWithData:(NSDictionary *)taskData
{
    self = [super init];
    
    if (self)
    {
    self.taskTitle = taskData[TASK_TITLE];
    self.taskDate = taskData[TASK_DATE];
    self.taskDescription = taskData[TASK_DESCRIPTION];
    self.isCompleted = [taskData[TASK_COMPLETION] boolValue];
    }
    return self;
}

-(id)init
{
    self = [self initWithData:nil];
    
    return self;
}
@end
