//
//  NSDictionary+LKObject.m
//  LKObject
//
//  Created by anjubao on 16/8/4.
//  Copyright © 2016年 anjubao. All rights reserved.
//

#import "NSDictionary+LKObject.h"
#import "NSArray+LKObject.h"
#import "NSArray+JsonString.h"
#import "NSDictionay+JsonString.h"

@implementation NSDictionary(LKObject)


- (NSDictionary *)descriptionDictionary{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithDictionary:self];
    for (NSString *key in [self allKeys]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[LKObject class]]) {
            [dictionary setObject:[value descriptionDictionary] forKey:key];
        }
        else if ([value isKindOfClass:[NSDictionary class]]){
            [dictionary setObject:[value descriptionDictionary] forKey:key];
        }
        else if ([value isKindOfClass:[NSArray class]]){
            [dictionary setObject:[value descriptionArray] forKey:key];
        }
    }
    return dictionary;
}

@end
