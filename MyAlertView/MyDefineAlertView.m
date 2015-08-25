//
//  MyDefineAlertView.m
//  MyAlertView
//
//  Created by liqunfei on 15/8/24.
//  Copyright (c) 2015年 chuchengpeng. All rights reserved.
//

#import "MyDefineAlertView.h"

#define BUTTONBGCOLOR_OK [UIColor colorWithRed:158/255.0 green:214/255.0 blue:243/255.0 alpha:1.0]
#define BUTTONBGCOLOR_CANCLE [UIColor colorWithRed:255.0/255.0 green:20/255.0 blue:20/255.0 alpha:1.0]
#define TAG 100
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

CGFloat   const Button_Size_Width = 80;
CGFloat   const Button_Size_Height = 30;
NSInteger const title_Font = 18;
NSInteger const detail_Font = 16;
NSInteger const Logo_Rad = 40;
NSInteger const Button_Font = 16;

@interface MyDefineAlertView ()
{
    UIView       *logoView;
    UILabel      *titleLabel;
    UILabel      *detailLabel;
    UIButton     *OKButton;
    UIButton     *cancleButton;
    CAShapeLayer *pathLayer;
}

@end

@implementation MyDefineAlertView

+ (instancetype)shared
{
    static dispatch_once_t once = 0;
    static MyDefineAlertView *alert;
    dispatch_once(&once, ^{
        alert = [[MyDefineAlertView alloc] init];
    });
    return alert;
}

- (void)controlInit {
    CGFloat x = logoView.frame.origin.x;
    CGFloat y = logoView.frame.origin.y;
    CGFloat height = logoView.frame.size.height;
    CGFloat width = logoView.frame.size.width;
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(x ,y + height / 2, width, title_Font + 5)];
    [titleLabel setFont:[UIFont systemFontOfSize:title_Font]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    detailLabel  = [[UILabel alloc] initWithFrame:CGRectMake(x ,y + height / 2 + (title_Font + 10), width, detail_Font + 5)];
    detailLabel.textColor = [UIColor grayColor];
    [detailLabel setFont:[UIFont systemFontOfSize:detail_Font]];
    [detailLabel setTextAlignment:NSTextAlignmentCenter];
    
    CGFloat centerY = detailLabel.center.y + 40;
    
    OKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    OKButton.layer.cornerRadius = 5;
    OKButton.titleLabel.font = [UIFont systemFontOfSize:Button_Font];
    OKButton.center = CGPointMake(detailLabel.center.x + 50, centerY);
    OKButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
    OKButton.backgroundColor = BUTTONBGCOLOR_OK;
    
    
    cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleButton.center = CGPointMake(detailLabel.center.x - 50, centerY);
    cancleButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
    cancleButton.backgroundColor = BUTTONBGCOLOR_CANCLE;
    cancleButton.layer.cornerRadius = 5;
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:Button_Font];
    
    
    [self addSubview:titleLabel];
    [self addSubview:detailLabel];
    [self addSubview:OKButton];
    [self addSubview:cancleButton];
    
    cancleButton.hidden = YES;
    OKButton.hidden = YES;
    
    OKButton.tag = TAG;
    cancleButton.tag = TAG + 1;
    
    [OKButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick:(UIButton *)sender {
    self.clickBlock(sender.tag - TAG);
}

- (void)setInterFace {
    [self logoInit];
    [self controlInit];
}

- (void)logoInit {
    [logoView removeFromSuperview];
    logoView = nil;
    logoView = [[UIView alloc] init];
    logoView.center = CGPointMake(self.center.x, self.center.y-40);
    logoView.bounds = CGRectMake(0, 0, 320/1.5,320/1.5);
    logoView.backgroundColor = [UIColor whiteColor];
    logoView.layer.cornerRadius = 10;
    logoView.layer.shadowColor = [UIColor blackColor].CGColor;
    logoView.layer.shadowOffset = CGSizeMake(0, 5);
    logoView.layer.shadowOpacity = 0.3f;
    logoView.layer.shadowRadius = 10.f;
    if (titleLabel) {
        [self insertSubview:logoView belowSubview:titleLabel];
    }
    else {
        [self addSubview:logoView];
    }
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = (CGRect){{0.f,0.f}, [UIScreen mainScreen].bounds.size};
        self.alpha = 1.0;
        [self setBackgroundColor:[UIColor clearColor]];
        self.hidden = NO;
        self.windowLevel = 100;
        [self setInterFace];
    }
    return self;
}

