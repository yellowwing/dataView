//
//  QuartzView.m
//  通信录
//
//  Created by yellow on 16/7/1.
//  Copyright © 2016年 yellow. All rights reserved.
//

#import "QuartzView.h"

#define rectRedHeight 150

@interface QuartzView ()

@property(nonatomic,assign)NSInteger profit;

@property(nonatomic,assign)CGFloat rectGreenHight;

@property(nonatomic,assign,getter = isAscengding)BOOL ascending;


@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation QuartzView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.profit = 5;
        
        self.rectGreenHight = 3;
        
        self.ascending = YES;
        
    }
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];

}


-(void)drawRect:(CGRect)rect{
    CGFloat padding = 10;
    CGFloat rectWidth = 80;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    CGContextSetLineWidth(ctx, rectWidth);
    
    //柱体
    CGContextSetRGBStrokeColor(ctx, 0, 0.8, 0, 1);
    CGContextMoveToPoint(ctx, 100, rectRedHeight);
    CGContextAddLineToPoint(ctx, 100, rectRedHeight - self.rectGreenHight);
    
    CGContextStrokePath(ctx);

    //画文字
    NSString *str = [NSString stringWithFormat:@"你获得%ld％效益",(long)self.profit];
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor redColor];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12];
    [str drawInRect:CGRectMake(160, 100, 100, 60) withAttributes:attrs];
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
        self.rectGreenHight += 4;
        
        self.profit += 4;
        if (self.profit >= 153) {
            self.profit = 153;
        }
        
    }else{
        self.rectGreenHight -= 4;
        
        self.profit -= 4;
        
        if (self.profit <= 5) {
            self.profit = 5;
        }
    }
    
    if (self.rectGreenHight > rectRedHeight || self.rectGreenHight < 0) {
        
        [self stopDisplay];
        
        self.ascending = !self.isAscengding;
    }
    
    [self setNeedsDisplay];
}

@end
