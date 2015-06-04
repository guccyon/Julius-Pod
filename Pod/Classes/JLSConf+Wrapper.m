//
//  JLSConf+Wrapper.m
//  Pods
//
//  Created by Tetsuro Higuchi on 6/8/15.
//
//

#import "JLSConf+Wrapper.h"

@implementation JLSConf (Wrapper)
+(Jconf *) jConfNew {
    return j_jconf_new();
}
+(void) jConfFree:(Jconf *)jconf {
    j_jconf_free(jconf);
}

+(int) configLoadArgs:(Jconf *)jconf argc:(int)argc strArray:(NSArray *) strArray
{
    char *argv[[strArray count]];
    NSInteger i = 0;
    for (NSString *str in strArray) {
        argv[i++] = (char *)[str UTF8String];
    }
    return j_config_load_args(jconf, argc, argv);
}

+(int) configLoadString:(Jconf *)jconf string:(NSString *)string {
    return j_config_load_string(jconf, (char *)[string UTF8String]);
}


+(int) configLoadFile:(Jconf *)jconf filename:(NSString *)filename {
    return j_config_load_file(jconf, (char *)[filename UTF8String]);
}

+(boolean) jconfFinalize:(Jconf *) jconf {
    return j_jconf_finalize(jconf);
}
@end
