//
//  HelpViewController.m
//  HelpView
//
//  Created by pipixia on 13-7-24.
//  Copyright (c) 2013年 pipixia. All rights reserved.
//

#import "HelpViewController.h"
#import <QuartzCore/QuartzCore.h>
#define ISIPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface HelpViewController ()
{
    NSArray *img_array;
    NSInteger now_img;
    UIButton *btn;
    
}

@property (retain, nonatomic) UIImageView *background_img;
@property (retain, nonatomic) UIImageView *front_img;


@end

@implementation HelpViewController
@synthesize background_img;
@synthesize front_img;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (ISIPHONE5)
        {
            img_array = [[NSArray alloc]initWithObjects:@"b101.png",@"b102.png",@"b103.png",nil];
        }else
        {
            img_array = [[NSArray alloc]initWithObjects:@"b101.png",@"b102.png",@"b103.png",nil];
        }
        
        now_img = 0;
        self.view.frame = CGRectMake(0, 0, 320, ScreenHeight);

    }
    return self;
}
#pragma mark - SelfMethod
- (void)swipeLeft
{
    NSLog(@"left");
    if (now_img<2) {
        now_img++;
        
        [self leftHide];
        if (now_img == 2) {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];

            [btn setBackgroundImage:[UIImage imageNamed:@"dot1.png"] forState:UIControlStateNormal];
            if (ISIPHONE5)
            {
                btn.frame = CGRectMake(73, ScreenHeight - 110, 175, 31);
            }else{
                btn.frame = CGRectMake(73, 405, 175, 31);
            }
            [btn addTarget:self action:@selector(btnGo) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:btn];
        }
    }
}
-(void)btnGo
{
    if (self.delegate && self.onStartClick) {
        [self.delegate performSelector:self.onStartClick];
    }
    [self.view removeFromSuperview];
}
-(void)swipeRight
{
    NSLog(@"right");
    if (now_img>0) {
        now_img--;
        [self rightHide];
        btn.alpha = 0;
//        [btn removeFromSuperview];
    }
    
    NSLog(@"%d",now_img);
}
- (void)leftHide
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    front_img.frame = CGRectMake(-320, front_img.frame.origin.y, front_img.frame.size.width, front_img.frame.size.height);
    front_img.alpha = 0;
    [UIView commitAnimations];
    background_img.image = [UIImage imageNamed:[img_array objectAtIndex:now_img]];
    [self performSelector:@selector(showImage) withObject:nil afterDelay:0.4];
}
- (void)rightHide
{
//    btn.alpha = 0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.4];
    front_img.frame = CGRectMake(320, front_img.frame.origin.y, front_img.frame.size.width, front_img.frame.size.height);
    front_img.alpha = 0;
    [UIView commitAnimations];
    background_img.image = [UIImage imageNamed:[img_array objectAtIndex:now_img]];
    [self performSelector:@selector(showImage) withObject:nil afterDelay:0.4];
}
- (void)showImage
{
    front_img.frame = CGRectMake(0, 0, front_img.frame.size.width,front_img.frame.size.height);
    front_img.alpha = 1;
    front_img.image = [UIImage imageNamed:[img_array objectAtIndex:now_img]];
    //    [self showButtonImage];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor brownColor];
    
    background_img = [[UIImageView alloc]init];
    background_img.frame = CGRectMake(0, 0, 320, ScreenHeight);
    [self.view addSubview:background_img];
    
    front_img = [[UIImageView alloc]init];
    front_img.frame = CGRectMake(0, 0, 320, ScreenHeight);
    [self.view addSubview:front_img];
    
    if (ISIPHONE5)
    {
        background_img.image = [UIImage imageNamed:@"b101.png"];
        front_img.image = [UIImage imageNamed:@"b101.png"];
    }else
    {
        background_img.image = [UIImage imageNamed:@"b1.png"];
        front_img.image = [UIImage imageNamed:@"b1.png"];
    }
    // Do any additional setup after loading the view from its nib.
    UISwipeGestureRecognizer *leftGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
    leftGR.direction = UISwipeGestureRecognizerDirectionLeft;
    front_img.userInteractionEnabled = YES;
    [front_img addGestureRecognizer:leftGR];
    UISwipeGestureRecognizer *rightGR = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight)];
    rightGR.direction = UISwipeGestureRecognizerDirectionRight;
    [front_img addGestureRecognizer:rightGR];
}

- (void)viewDidUnload
{
    [self setBackground_img:nil];
    [self setFront_img:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
