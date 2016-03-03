//
//  HYBQRCodeViewController.m
//  huiyuanbao
//
//  Created by zhouhai on 16/3/3.
//  Copyright © 2016年 huiyuanbao. All rights reserved.
//

#import "HYBQRCodeViewController.h"
#import "QRCodeReader.h"
#import "QRCodeReaderViewController.h"

@interface HYBQRCodeViewController ()<QRCodeReaderDelegate>
@end

@implementation HYBQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    self.navigationBar.title = @"二维码扫描";
    self.view.backgroundColor = [UIColor clearColor];
    
    // 设置界面
    // Create the reader object
    QRCodeReader *reader = [QRCodeReader readerWithMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // Instantiate the view controller
    QRCodeReaderViewController *vc = [QRCodeReaderViewController readerWithCancelButtonTitle:@"取消" codeReader:reader startScanningAtLoad:YES showSwitchCameraButton:YES showTorchButton:YES];
    
    // Set the presentation style
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    
    // Define the delegate receiver
    vc.delegate = self;
    
    // Or use blocks
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        NSLog(@"%@", resultAsString);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", result);
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
