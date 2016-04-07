//
//  NSString+JsonString.m
//  LKObject
//
//  Created by anjubao on 4/6/16.
//  Copyright © 2016 anjubao. All rights reserved.
//

#import "NSString+JsonString.h"

@implementation NSString(JsonString)

- (NSString *)jsonString{
    
    return [NSString stringWithFormat:@"\"%@\"",self];
}

@end
