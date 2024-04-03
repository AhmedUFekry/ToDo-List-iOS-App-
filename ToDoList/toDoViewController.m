//
//  toDoViewController.m
//  ToDoList
//
//  Created by A7med Fekry on 02/04/2024.
//

#import "toDoViewController.h"
#import "Tasks.h"
#import "AddTaskViewController.h"
#import "EditTaskViewController.h"

@interface toDoViewController ()

@end

@implementation toDoViewController
{
    Tasks *task;
    Tasks *sellectedTask;
    NSUserDefaults *defToDo;
    NSData *archivedArr;
    NSData *archivedObject;
    NSMutableArray *searchResultArr;
    NSUInteger numOfRows;
    NSUInteger searchSwitch;
    int i;
    
    
}
static  NSMutableArray *tasksArr;
+(void)initialize{
    tasksArr = [NSMutableArray new];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    task = [Tasks new];
    sellectedTask = [Tasks new];
    defToDo = [NSUserDefaults standardUserDefaults];
    if([defToDo objectForKey:@"tasksArrr"] == nil){
        archivedArr = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
        [defToDo setObject:archivedArr forKey:@"tasksArrr"];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    searchResultArr = [NSMutableArray new];
    searchSwitch = 0;
    //getting Array from NS defualt
    defToDo = [NSUserDefaults standardUserDefaults];
    archivedArr = [[defToDo objectForKey:@"tasksArrr"] mutableCopy];
    tasksArr = [NSKeyedUnarchiver unarchiveObjectWithData:archivedArr];
    if(tasksArr.count == 0){
        [_toDoTable setHidden:YES];
    }else{
        [_toDoTable setHidden:NO];
        [_toDoTable reloadData];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    /*if(tasksArr.count == 0){
        [_toDoTable setHidden:YES];
        [_emptyLabel setHidden:NO];

    }else{
        [_toDoTable reloadData];
    }*/
}

    
- (IBAction)addNewTaskButton:(id)sender {
    
    AddTaskViewController *addTaskViewC = [self.storyboard instantiateViewControllerWithIdentifier:@"AddTaskViewController"];
    [self.navigationController pushViewController:addTaskViewC animated:YES]   ;
    //ماتنساش تغيد ال complition ، تحط انه يجع اللي في ال textfield ، textview لل todoView
}

- (IBAction)SearchButton:(id)sender {
    for (i=0; i<[tasksArr count]; i++) {
        if(_searchTextField.text == [[tasksArr objectAtIndex:i]taskTitle]){
            [searchResultArr addObject:[tasksArr objectAtIndex:i]];
        }
    }
    if(tasksArr.count == 0){
        [_toDoTable setHidden:YES];
    }
    searchSwitch = 1;
    [_toDoTable setHidden:NO];
    [_toDoTable reloadData];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    printf("numberOfSectionsInTableView/n");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch(searchSwitch){
        case 0:
            numOfRows = [tasksArr count];
            break;
        case 1:
            numOfRows = [searchResultArr count];
    }
    printf("numberOfRowsInSection\n");
    return numOfRows;//[tasksArr count] ;
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToDoCell" forIndexPath:indexPath];
    if(searchSwitch == 0){
        cell.textLabel.text = [[tasksArr objectAtIndex:indexPath.row] taskTitle ];
        cell.imageView.image=[UIImage imageNamed:[[[tasksArr objectAtIndex:indexPath.row]taskPeriority]stringValue]];
        cell.detailTextLabel.text = [[tasksArr objectAtIndex:indexPath.row] taskCreationDate ] ;
        printf("cellForRowAtIndexPath\n");
    }else if (searchSwitch == 1){
        cell.textLabel.text = [[searchResultArr objectAtIndex:indexPath.row] taskTitle ];
        cell.imageView.image=[UIImage imageNamed:[[[searchResultArr objectAtIndex:indexPath.row]taskPeriority]stringValue]];
        cell.detailTextLabel.text = [[searchResultArr objectAtIndex:indexPath.row] taskCreationDate ] ;
        printf("cellForRowAtIndexPath\n");
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditTaskViewController *editViewC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditTaskViewController"];
    editViewC.indexNum = indexPath.row;
        
    editViewC.arrayCommingFrom = @"1";
    sellectedTask.taskTitle = [[tasksArr objectAtIndex:indexPath.row] taskTitle ];
    
    sellectedTask.taskDiscription = [[tasksArr objectAtIndex:indexPath.row]taskDiscription];
    //sellectedTask.taskState = [[tasksArr objectAtIndex:indexPath.row]taskState];
    sellectedTask.taskPeriority =[[tasksArr objectAtIndex:indexPath.row]taskPeriority];
    
    //show object attributes in editView
    editViewC.viewDetailsOfSellectedCell = sellectedTask;


    //adding taskObject to defualts
    archivedObject = [NSKeyedArchiver archivedDataWithRootObject:sellectedTask];
    [defToDo setObject:archivedObject forKey:@"archivedObject"];
    
    [self.navigationController pushViewController:editViewC  animated:YES];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"delete" message:@"are you sure you want to remove!! " preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [tasksArr removeObjectAtIndex:indexPath.row];
        
        self->archivedObject = [NSKeyedArchiver archivedDataWithRootObject:self->sellectedTask];
        [self->defToDo setObject:self->archivedObject forKey:@"archivedObject"];
        
       NSData *d = [NSKeyedArchiver archivedDataWithRootObject:tasksArr];
        [defToDo setObject:d forKey:@"tasksArrr"];
        
       
        if(tasksArr.count == 0){
            [_toDoTable setHidden:YES];
            [_emptyLabel setHidden:NO];

        }else{
            [_toDoTable reloadData];
        }    }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDestructive handler:nil];
    [alert addAction:yes];
    [alert addAction:no];
    [self presentViewController:alert animated:YES completion:nil];

}

@end
