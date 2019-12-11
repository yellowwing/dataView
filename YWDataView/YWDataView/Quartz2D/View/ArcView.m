//
//  ArcView.m
//  通信录
//
//  Created by yellow on 16/7/1.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "ArcView.h"
#import "YWTool.h"

@interface ArcView ()

@property(nonatomic,assign)NSInteger profit;

@property(nonatomic,assign)CGFloat increaseAngle;

@property(nonatomic,assign,getter = isAscengding)BOOL ascending;

@property (nonatomic, strong) CADisplayLink *link;

@end


@implementation ArcView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.profit = 3;
        
        self.increaseAngle = Angle2Radian(10);
        
        self.ascending = YES;
        
    }
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
}


-(void)drawRect:(CGRect)rect{

    // 1.获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.画1/4圆
    CGContextMoveToPoint(ctx, 75, 75);
    CGContextAddLineToPoint(ctx, 75, 20);
    CGContextAddArc(ctx, 75, 75, 60, -M_PI_2,  -M_PI_2 + self.increaseAngle, 0);
    CGContextClosePath(ctx);
    
    [YWColor(0, 200, 200) set];
    
    // 3.显示所绘制的东西
    CGContextFillPath(ctx);
    
    //画文字
    NSString *str = [NSString stringWithFormat:@"开盘最高%ld％",self.profit];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12];
    [str drawInRect:CGRectMake(40, 170, 100, 60) withAttributes:attrs];


}
-(void)start{
    
    //开启定时器
    [self startDisplay];
    
    
}

/**
 *  开始不停得旋转
 */
- (void)startDisplay
{
    if (self.link) return;
    
    // 1秒内刷新60次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

- (void)stopDisplay
{
    [self.link invalidate];
    self.link = nil;
}

- (void)update
{
    if (self.isAscengding) {
        self.increaseAngle += Angle2Radian(4);
        
        self.profit += 4;
        if (self.profit >= 305) {
            self.profit = 305;
        }
        
    }else{
        self.increaseAngle -= Angle2Radian(4);
        
        self.profit -= 4;
        
        if (self.profit <= 3) {
            self.profit = 3;
        }
    }
    
    if (self.increaseAngle > Angle2Radian(300) || self.increaseAngle < Angle2Radian(10)) {
        
        [self stopDisplay];
        
        self.ascending = !self.isAscengding;
    }
    
    [self setNeedsDisplay];
}

@end
