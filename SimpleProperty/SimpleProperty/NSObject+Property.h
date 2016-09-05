//
//  NSObject+Property.h
//  EasyModel
//
//  Created by ileo on 16/8/26.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyTools.h"

@protocol PropertyDelegate <NSObject>

@optional
#pragma mark - 赋值
-(BOOL)willTryToValueWithKey:(NSString *)key value:(id)value;//当从dic取数据赋值时调用,返回YES 赋值，返回NO不赋值
-(NSObject *)instanceObjectWithProperty:(Property *)property;//返回property对应的实例
-(void)didValueWithProperty:(Property *)property value:(id)value;//给属性赋值完调用

#pragma mark -
//包含需要赋值属性的类（已包含本类，不需要再添加）（当需要给父类属性赋值时调用）
-(NSArray<Class> *)superPropertyClasses;

@end

//保存赋值只支持基本类型，NSNumber,NSString,NSArray,NSDictionary
@interface NSObject (Property) <PropertyDelegate>

#pragma mark - 赋值
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
//给属性赋值
-(void)fillPropertyWithDictionary:(NSDictionary *)dictionary;
-(void)fillValue:(id)value withProperty:(Property *)pro;

+(NSArray *)instanceObjectsWithDictionarys:(NSArray<NSDictionary *> *)dics createObject:(NSObject *(^)())create;

//返回字典格式的数据
-(NSDictionary *)propertyDictionaryValue;
-(NSArray<Property *> *)properties;

-(Property *)propertyWithName:(NSString *)name;

#pragma mark - debug
//支持基本类型(简单类) 否则会崩溃
-(NSString *)propertyDescription;


@end

