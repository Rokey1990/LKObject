//
//  NSArray+JsonString.m
//  JRFitness
//
//  Created by 安居宝 安居宝 on 15/10/24.
//  Copyright © 2015年 com.anjubao. All rights reserved.
//

#import "NSArray+JsonString.h"
#import "NSDictionay+JsonString.h"
#import "NSString+JsonString.h"

@implementation NSArray(JsonString)

-(NSString *)jsonString{
    NSMutableString *jsonString = [[NSMutableString alloc] initWithString:@"["];
    for (id item in self) {
        NSString *string = nil;
        if ([item isKindOfClass:[LKObject class]]) {
            string = [[item objectDictionary] jsonString];
            if ([item isEqual:[self lastObject]]) {
                [jsonString appendFormat:@"%@",string];
            }
            else{
                [jsonString appendFormat:@"%@,",string];
            }
        }
        else if ([item isKindOfClass:[NSDictionary class]]){
            string = [item jsonString];
            if ([item isEqual:[self lastObject]]) {
                [jsonString appendFormat:@"%@",string];
            }
            else{
                [jsonString appendFormat:@"%@,",string];
            }
        }
        else{
            string = item;
            if ([item isEqual:[self lastObject]]) {
                [jsonString appendFormat:@"\"%@\"",string];
            }
            else{
                [jsonString appendFormat:@"\"%@\",",string];
            }
        }
       
    }
    [jsonString appendString:@"]"];
    return jsonString;

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
                NSLog(@"warning: the params jsonItem is not the xxx object");
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
