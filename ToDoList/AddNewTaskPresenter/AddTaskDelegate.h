//
//  AddTaskDelegate.h
//  ToDoList
//
//  Created by Nareman on 02/04/2024.
//

#import <Foundation/Foundation.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@protocol AddTaskDelegate <NSObject>
- (void)refreshTasks:(NSMutableDictionary *)taskDict;
@end

NS_ASSUME_NONNULL_END
