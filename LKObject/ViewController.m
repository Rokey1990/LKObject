//
//  ViewController.m
//  LKObject
//
//  Created by anjubao on 4/6/16.
//  Copyright © 2016 anjubao. All rights reserved.
//

#import "ViewController.h"
#import "LKObject.h"

@interface TestObject : LKObject

@property (nonatomic,strong) NSString *testString;
@property (nonatomic,assign) int testInt;
@property (nonatomic,assign) float testFloat;

@end

@implementation TestObject

//+ (NSDictionary *)parserDictionary{
//    return @{
//             @"testString":@"testString",
//             @"testInt":@"testInt",
//             @"testFloat":@"testFloat",
//             };
//}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    TestObject *test = [[TestObject alloc] initWithDictionary:@{
                                                                @"testString":@"hello,kitty",
                                                                @"testInt":@"20",
                                                                @"testFloat":@"11.1",
                                                                @"testDouble":@"20.1"
                                                                }];
    NSLog(@"%@",test.objectDictionary);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
