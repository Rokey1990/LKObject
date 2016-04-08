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
        [jsonString appendFormat:item==[self lastObject]?@"%@":@"%@,",[item jsonString]];
    }
    [jsonString appendString:@"]"];
    return jsonString;

}

@end
