//
//  LKObject+Categories.h
//  JRFitness
//
//  Created by anjubao on 10/17/15.
//  Copyright © 2015 com.anjubao. All rights reserved.
//

#import "LKObject.h"

@interface NSArray(LKObject)

@property (nonatomic,strong,readonly) NSArray *objectArray;

@property (nonatomic,strong,readonly) NSArray *descriptionArray;

@end


@interface NSDictionary(LKObject)

@property (nonatomic,strong,readonly) NSDictionary *objectDictionary;

@property (nonatomic,strong,readonly) NSDictionary *descriptionDictionary;

@end