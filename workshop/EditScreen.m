//
//  EditScreen.m
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import "EditScreen.h"
#import "InprogressScreen.h"
@interface EditScreen ()
{
    InprogressScreen * inprogressScreen;
}
@property (weak, nonatomic) IBOutlet UITextField *edtEditTitle;
@property (weak, nonatomic) IBOutlet UITextField *edtEditDesc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *edtEditPriority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *edtState;
@property (weak, nonatomic) IBOutlet UIDatePicker *edtDate;

@end

@implementation EditScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleDone target:self action:@selector(showSaveAlert)];
    
    _edtEditTitle.text=self.taskSelected.Title;
    _edtEditDesc.text=self.taskSelected.desc;
    
    if([_taskSelected.tpriorty isEqualToString:@"High"]){
        [_edtEditPriority setSelectedSegmentIndex:0];
    }
    else  if([_taskSelected.tpriorty isEqualToString:@"Medium"]){
        [_edtEditPriority setSelectedSegmentIndex:1];
    }else{
        [_edtEditPriority setSelectedSegmentIndex:2];
    }
    
    printf("The selected state is : %s",[_taskSelected.state UTF8String]);
      if([_taskSelected.state isEqualToString:@"TODO"]||_taskSelected.state==nil){
        [_edtState setSelectedSegmentIndex:0];
    }else if([_taskSelected.state isEqualToString:@"In Progress"]){
        [_edtState setSelectedSegmentIndex:1];
        [_edtState setEnabled:NO forSegmentAtIndex:0];
    }
    else{
        [_edtState setSelectedSegmentIndex:2];
        [_edtState setEnabled:NO forSegmentAtIndex:0];
        [_edtState setEnabled:NO forSegmentAtIndex:1];
    }
    _edtDate.date=_taskSelected.fdata;
    
    [_edtDate setMinimumDate:[NSDate date]];
}

-(void)showSaveAlert{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:@"Save Change" message:@"Do you want to save the changes?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * save = [UIAlertAction actionWithTitle:@"Sava" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self saveAction];
    }];
    
    UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:save];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:NULL];
}
-(void)saveAction{
//    TaskData *editedTask = [TaskData new];
    _taskSelected.Title = _edtEditTitle.text;
    _taskSelected.desc = _edtEditDesc.text;
    _taskSelected.fdata=_edtDate.date;
    switch (_edtEditPriority.selectedSegmentIndex) {
        case 0:
            _taskSelected.tpriorty=@"High";
            break;
        case 1:
            _taskSelected.tpriorty=@"Medium";
            break;
        default:
            _taskSelected.tpriorty=@"Low";
            break;
    }
    
   
    
    switch (_edtState.selectedSegmentIndex) {
        case 0:
            _taskSelected.state=@"TODO";
            break;
        case 1:
            _taskSelected.state=@"In Progress";
            NSDate *proTask = [[NSUserDefaults standardUserDefaults] objectForKey:@"InProg"];
            NSArray *proArray = [NSKeyedUnarchiver unarchiveObjectWithData:proTask];
            NSMutableArray* arr =proArray;
            [arr addObject:_taskSelected];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSData *Mdata = [NSKeyedArchiver archivedDataWithRootObject:arr];
            [defaults setObject:Mdata forKey:@"InProg"];
            printf("The count of Array is : %lu \n",(unsigned long)arr.count);
            break;
    }
    if(_edtState.selectedSegmentIndex==2){
        _taskSelected.state=@"DONE";
        NSDate *doneTask = [[NSUserDefaults standardUserDefaults] objectForKey:@"Done"];
        NSArray *myArray = [NSKeyedUnarchiver unarchiveObjectWithData:doneTask];
        NSMutableArray* darr =myArray;
        printf("The selected title %s \n",[_taskSelected.Title UTF8String]);
        [darr addObject:_taskSelected];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *Mdata = [NSKeyedArchiver archivedDataWithRootObject:darr];
        [defaults setObject:Mdata forKey:@"Done"];
        printf("The Done count of Array is in edit is : %lu \n",(unsigned long)darr.count);
    }
    
    [self.delegate saveEditAction:_taskSelected];
    [self.navigationController popViewControllerAnimated:YES];
}




@end

