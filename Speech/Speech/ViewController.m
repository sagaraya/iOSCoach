//
//  ViewController.m
//  Speech
//
//  Created by Keisei SHIGETA on 2014/12/05.
//  Copyright (c) 2014年 Keisei SHIGETA. All rights reserved.
//

#import "AVFoundation/AVFoundation.h"
#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) AVSpeechSynthesizer *speechSynthesizer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    [self speechWithText:@"こんにちは。元気ですか？"];
    [self speechWithText:@"Hello! How are you?"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)speechWithText:(NSString *)text
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    utterance.rate = AVSpeechUtteranceMinimumSpeechRate;

    [_speechSynthesizer speakUtterance:utterance];
}

@end
