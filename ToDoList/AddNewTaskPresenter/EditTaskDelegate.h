//
//  EditTaskDelegate.h
//  ToDoList
//
//  Created by Nareman on 02/04/2024.
//

#import <Foundation/Foundation.h>
#import "Task.h"
NS_ASSUME_NONNULL_BEGIN

@protocol EditTaskDelegate <NSObject>
- (void)refreshEdittingTasks:(NSMutableDictionary *)taskDict withIndex:(NSInteger *)index;

@end

NS_ASSUME_NONNULL_END
