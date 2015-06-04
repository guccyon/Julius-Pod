//
//  JLSRecog+Wrapper.m
//  Pods
//
//  Created by Tetsuro Higuchi on 6/8/15.
//
//

#import "JLSRecog+Wrapper.h"

@implementation JLSRecog (Wrapper)
+(Recog *) recogNew {
    return j_recog_new();
}

+(void) recogFree:(Recog *)recog {
    j_recog_free(recog);
}

+(JLSStreamState) openStream:(Recog *)recog file_or_dev_name:(NSString *)file_or_dev_name {
    return j_open_stream(recog, (char *)[file_or_dev_name UTF8String]);
}

+(JLSStreamState) closeStream:(Recog *)recog {
    return j_close_stream(recog);
}

+(JLSState) recognizeStream:(Recog *)recog {
    return j_recognize_stream(recog);
}


+(void) requestPause:(Recog *)recog {
    j_request_pause(recog);
}

+(void) requestTerminate:(Recog *)recog {
    j_request_terminate(recog);
}

+(void) requestResume:(Recog *)recog {
    j_request_resume(recog);
}

+(void) scheduleGrammarUpdate:(Recog *)recog {
    schedule_grammar_update(recog);
}

+(void) resetReload:(Recog *)recog {
    j_reset_reload(recog);
}

+(boolean) loadAll:(Recog *)recog jconf:(Jconf *)jconf {
    return j_load_all(recog, jconf);
}

+(boolean) finalFusion:(Recog *)recog {
    return j_final_fusion(recog);
}

+(boolean) adinInit:(Recog *)recog {
    return j_adin_init(recog);
}

+(void) recogInfo:(Recog *)recog {
    j_recog_info(recog);
}

@end
