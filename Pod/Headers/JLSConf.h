//
//  JLSConf.h
//  Pods
//
//  Created by Tetsuro Higuchi on 6/3/15.
//
//

#import <Foundation/Foundation.h>

#import "JLSConstants.h"

@interface JLSConf : NSObject

+(JLSConf *)defaultConfig;
+(JLSConf *)confWithPath:(NSString*) path;
+(JLSConf *)confWithName:(NSString*) name;
@end
