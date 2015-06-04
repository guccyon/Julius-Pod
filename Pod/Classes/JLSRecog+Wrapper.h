//
//  JLSRecog+Wrapper.h
//  Pods
//
//  Created by Tetsuro Higuchi on 6/8/15.
//
//

#import "JLSRecog.h"
#import <julius/jfunc.h>

@interface JLSRecog (Wrapper)

+(Recog *) recogNew;
+(void) recogFree:(Recog *)recog;
+(JLSStreamState) openStream:(Recog *)recog file_or_dev_name:(NSString *)file_or_dev_name;
+(JLSStreamState) closeStream:(Recog *)recog;
+(JLSState) recognizeStream:(Recog *)recog;
+(void) requestPause:(Recog *)recog;
+(void) requestTerminate:(Recog *)recog;
+(void) requestResume:(Recog *)recog;
+(void) scheduleGrammarUpdate:(Recog *)recog;
+(void) resetReload:(Recog *)recog;
+(boolean) loadAll:(Recog *)recog jconf:(Jconf *)jconf;
+(boolean) finalFusion:(Recog *)recog;
+(boolean) adinInit:(Recog *)recog;
+(void) recogInfo:(Recog *)recog;

@end
