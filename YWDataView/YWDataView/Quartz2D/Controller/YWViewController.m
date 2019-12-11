//
//  YWViewController.m
//  YWDataView
//
//  Created by yellow on 2019/12/11.
//  Copyright © 2019 YW. All rights reserved.
//

#import "YWViewController.h"
#import "QuartzView.h"
#import "TwoArcView.h"
#import "ArcView.h"

@interface YWViewController ()

@property (weak, nonatomic) IBOutlet QuartzView *quartzView;
@property (weak, nonatomic) IBOutlet ArcView *arcView;

@property (weak, nonatomic) IBOutlet TwoArcView *twoArcView;
@end

@implementation YWViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.quartzView start];
    
    [self.twoArcView start];
    
    [self.arcView start];

}


@end
