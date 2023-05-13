//
//  Utils.h
//  workshop
//
//  Created by Mac on 28/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utils : NSObject
//Task Decode Keys
+(NSString*)taskTitleDecodeKey;
+(NSString*)taskDescriptionDecodeKey;
+(NSString*)taskDateDecodeKey;
+(NSString*)taskPriortyDecodeKey;
+(NSString*)taskStateDecodeKey;

//User Defults Keys
+(NSString*)todoUserDefultKey;
+(NSString*)doneUserDefultKey;
+(NSString*)inprogressUserDefultKey;

@end



NS_ASSUME_NONNULL_END
