//
//  DoneViewController.h
//  ToDoList
//
//  Created by A7med Fekry on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"
NS_ASSUME_NONNULL_BEGIN

@interface DoneViewController : UIViewController <UITableViewDelegate , UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *doneTableV;
@property (weak, nonatomic) IBOutlet UISegmentedControl *donePriortySegment;

@end

NS_ASSUME_NONNULL_END
