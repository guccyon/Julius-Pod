//
//  JLSJulius.h
//  Pods
//
//  Created by Tetsuro Higuchi on 6/3/15.
//
//

#import <Foundation/Foundation.h>
#import <julius/julius.h>

#import "JLSConstants.h"
#import "JLSRecog.h"

typedef void (^JLSRecognizeCompletion)(JLSRecogResult *result, NSError *error);

@interface JLSJulius : NSObject

+ (JLSJulius *)recognizeFileAtPath:(NSString *)path completion:(JLSRecognizeCompletion)completion;

+(void) enableDebugMessage;
+(void) disableDebugMessage;
+(void) enableVerboseMessage;
+(void) disableVerboseMessage;
@end
