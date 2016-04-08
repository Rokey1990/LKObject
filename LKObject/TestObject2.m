//
//  TestObject2.m
//  LKObject
//
//  Created by anjubao on 4/7/16.
//  Copyright © 2016 anjubao. All rights reserved.
//

#import "TestObject2.h"

@implementation TestObject2

+ (NSDictionary *)parserDictionary{
    
    return @{
             @"testName":@"testName",
             @"object1":@"object1",
             @"testArray":@"testArray",
             @"testArray2":@[@"testArray2",@"TestObject3"],
             };
}
- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}
@end
