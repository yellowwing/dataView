//
//  TwoArcView.m
//  通信录
//
//  Created by yellow on 16/7/1.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "TwoArcView.h"
#import "YWTool.h"
@interface TwoArcView ()

@property(nonatomic,assign)NSInteger profit;

@property(nonatomic,assign)CGFloat increaseAngle;

@property(nonatomic,assign,getter = isAscengding)BOOL ascending;


@property (nonatomic, strong) CADisplayLink *link;
@end


@implementation TwoArcView
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.profit = 1;
        
        self.increaseAngle = Angle2Radian(1);
        
        self.ascending = YES;
        
    }
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
}

-(void)drawRect:(CGRect)rect{
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 25);
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //半径是55
    CGContextAddEllipseInRect(ctx, CGRectMake(20, 20, 110, 110));

//    CGContextSetRGBStrokeColor(ctx, 0, 0, 1, 1);
    [YWColor(240, 240, 0) set];

    CGContextStrokePath(ctx);
    

    //第二个覆盖圆
    CGContextAddArc(ctx, 75, 75, 55, -M_PI_2, -M_PI_2 + self.increaseAngle, 0);
    
    //    CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
    [YWColor(250, 50, 255) set];
    
    CGContextStrokePath(ctx);
    
     //画文字
    NSString *str = [NSString stringWithFormat:@"你的利润是%d％",self.profit];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12];
    [str drawInRect:CGRectMake(40, 170, 100, 60) withAttributes:attrs];

    
}
-(void)start{
    
    //开启定时器
    [self startDisplay];
    
    
}


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
        if (self.profit >= 230) {
            self.profit = 230;
        }
        
    }else{
        self.increaseAngle -= Angle2Radian(4);
        
        self.profit -= 4;
        
        if (self.profit <= 1) {
            self.profit = 1;
        }
    }
    
    if (self.increaseAngle > Angle2Radian(230) || self.increaseAngle < Angle2Radian(1)) {
        
        [self stopDisplay];
        
        self.ascending = !self.isAscengding;
    }
    
    [self setNeedsDisplay];
}

@end
