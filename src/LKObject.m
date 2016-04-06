//
//  LKObject.m
//  JRFitness
//
//  Created by anjubao on 10/16/15.
//  Copyright © 2015 com.anjubao. All rights reserved.
//

#import "LKObject.h"
#import <objc/runtime.h>


@implementation LKObject

+(NSDictionary *)parserDictionary{
    return nil;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        NSMutableDictionary *parserDict = [[NSMutableDictionary alloc] initWithDictionary:[[self class] parserDictionary]];
        for (NSString *key in [parserDict allKeys]) {
            
            id valueKey = parserDict[key];
            
            NSString *valueType = nil;
            if ([valueKey isKindOfClass:[NSArray class]]) {
                valueType = [valueKey objectAtIndex:1];
                valueKey = [valueKey objectAtIndex:0];
            }
            id value = dictionary[valueKey];
            if(value)
            {
                Ivar ivar = class_getInstanceVariable([self class], [[@"_" stringByAppendingString:key] UTF8String]);
                const char *iType = ivar_getTypeEncoding(ivar);
                
                if (iType[0] == '@') {
                    static char typeString[32];
                    memset(typeString, 0, 32);
                    char *p = typeString;
                    for (int i = 0; i<strlen(iType); i++) {
                        if (iType[i]!='@' && iType[i]!='\"') {
                            *(p++) = iType[i];
                        }
                    }
                    Class objectClass = NSClassFromString([NSString stringWithUTF8String:typeString]);
                   
                    if ([objectClass isSubclassOfClass:[LKObject class]]) { //处理LKObject类型变量，并进行解析
                        [parserDict setObject:[[objectClass alloc] initWithDictionary:dictionary[valueKey]] forKey:key];
                        continue;
                    }
                    if ([objectClass isSubclassOfClass:[NSArray class]]) { //处理数组
                        if ([value isKindOfClass:[NSString class]]) {
                            value = JsonPresentation(value);
                        }
                        if (valueType) {
                            NSMutableArray *array = [[NSMutableArray alloc] init];
                            Class itemClass = NSClassFromString(valueType);
                            
                            for (id dict in value) {
                                if ([dict isKindOfClass:[NSDictionary class]] && [itemClass isSubclassOfClass:[LKObject class]]) {//判断元素是否属于字典
                                    id item = [[itemClass alloc] initWithDictionary:dict];
                                    [array addObject:item];
                                }
                            }
                            if (array.count>0) {
                                [parserDict setObject:array forKey:key];
                                continue;
                            }
                        }
                        
                        [parserDict setObject:value forKey:key];
                        continue;
                    }
                    
                }
                
                ///设置变量值
                [parserDict setObject:dictionary[valueKey] forKey:key];
            }
            else{
                ///设置变量值为空
                [parserDict removeObjectForKey:key];
            }
            
        }
        [self setValuesForKeysWithDictionary:parserDict];
       
    }
    return self;
}

-(NSDictionary *)objectDictionary{
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSDictionary *parserDict = [[self class] parserDictionary];
    
    NSString *valueType = nil;
    for (NSString *key in parserDict) {
    
        id valueKey = parserDict[key];//与服务端对应的key
        if ([valueKey isKindOfClass:[NSArray class]]) {
            valueType = [valueKey objectAtIndex:1];
            valueKey = [valueKey objectAtIndex:0];
        }
        id value = [self valueForKey:key];
        if (value) {
            if ([value isKindOfClass:[LKObject class]]) {//将LKObject类型变量转为字典类型
                [dictionary setValue:[[value objectDictionary] jsonString] forKey:valueKey];
            }
            else if ([value isKindOfClass:[NSArray class]]){//反解析数组
                
//                NSMutableArray *arrary = [[NSMutableArray alloc] init];
//                for (id object in value) {
//                    if ([object isKindOfClass:[LKObject class]]) {//将LKObject类型变量转为字典类型
//                        [arrary addObject:[[object objectDictionary] jsonString]];
//                    }
//                    else{
//                        [arrary addObject:object];
//                    }
//                    
//                }
                
                
                [dictionary setValue:[value jsonString] forKey:valueKey];
            }
            else{
                [dictionary setValue:value forKey:valueKey];
            }
        }
    }
    
    return dictionary;
}


@end
