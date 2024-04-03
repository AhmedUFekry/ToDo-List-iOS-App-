//
//  InProgressViewController.h
//  ToDoList
//
//  Created by A7med Fekry on 02/04/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InProgressViewController : UIViewController
<UITableViewDelegate , UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *inporogreesTableView;
@property NSInteger *inProgIndexItem;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priortyFilterSegment;

@end

NS_ASSUME_NONNULL_END
