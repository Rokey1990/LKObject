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
        else if([object isKindOfClass:[NSDictionary class]]){
            [object addObject:[object objectDictionary]];
        }
        else if ([object isKindOfClass:[NSArray class]]){
            [object addObject:[object objectArray]];
        }
        else{
            [objectArray addObject:object];
        }
    }
    return objectArray;
}

- (NSArray *)descriptionArray{
    NSMutableArray *objectArray = [[NSMutableArray alloc] init];
    for (id object in self) {
        if ([object isKindOfClass:[LKObject class]]) {
            [objectArray addObject:[object descriptionDictionary]];
        }
        else if([object isKindOfClass:[NSDictionary class]]){
            [object addObject:[object descriptionDictionary]];
        }
        else if ([object isKindOfClass:[NSArray class]]){
            [object addObject:[object descriptionDictionary]];
        }
        else{
            [objectArray addObject:object];
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
        else if ([value isKindOfClass:[NSDictionary class]]){
            [dictionary setObject:[value objectDictionary] forKey:key];
        }
        else if ([value isKindOfClass:[NSArray class]]){
            [dictionary setObject:[value objectArray] forKey:key];
        }
    }
    return dictionary;
}

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
