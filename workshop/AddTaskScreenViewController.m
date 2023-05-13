//
//  AddTaskScreenViewController.m
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import "AddTaskScreenViewController.h"
#import "TaskData.h"
@interface AddTaskScreenViewController ()

@property (weak, nonatomic) IBOutlet UITextField *edtTaskTitle;
@property (weak, nonatomic) IBOutlet UITextField *edtTaskDesc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *taskPriority;
@property (weak, nonatomic) IBOutlet UIDatePicker *TaskDate;

@end

@implementation AddTaskScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(savaAction)];
    [_TaskDate setMinimumDate:[NSDate date]];
    // Do any additional setup after loading the view.
}

-(void)saveTask{

    TaskData *t = [TaskData new];
    t.Title = _edtTaskTitle.text;
    t.desc = _edtTaskDesc.text;
    switch (_taskPriority.selectedSegmentIndex) {
        case 0:
            t.tpriorty=@"High";
            break;
        case 1:
            t.tpriorty=@"Medium";
            break;
        default:
            t.tpriorty=@"Low";
            break;
    }
    [self.deleget setNewTaskAction:t];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)savaAction{
    if (_edtTaskTitle.text.length == 0 || _edtTaskDesc.text.length == 0) {
           UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Error" message:@"Please fill in all the fields" preferredStyle:UIAlertControllerStyleAlert];
           UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
           [alert addAction:ok];
           [self presentViewController:alert animated:YES completion:nil];
           
    }else{
        [self showSaveAlert];
    }
}
-(void)showSaveAlert{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Save Colleague" message:@"Do you want to save this Task?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * save = [UIAlertAction actionWithTitle:@"Sava" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveTask];
    }];
    
    UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:save];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

- (IBAction)DateAction:(id)sender {
}

@end
