//
//  TaskData.h
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskData : NSObject <NSCoding>

@property NSString * Title;
@property NSString * desc;
@property NSDate * fdata;
@property NSString * tpriorty;
@property NSString *state ;

@end

NS_ASSUME_NONNULL_END
