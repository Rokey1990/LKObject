//
//  NSDictionay+JsonString.m
//  JRFitness
//
//  Created by 安居宝 安居宝 on 15/10/24.
//  Copyright © 2015年 com.anjubao. All rights reserved.
//

#import "NSDictionay+JsonString.h"

@implementation NSDictionary(JsonString)

-(NSString *)jsonString{
    NSMutableString *jsonString = [[NSMutableString alloc] initWithString:@"{"];
    NSArray *keys = [self allKeys];
    for (NSString *key in keys) {
        id value = self[key];
        if ([value isKindOfClass:[LKObject class]]) {
            value = [[value objectDictionary] jsonString];
        }
        if ([key isEqual:[keys lastObject]]) {
            [jsonString appendFormat:@"\"%@\":%@",key,[self[key] jsonString]];
        }
        else{
            [jsonString appendFormat:@"\"%@\":%@,",key,[self[key] jsonString]];
        }
    }
    [jsonString appendString:@"}"];

    return jsonString;
}

@end
