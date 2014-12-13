//
//  ViewController.m
//  TextInput
//
//  Created by Keisei SHIGETA on 2014/12/04.
//  Copyright (c) 2014年 Keisei SHIGETA. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 参考：Objective-C - キーボードを閉じる動作の実装 - Qiita http://qiita.com/FGtatsuro/items/2c328fdb4963d6fa7949

- (IBAction)didEndOnExit:(id)sender {
    //senderはtextField
    _textLabel.text = _textField.text;
}

- (IBAction)tapOutsideTextField:(id)sender {
    //senderはgestureRecognizer
    [self.view endEditing:YES];
    _textLabel.text = _textField.text;
}

@end
