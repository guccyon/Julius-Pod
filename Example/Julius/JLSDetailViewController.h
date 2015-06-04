//
//  JLSDetailViewController.h
//  Julius
//
//  Created by Tetsuro Higuchi on 6/5/15.
//  Copyright (c) 2015 Tetsuro Higuchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLSDetailViewController : UIViewController

@property NSString *path;
@property IBOutlet UILabel *fileName;
@property IBOutlet UITextView *result;

@end
