//
//  AddTaskViewController.h
//  ToDoList
//
//  Created by A7med Fekry on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "Tasks.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddTaskViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priortySegment;

@property (weak, nonatomic) IBOutlet UITextView *discrptionTextView;
@property Tasks *taskContainer;

@property (weak, nonatomic) IBOutlet UIDatePicker *creationDate;


@end

NS_ASSUME_NONNULL_END
