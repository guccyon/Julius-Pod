//
//  JLSJulius.m
//  Pods
//
//  Created by Tetsuro Higuchi on 6/3/15.
//
//

#import "JLSJulius.h"

#import "JLSRecog.h"
#import <julius/jfunc.h>

@interface JLSJulius()<JLSRecogDelegate> {
    JLSRecog *_recog;
}
@property (copy) JLSRecognizeCompletion completion;
@end

@implementation JLSJulius

- (id)initWithPath:(NSString *)path Completion:(JLSRecognizeCompletion)completion {
    self = [self init];
    if (self) {
        JLSConf *conf = [JLSConf defaultConfig];
        _recog = [JLSRecog recogWithConf:conf];
        _recog.delegate = self;
        self.completion = completion;
    }
    return self;
}

- (void)recognizeFileAtPath:(NSString *)path {
    [_recog recognizeWithPath:path];
}

#pragma mark - JLSRecogDelegate
- (void) didRecognize:(JLSRecogResult*) result {
    if (self.completion) {
        NSError *error = nil;
        self.completion(result, error);
    }
}


+ (JLSJulius *)recognizeFileAtPath:(NSString *)path completion:(JLSRecognizeCompletion)completion {
    return [[self alloc] initWithPath:path Completion:completion];
}

+(void) enableDebugMessage {
    j_enable_debug_message();
}

+(void) disableDebugMessage {
    j_disable_debug_message();
}

+(void) enableVerboseMessage {
    j_enable_verbose_message();
}

+(void) disableVerboseMessage {
    j_disable_verbose_message();
}
@end
