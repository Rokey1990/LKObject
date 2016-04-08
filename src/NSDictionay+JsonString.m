//
//  NSDictionay+JsonString.m
//  JRFitness
//
//  Created by 安居宝 安居宝 on 15/10/24.
//  Copyright © 2015年 com.anjubao. All rights reserved.
//

#import "NSDictionay+JsonString.h"
#import "NSString+JsonString.h"
@implementation NSDictionary(JsonString)

-(NSString *)jsonString{
    NSMutableString *jsonString = [[NSMutableString alloc] initWithString:@"{"];
    NSArray *keys = [self allKeys];
    for (NSString *key in keys) {
        [jsonString appendFormat:key==[keys lastObject]?@"%@:%@":@"%@:%@,",key.jsonString,[self[key] jsonString]];
    }
    [jsonString appendString:@"}"];

    return jsonString;
}

@end
