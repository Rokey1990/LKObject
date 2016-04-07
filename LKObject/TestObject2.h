//
//  TestObject2.h
//  LKObject
//
//  Created by anjubao on 4/7/16.
//  Copyright © 2016 anjubao. All rights reserved.
//

#import "LKObject.h"
#import "TestObject1.h"

@interface TestObject2 : LKObject

@property (strong,nonatomic) NSString *testName;

@property (nonatomic,strong) TestObject1 *object1;

@property (nonatomic,strong) NSArray<NSString *> *testArray;

@property (nonatomic,strong) NSArray<TestObject3 *> *testArray2;


@end