- (void)addButtonTitleWithCancle:(NSString *)cancle OK:(NSString *)OK {
    BOOL flag = NO;
    if (!cancle && OK) {
        flag = YES;
    }
    CGFloat centerY = detailLabel.center.y + 40;
    if (flag) {
        OKButton.center = CGPointMake(detailLabel.center.x, centerY);
        OKButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
        cancleButton.hidden = YES;
    }
    else {
        cancleButton.hidden = NO;
        [cancleButton setTitle:cancle forState:UIControlStateNormal];
        OKButton.center = CGPointMake(detailLabel.center.x + 50, centerY);
        OKButton.bounds = CGRectMake(0, 0, Button_Size_Width, Button_Size_Height);
    }
    OKButton.hidden = NO;
    [OKButton setTitle:OK forState:UIControlStateNormal];
}

+ (instancetype)showAlertViewWithStyle:(MyAlertViewStyle)style title:(NSString *)title detail:(NSString *)detail cancleButtonTitle:(NSString *)cancle OKButtonTitle:(NSString *)OK callBlock:(CallBackBlock)callBack {
    switch (style) {
        case MyAlertViewStyleDefault:
            [[self shared] drawRight];
            break;
        case MyAlertViewStyleSuccess:
            [[self shared] drawRight];
            break;
        case MyAlertViewStyleFaile:
            [[self shared] drawWrong];
            break;
        case MyAlertViewStyleWaring:
            [[self shared] drawWaring];
            break;
            
        default:
            break;
    }
    [[self shared] addButtonTitleWithCancle:cancle OK:OK];
    [[self shared] addTitle:title detaile:detail];
    [[self shared] setClickBlock:nil];
    [[self shared] setClickBlock:callBack];
    [[self shared] setHidden:NO];
    return  [self shared];
}

+ (instancetype)showAlertViewWithTitle:(NSString *)title detail:(NSString *)detail cancelButtonTitle:(NSString *)cancleTitle OKButtonTitle:(NSString *)OKTitle callBlock:(CallBackBlock)callBackBlock
{
    return [self showAlertViewWithStyle:MyAlertViewStyleSuccess title:title detail:detail cancleButtonTitle:cancleTitle OKButtonTitle:OKTitle callBlock:callBackBlock];
}

- (void)addTitle:(NSString *)title detaile:(NSString *)detail {
    titleLabel.text = title;
    detailLabel.text = detail;
}

#pragma mark 画警告线
- (void)drawWaring {
    [self logoInit];
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    CGFloat x = logoView.frame.size.width/2;
    CGFloat y = 15;
    [path moveToPoint:CGPointMake(x, y)];
    
    CGPoint p1 = CGPointMake(x - 45, y + 80);
    [path addLineToPoint:p1];
    CGPoint p2 = CGPointMake(x + 45, y + 80);
    [path addLineToPoint:p2];
    [path closePath];
    
    [path moveToPoint:CGPointMake(x, y + 20)];
    CGPoint p3 = CGPointMake(x, y + 60);
    [path addLineToPoint:p3];
    
    [path moveToPoint:CGPointMake(x, y + 70)];
    [path addArcWithCenter:CGPointMake(x, y + 70) radius:2 startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor orangeColor].CGColor;
    layer.lineWidth = 5;
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [logoView.layer addSublayer:layer];
}

#pragma mark 画错误线
- (void)drawWrong {
    [self logoInit];
    CGFloat x = logoView.frame.size.width / 2 - Logo_Rad;
    CGFloat y = 15;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(x, y, Logo_Rad * 2, Logo_Rad * 2) cornerRadius:5];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    CGFloat space = 20;
    
    [path moveToPoint:CGPointMake(x + space, y + space)];
    CGPoint p1 = CGPointMake(x + Logo_Rad*2 - space, y + Logo_Rad * 2 - space);
    [path addLineToPoint:p1];
    [path moveToPoint:CGPointMake(x + Logo_Rad * 2 - space, y + space)];
    CGPoint p2 = CGPointMake(x + space, y + Logo_Rad * 2 - space);
    [path addLineToPoint:p2];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    layer.lineWidth = 5;
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [logoView.layer addSublayer:layer];
}
#pragma mark 画正确线
- (void)drawRight {
    [self logoInit];
    CGPoint pathCenter = CGPointMake(logoView.bounds.size.width / 2, logoView.bounds.size.height / 2 -50);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:pathCenter radius:Logo_Rad startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    CGFloat x = logoView.bounds.size.width/2.5 + 5;
    CGFloat y = logoView.bounds.size.height/3.0 - 10.5;
    [path moveToPoint:CGPointMake(x, y)];
    
    CGPoint p1 = CGPointMake(x + 10, y + 10);
    [path addLineToPoint:p1];
    CGPoint p2 = CGPointMake(x + 35, y - 20);
    [path addLineToPoint:p2];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor greenColor].CGColor;
    layer.lineWidth = 5;
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    [logoView.layer addSublayer:layer];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
 
}


@end
