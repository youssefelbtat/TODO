//
//  DoneScreen.h
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface DoneScreen : UIViewController <UITableViewDelegate,UITableViewDataSource,MyProtocol>
{
    @public
    NSMutableArray * doneTasksArray;
}


@end

NS_ASSUME_NONNULL_END
