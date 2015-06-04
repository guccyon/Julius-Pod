//
//  Helper.h
//  Julius
//
//  Created by Tetsuro Higuchi on 6/4/15.
//  Copyright (c) 2015 Tetsuro Higuchi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject
+ (NSString*)temporaryDirectory;
+ (NSString*)temporaryDirectoryWithFileName:(NSString*)fileName;
+ (NSString*)documentDirectory;
+ (NSString*)documentDirectoryWithFileName:(NSString*)fileName;
+ (BOOL)fileExistsAtPath:(NSString*)path;
+ (NSArray*)listFilesAtPath:(NSString*)directoryPath extension:(NSString*)extension;
+ (BOOL)removeFilePath:(NSString*)path;
@end
