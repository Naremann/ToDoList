//
//  Task.h
//  ToDoList
//
//  Created by Nareman on 02/04/2024.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject
@property int taskId;
@property NSString *name;
@property NSString *desc;
@property int priority;
@property int type;
@property NSDate *date;
@property NSUserDefaults *userDefault;

/*-(void) addNewTaskWithName :(NSString *)name andDesc : (NSString *)desc andPriority : (int) priority andType : (int) type andDate : (NSDate *)date;*/


@end

NS_ASSUME_NONNULL_END
