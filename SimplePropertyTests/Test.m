//
//  Test.m
//  SimpleProperty
//
//  Created by ileo on 16/8/29.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "Test.h"


@implementation Test

-(NSObject *)instanceObjectWithProperty:(Property *)property{
    if ([property.name isEqualToString:@"aArr"] || [property.name isEqualToString:@"dic"]) {
        return [[ARR alloc] init];
    }
    return nil;
}

@end
