//
//  ScoreView.m
//  VolleyballVoice
//
//  Created by mac on 2017/6/2.
//  Copyright © 2017年 thc. All rights reserved.
//

#import "ScoreView.h"
#import "ScoreButton.h"
#import "SCoreLeftView.h"
#import "FaultView.h"
#import "VolleyBallPlayers+CoreDataClass.h"


//按钮数量
static NSInteger num = 6;
@interface ScoreView()

//移动的假image
@property (nonatomic,strong)UIImageView * normolImage;
@property (nonatomic,strong)NSArray *evaluateVeiws;

@property (nonatomic,strong)NSArray *evaluateVeiws2;
@property (nonatomic,strong)UIPanGestureRecognizer *pan;

@property (nonatomic,strong)FaultView * faultView;//失误的view
@property (nonatomic,strong)ScoreButton *serveButton;//发球
@property (nonatomic,strong)ScoreButton *blockButton;//拦网
@property (nonatomic,strong)ScoreButton *spikeButton;//扣球
/**传球*/
@property (nonatomic,strong)ScoreButton *passButton;
/** 防守 */
@property (nonatomic,strong)ScoreButton *defendButton;
/** 接发球 */
@property (nonatomic,strong)ScoreButton *receiveButton;

@property (nonatomic,strong)SCoreLeftView *leftView;

@property (nonatomic,strong)NSMutableArray *titleArray;


//是否在六个按钮中
@property (nonatomic,assign)BOOL isSix;


@end

@implementation ScoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame]; 
    if (self) {
        
        [self initView];
    }
    return self;
}

-(void)initView{

    self.faultView = [[FaultView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    [self addSubview:self.faultView];
    
    self.leftView = [[SCoreLeftView alloc] initWithFrame:CGRectMake(self.width/2, 0, self.width/2 - 20, self.width)];
    self.leftView.center = CGPointMake(self.leftView.centerX , self.height/2);
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(SmallpanClick:)];
    [self.leftView.smallview addGestureRecognizer:pan];
    [self.faultView addSubview:self.leftView];
    
    
    
    self.serveButton = [self setframeforButton:0];
    self.blockButton = [self setframeforButton:1];
    self.spikeButton = [self setframeforButton:2];
    self.passButton = [self setframeforButton:3];
    self.defendButton = [self setframeforButton:4];
    self.receiveButton = [self setframeforButton:5];
    

    self.evaluateVeiws = @[];
    self.evaluateVeiws2 = @[self.serveButton,
                                self.blockButton,
                                self.spikeButton,
                                self.passButton,
                                self.defendButton,
                                self.receiveButton];
}

-(ScoreButton*)setframeforButton:(NSInteger)i{
    CGFloat width = 35;

    CGFloat radius = self.height/2 - self.height/9;
    CGFloat r = M_PI / (num - 1) * i;
    CGFloat r1 = r > M_PI/2 ? M_PI - r : r;
    CGFloat x = radius - sin(r1) * radius + (self.width - radius - width);
    CGFloat y = radius - cos(r1) * radius + (self.height/2 - radius - width/2);
    if (r > M_PI/2) {
        y = radius + cos(r1) * radius + (self.height/2 - radius - width/2);
    }
    
    
    CGRect frame = CGRectMake(x, y, width, width);
    ScoreButton * button = [[ScoreButton alloc] initWithFrame:frame title:self.titleArray[i]];
    button.tag = i;
    [button setSelected:NO];
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panClick:)];
    [button addGestureRecognizer:pan];
    [self addSubview:button];
    return button;
}



-(void)panClick:(UIGestureRecognizer*)sender{

    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    static CGRect startframe;
    UIButton * btn = (UIButton *)sender.view;
    
    if ([recongizer state] == UIGestureRecognizerStateBegan)
    {
        [btn setSelected:YES];

        [self bringSubviewToFront:sender.view];
        startframe = sender.view.frame;
//        [[self completionLabel] setText:nil];
    }
    if ([recongizer state] == UIGestureRecognizerStateChanged) {
        CGPoint point = [sender locationInView:self];

        if ([self RadiusWithButton:btn point:point]) {
            
            self.leftView.isContectPoint = YES;
        }else{
        
            self.leftView.isContectPoint = NO;
        }
        
        //失误
        if (![self.faultView.PATH containsPoint:point]) {
            self.faultView.isSelect = YES;
        }else{
        
            self.faultView.isSelect = NO;
        }

    }
    if ([recongizer state] == UIGestureRecognizerStateEnded){
    
        sender.view.frame = startframe;
        self.faultView.backgroundColor = VB_BACK;
        self.leftView.isContectPoint = NO;
        
        [btn setSelected:NO];
        CGPoint point = [sender locationInView:self];
        
        
        
        if ([self RadiusWithButton:btn point:point]) {
            
            //得分
            [(ScoreButton*)btn sendMessage];
            
        }
        
        //失误
        if (![self.faultView.PATH containsPoint:point]) {
            self.faultView.isSelect = NO;

            //失误
            [(ScoreButton*)btn shiwu];

        }
        
        
        
    }
    
    NSArray *views = self.evaluateVeiws;

//    __block UILabel *label = [self completionLabel];
    
    // Block to execute when our dragged view is contained by one of our evaluation views.
    static void (^overlappingBlock)(UIView *overlappingView);
    overlappingBlock = ^(UIView *overlappingView) {

    };
    
    // Block to execute when gesture ends.
    static void (^completionBlock)(UIView *overlappingView);
    completionBlock = ^(UIView *overlappingView) {
        

    };
    

    [recongizer dragViewWithinView:self
           evaluateViewsForOverlap:views
   containedByOverlappingViewBlock:overlappingBlock
                        completion:completionBlock];

}

