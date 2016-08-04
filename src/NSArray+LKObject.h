//
//  NSArray+LKObject.h
//  LKObject
//
//  Created by anjubao on 16/8/4.
//  Copyright © 2016年 anjubao. All rights reserved.
//

#import "LKObject.h"

@interface NSArray(LKObject)

@property (nonatomic,strong,readonly) NSArray *descriptionArray;

/**
 *  使用数组初始化一个类(类名为classname)对象数组
 *
 *  @param className 类名为classname LKObject子类的类名，如TestObject:LKObject，则此处可以为LKObject
 *  @param array 传入的json数组
 *
 *  @return 返回一个NSArray<ClassName>的数组，如NSArray<TestObject>
 */
+ (instancetype)arrayWithArray:(NSArray *)array objectClassName:(NSString *)className;

/**
 *  使用json字符串初始化一个类(类名为classname)对象数组
 *
 *  @param jsonString 需要
 *  @param className  数组中元素的类型
 *
 *  @return 一个由ClassName对象构成的数组
 */
+ (instancetype)arrayWithJsonString:(NSString *)jsonString objectClassName:(NSString *)className;
/**
 *  初始化一个对象数组，参数同时兼容jsonString 及NSArray
 *
 *  @param jsonItem  需要传入的jsonString或者NSArray
 *  @param className 对象的类名
 *
 *  @return 一个由ClassName对象构成的数组
 */
+ (instancetype)arrayWithJsonItem:(id)jsonItem objectClassName:(NSString *)className;

@end
