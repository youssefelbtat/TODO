//
//  MyProtocol.h
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import <Foundation/Foundation.h>
#import "TaskData.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MyProtocol <NSObject>
- (void)setNewTaskAction:(TaskData *)task;
- (void)saveEditAction:(TaskData *)editedTask;


@end

NS_ASSUME_NONNULL_END
