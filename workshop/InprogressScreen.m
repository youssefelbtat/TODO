//
//  InprogressScreen.m
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import "InprogressScreen.h"
#import "TaskData.h"
#import "DetilsTaskScreen.h"
#import "EditScreen.h"
@interface InprogressScreen ()
@property (weak, nonatomic) IBOutlet UITableView *progresssTableView;
@property BOOL isfilter;
@property (strong, nonatomic) NSMutableArray<TaskData *> *highTasks;
@property (strong, nonatomic) NSMutableArray<TaskData *> *mediumTasks;
@property (strong, nonatomic) NSMutableArray<TaskData *> *lowTasks;

@end

@implementation InprogressScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    _progresssTableView.dataSource=self;
    _progresssTableView.delegate=self;
    _isfilter=NO;
        _highTasks = [NSMutableArray array];
        _mediumTasks = [NSMutableArray array];
        _lowTasks = [NSMutableArray array];
    }

- (void)viewWillAppear:(BOOL)animated{
    NSDate *proTask = [[NSUserDefaults standardUserDefaults] objectForKey:@"InProg"];
    NSArray *proArray = [NSKeyedUnarchiver unarchiveObjectWithData:proTask];
    _highTasks.removeAllObjects;
    _lowTasks.removeAllObjects;
    _mediumTasks.removeAllObjects;
    if(proArray){
        ProgressTasksArray=proArray;
        for(TaskData * task in proArray){
            if([task.tpriorty isEqual:@"High"])
            {
                [_highTasks addObject:task];
                
            }else if ([task.tpriorty isEqual:@"Low"]){
                [_lowTasks addObject:task];
            }else{
                [_mediumTasks addObject:task];
            }
        }
    }else{
        ProgressTasksArray=[NSMutableArray array];
    }
    [self.progresssTableView reloadData];
}
- (void)saveEditAction:(TaskData *)editedTask {
    NSInteger index = [ProgressTasksArray indexOfObject:editedTask];;
    if (index != NSNotFound) {
        if([editedTask.state isEqual:@"In Progress"]){
            ProgressTasksArray[index] = editedTask;
            if([editedTask.tpriorty isEqual:@"High"]){
                [_highTasks addObject:editedTask];
            }else if([editedTask.tpriorty isEqual:@"Low"]){
                [_lowTasks addObject:editedTask];
            }else{
                [_mediumTasks addObject:editedTask];
            }
        }else {
            
            [ProgressTasksArray removeObjectAtIndex:index];
        }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:ProgressTasksArray];
        [defaults setObject:data forKey:@"InProg"];
        [self.progresssTableView reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if(_isfilter){
        return 3;
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(_isfilter){
        switch (section) {
            case 0:
                return _highTasks.count;
                break;
            case 1:
                return _mediumTasks.count;
                break;
            case 2:
                return _lowTasks.count;
                break;
            default:
                break;
        }
    }
    
    return ProgressTasksArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"procell"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"procell"];
    if(!_isfilter){
        NSDate *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"InProg"];
        NSArray *TaskArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        TaskData *task =  TaskArray[indexPath.row];
        cell.textLabel.text = task.Title;
        cell.detailTextLabel.text = task.desc;
        
        if ([task.tpriorty isEqualToString:@"High"]) {
            [cell.imageView setImage:[UIImage imageNamed:@"high"]];
        } else if ([task.tpriorty isEqualToString:@"Low"]) {
            [cell.imageView setImage:[UIImage imageNamed:@"low"]];
        } else {
            [cell.imageView setImage:[UIImage imageNamed:@"med"]];
        }
    }else{
        TaskData *task =nil;
        switch (indexPath.section) {
            case 0:
                task =  _highTasks[indexPath.row];
                cell.textLabel.text = task.Title;
                cell.detailTextLabel.text = task.desc;
                
                if ([task.tpriorty isEqualToString:@"High"]) {
                    [cell.imageView setImage:[UIImage imageNamed:@"high"]];
                } else if ([task.tpriorty isEqualToString:@"Low"]) {
                    [cell.imageView setImage:[UIImage imageNamed:@"low"]];
                } else {
                    [cell.imageView setImage:[UIImage imageNamed:@"med"]];
                }
                break;
            case 1:
                task =  _mediumTasks[indexPath.row];
                cell.textLabel.text = task.Title;
                cell.detailTextLabel.text = task.desc;
                
                if ([task.tpriorty isEqualToString:@"High"]) {
                    [cell.imageView setImage:[UIImage imageNamed:@"high"]];
                } else if ([task.tpriorty isEqualToString:@"Low"]) {
                    [cell.imageView setImage:[UIImage imageNamed:@"low"]];
                } else {
                    [cell.imageView setImage:[UIImage imageNamed:@"med"]];
                }
                break;
            case 2:
                task =  _lowTasks[indexPath.row];
                cell.textLabel.text = task.Title;
                cell.detailTextLabel.text = task.desc;
                
                if ([task.tpriorty isEqualToString:@"High"]) {
                    [cell.imageView setImage:[UIImage imageNamed:@"high"]];
                } else if ([task.tpriorty isEqualToString:@"Low"]) {
                    [cell.imageView setImage:[UIImage imageNamed:@"low"]];
                } else {
                    [cell.imageView setImage:[UIImage imageNamed:@"med"]];
                }
                
                break;
            default:
                break;
        }
    }
  
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    NSDate *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"InProg"];
    NSArray *TaskArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    TaskData *selected = nil;
    
    if(!_isfilter){
        selected = TaskArray[indexPath.row];
    }else{
        switch (indexPath.section) {
            case 0:
                selected=_highTasks[indexPath.row];
                break;
            case 1:
                selected=_mediumTasks[indexPath.row];
                break;
            case 2:
                selected=_lowTasks[indexPath.row];
                break;
            default:
                break;
        }
    }
 
    DetilsTaskScreen * sec = [self.storyboard instantiateViewControllerWithIdentifier:@"deScreen"];
    
    sec.taskSelected=selected;
    
    [self.navigationController pushViewController:sec animated:YES];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Delete Task" message:@"Do you want to delete this Task?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * save = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(!_isfilter){
                [ProgressTasksArray removeObjectAtIndex:indexPath.row];
            }else{
                switch (indexPath.section) {
                    case 0:
                       [_highTasks removeObjectAtIndex:indexPath.row];
                        break;
                    case 1:
                        [_mediumTasks removeObjectAtIndex:indexPath.row];
                        break;
                    case 2:
                        [_lowTasks removeObjectAtIndex:indexPath.row];
                        break;
                        
                    default:
                        break;
                }
            }
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *Mdata = [NSKeyedArchiver archivedDataWithRootObject:ProgressTasksArray];
            [defaults setObject:Mdata forKey:@"InProg"];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
           
        }];
        
        UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:save];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:NULL];
        
        
       
    }];
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        TaskData * selected ;
        if(!_isfilter){
            selected =ProgressTasksArray[indexPath.row];
        }else{
            switch (indexPath.section) {
                case 0:
                    selected=self->_highTasks[indexPath.row];
                    break;
                case 1:
                    selected=self->_mediumTasks[indexPath.row];
                    break;
                case 2:
                    selected=self->_lowTasks[indexPath.row];
                    break;
                    
                default:
                    break;
            }
        }
      
     
        EditScreen * sec = [self.storyboard instantiateViewControllerWithIdentifier:@"editScreen"];
        printf("The selected is : %s",[selected.Title UTF8String]);
        sec.taskSelected=selected;
        sec.delegate=self;
        [self.navigationController pushViewController:sec animated:YES];
        
    }];
    
    return @[deleteAction, editAction];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    headerView.backgroundColor = [UIColor linkColor];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width - 20, 30)];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.font = [UIFont boldSystemFontOfSize:18.50];
    headerLabel.textColor = [UIColor whiteColor];
    
    if(!_isfilter){
        headerLabel.text = @"All InProgress Tasks";
    }else{
        switch (section) {
            case 0:
                headerLabel.text = @"High";
                break;
            case 1:
                headerLabel.text = @"Medium";
                break;
            case 2:
                headerLabel.text = @"Low";
                break;
            default:
                break;
        }
    }
    
    
    [headerView addSubview:headerLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (IBAction)filterAction:(id)sender {
    
    _isfilter =!_isfilter;
    [self.progresssTableView reloadData];
}


@end


