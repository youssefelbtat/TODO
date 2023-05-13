//
//  EditScreen.h
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import <UIKit/UIKit.h>
#import "TaskData.h"
#import "MyProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditScreen : UIViewController

@property TaskData * taskSelected;
@property (nonatomic, weak) id<MyProtocol> delegate;


@end

NS_ASSUME_NONNULL_END