-(void)SmallpanClick:(UIGestureRecognizer*)sender{
    UIPanGestureRecognizer *recongizer = (UIPanGestureRecognizer *)sender;
    static CGRect startframe;
    CGPoint point = [sender locationInView:self];

    if ([recongizer state] == UIGestureRecognizerStateBegan)
    {
        [self bringSubviewToFront:self];
        startframe = sender.view.frame;
        [self.leftView clickAnimation:point];

    }

    if ([recongizer state] == UIGestureRecognizerStateEnded){
        
        sender.view.backgroundColor = [UIColor clearColor];
        [self.leftView removeLayer];
        sender.view.hidden = NO;

    }
    
    NSArray *views = self.evaluateVeiws2;
    
    // Block to execute when our dragged view is contained by one of our evaluation views.
    static void (^overlappingBlock)(UIView *overlappingView);
    overlappingBlock = ^(UIView *overlappingView) {
        
        [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            ScoreButton *aView = (ScoreButton *)obj;
            
            // Style an overlapping view
            
            if (aView == overlappingView)
            {

                [aView setSelected:YES];
            }
             else
            {
                [aView setSelected:NO];
            }
            
        }];
    };
    
    // Block to execute when gesture ends.
    static void (^completionBlock)(UIView *overlappingView);
    completionBlock = ^(UIView *overlappingView) {
        
        if (overlappingView) {
            
            [(ScoreButton*)overlappingView sendMessage];
        }
        sender.view.frame = startframe;

        // Remove styling from all views
        [views enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ScoreButton *aView = (ScoreButton *)obj;
            [aView setSelected:NO];
        }];
    };
    
    
    [sender dragViewWithinView:self
           evaluateViewsForOverlap:views
   containedByOverlappingViewBlock:overlappingBlock
                        completion:completionBlock];
}


-(BOOL)RadiusWithButton:(UIButton*)Btn point:(CGPoint)point{


    
    CGRect leftV = [self.leftView convertRect:self.leftView.bounds toView:self];
    CGFloat x;
    x = leftV.origin.x + self.leftView.radius + self.leftView.radius*sin(M_PI*0.1);
    CGPoint leftcenter = CGPointMake(x, leftV.origin.y + self.leftView.height/2);
    
    CGRect btnV = [Btn convertRect:Btn.bounds toView:self];


    CGPoint btnCenter = CGPointMake(btnV.origin.x + btnV.size.width/2, btnV.origin.y + btnV.size.height/2);

    
//    NSLog(@"%@           %@",leftcenter,btnCenter);
    
//    CGFloat width = sqrt(pow((leftcenter.x - btnCenter.x), 2) + pow((leftcenter.y - btnCenter.y), 2));
    CGFloat width = self.leftView.radius + btnV.size.width/2;

    CGFloat w = sqrt(pow((leftcenter.x - point.x), 2) + pow((leftcenter.y - point.y), 2));

    
    if (fabs(width) > fabs(w)) {

        
        return YES;
    }else{
        
//        NSLog(@"%f         %f           %f",fabs(w - width),fabs(width),fabs(w));
//        NSLog(@"%f,%f      %f,%f      %f,%f",btnCenter.x,btnCenter.y,leftcenter.x,leftcenter.y,point.x,point.y);
        return NO;
    }
}

-(NSMutableArray *)titleArray{

    if (!_titleArray) {
        _titleArray = [[NSMutableArray alloc] initWithObjects:@"发球",@"拦网",@"扣球",@"传球",@"防守",@"接发球", nil];
    }
    return _titleArray;
}

-(UIImageView*)normolImage{

    if (!_normolImage) {
        _normolImage = [[UIImageView alloc] init];
        _normolImage.backgroundColor = [UIColor blueColor];
        _normolImage.userInteractionEnabled = YES;

//        _normolImage.hidden = YES;
        [self addSubview:_normolImage];
        
    }
    return _normolImage;
}
-(UIPanGestureRecognizer *)pan{

    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panClick:)];
    }
    return _pan;
}


@end
