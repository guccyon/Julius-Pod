//
//  JLSConf+Wrapper.h
//  Pods
//
//  Created by Tetsuro Higuchi on 6/8/15.
//
//

#import "JLSConf.h"
#import <julius/jfunc.h>


@interface JLSConf (Wrapper)
+(Jconf *) jConfNew;
+(void) jConfFree:(Jconf *)jconf;
+(int) configLoadArgs:(Jconf *)jconf argc:(int)argc strArray:(NSArray *) strArray;
+(int) configLoadString:(Jconf *)jconf string:(NSString *)string;
+(int) configLoadFile:(Jconf *)jconf filename:(NSString *)filename;
+(boolean) jconfFinalize:(Jconf *) jconf;

@end
