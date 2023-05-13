//
//  TaskData.m
//  workshop
//
//  Created by Mac on 26/04/2023.
//

#import "TaskData.h"
#import "Utils.h"
@implementation TaskData
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _Title = [coder decodeObjectForKey:[Utils taskTitleDecodeKey]];
        _desc = [coder decodeObjectForKey:[Utils taskDescriptionDecodeKey]];
        _fdata = [coder decodeObjectForKey:[Utils taskDateDecodeKey]];
        _tpriorty = [coder decodeObjectForKey:[Utils taskPriortyDecodeKey]];
        _state = [coder decodeObjectForKey:[Utils taskStateDecodeKey]];
        if (!_state) {
                    _state = @"TODO";
                }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_Title forKey:[Utils taskTitleDecodeKey]];
    [coder encodeObject:_desc forKey:[Utils taskDescriptionDecodeKey]];
    [coder encodeObject:_fdata forKey:[Utils taskDateDecodeKey]];
    [coder encodeObject:_tpriorty forKey:[Utils taskPriortyDecodeKey]];
    [coder encodeObject:_state forKey:[Utils taskStateDecodeKey]];
}

@end
