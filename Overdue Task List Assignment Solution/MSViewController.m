//
//  MSViewController.m
//  Overdue Task List Assignment Solution
//
//  Created by Mat Sletten on 5/7/14.
//  Copyright (c) 2014 Mat Sletten. All rights reserved.
//

#import "MSViewController.h"
#import "MSTaskObject.h"



@interface MSViewController ()

@end

@implementation MSViewController

#pragma  mark - Lazy Instantiation
-(NSMutableArray *)MSTaskObjects
{
    if (!_MSTaskObjects)
    {
        _MSTaskObjects = [[NSMutableArray alloc] init];
    }
    return _MSTaskObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //Set tableView Delegate and Data Source equal to self
    self.taskTableView.delegate = self;
    self.taskTableView.dataSource = self;
    
    //This Array recieves the task object dictionaries for every instance created using the helper method below that passes a task object to a task dictionary.
    NSArray *taskArray = [[NSUserDefaults standardUserDefaults] arrayForKey:TASK_DICTIONARIES_KEY];
    for (NSDictionary * taskDictionary in taskArray)
    {
        MSTaskObject *currentTaskObject = [self taskObjectForDictionary:taskDictionary];
        [self.MSTaskObjects addObject:currentTaskObject];
    }
//    [taskMutableArray insertObject:taskMutableArray atIndex:0];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[MSAddTaskViewController class]])
         {
             MSAddTaskViewController *addTaskVC = segue.destinationViewController;
             addTaskVC.addTaskDelegate = self;
         }
    //Below we allow the accessory table row button to access the object detail in the task detail viewController
    else if ([segue.destinationViewController isKindOfClass:[MSDetailTaskViewController class]])
    {
        MSDetailTaskViewController *detailTaskVC = segue.destinationViewController;
        NSIndexPath *selectedTaskPath = sender;
        MSTaskObject *selectedTaskObject = self.MSTaskObjects[selectedTaskPath.row];
        detailTaskVC.taskDetailObject = selectedTaskObject;
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MSAddTaskViewControllerDelegate

- (void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didAddTask:(MSTaskObject *)addedTask
{
    [self.MSTaskObjects addObject:addedTask];
    //use an NSLog below to make sure when Task tile is added in application it is being added to our array
    //NSLog(@"%@", addedTask.taskTitle);
    
    NSMutableArray *tasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_DICTIONARIES_KEY] mutableCopy];
    if (!tasksAsPropertyLists) tasksAsPropertyLists = [[NSMutableArray alloc] init];
    [tasksAsPropertyLists addObject: [self taskObjectAsAPropertyList:addedTask]];
    [[NSUserDefaults standardUserDefaults] setObject:tasksAsPropertyLists forKey:TASK_DICTIONARIES_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.taskTableView reloadData];
}

//Because this if/else uses a single line of evaluation after each statement, we can refactor to remove the curly braces. I left them in for clarity.
- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender
{
    if (self.taskTableView.editing == YES)
    {
        [self.taskTableView setEditing:NO animated:YES];
    }
    else
    {
        [self.taskTableView setEditing:YES animated:YES];
    }
}

- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender
{
    [self performSegueWithIdentifier:@"toAddTaskVCSegue" sender:nil];
}

#pragma mark - Helper Methods
-(NSDictionary *)taskObjectAsAPropertyList:(MSTaskObject *)addedTaskObject;
{
    NSDictionary *addTaskDictionary = @{TASK_TITLE : addedTaskObject.taskTitle, TASK_DATE : addedTaskObject.taskDate, TASK_DESCRIPTION : addedTaskObject.taskDescription, TASK_COMPLETION : @(addedTaskObject.isCompleted)};
    return addTaskDictionary;
}
//Use this to create a task object for our dictionary, which will go into the array created in viewDidLoad. This object dictionary will get passed to the dictionary array whenever a task is added.
-(MSTaskObject *)taskObjectForDictionary:(NSDictionary *)addedTaskDictionary
{
    MSTaskObject *addedTaskObject = [[MSTaskObject alloc] initWithData:addedTaskDictionary];
    return addedTaskObject;
}

-(BOOL)isDateGreaterThanDate:(NSDate *)fromDate and:(NSDate *)toDate
{
    NSTimeInterval fromDateInterval = [fromDate timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    if (fromDateInterval > toDateInterval) return YES;
    else return NO;
//refactored the else if below to the above becuase each if/else only evaluated one line of code.
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
}

-(void)updateCompletionOfTask:(MSTaskObject *)completedTask forIndexPath:(NSIndexPath *)taskIndexPath
{
    NSMutableArray *completedTasksAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:TASK_DICTIONARIES_KEY]mutableCopy];
    if (!completedTasksAsPropertyLists) completedTasksAsPropertyLists = [[NSMutableArray alloc] init];
    [completedTasksAsPropertyLists removeObjectAtIndex:taskIndexPath.row];
    //Use this BOOL argument to show visually which tasks have been completed and which have not
    if(completedTask.isCompleted == YES) completedTask.isCompleted = NO;
    else completedTask.isCompleted = YES;
    
    [completedTasksAsPropertyLists insertObject:[self taskObjectAsAPropertyList:completedTask] atIndex:taskIndexPath.row];
    [[NSUserDefaults standardUserDefaults] setObject:completedTasksAsPropertyLists forKey:TASK_DICTIONARIES_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.taskTableView reloadData];
}

