//
//  TaskManager.h
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskManager : NSObject

@property (nonatomic, strong)  NSMutableArray *todoTasks;
@property (nonatomic, strong)  NSMutableArray *inProgressTasks;
@property (nonatomic, strong)  NSMutableArray *doneTasks;

+ (instancetype)getInstance;
+ (NSMutableArray*)getTaskFromUserDuf :(NSString *)key;
+ (void)sendTaskToUserDuf :(NSString*)key;

@end

NS_ASSUME_NONNULL_END
