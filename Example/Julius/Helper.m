//
//  Helper.m
//  Julius
//
//  Created by Tetsuro Higuchi on 6/4/15.
//  Copyright (c) 2015 Tetsuro Higuchi. All rights reserved.
//

#import "Helper.h"

@implementation Helper
+ (NSString*)temporaryDirectory
{
    return NSTemporaryDirectory();
}

+ (NSString*)temporaryDirectoryWithFileName:(NSString*)fileName
{
    return [[self temporaryDirectory] stringByAppendingPathComponent:fileName];
}

+ (NSString*)documentDirectory
{
    NSArray *paths =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    return [paths objectAtIndex:0];
}

+ (NSString*)documentDirectoryWithFileName:(NSString*)fileName
{
    return [[self documentDirectory] stringByAppendingPathComponent:fileName];
}

+ (BOOL)fileExistsAtPath:(NSString*)path
{
    NSFileManager* fileManager = [[NSFileManager alloc] init];
    return [fileManager fileExistsAtPath:path];
}

+ (NSArray*)listFilesAtPath:(NSString*)directoryPath extension:(NSString*)extension
{
    NSFileManager *fileManager=[[NSFileManager alloc] init];
    NSError *error = nil;
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:directoryPath error:&error];
    if (error) return nil;
    NSMutableArray *files = [[NSMutableArray alloc] init];
    for (NSString *fileName in contents) {
        if ([[fileName pathExtension] isEqualToString:extension]) {
            [files addObject:fileName];
        }
    }
    return files;
}

+ (BOOL)removeFilePath:(NSString*)path
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    return [fileManager removeItemAtPath:path error:NULL];
}
@end
