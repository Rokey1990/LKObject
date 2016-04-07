//
//  NSArray+JsonString.h
//  JRFitness
//
//  Created by 安居宝 安居宝 on 15/10/24.
//  Copyright © 2015年 com.anjubao. All rights reserved.
//

#import "LKObject.h"

@interface NSArray(JsonString)

///使用数组初始化一个类(类名为classname)对象数组
+ (instancetype)arrayWithArray:(NSArray *)array objectClassName:(NSString *)className;
///使用json字符串初始化一个类(类名为classname)对象数组
+ (instancetype)arrayWithJsonString:(NSString *)jsonString objectClassName:(NSString *)className;
///初始化一个对象数组，参数同时兼容jsonString 及NSArray
+ (instancetype)arrayWithJsonItem:(id)jsonItem objectClassName:(NSString *)className;
///数组的json字符串表示
@property (readonly) NSString *jsonString;

@end
