//
//  AddNewTaskViewController.h
//  ToDoList
//
//  Created by Nareman on 02/04/2024.
//

#import <UIKit/UIKit.h>
#import "AddTaskDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddNewTaskViewController : UIViewController
@property id<AddTaskDelegate>addTaskDelegate;
@end

NS_ASSUME_NONNULL_END
