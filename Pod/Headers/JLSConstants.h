//
//  JLS Constants.h
//  Pods
//
//  Created by Tetsuro Higuchi on 6/3/15.
//
//

typedef NS_ENUM(NSInteger, JLSState)
{
    JLSStateError    = -1,
    JLSStateSuccess  = 0,
    JLSStateNotReady = 1
};

typedef NS_ENUM(NSInteger, JLSStreamState)
{
    JLSStreamStateDeviceError  = -2,
    JLSStreamStateGeneralError = -1,
    JLSStreamStateSuccess      = 0
};

static NSString *const kJLSBundleName = @"Julius";
static NSString *const kJLSJconfFileType = @"jconf";
static NSString *const kJLSDefaultJconfName = @"light";