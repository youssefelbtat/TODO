//
//  InprogressScreen.h
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface InprogressScreen : UIViewController <UITableViewDelegate,UITableViewDataSource,MyProtocol>
{
    @public
    NSMutableArray * ProgressTasksArray;
}

@end

NS_ASSUME_NONNULL_END

