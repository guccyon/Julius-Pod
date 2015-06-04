//
//  JLSDetailViewController.m
//  Julius
//
//  Created by Tetsuro Higuchi on 6/5/15.
//  Copyright (c) 2015 Tetsuro Higuchi. All rights reserved.
//

#import "JLSDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Helper.h"
#import "JLSRecog.h"

@interface JLSDetailViewController ()<JLSRecogDelegate> {
    AVAudioPlayer *player;
    JLSRecog *recog;
}

@end

@implementation JLSDetailViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:[self fullpath]] error:nil];
    [player prepareToPlay];

    NSString *confPath = [[NSBundle mainBundle] pathForResource:@"light" ofType:@"jconf"];
    JLSConf *conf = [JLSConf confWithPath:confPath];
    recog = [JLSRecog recogWithConf:conf];
    recog.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.fileName.text = self.path;
}

- (NSString*) fullpath {
    return [Helper temporaryDirectoryWithFileName:self.path];
}

- (IBAction)playback:(id)sender
{
    [player play];
}

- (IBAction)recognize:(id)sender {    
    [recog recognizeWithPath:[self fullpath]];
}

#pragma mark - JLSRecogDelegate
- (void)didRecognize:(JLSRecogResult *)result
{
    NSMutableString *resultString = [NSMutableString string];
    
    for(NSString *str in result.sentences) {
        [resultString appendString:str];
    }
    self.result.text = [NSString stringWithFormat:@"result: %@", resultString];
}
@end

