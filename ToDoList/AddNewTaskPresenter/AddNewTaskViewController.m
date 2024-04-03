//
//  AddNewTaskViewController.m
//  ToDoList
//
//  Created by Nareman on 02/04/2024.
//

#import "AddNewTaskViewController.h"
#import "Task.h"
#import "Alert.h"

@interface AddNewTaskViewController ()
@property (weak, nonatomic) IBOutlet UITextField *task_name;

@property (weak, nonatomic) IBOutlet UIDatePicker *date_picker;
@property (weak, nonatomic) IBOutlet UITextField *task_desc;
@end

NSInteger priorityLevel = 0;
@implementation AddNewTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)saveNewTask:(id)sender {
    NSString *taskName = self.task_name.text;
    NSString *taskDesc = self.task_desc.text;
    NSDate *selectedDate=self.date_picker.date;
    NSInteger type=0;
    NSDictionary *taskDict = @{
           @"name": taskName,
           @"desc": taskDesc,
           @"priority": @(priorityLevel),
           @"date": selectedDate,
           @"type":@(type)
       };
       
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *tasks = [[userDefaults objectForKey:@"tasks"] mutableCopy];
    if(tasks ==nil){
        tasks=[[NSMutableArray alloc]init];
    }
    
   // [tasks addObject:taskDict];
  //  [userDefaults setObject:tasks forKey:@"tasks"];
    [Alert showAlertDialogWithTitle:@"Saved Task" andMsg:@"Are you sure you want to save the task" andHandler:^(UIAlertAction *action){
        [tasks addObject:taskDict];
         [userDefaults setObject:tasks forKey:@"tasks"];
        [self dismissViewControllerAnimated:YES completion:^{
            [_addTaskDelegate refreshTasks:taskDict];
        }];
        printf("SAVED");
        } andViewController:self];
}



- (IBAction)checkPriority:(id)sender {
    printf("Hello");
    priorityLevel=[sender selectedSegmentIndex];
    printf("Result: %ld",priorityLevel);
}


@end
