//
//  AddTaskScreenViewController.h
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddTaskScreenViewController : UIViewController
@property id<MyProtocol> deleget;

@end

NS_ASSUME_NONNULL_END
