//
//  QJTimeCountDownView.m
//  LH_QJ
//
//  Created by 郭军 on 2018/5/10.
//  Copyright © 2018年 LHYD. All rights reserved.
//

#import "QJTimeCountDownView.h"

// label数量
#define lblCount 3
#define separateLblCount 2
#define separateLabelCount 2


@interface TimeCountDownLabel : UILabel


@end


@implementation TimeCountDownLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.textAlignment = NSTextAlignmentCenter;
        self.font = JGBoldFont(12);

        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithHexCode:@"#535353"];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 2.5f;
    }
    return self;
}

@end




@interface QJTimeCountDownView ()

@property (nonatomic, weak) NSTimer* timer;  // 定时器

@property (nonatomic,strong)NSMutableArray *timeLabelArrM;
@property (nonatomic,strong)NSMutableArray *separateLabelArrM;

// hour
@property (nonatomic,strong)TimeCountDownLabel *hourLabel;
// minues
@property (nonatomic,strong)TimeCountDownLabel *minuesLabel;
// seconds
@property (nonatomic,strong)TimeCountDownLabel *secondsLabel;
@end


@implementation QJTimeCountDownView

// 创建单例
+ (instancetype)shareCountDown{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[QJTimeCountDownView alloc] init];
    });
    return instance;
}

+ (instancetype)countDown{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.hourLabel];
        [self addSubview:self.minuesLabel];
        [self addSubview:self.secondsLabel];
        
        for (NSInteger index = 0; index < separateLabelCount; index ++) {
            UILabel *separateLabel = [[UILabel alloc] init];
            separateLabel.text = @":";
            separateLabel.textAlignment = NSTextAlignmentCenter;
            separateLabel.textColor = [UIColor colorWithHexCode:@"#535353"];
            separateLabel.font = JGFont(10);
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
- (void)setTimestamp:(NSInteger)timestamp{
    _timestamp = timestamp;
    
    if (_timestamp != 0) {
        
        if (self.timer.isValid) {
            return;
        } else {
            self.timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        }
    }
    
    
    
}

-(void)timer:(NSTimer*)timerr{
    _timestamp--;
    
    if (!self.timer) {
        _timestamp = 0;
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

- (void)getDetailTimeWithTimestamp:(NSInteger)timestamp{
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
    //    JGLog(@"%zd日:%zd时:%zd分:%zd秒",day,hour,minute,second);
    
    self.hourLabel.text = [NSString stringWithFormat:@"%zd",day*24 + hour];
    self.minuesLabel.text = [NSString stringWithFormat:@"%zd",minute];
    self.secondsLabel.text = [NSString stringWithFormat:@"%zd",second];
}





- (void)layoutSubviews{
    [super layoutSubviews];
    // 获得view的宽、高
    CGFloat viewH = self.frame.size.height;
    // 单个label的宽高
    CGFloat labelW = _TimeLblWidth != 0 ? _TimeLblWidth : 15;
    CGFloat separatW = _PaddingWidth != 0 ? _PaddingWidth : 10;

    CGFloat labelH = viewH;
    self.hourLabel.frame = CGRectMake(0, 0, labelW, labelH);
    self.minuesLabel.frame = CGRectMake( labelW + separatW, 0, labelW, labelH);
    self.secondsLabel.frame = CGRectMake(2 * (labelW + separatW), 0, labelW, labelH);
    
    for (NSInteger index = 0; index < self.separateLabelArrM.count ; index ++) {
        UILabel *separateLabel = self.separateLabelArrM[index];
        separateLabel.frame = CGRectMake((labelW + separatW)  * (index + 1) - separatW, 0, separatW, labelH);
    }
}

#pragma mark - setter & getter

- (void)setPaddingWidth:(NSInteger)PaddingWidth {
    _PaddingWidth = PaddingWidth;
}

- (void)setTimeLblWidth:(NSInteger)TimeLblWidth {
    _TimeLblWidth = TimeLblWidth;
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


- (UILabel *)hourLabel{
    if (_hourLabel == nil) {
        _hourLabel = [[TimeCountDownLabel alloc] init];
    }
    return _hourLabel;
}

- (UILabel *)minuesLabel{
    if (_minuesLabel == nil) {
        _minuesLabel = [[TimeCountDownLabel alloc] init];
    }
    return _minuesLabel;
}

- (UILabel *)secondsLabel{
    if (_secondsLabel == nil) {
        _secondsLabel = [[TimeCountDownLabel alloc] init];
    }
    return _secondsLabel;
}

-(void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
    
    JGLogFunc
}

@end
