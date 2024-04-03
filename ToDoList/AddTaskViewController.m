//
//  AddTaskViewController.m
//  ToDoList
//
//  Created by A7med Fekry on 02/04/2024.
//

#import "AddTaskViewController.h"
#import "toDoViewController.h"
#import "Tasks.h"


@interface AddTaskViewController ()

@end

@implementation AddTaskViewController
{
    Tasks *task ;
    NSUserDefaults *defToDo;
    NSData *archivedArr;
    
}
static NSMutableArray *tasksArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    task = [Tasks new];
    //getting Array from NS defualt
    defToDo = [NSUserDefaults standardUserDefaults];
    archivedArr = [defToDo objectForKey:@"tasksArrr"];
    tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:archivedArr];
   
    
    
    
    
}

- (IBAction)addTaskButton:(id)sender {
    toDoViewController *toDoViewC = [self.storyboard instantiateViewControllerWithIdentifier:@"toDoViewController"];
    [task setTaskTitle:_titleTextField.text];
    NSNumber *num = [[NSNumber alloc]initWithInteger:_priortySegment.selectedSegmentIndex];
    [task setTaskPeriority:num];
    [task setTaskCreationDate:_creationDate.date];
    [task setTaskDiscription:_discrptionTextView.text];
    
    
    //adding Array to NSDefualt
    [tasksArr addObject:task];
    archivedArr = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
    [defToDo setObject:archivedArr forKey:@"tasksArrr"];
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end