-(void)saveMovedTasks
{
    NSMutableArray *movedTasksAsPropertyLists = [[NSMutableArray alloc] init];
    for (int x = 0; x < [self.MSTaskObjects count]; x++)
    {
        [movedTasksAsPropertyLists addObject:[self taskObjectAsAPropertyList:self.MSTaskObjects[x]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:movedTasksAsPropertyLists forKey:TASK_DICTIONARIES_KEY];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.MSTaskObjects count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
        //configure cell...
        //MSTaskObject *addedNewTask = [self.MSTaskObjects objectAtIndex:indexPath.row];
        MSTaskObject *addedNewTask = self.MSTaskObjects[indexPath.row];
        cell.textLabel.text = addedNewTask.taskTitle;
        NSDateFormatter *taskDateFormatter = [[NSDateFormatter alloc] init];
        [taskDateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *stringFromDate = [taskDateFormatter stringFromDate:addedNewTask.taskDate];
        cell.detailTextLabel.text = stringFromDate;
    //Using the TimeInterval above, we're comparing the task date to the current date to see if the task date is overdue
    BOOL isOverdue = [self isDateGreaterThanDate:[NSDate date] and:addedNewTask.taskDate];
    //use RGB coloring for custom color with n/255.0f as the GCfloat values for each RGBA field
    if (addedNewTask.isCompleted == YES) cell.backgroundColor = [UIColor colorWithRed:143/255.0f green:188/255.0f blue:143/255.0f alpha:1.0f];
    else if (isOverdue == YES) cell.backgroundColor = [UIColor colorWithRed:0/255.0f green:139/255.0f blue:139/255.0f alpha:1.0f];
    else cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)selectedIndexPath
{
    MSTaskObject *selectedTask = self.MSTaskObjects[selectedIndexPath.row];
    [self updateCompletionOfTask:selectedTask forIndexPath:selectedIndexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {   //To remove an object or make a row editable in a table and persist the change, use the following...
        [self.MSTaskObjects removeObjectAtIndex:indexPath.row];
    
        NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc] init];
        for (MSTaskObject *deletedTask in self.MSTaskObjects)
        {
            [newTaskObjectsData addObject:[self taskObjectAsAPropertyList:deletedTask]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsData forKey:TASK_DICTIONARIES_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailTaskVCSegue" sender:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//below stipulates how to allow for table rows to be reordered.
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //MSTaskObject *moveTaskObject = [self.MSTaskObjects objectAtIndex:sourceIndexPath.row];
    //refactored line above to below to use literals
    MSTaskObject *moveTaskObject = self.MSTaskObjects[sourceIndexPath.row];
    [self.MSTaskObjects removeObjectAtIndex:sourceIndexPath.row];
    [self.MSTaskObjects insertObject:moveTaskObject atIndex:destinationIndexPath.row];
    [self saveMovedTasks];
}

@end
