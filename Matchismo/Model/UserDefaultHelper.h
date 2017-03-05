//
//  UserDefaultHelper.h
//  Matchismo
//
//  Created by Lmz on 2017/2/23.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultHelper : NSObject

+ (void)writeArrayToDefault:(NSArray *)array key:(NSString *)key;
+ (id)readArrayFromDefaultByKey:(NSString *)key;

+ (void)writeIntegerToDefault:(NSInteger)integer key:(NSString *)key;
+ (NSInteger)readIntegerFromDefaultByKey:(NSString *)key;

+ (void)removeDefaultForKey:(NSString *)key;

@end
