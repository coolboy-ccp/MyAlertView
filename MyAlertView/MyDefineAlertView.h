//
//  MyDefineAlertView.h
//  MyAlertView
//
//  Created by liqunfei on 15/8/24.
//  Copyright (c) 2015年 chuchengpeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MyWindowClick) {
    MyWindowClickForOK,
    MyWindowClickForCancel
};

typedef NS_ENUM(NSInteger, MyAlertViewStyle) {
    MyAlertViewStyleDefault,
    MyAlertViewStyleSuccess,
    MyAlertViewStyleFaile,
    MyAlertViewStyleWaring
};

typedef void (^CallBackBlock)(MyWindowClick buttonIndex);

@interface MyDefineAlertView : UIWindow

@property (nonatomic,strong)CallBackBlock clickBlock;

+ (instancetype)shared;
+ (instancetype)showAlertViewWithTitle:(NSString *)title detail:(NSString *)detail cancelButtonTitle:(NSString *)cancleTitle OKButtonTitle:(NSString *)OKTitle callBlock:(CallBackBlock)callBackBlock;
+ (instancetype)showAlertViewWithStyle:(MyAlertViewStyle)style title:(NSString *)title detail:(NSString *)detail cancleButtonTitle:(NSString *)cancle OKButtonTitle:(NSString *)OK callBlock:(CallBackBlock)callBack;
@end
