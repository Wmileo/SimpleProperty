//
//  ARR.m
//  SimpleProperty
//
//  Created by ileo on 16/8/29.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "ARR.h"
#import "NSObject+Property.h"

@implementation ARR

-(void)dealloc{
    NSLog(@"dealloc");
}

-(NSArray<Class> *)superPropertyClasses{
    return @[[Father class]];
}

-(BOOL)willSaveUserDefaultValue:(id)value withProperty:(Property *)property{
    return YES;
}

-(BOOL)willClearUserDefaultProperty:(Property *)property{
       NSLog(@"needAutoSaveUserDefaultForProperty %@",property.name);
    return YES;
}

-(BOOL)needAutoSaveUserDefaultForProperty:(Property *)property{
    return YES;
}

@end
