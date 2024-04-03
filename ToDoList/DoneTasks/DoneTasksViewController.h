//
//  DoneTasksViewController.h
//  ToDoList
//
//  Created by Nareman on 03/04/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DoneTasksViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property NSMutableArray *tasks;
@property NSMutableArray *filteredTasks;
@end

NS_ASSUME_NONNULL_END
