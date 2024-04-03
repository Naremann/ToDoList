//
//  ViewController.h
//  ToDoList
//
//  Created by Nareman on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "AddTaskDelegate.h"
#import "EditTaskDelegate.h"
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,AddTaskDelegate,UISearchBarDelegate>
@property NSMutableArray *tasks;
@property NSMutableArray *filteredTasks;


@end

