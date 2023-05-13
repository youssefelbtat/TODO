//
//  ToDoScreen.m
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import "ToDoScreen.h"
#import "AddTaskScreenViewController.h"
#import "TaskManager.h"
#import "DetilsTaskScreen.h"
#import "EditScreen.h"
#import "Utils.h"

@interface ToDoScreen ()
@property (weak, nonatomic) IBOutlet UITableView *TodoTable;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray<TaskData *> *filteredTasksArray;
@property (nonatomic, assign) BOOL isSearching;
@end

@implementation ToDoScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    _TodoTable.dataSource=self;
    _TodoTable.delegate=self;
    _searchBar.delegate = self;
    
    _isSearching=NO;
    self.filteredTasksArray = [NSMutableArray array];
    
}

- (void)viewWillAppear:(BOOL)animated{
  
    if([TaskManager getTaskFromUserDuf:[Utils todoUserDefultKey]]){
        TodoTasksArray=[TaskManager getTaskFromUserDuf:[Utils todoUserDefultKey]];
    }else{
        TodoTasksArray=[NSMutableArray array];
    }
}

- (IBAction)navToAddTask:(id)sender {
    AddTaskScreenViewController * addScreen =[self.storyboard instantiateViewControllerWithIdentifier:@"adScreen"];
    addScreen.deleget=self;
    [self.navigationController pushViewController:addScreen animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if (searchText.length == 0) {
        self.isSearching = NO;
    } else {
        self.isSearching = YES;
        [self.filteredTasksArray removeAllObjects];
        for (TaskData *task in TodoTasksArray) {
            NSRange range = [task.Title rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [self.filteredTasksArray addObject:task];
            }
        }
    }
    [self.TodoTable reloadData];
}

- (void)setNewTaskAction:(TaskData *)task{
    
        [TodoTasksArray addObject:task];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *toData = [NSKeyedArchiver archivedDataWithRootObject:TodoTasksArray];
    [defaults setObject:toData forKey:@"ToDo"];

        [_TodoTable reloadData];
       
    
}

- (void)saveEditAction:(TaskData *)editedTask {
    NSInteger index = [TodoTasksArray indexOfObject:editedTask];;
    if (index != NSNotFound) {
        if([editedTask.state isEqual:@"TODO"]){
            TodoTasksArray[index] = editedTask;
        }else {
            
            [TodoTasksArray removeObjectAtIndex:index];
        }
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:TodoTasksArray];
        [defaults setObject:data forKey:@"ToDo"];
        [self.TodoTable reloadData];
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.isSearching ? self.filteredTasksArray.count : TodoTasksArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"todocell"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"todocell"];
    
    NSDate *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"ToDo"];
    NSArray *TodoArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    TaskData *task = self.isSearching ? self.filteredTasksArray[indexPath.row] : TodoArray[indexPath.row];
    
    cell.textLabel.text = task.Title;
    cell.detailTextLabel.text = task.desc;
    
    if ([task.tpriorty isEqualToString:@"High"]) {
        [cell.imageView setImage:[UIImage imageNamed:@"high"]];
    } else if ([task.tpriorty isEqualToString:@"Low"]) {
        [cell.imageView setImage:[UIImage imageNamed:@"low"]];
    } else {
        [cell.imageView setImage:[UIImage imageNamed:@"med"]];
    }
    
    return cell;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //new
    
    
    NSDate *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"ToDo"];
    NSArray *TodoArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    TaskData *selected = self.isSearching ? self.filteredTasksArray[indexPath.row] : TodoArray[indexPath.row];
 
    DetilsTaskScreen * sec = [self.storyboard instantiateViewControllerWithIdentifier:@"deScreen"];
    printf("The selected is : %s",[selected.Title UTF8String]);
    sec.taskSelected=selected;
    
    [self.navigationController pushViewController:sec animated:YES];
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Delete Task" message:@"Do you want to delete this Task?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * save = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(_isSearching){
                [_filteredTasksArray removeObjectAtIndex:indexPath.row];
            }
            [TodoTasksArray removeObjectAtIndex:indexPath.row];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *Mdata = [NSKeyedArchiver archivedDataWithRootObject:TodoTasksArray];
            [defaults setObject:Mdata forKey:@"ToDo"];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
           
        }];
        
        UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:save];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:NULL];
        
        
       
    }];
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        TaskData * selected;
        if(_isSearching){
            selected = _filteredTasksArray[indexPath.row];
        }else{
            selected =self->TodoTasksArray[indexPath.row];
        }
        
        
        EditScreen * sec = [self.storyboard instantiateViewControllerWithIdentifier:@"editScreen"];
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
    
    headerLabel.text = @"ToDo Tasks";
    
    [headerView addSubview:headerLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


@end
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
