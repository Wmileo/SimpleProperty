//
//  Test.h
//  SimpleProperty
//
//  Created by ileo on 16/8/29.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LRModel.h"
#import <UIKit/UIKit.h>
#import "ARR.h"

@interface Test : LRModel

@property (nonatomic, copy) NSArray<ARR *> *aArr;

@property (nonatomic, copy) NSArray *arr;

@property (nonatomic, strong) ARR *dic;

@property (nonatomic, assign) BOOL heihei;



@end
