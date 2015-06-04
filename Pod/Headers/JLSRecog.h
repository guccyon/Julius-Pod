//
//  JLSRecog.h
//  Pods
//
//  Created by Tetsuro Higuchi on 6/3/15.
//
//

#import <Foundation/Foundation.h>

#import "JLSConstants.h"
#import "JLSConf.h"
#import "JLSRecogResult.h"

@protocol JLSRecogDelegate;

@interface JLSRecog : NSObject

@property (readonly) BOOL ready;
@property (assign) id<JLSRecogDelegate> delegate;

/**
 * print Recog instance info
 */
- (void) printInfo;

- (JLSState) recognizeWithPath:(NSString *)path;

/**
 * create Recog instance
 *
 * @param conf: JLSConf instance
 */
+ (JLSRecog *)recogWithConf:(JLSConf *)conf;

- (id)init __attribute__((unavailable("init is not available")));

@end

@protocol JLSRecogDelegate <NSObject>

@required
- (void) didRecognize:(JLSRecogResult*) result;

@end
