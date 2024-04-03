//
//  EditTaskViewController.h
//  ToDoList
//
//  Created by Nareman on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "EditTaskDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditTaskViewController : UIViewController
@property NSDictionary *taskDict;
@property id<EditTaskDelegate>editTaskDelegate;
@end

NS_ASSUME_NONNULL_END
