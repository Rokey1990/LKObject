//
//  LKObject.m
//  JRFitness
//
//  Created by anjubao on 10/16/15.
//  Copyright © 2015 com.anjubao. All rights reserved.
//

#import "LKObject.h"
#import <objc/runtime.h>
#import "LKObject+Categories.h"

@implementation LKObject

+(NSDictionary *)parserDictionary{
    return nil;
}

#ifdef DEBUG
#if DEBUG
- (void)validateParserDicionay{
    NSLog(@"hello,kitty");
    NSDictionary *parserDictionary = [[self class] parserDictionary];
    NSArray *parserKeys = parserDictionary.allKeys;
    for (NSString *key in parserKeys) {
        NSAssert(class_getProperty([self class], key.UTF8String), @"LKObject Error:The Key-Value: %@,%@ cannot find any corresponding property in class: %@",key,parserDictionary[key],[self class]);

    }
}
#endif
#endif

- (NSMutableDictionary *)normalParserDictionary{
    NSMutableDictionary *parserDictionary = [[NSMutableDictionary alloc] init];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(properties[i])];
        [parserDictionary setObject:propertyName forKey:propertyName];
    }
    return parserDictionary;
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
#ifdef DEBUG
#if DEBUG == 1
        [self validateParserDicionay];
#endif
#endif
        NSMutableDictionary *parserDict = [[NSMutableDictionary alloc] initWithDictionary:[[self class] parserDictionary]];
        if (parserDict.allKeys.count == 0) {
            parserDict = [self normalParserDictionary];
        }
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
//                            NSMutableArray *array = [[NSMutableArray alloc] init];
//                            Class itemClass = NSClassFromString(valueType);
//                            
//                            for (id dict in value) {
//                                if ([dict isKindOfClass:[NSDictionary class]] && [itemClass isSubclassOfClass:[LKObject class]]) {//判断元素是否属于字典
//                                    id item = [[itemClass alloc] initWithDictionary:dict];
//                                    [array addObject:item];
//                                }
//                            }
                            NSArray *array = [NSArray arrayWithArray:value objectClassName:valueType];
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
    if (!parserDict) {
        parserDict = [self normalParserDictionary];
    }
    
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
                [dictionary setValue:[value jsonString] forKey:valueKey];
            }
            else{
                [dictionary setValue:value forKey:valueKey];
            }
        }
    }
    
    return dictionary;
}

- (NSDictionary *)descriptionDictionary{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSDictionary *parserDict = [[self class] parserDictionary];
    if (!parserDict) {
        parserDict = [self normalParserDictionary];
    }
    
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
                [dictionary setValue:[value descriptionDictionary] forKey:valueKey];
            }
            else if ([value isKindOfClass:[NSArray class]]){//反解析数组
                [dictionary setValue:[value descriptionArray] forKey:valueKey];
            }
            else if ([value isKindOfClass:[NSDictionary class]]){
                [dictionary setValue:[value descriptionDictionary] forKey:valueKey];
            }
            else{
                [dictionary setValue:value forKey:valueKey];
            }
        }
    }
    
    return dictionary;
}

- (void)testMethods{
    NSLog(@"testMethods");
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
//        NSLog(@"%s",property_getAttributes(properties[i]));
        int attrCount = 0;
        objc_property_attribute_t *attributes = property_copyAttributeList(properties[i], &attrCount);
        for (int i = 0; i < attrCount; i++) {
            NSLog(@"%s,%s",attributes[i].name,attributes[i].value);
            
        }
    }
}


@end
