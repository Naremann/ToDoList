//
//  EditTaskViewController.m
//  ToDoList
//
//  Created by Nareman on 02/04/2024.
//

#import "EditTaskViewController.h"
#import "Alert.h"
@interface EditTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *task_name;
@property (weak, nonatomic) IBOutlet UITextField *task_desc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority_level;

@property (weak, nonatomic) IBOutlet UISegmentedControl *progress_type;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation EditTaskViewController
NSInteger progressType=0;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTaskDetailsInViews];
   
}
- (IBAction)checkProgressType:(id)sender {
    progressType=[sender selectedSegmentIndex];
}

-(void) setTaskDetailsInViews{
    NSString *name = _taskDict[@"name"];
    NSString *desc=_taskDict[@"desc"];
    NSInteger *priorityLevel=[_taskDict[@"priority"] integerValue];
    NSInteger *progressType=[_taskDict[@"type"] integerValue];

    NSDate *date=_taskDict[@"date"];
    _task_name.text=name;
    _task_desc.text=desc;
    _priority_level.selectedSegmentIndex=priorityLevel;
    _progress_type.selectedSegmentIndex=progressType;
    _datePicker.date=date;
}
- (IBAction)editSelectedTask:(id)sender {
    NSString *updatedName = self.task_name.text;
        NSString *updatedDesc = self.task_desc.text;
        NSInteger updatedPriorityLevel = self.priority_level.selectedSegmentIndex;
        NSInteger updatedProgressType= self.progress_type.selectedSegmentIndex;

        NSDate *updatedDate = self.datePicker.date;
    printf("_progress_type: %d",_progress_type.selectedSegmentIndex);
    NSMutableDictionary *updatedTaskDict=[self.taskDict mutableCopy];
    [updatedTaskDict setObject:updatedName forKey:@"name"];
    [updatedTaskDict setObject:updatedDesc forKey:@"desc"];
    [updatedTaskDict setObject:@(updatedPriorityLevel) forKey:@"priority"];
    [updatedTaskDict setObject:@(updatedProgressType) forKey:@"type"];
    [updatedTaskDict setObject:updatedDate forKey:@"date"];
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSMutableArray *tasks=[[userDefault objectForKey:@"tasks"]mutableCopy];
    NSInteger taskIndex=[tasks indexOfObject:_taskDict];
    if(taskIndex !=NSNotFound){
        [Alert showAlertDialogWithTitle:@"Edit current Task" andMsg:@"Are you sure you want to edit this task" andHandler:^(UIAlertAction *action){
                    [tasks replaceObjectAtIndex:taskIndex withObject:updatedTaskDict];
                    [userDefault setObject:tasks forKey:@"tasks"];[tasks replaceObjectAtIndex:taskIndex withObject:updatedTaskDict];
            [userDefault setObject:tasks forKey:@"tasks"];
           
           [_editTaskDelegate refreshEdittingTasks:_taskDict withIndex:taskIndex];
   
            
	                    [self dismissViewControllerAnimated:YES completion:^{
                        

//                        [_editTaskDelegate refreshEdittingTasks:_taskDict];

                        
                    }];
        } andViewController:self];
       // [tasks replaceObjectAtIndex:taskIndex withObject:updatedTaskDict];
        //[userDefault setObject:tasks forKey:@"tasks"];
    }
    
}


@end
