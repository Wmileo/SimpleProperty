//
//  NSObject+Property.m
//  EasyModel
//
//  Created by ileo on 16/8/26.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

static char keyProperties;

-(NSArray<Property *> *)properties{
    NSArray *tmp = objc_getAssociatedObject(self, &keyProperties);
    if (!tmp) {
        NSArray *extra = [self respondsToSelector:@selector(superPropertyClasses)] ? self.superPropertyClasses : @[];
        NSMutableArray<Class> *clases = [NSMutableArray arrayWithArray:extra];
        [clases addObject:[self class]];
        NSMutableArray *pros = [NSMutableArray arrayWithCapacity:5];
        for (Class obj in clases) {
            [pros addObjectsFromArray:[PropertyTools propertiesWithClass:obj]];
        }
        tmp = [pros copy];
        objc_setAssociatedObject(self, &keyProperties, tmp, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    return tmp;
}

-(NSDictionary *)propertyDictionaryValue{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:4];
    for (Property *obj in self.properties) {
        id value = [self valueForKey:obj.name];
        if (value) {
            [dic setObject:value forKey:obj.name];
        }
    }
    return dic;
}

-(Property *)propertyWithName:(NSString *)name{
    Property *pro = nil;
    for (Property * obj in self.properties) {
        if ([obj.name isEqualToString:name]) {
            pro = obj;
        }
    }
    return pro;
}

#pragma mark - 赋值

-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [self init];
    if (self) {
        [self fillPropertyWithDictionary:dictionary];
    }
    return self;
}

-(void)fillValue:(id)value withProperty:(Property *)pro{
    @autoreleasepool {
        __block id newValue = value;
        if ([PropertyTools isValueValidWithProperty:pro value:value invalidCallBack:^(id initValue) {
            newValue = pro.initValue;
            NSLog(@"----invalid value:%@   forKey:%@  class:%@   newValue:%@",value,pro.name,[self class],pro.initValue);
        }]) {
            if ([self respondsToSelector:@selector(instanceObjectWithProperty:)] && [self instanceObjectWithProperty:pro]) {
                if ([pro.type isEqualToString:@"NSArray"]) {
                    NSArray *tmp = value;
                    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:tmp.count];
                    __weak __typeof(self) wself = self;
                    [tmp enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        NSObject *instance = [wself instanceObjectWithProperty:pro];
                        if ([PropertyTools isValidDictionaryValue:obj]) {
                            [instance fillPropertyWithDictionary:obj];
                            [arr addObject:instance];
                        }else{
                            [arr addObject:obj];
                            NSLog(@"----invalid value:%@   forKey:%@ index:%zd  class:%@ newValue:%@",obj,pro.name,idx,[instance class],obj);
                        }
                    }];
                    newValue = [arr copy];
                }else{
                    NSObject *instance = [self instanceObjectWithProperty:pro];
                    if ([pro.type isEqualToString:[NSString stringWithCString:class_getName([instance class]) encoding:NSUTF8StringEncoding]] && [PropertyTools isValidDictionaryValue:value]) {
                        [instance fillPropertyWithDictionary:value];
                        newValue = instance;
                    }else{
                        NSLog(@"----invalid value:%@   forKey:%@  class:%@ newValue:%@",value,pro.name,[instance class],value);
                        newValue = pro.initValue;
                    }
                }
            }
        }
        [self setValue:newValue forKey:pro.name];
    }
}

-(void)fillPropertyWithDictionary:(NSDictionary *)dictionary{
    NSArray<NSString *> *keys = [dictionary allKeys];
    NSMutableArray *tmp = [NSMutableArray arrayWithArray:self.properties];
    for (NSString * key in keys) {
        NSArray<Property *> *pros = [tmp copy];
        if (![self respondsToSelector:@selector(willTryToValueWithKey:value:)] || [self willTryToValueWithKey:key value:dictionary[key]]) {
            for (Property * pro in pros) {
                if ([pro.name isEqualToString:key]) {
                    [self fillValue:dictionary[pro.name] withProperty:pro];
                    [tmp removeObject:pro];
                    break;
                }
            }
        }
    }
}

+(NSArray *)instanceObjectsWithDictionarys:(NSArray<NSDictionary *> *)dics createObject:(NSObject *(^)())create{
    if ([PropertyTools isValidArrayValue:dics]) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:dics.count];
        [dics enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([PropertyTools isValidDictionaryValue:obj] && create) {
                NSObject *object = create();
                [object fillPropertyWithDictionary:obj];
                [arr addObject:object];
            }else{
                NSLog(@"----no creat instance   or   invalid value:%@ (+instanceObjects)  no a dictionary object",obj);
                [arr addObject:obj];
            }
        }];
        return [arr copy];
    }else{
        NSLog(@"----invalid value:%@ new value:%@ (+instanceObjects)  no a array object",dics,@[]);
        return @[];
    }
}

#pragma mark - debug

-(NSString *)propertyDescription{
    NSMutableString *debug = [NSMutableString stringWithFormat:@"--%@--{\n",[self class]];
    __weak __typeof(self) wself = self;
    [self.properties enumerateObjectsUsingBlock:^(Property * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != 0) [debug appendString:@"\n"];
        id value = [wself valueForKey:obj.name];
        if ([wself respondsToSelector:@selector(instanceObjectWithProperty:)] && [wself instanceObjectWithProperty:obj]) {
            if ([obj.type isEqualToString:@"NSArray"]) {
                [debug appendFormat:@"     %@ : (\n",obj.name];
                [value enumerateObjectsUsingBlock:^(id  _Nonnull val, NSUInteger idx, BOOL * _Nonnull stop) {
                    [debug appendFormat:@"         %@",((NSObject *)val).propertyDescription];
                }];
                [debug appendString:@")"];
            }else{
                [debug appendFormat:@"     %@ : %@",obj.name,((NSObject *)value).propertyDescription];
            }
        }else{
            [debug appendFormat:@"     %@ : %@",obj.name,value];
        }
    }];
    [debug appendString:@"\n}"];
    return debug;
}


@end
