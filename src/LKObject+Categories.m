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


- (NSArray *)descriptionArray{
    NSMutableArray *objectArray = [[NSMutableArray alloc] init];
    for (id object in self) {
        if ([object isKindOfClass:[LKObject class]]) {
            [objectArray addObject:[object descriptionDictionary]];
        }
        else if([object isKindOfClass:[NSDictionary class]]){
            [objectArray addObject:[object descriptionDictionary]];
        }
        else if ([object isKindOfClass:[NSArray class]]){
            [objectArray addObject:[object descriptionDictionary]];
        }
        else{
            [objectArray addObject:object];
        }
    }
    return objectArray;
}

+ (instancetype)arrayWithArray:(NSArray *)array objectClassName:(NSString *)className{
    NSMutableArray *objectArray = [[NSMutableArray alloc] init];
    Class objectClass = NSClassFromString(className);
    if ([objectClass isSubclassOfClass:[LKObject class]]) {
        
        for (id object in array) {
            if ([object isKindOfClass:[NSDictionary class]]) {
                [objectArray addObject:[[objectClass alloc] initWithDictionary:object]];
            }
            else{
                NSLog(@"warning: the params jsonItem is not the %@ object",className);
            }
        }
        
    }
    else{
        [objectArray addObjectsFromArray:array];
        return objectArray;
        
    }
    
    return objectArray;
}

+ (instancetype)arrayWithJsonString:(NSString *)jsonString objectClassName:(NSString *)className{
    return [self arrayWithArray:JsonPresentation(jsonString) objectClassName:className];
}

+ (instancetype)arrayWithJsonItem:(id)jsonItem objectClassName:(NSString *)className{
    if ([jsonItem isKindOfClass:[NSString class]]) {
        return [self arrayWithArray:JsonPresentation(jsonItem) objectClassName:className];
    }
    else if ([jsonItem isKindOfClass:[NSArray class]]){
        return [self arrayWithArray:jsonItem objectClassName:className];
    }
    else{
        NSLog(@"warning: the params jsonItem is not the xxx object");
        return nil;
    }
}

@end


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
