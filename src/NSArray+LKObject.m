//
//  NSArray+LKObject.m
//  LKObject
//
//  Created by anjubao on 16/8/4.
//  Copyright © 2016年 anjubao. All rights reserved.
//

#import "NSArray+LKObject.h"

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
            [objectArray addObject:[object descriptionArray]];
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
        NSLog(@"warning: the params jsonItem is not the %@ object",[self class]);
        return nil;
    }
}

@end
