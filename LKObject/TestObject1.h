//
//  TestObject1.h
//  LKObject
//
//  Created by anjubao on 4/7/16.
//  Copyright © 2016 anjubao. All rights reserved.
//

#import "LKObject.h"
#import "TestObject3.h"

@interface TestObject1 : LKObject

@property (strong,nonatomic) NSString *testName;

@property (strong,nonatomic) NSString *testString;

@property (assign,nonatomic) int testInt;

@property (assign,nonatomic) float testFloat;

@property (nonatomic,strong) TestObject3 *testObject3;;

@end
