//
//  JLSRecog.m
//  Pods
//
//  Created by Tetsuro Higuchi on 6/3/15.
//
//

#import "JLSRecog.h"
#import "JLSConf+Private.h"
#import "JLSRecog+Wrapper.h"

@interface JLSRecog() {
    Recog *_recog;
    BOOL _ready;
    NSString *_readingFile;
}
@end

@implementation JLSRecog

void JLSRecognitionResultListener(Recog *recog, void *data);

#pragma mark - Private Methods
- (id)initWithConf:(JLSConf *)conf {
    if (self = [super init]) {
        _recog = [JLSRecog recogNew];
        [self _setup:conf];
        [self _prepareListeners];
    }
    return self;
}

- (void) _setup:(JLSConf *)conf {
    _ready = NO;
    
    if ([JLSRecog loadAll:_recog jconf:conf.jconf] == FALSE) {
        return;
    }

    if ([JLSRecog finalFusion:_recog] == FALSE) {
        return;
    }

    if ([JLSRecog adinInit:_recog] == FALSE) {
        return;
    }

    _ready = YES;
}

- (void) _prepareListeners {
    [JLSRecog callbackAdd:_recog code:CALLBACK_RESULT completion:JLSRecognitionResultListener data:self];
}

- (void) _receiveRecognitionResult {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didRecognize:)]) {
        JLSRecogResult *result = [self _resultFromRecog];
        [self.delegate didRecognize:result];
    }

    j_close_stream(_recog);
}

- (JLSRecogResult *) _resultFromRecog {
    NSMutableArray *sentences = [NSMutableArray array];
    
    for(RecogProcess *r = _recog->process_list; r; r = r->next) {
        Output result = r->result;
        
        if (! r->live) continue;
        
        if (result.status < 0) continue;
        
        WORD_INFO *winfo = r->lm->winfo;
        for(int n = 0; n < result.sentnum; n++) {
            Sentence *s = &(result.sent[n]);
            WORD_ID *seq = s->word;
            int seqnum = s->word_num;
            
            NSMutableString *sentence = [NSMutableString string];
            for(int i = 0; i < seqnum; i++) {
                NSString *letter = [NSString stringWithCString:winfo->woutput[seq[i]] encoding:NSJapaneseEUCStringEncoding];
                if (letter) {
                    [sentence appendString:letter];
                }
            }
            [sentences addObject:sentence];
        }
    }
    
    return [JLSRecogResult resultWithSentences:sentences];
}

- (void)_notifyToDelegate:(SEL)selector withObject:(NSObject *)object {
    if (self.delegate && [self.delegate respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.delegate performSelector:selector withObject:self withObject:object];
#pragma clang diagnostic pop
    }
}

- (void) dealloc {
    [JLSRecog recogFree:_recog];
}

#pragma mark - Public Methods
- (void) printInfo {
    [JLSRecog recogInfo:_recog];
}

- (JLSState) recognizeWithPath:(NSString *)path {
    if (!_ready) {
        return JLSStateNotReady;
    }
    
    if ([JLSRecog openStream:_recog file_or_dev_name:path] == JLSStateSuccess) {
        if ([JLSRecog recognizeStream:_recog] == JLSStateSuccess) {
            _readingFile = path;
            return JLSStateSuccess;
        }
        
        [JLSRecog closeStream:_recog];
    }
    return JLSStateError;
}

#pragma mark - Class Methods
+(JLSRecog *)recogWithConf:(JLSConf *)conf {
    return [[self alloc] initWithConf:conf];
}


#pragma mark - callback wrapper functions
+(int) callbackAdd:(Recog *)recog code:(int)code completion:(void(*)(Recog *recog, void *data))completion data:(id)data {
    return callback_add(recog, code, completion, (__bridge void*) data);
}

void JLSRecognitionResultListener(Recog *recog, void *data) {
    JLSRecog *recogObject = (__bridge JLSRecog *)data;
    [recogObject _receiveRecognitionResult];
}

@end
