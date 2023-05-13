//
//  TaskManager.m
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import "TaskManager.h"
#import "Utils.h"

static TaskManager *sharedInstance = nil;

@implementation TaskManager

+ (instancetype)getInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[TaskManager alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        if([TaskManager getTaskFromUserDuf:[Utils todoUserDefultKey]]){
            _todoTasks=[TaskManager getTaskFromUserDuf:[Utils todoUserDefultKey]];
        }else{
            _todoTasks = [NSMutableArray array];
        }
        
        
        if([TaskManager getTaskFromUserDuf:[Utils inprogressUserDefultKey]]){
            _todoTasks=[TaskManager getTaskFromUserDuf:[Utils inprogressUserDefultKey]];
        }else{
            _inProgressTasks = [NSMutableArray array];
        }
        
        if([TaskManager getTaskFromUserDuf:[Utils doneUserDefultKey]]){
            _todoTasks=[TaskManager getTaskFromUserDuf:[Utils doneUserDefultKey]];
        }else{
            _doneTasks = [NSMutableArray array];
        }
        
    }
    return self;
}

+(NSMutableArray*)getTaskFromUserDuf :(NSString *)key{
    NSDate *toDoTask = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSMutableArray *toDoArray = [NSKeyedUnarchiver unarchiveObjectWithData:toDoTask];
    return toDoArray ;
}

+(void)sendTaskToUserDuf :(NSString*)key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *task;
    if([key isEqualToString:[Utils todoUserDefultKey]]){
        task = [NSKeyedArchiver archivedDataWithRootObject:[[TaskManager getInstance] todoTasks]];
    }else if ([key isEqualToString:[Utils doneUserDefultKey]]){
        task = [NSKeyedArchiver archivedDataWithRootObject:[[TaskManager getInstance] doneTasks]];
    }else{
        task = [NSKeyedArchiver archivedDataWithRootObject:[[TaskManager getInstance] inProgressTasks]];
    }
    [defaults setObject:task forKey:key];
}

@end


