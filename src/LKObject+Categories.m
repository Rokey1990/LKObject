//
//  LKObject+Categories.m
//  JRFitness
//
//  Created by anjubao on 10/17/15.
//  Copyright © 2015 com.anjubao. All rights reserved.
//

#import "LKObject+Categories.h"
#import "NSArray+JsonString.h"
#import "NSDictionay+JsonString.h"

@implementation NSArray(LKObject)

-(NSArray *)objectArray{
    NSMutableArray *objectArray = [[NSMutableArray alloc] init];
    for (id object in self) {
        if ([object isKindOfClass:[LKObject class]]) {
            [objectArray addObject:[object objectDictionary]];
        }
    }
    return objectArray;
}

@end


@implementation NSDictionary(LKObject)

-(NSDictionary *)objectDictionary{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:self];
    for (NSString *key in [self allKeys]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[LKObject class]]) {
            [dictionary setObject:[value objectDictionary] forKey:key];
            
        }
    }
    return nil;
}

@end
