//
//  LKObject.h
//  JRFitness
//
//  Created by anjubao on 10/16/15.
//  Copyright © 2015 com.anjubao. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSArray+JsonString.h"
#import "NSDictionay+JsonString.h"

#define JsonPresentation(string) (string?[NSJSONSerialization JSONObjectWithData:[string dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil]:nil)


@interface LKObject : NSObject


/**
 *  记录属性及其在服务端解析数据时所对应的字段
 *
 *  @return 返回属性与服务端返回数据字段名之间的字典
 */
+ (NSDictionary *)parserDictionary;

/**
 *  从服务端接收的数据，解析到对应的类中
 *
 *  @param dictionary 从服务端获取到的数据
 *
 *  @return 解析后的对象
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 *  根据当前对象的值，构造出展示所有数据内容的字典
 *
 *  @return 描述对象的字典
 */
- (NSDictionary *) descriptionDictionary;

/**
 *  将对象转为json字符串(空值属性将会被屏蔽)；
 *
 *  @return 对象的json字符串
 */
- (NSString *)jsonString;

- (void)testMethods;

@end


