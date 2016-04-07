//
//  NSNumber+JsonString.m
//  LKObject
//
//  Created by anjubao on 4/7/16.
//  Copyright © 2016 anjubao. All rights reserved.
//

#import "NSNumber+JsonString.h"

@implementation NSNumber(JsonString)
- (NSString *)jsonString{
    return [self description];
}
@end
