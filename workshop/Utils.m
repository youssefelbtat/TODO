//
//  Utils.m
//  workshop
//
//  Created by Mac on 28/04/2023.
//

#import "Utils.h"

@implementation Utils
+(NSString*)taskTitleDecodeKey{
    return @"title";
}
+(NSString*)taskDescriptionDecodeKey{
    return @"desc";
}
+(NSString*)taskDateDecodeKey{
    return @"data";
}
+(NSString*)taskPriortyDecodeKey{
    return @"priorty";
}
+(NSString*)taskStateDecodeKey{
    return @"state";
}
+(NSString*)todoUserDefultKey{
    return @"ToDo";
}
+(NSString*)doneUserDefultKey{
    return @"Done";
}
+(NSString*)inprogressUserDefultKey{
    return @"InProg";
}


@end
