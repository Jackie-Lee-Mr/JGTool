//
//  QJCountDownView.m
//  LH_QJ
//
//  Created by 郭军 on 2018/5/9.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJCountDownView.h"
// label数量
#define labelCount 4
#define separateLabelCount 2


@interface CountDownLabel : UILabel


@end


@implementation CountDownLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.textAlignment = NSTextAlignmentCenter;
        self.font = JGFont(11);
        self.textColor = JG999Color;
        
    }
    return self;
}



@end






@interface QJCountDownView ()

@property (nonatomic, weak) NSTimer* timer;  // 定时器


@property (nonatomic,strong)NSMutableArray *timeLabelArrM;
@property (nonatomic,strong)NSMutableArray *separateLabelArrM;
// 描述
@property (nonatomic,strong)CountDownLabel *descLabel;
// hour
@property (nonatomic,strong)CountDownLabel *hourLabel;
// minues
@property (nonatomic,strong)CountDownLabel *minuesLabel;
// seconds
@property (nonatomic,strong)CountDownLabel *secondsLabel;
@end




@implementation QJCountDownView

// 创建单例
+ (instancetype)shareCountDown{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QJCountDownView alloc] init];
    });
    return instance;
}

+ (instancetype)countDown{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.descLabel];
        [self addSubview:self.hourLabel];
        [self addSubview:self.minuesLabel];
        [self addSubview:self.secondsLabel];
        
        for (NSInteger index = 0; index < separateLabelCount; index ++) {
            CountDownLabel *separateLabel = [[CountDownLabel alloc] init];
            separateLabel.text = @":";
            separateLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:separateLabel];
            [self.separateLabelArrM addObject:separateLabel];
        }
    }
    return self;
}

- (void)setBackgroundImageName:(NSString *)backgroundImageName{
    _backgroundImageName = backgroundImageName;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:backgroundImageName]];
    imageView.frame = self.bounds;
    [self addSubview:imageView];
    //    [self bringSubviewToFront:imageView];
}

// 拿到外界传来的时间戳
- (void)setTimestamp:(double)timestamp{
    _timestamp = timestamp;
    
    if (timestamp <= 0) {
        [self getDetailTimeWithTimestamp:0];
    }else  {
        
        if (self.timer.isValid) {
            return;
        } else {
            self.timer =[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
    }
}

-(void)timer:(NSTimer*)timerr{
    _timestamp = _timestamp - 0.1;
    
    
    if (!self.timer) {
        _timestamp = 0;
        JGLog(@"%@",self.timer);

    }
    
    
    if (self.timer) {
        [self getDetailTimeWithTimestamp:_timestamp];
    }
    
    
    if (_timestamp <= 0) {
        
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
            // 执行block回调
            self.timerStopBlock();
        }
    }
}

- (void)getDetailTimeWithTimestamp:(double)timestamp{
    NSInteger ms = timestamp;
    NSInteger ss = 1;
    NSInteger mi = ss * 60;
    NSInteger hh = mi * 60;
    NSInteger dd = hh * 24;
    
    
    // 剩余的
    NSInteger day = ms / dd;// 天
    NSInteger hour = (ms - day * dd) / hh;// 时
    NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
    NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
    int mmm = [[NSString stringWithFormat:@"%f",timestamp * 10] intValue];
    NSInteger hm = mmm % 10;// 毫秒
    
    //    JGLog(@"%zd日:%zd时:%zd分:%zd秒",day,hour,minute,second);
    
    self.hourLabel.text = [NSString stringWithFormat:@"%zd",day * 24 + hour];
    self.minuesLabel.text = [NSString stringWithFormat:@"%zd",minute];
    self.secondsLabel.text = [NSString stringWithFormat:@"%zd.%zd",second ,hm];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 获得view的宽、高
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    // 单个label的宽高
    CGFloat labelW = viewW / labelCount;
    CGFloat labelH = viewH;
    self.descLabel.frame = CGRectMake(0, 0, labelW, labelH);
    self.hourLabel.frame = CGRectMake(labelW, 0, labelW, labelH);
    self.minuesLabel.frame = CGRectMake(2 * labelW , 0, labelW, labelH);
    self.secondsLabel.frame = CGRectMake(3 * labelW, 0, labelW, labelH);
    
    for (NSInteger index = 0; index < self.separateLabelArrM.count ; index ++) {
        CountDownLabel *separateLabel = self.separateLabelArrM[index];
        separateLabel.frame = CGRectMake((labelW - 1) * (index + 2), 0, 5, labelH);
    }
}


/**
 *  关闭定时器
 */
- (void)CloseTimer {
    
    [self.timer invalidate];
    self.timer = nil;
}



#pragma mark - setter & getter

- (void)setTitleFont:(UIFont *)TitleFont {
    _TitleFont = TitleFont;
    
    for (NSInteger index = 0; index < self.separateLabelArrM.count ; index ++) {
        CountDownLabel *separateLabel = self.separateLabelArrM[index];
        separateLabel.font = TitleFont;
    }
    
    self.descLabel.font = TitleFont;
    self.hourLabel.font = TitleFont;
    self.minuesLabel.font = TitleFont;
    self.secondsLabel.font = TitleFont;
}

- (void)setTitleColor:(UIColor *)TitleColor {
    _TitleColor = TitleColor;
    
    for (NSInteger index = 0; index < self.separateLabelArrM.count ; index ++) {
        CountDownLabel *separateLabel = self.separateLabelArrM[index];
        separateLabel.textColor = TitleColor;
    }
    
    self.descLabel.textColor = TitleColor;
    self.hourLabel.textColor = TitleColor;
    self.minuesLabel.textColor = TitleColor;
    self.secondsLabel.textColor = TitleColor;
}




- (NSMutableArray *)timeLabelArrM{
    if (_timeLabelArrM == nil) {
        _timeLabelArrM = [[NSMutableArray alloc] init];
    }
    return _timeLabelArrM;
}

- (NSMutableArray *)separateLabelArrM{
    if (_separateLabelArrM == nil) {
        _separateLabelArrM = [[NSMutableArray alloc] init];
    }
    return _separateLabelArrM;
}

- (CountDownLabel *)descLabel {
    if (_descLabel == nil) {
        _descLabel = [[CountDownLabel alloc] init];
        _descLabel.textAlignment = NSTextAlignmentRight;
        _descLabel.text = @"剩余";
    }
    return _descLabel;
}


- (CountDownLabel *)hourLabel{
    if (_hourLabel == nil) {
        _hourLabel = [[CountDownLabel alloc] init];
    }
    return _hourLabel;
}

- (CountDownLabel *)minuesLabel{
    if (_minuesLabel == nil) {
        _minuesLabel = [[CountDownLabel alloc] init];
    }
    return _minuesLabel;
}

- (CountDownLabel *)secondsLabel{
    if (_secondsLabel == nil) {
        _secondsLabel = [[CountDownLabel alloc] init];
    }
    return _secondsLabel;
}

-(void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
    
    JGLogFunc
}


@end
