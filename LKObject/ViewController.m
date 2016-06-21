//
//  ViewController.m
//  LKObject
//
//  Created by anjubao on 4/6/16.
//  Copyright © 2016 anjubao. All rights reserved.
//

#import "ViewController.h"
#import "LKObject.h"

#import "TestObject1.h"
#import "TestObject2.h"
#import "TestObject4.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    TestObject3 *object3 = [[TestObject3 alloc] initWithDictionary:@{@"name":@"testName"}];
    NSLog(@"%@",object3.descriptionDictionary);
    
    TestObject1 *object1 = [[TestObject1 alloc] initWithDictionary:@{@"testName":@"name",
                                                                               @"testString":@"string",
                                                                               @"testInt":@"100",
                                                                               @"testFloat":@"20.1",
                                                                               @"testObject3":@{@"name":@"testName"}
                                                                               }];
    NSLog(@"%@",object1.descriptionDictionary);
    
    TestObject2 *test = [[TestObject2 alloc] initWithDictionary:@{
                                                                @"testName":@"hello,kitty",
                                                                @"object1":@{@"testName":@"name",
                                                                             @"testString":@"string",
                                                                             @"testInt":@"100",
                                                                             @"testFloat":@"20.1",
                                                                             @"testObject3":@{@"name":@"testName"}
                                                                             },
                                                                @"testArray":@[@"hello",@"kitty",@"ni",@"hao"],
                                                                @"testArray2":@[@{@"name":@"testName"},@{@"name":@"testName"}]
                                                                }];
    NSLog(@"%@",test.descriptionDictionary);
    NSString *jsonString = [test.descriptionDictionary jsonString];
    NSLog(@"%@",jsonString);
    NSLog(@"%@",JsonPresentation(test.descriptionDictionary.jsonString));
    
    
    TestObject4 *test4 = [TestObject4 new];
    [test4 setValuesForKeysWithDictionary:@{@"testString1":@"hello,kitty",@"testArray":@[@{@"name":@"test3_1"},@{@"name":@"test3_2"},@{@"name":@"test3_3"}]} parserDictionary:@{@"testString":@"testString1",@"normalArray":@[@"testArray",@"TestObject3"]}];
    NSLog(@"%@",test4.descriptionDictionary);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
