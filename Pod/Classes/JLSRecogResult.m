//
//  JLSRecogResult.m
//  Pods
//
//  Created by Tetsuro Higuchi on 6/3/15.
//
//

#import "JLSRecogResult.h"

@interface JLSRecogResult()
@property (readwrite) NSArray *sentences;
@end

@implementation JLSRecogResult

+(JLSRecogResult *)resultWithSentences:(NSArray *)sentences {
    JLSRecogResult *instance = [self new];
    instance.sentences = sentences;
    return instance;
}

@end
