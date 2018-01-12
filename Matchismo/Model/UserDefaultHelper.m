//
//  UserDefaultHelper.m
//  Matchismo
//
//  Created by Lmz on 2017/2/23.
//  Copyright © 2017年 CS193p. All rights reserved.
//

#import "UserDefaultHelper.h"

@implementation UserDefaultHelper

+ (void)writeArrayToDefault:(NSArray *)array key:(NSString *)key {
  [[NSUserDefaults standardUserDefaults] setObject:array forKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)readArrayFromDefaultByKey:(NSString *)key {
  return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


+ (void)writeIntegerToDefault:(NSInteger)integer key:(NSString *)key {
  [[NSUserDefaults standardUserDefaults] setInteger:integer forKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger)readIntegerFromDefaultByKey:(NSString *)key {
  return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}


+ (void)removeDefaultForKey:(NSString *)key {
  [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
  [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

