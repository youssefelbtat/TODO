//
//  DetilsTaskScreen.m
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import "DetilsTaskScreen.h"

@interface DetilsTaskScreen ()
@property (weak, nonatomic) IBOutlet UILabel *tvTaskTitle;
@property (weak, nonatomic) IBOutlet UILabel *tvTaskdesc;
@property (weak, nonatomic) IBOutlet UILabel *tvTaskPriority;
@property (weak, nonatomic) IBOutlet UILabel *tvTaskState;
@property (weak, nonatomic) IBOutlet UIDatePicker *tvTaskDate;


@end

@implementation DetilsTaskScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    _tvTaskTitle.text=self.taskSelected.Title;
    _tvTaskdesc.text=self.taskSelected.desc;
    _tvTaskPriority.text=self.taskSelected.tpriorty;
    _tvTaskState.text=self.taskSelected.state;
    _tvTaskDate.date=self.taskSelected.fdata;
    _tvTaskDate.userInteractionEnabled = NO;
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
