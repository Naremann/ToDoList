//
//  DoneTasksViewController.m
//  ToDoList
//
//  Created by Nareman on 03/04/2024.
//

#import "DoneTasksViewController.h"
#import "AddNewTaskViewController.h"
#import "EditTaskViewController.h"
@interface DoneTasksViewController ()
@property (weak, nonatomic) IBOutlet UITableView *table_view;
@property (weak, nonatomic) IBOutlet UISearchBar *search_bar;

@property (weak, nonatomic) IBOutlet UISegmentedControl *selected_priority;

@end

@implementation DoneTasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTasks];
    
}



- (IBAction)filterPriority:(UISegmentedControl *)sender {
    NSInteger selectedPriorityIndex = sender.selectedSegmentIndex;
    
    NSPredicate *predicate;
    switch (selectedPriorityIndex) {
        case 0:
            predicate = [NSPredicate predicateWithFormat:@"priority == %@", @(0)];
            break;
        case 1:
            predicate = [NSPredicate predicateWithFormat:@"priority == %@", @(1)];
            break;
        case 2:
            predicate = [NSPredicate predicateWithFormat:@"priority == %@", @(2)];
            break;
        default:
            predicate = [NSPredicate predicateWithFormat:@"priority == %@", @(0)]; //
            break;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *allTasks = [[userDefaults objectForKey:@"tasks"]mutableCopy];
    if (allTasks) {
        
        self.tasks = [[allTasks filteredArrayUsingPredicate:predicate] mutableCopy];
        [_table_view reloadData];
    }
}

- (void)loadTasks {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *allTasks = [[userDefaults objectForKey:@"tasks"]mutableCopy];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@", @(2)];
    self.tasks = [[allTasks filteredArrayUsingPredicate:predicate] mutableCopy];
   /* NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *allTasks = [userDefaults objectForKey:@"tasks"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@", @(0)];
    self.filteredTasks = [[allTasks filteredArrayUsingPredicate:predicate] mutableCopy];
    */
    [_table_view reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.filteredTasks) {
        return self.filteredTasks.count;
        }
    return self.tasks.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditTaskViewController *editTaskViewController=[self.storyboard instantiateViewControllerWithIdentifier:@"EditTaskViewController"];
    NSDictionary *selectedTask=[_tasks objectAtIndex:indexPath.row];
    NSString *name =selectedTask[@"name"];
    NSLog(@"Selected Task Name: %@", name);
    editTaskViewController.taskDict=selectedTask;
  //  editTaskViewController.editTaskDelegate=self;
    [self presentViewController:editTaskViewController animated:YES completion:nil];
}




- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *deletedTask;
        if (self.tasks && indexPath.row < self.filteredTasks.count) {
            deletedTask = [self.filteredTasks objectAtIndex:indexPath.row];
            [self.filteredTasks removeObjectAtIndex:indexPath.row];
        } else if (indexPath.row < self.tasks.count) {
            deletedTask = [self.tasks objectAtIndex:indexPath.row];
            [self.tasks removeObjectAtIndex:indexPath.row];
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self updateTasksInUserDefaults];
        
    }
}

- (void)updateTasksInUserDefaults {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *allTasks = [NSMutableArray array];
    if (self.tasks) {
        [allTasks addObjectsFromArray:self.tasks];
    }
    if (self.filteredTasks) {
        [allTasks addObjectsFromArray:self.filteredTasks];
    }
    
    [userDefaults setObject:allTasks forKey:@"tasks"];
    
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSArray *currentTasks = self.filteredTasks ? self.filteredTasks : self.tasks;
    if (indexPath.row < currentTasks.count) {
        NSDictionary *taskDict = currentTasks[indexPath.row];
        int priorityLevel=[taskDict[@"priority"] intValue];
        int progressType=[taskDict[@"type"] intValue];
    
        printf("priorityLevel: %d",priorityLevel);
        UILabel *taskName = [cell viewWithTag:1];
        UILabel *taskDate = [cell viewWithTag:3];
        UIImageView *imageView = (UIImageView *)[cell viewWithTag:4];
        UIView *view=[cell viewWithTag:5];
        
        taskName.text = taskDict[@"name"];
        switch (priorityLevel) {
            case 0:
                [view setBackgroundColor:[UIColor redColor]];
                imageView.image = [UIImage imageNamed:@"high"];
                taskName.textColor=[UIColor redColor];

                break;
            case 1:
                [view setBackgroundColor:[UIColor systemYellowColor]];
                imageView.image=[UIImage imageNamed:@"med"];
                taskName.textColor=[UIColor systemYellowColor];
                break;
            case 2:
                [view setBackgroundColor:[UIColor greenColor]];
                imageView.image=[UIImage imageNamed:@"low"];
                taskName.textColor=[UIColor greenColor];


            default:
                break;
        }
        
        NSDate *date = taskDict[@"date"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd  HH:mm"];
        NSString *formattedDate = [dateFormatter stringFromDate:date];
        taskDate.text = formattedDate;
           
        }
     
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)refreshTasks:(NSMutableDictionary *)taskDict{
    [_tasks addObject:taskDict];
    [_table_view reloadData];
}







@end
