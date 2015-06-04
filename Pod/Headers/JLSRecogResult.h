//
//  JLSRecogResult.h
//  Pods
//
//  Created by Tetsuro Higuchi on 6/3/15.
//
//

#import <Foundation/Foundation.h>

@interface JLSRecogResult : NSObject

@property (readonly) NSArray *sentences;

+(JLSRecogResult *)resultWithSentences:(NSArray *)sentences;

@end
