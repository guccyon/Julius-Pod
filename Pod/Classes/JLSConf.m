//
//  JLSConf.m
//  Pods
//
//  Created by Tetsuro Higuchi on 6/3/15.
//
//

#import "JLSConf.h"

#import "JLSConf+Wrapper.h"

@interface JLSConf() {
    Jconf *_jconf;
}
@property (readwrite) Jconf *jconf;
@end

@implementation JLSConf

- (id)init {
    if(self = [super init]) {
        _jconf = [JLSConf jConfNew];
    }
    return self;
}

- (id)initWithPath:(NSString *)path {
    if (self = [self init]) {
        [self loadConfigAtPath:path];
    }
    return self;
}

- (void)loadConfigAtPath:(NSString *)path {
    if ([JLSConf configLoadFile:_jconf filename:path] == JLSStateError) {
        @throw [NSString stringWithFormat:@"could not load config from %@", path];
    }
    
    if ([JLSConf jconfFinalize:_jconf] == FALSE) {
        @throw [NSString stringWithFormat:@"%@ is invalid jconf", path];
    }
}

#pragma mark - Class methods
+(NSBundle *) juliusBundle {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:kJLSBundleName ofType:@"bundle"];
    return [NSBundle bundleWithPath:bundlePath];
}

+(JLSConf *)defaultConfig {
    NSString *path = [[self juliusBundle] pathForResource:kJLSDefaultJconfName ofType:kJLSJconfFileType];
    return [[self alloc] initWithPath:path];
}

+(JLSConf *)confWithName:(NSString*) name {
    NSString *path = [[self juliusBundle] pathForResource:name ofType:kJLSJconfFileType];
    return [[self alloc] initWithPath:path];
}

+(JLSConf *)confWithPath:(NSString*) path {
    return [[self alloc] initWithPath:path];
}

@end
