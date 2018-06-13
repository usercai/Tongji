//
//  HomeViewController.m
//  VolleyballVoice_iPhone
//
//  Created by mac on 2017/7/4.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "HomeViewController.h"
#import "ScoreView.h"
@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *scoreView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ScoreView * view = [[ScoreView alloc] initWithFrame:CGRectMake(0, 0, self.scoreView.width, self.scoreView.height)];
    NSLog(@"%f",self.scoreView.height);
    [self.scoreView addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
