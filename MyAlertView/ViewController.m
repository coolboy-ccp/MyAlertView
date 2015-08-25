//
//  ViewController.m
//  MyAlertView
//
//  Created by liqunfei on 15/8/24.
//  Copyright (c) 2015年 chuchengpeng. All rights reserved.
//

#import "ViewController.h"
#import "MyDefineAlertView.h"
@interface ViewController ()
{
    UIWindow *myWindow;
}
@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)showAlert:(UIButton *)sender {
    NSString *title = nil;
    NSString *detail = nil;
    NSString *cancle = @"cancle";
    NSString *OK = @"OK";
    switch (sender.tag - 1000) {
        case MyAlertViewStyleSuccess:
        case MyAlertViewStyleDefault:
            title = @"温馨提示";
            detail = @"登陆成功";
            cancle = nil;
            break;
        case MyAlertViewStyleFaile:
            title = @"错误提示";
            detail = @"您输入的信息有误";
            break;
        case MyAlertViewStyleWaring:
            title = @"警告！";
            detail = @"操作异常";
            break;
        default:
            break;
    }
    myWindow = [MyDefineAlertView showAlertViewWithStyle:sender.tag - 1000 title:title detail:detail cancleButtonTitle:cancle OKButtonTitle:OK callBlock:^(MyWindowClick buttonIndex) {
        if (buttonIndex) {
            NSLog(@"ok");
        }
        else {
            NSLog(@"cancle");
        }
        myWindow.hidden = YES;
        myWindow = nil;
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
