//
//  toDoViewController.h
//  ToDoList
//
//  Created by A7med Fekry on 02/04/2024.
//
#import <UIKit/UIKit.h>
#import "Tasks.h"

NS_ASSUME_NONNULL_BEGIN

@interface toDoViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>
//@property (weak, nonatomic) IBOutlet UISegmentedControl *priortySegments;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;
@property (weak, nonatomic) IBOutlet UITableView *toDoTable;
@property Tasks *taskContainer;
@property  NSInteger *sellctedObjectIndex;
@property NSInteger *toDoIndexItem;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;
@end
NS_ASSUME_NONNULL_END
