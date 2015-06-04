//
//  JLSViewController.m
//  Julius
//
//  Created by Tetsuro Higuchi on 06/03/2015.
//  Copyright (c) 2014 Tetsuro Higuchi. All rights reserved.
//

#import "JLSViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "Helper.h"
#import "JLSDetailViewController.h"

@interface JLSViewController ()<UITableViewDataSource, UITableViewDelegate, AVAudioRecorderDelegate> {
    NSArray* recordedFiles;
    AVAudioRecorder *recorder;
}

@property IBOutlet UITableView *tableView;
@end

@implementation JLSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self listRecordedFiles];
    self.navigationItem.leftBarButtonItem = [self editButtonItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)listRecordedFiles
{
    recordedFiles = @[];
    NSArray *list = [Helper listFilesAtPath:[Helper temporaryDirectory] extension:@"wav"];
    if (list) {
        recordedFiles = list;
    }
}

- (IBAction)recording:(id)sender
{
    UIBarButtonItem *button = sender;
    if([button.title isEqualToString:@"Stop"]) {
        [button setTitle:@"Recording"];
        [self stopRecording:sender];
    } else {
        [button setTitle:@"Stop"];
        [self startRecording:sender];
    }
}

- (void)startRecording:(id)sender
{
    // Create file path.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yMMddHHmmss"];
    NSString *fileName = [NSString stringWithFormat:@"%@.wav", [formatter stringFromDate:[NSDate date]]];
    NSString *filePath = [Helper temporaryDirectoryWithFileName:fileName];
    
    // Change Audio category to Record.
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryRecord error:nil];
    
    // Settings for AVAAudioRecorder.
    NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                              [NSNumber numberWithUnsignedInt:kAudioFormatLinearPCM], AVFormatIDKey,
                              [NSNumber numberWithFloat:16000.0], AVSampleRateKey,
                              [NSNumber numberWithUnsignedInt:1], AVNumberOfChannelsKey,
                              [NSNumber numberWithUnsignedInt:16], AVLinearPCMBitDepthKey,
                              nil];
    
    recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL URLWithString:filePath] settings:settings error:nil];
    recorder.delegate = self;
    
    [recorder prepareToRecord];
    [recorder record];
}

- (void)stopRecording:(id)sender
{
    [recorder stop];
    NSString *fileName = [recorder.url.path lastPathComponent];
    NSLog(@"recording finished: %@", fileName);
    NSMutableArray *files = [recordedFiles mutableCopy];
    [files addObject:fileName];
    recordedFiles = files;
    [self.tableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SelectFile"]) {
        JLSDetailViewController *detailController = (JLSDetailViewController *)segue.destinationViewController;
        detailController.path = ((UITableViewCell *)sender).textLabel.text;
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [recordedFiles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.textLabel.text = (NSString *)[recordedFiles objectAtIndex:indexPath.row];
        
        NSString *name = [recordedFiles objectAtIndex:indexPath.row];
        NSString *path = [Helper temporaryDirectoryWithFileName:name];
        NSDictionary *attr = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [attr valueForKey:NSFileCreationDate]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"SelectFile" sender:[tableView cellForRowAtIndexPath:indexPath]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *path = [recordedFiles objectAtIndex:indexPath.row];
        [Helper removeFilePath:[Helper temporaryDirectoryWithFileName:path]];
        NSMutableArray *files = [recordedFiles mutableCopy];
        [files removeObjectAtIndex:indexPath.row];
        recordedFiles = files;
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationFade];
    }
}
@end
