//
//  WriteReviewsViewController.m
//  QQList
//
//  Created by sunsu on 15/6/25.
//  Copyright (c) 2015年 CarolWang. All rights reserved.
//

#import "WriteReviewsViewController.h"

@interface WriteReviewsViewController ()
{
    CGRect _frame;
    UIImageView *_fullImageView;//当前看得图片
    int deleteCount;//缩小前的删除数
    BOOL isdele;//判断是否删除
    NSInteger buttonTag;//所删除的button的tag
}


@property(nonatomic,strong)UIView               * customActionView;
@property (strong,nonatomic)UIScrollView        * imageScrollView;//大图查看

@end

@implementation WriteReviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化
    deleteCount=0;
    isdele=NO;
    self.title = @"写评论";
    [self.rightNavItem setTitle:@"发布" forState:UIControlStateNormal];
    [self createTextView];
}

-(void)createTextView{
    
    
    //writeTextView
    CGRect writeTextViewFrame = CGRectMake(RECTFIX_WIDTH(10), 70, SCREEN_WIDTH-2*RECTFIX_WIDTH(10), 110);
    self.writeTextView = [[UITextView alloc]initWithFrame:writeTextViewFrame];
    self.writeTextView.delegate=self;
    self.writeTextView.returnKeyType=UIReturnKeyNext;
    self.writeTextView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.writeTextView];
    
    //textView背景
    UIImageView* imgview = [[UIImageView alloc] initWithFrame:self.writeTextView.frame];
    [self.view addSubview:imgview];
    [imgview setImage:[UIImage imageNamed:@"shurukuang_meishishuoshuo_534_263"]];
    imgview.userInteractionEnabled = YES;
    [self.view sendSubviewToBack:imgview];
    
    //提示输入多少字的label
    CGRect surplusWordsFrame = CGRectMake(200, CGRectGetMaxY(self.writeTextView.frame)+10, 100, 30);
    self.surplusWordsLabel = [[UILabel alloc]initWithFrame:surplusWordsFrame];
    self.surplusWordsLabel.text=[NSString stringWithFormat:@"亲,还差%u个字哦",15-self.writeTextView.text.length];
    self.surplusWordsLabel.font = [UIFont systemFontOfSize:12.0f];
    [self.view addSubview:self.surplusWordsLabel];
    
    //照片墙
    _photoArray=[[NSMutableArray alloc] init];
    
    self.customActionView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 200)];
    self.customActionView.backgroundColor = RGBCOLOR(230, 230, 230);
    
    for (int i=0; i<3; i++) {
        UIButton *actionBtn = [[UIButton alloc]initWithFrame:CGRectMake(RECTFIX_WIDTH(10), 20+(40+20)*i, SCREEN_WIDTH-20, 40)];
        NSArray * titleArray = @[@"拍照",@"从手机相册选择",@"取消"];
        [actionBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [actionBtn setTitleColor:RGBCOLOR(31, 31, 31)  forState:UIControlStateNormal];
        actionBtn.backgroundColor = RGBCOLOR(255, 255, 255);
        actionBtn.tag = 2100+i;
        if (i == 2) {
            actionBtn.backgroundColor = RGBCOLOR(193, 193, 193);
        }
        actionBtn.layer.borderColor = RGBCOLOR(218, 218, 218).CGColor;
        actionBtn.layer.borderWidth = 1.0f;
        actionBtn.layer.cornerRadius = 6.0f;
        [self.customActionView addSubview:actionBtn];
        [actionBtn addTarget:self action:@selector(getPicture:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.view addSubview:self.customActionView];
    
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backKeyboard)];
    tapGestureRecognizer.numberOfTouchesRequired = 1; //手指数
    tapGestureRecognizer.numberOfTapsRequired = 1; //tap次数
    tapGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:tapGestureRecognizer];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //添加照片按钮
    self.photoView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.surplusWordsLabel.frame)+10, SCREEN_WIDTH, 150)];
    self.addPhotoButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 50, 50)];
    [self.addPhotoButton setImage:[UIImage imageNamed:@"tp.png"] forState:UIControlStateNormal];
    [self.addPhotoButton addTarget:self action:@selector(clickAddPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.photoView addSubview:self.addPhotoButton];
    [self.view addSubview:self.photoView];
    
}

//刷新addbutton
-(void)reloadAddButton{
    if (_photoArray.count>0) {
        for (int i=0; i<_photoArray.count+deleteCount; i++) {
            //NSLog(@"移除所有");
            UIButton *button=(UIButton*)[self.photoView viewWithTag:i+1];
            [button removeFromSuperview];
            button=nil;
        }
        deleteCount=0;
        //NSLog(@"刷新时-----%lu",(unsigned long)_photoArray.count);
        for (int i=0; i<_photoArray.count; i++) {
            UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
            if (i>4) {
                button.frame=CGRectMake(20+(i-5)*(50+7.5), 80, 50, 50);
            }else{
                button.frame=CGRectMake(20+i*(50+7.5), 10, 50, 50);
            }
            button.tag=i+1;
            [button setBackgroundImage:[_photoArray objectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(bigImage:) forControlEvents:UIControlEventTouchUpInside];
            [self.photoView addSubview:button];
            
            if (i==_photoArray.count-1) {
                if (i>3) {
                    self.addPhotoButton.frame=CGRectMake(20+(i-4)*(50+7.5), 80, 50, 50);
                }else{
                    self.addPhotoButton.frame=CGRectMake(button.frame.origin.x+button.frame.size.width+7.5, 10, 50, 50);
                }
                
            }
            
            if (i==9) {
                self.addPhotoButton.hidden=YES;
                
            }else{
                self.addPhotoButton.hidden=NO;
            }
            
        }
    }else{
        //如果数组为0 删除干净了
        for (int i=0; i<_photoArray.count+deleteCount; i++) {
            //NSLog(@"移除所有");
            UIButton *button=(UIButton*)[self.photoView viewWithTag:i+1];
            [button removeFromSuperview];
            button=nil;
        }
        deleteCount=0;
        //NSLog(@"删除干净刷新时-----%lu",(unsigned long)_photoArray.count);
        self.addPhotoButton.frame=CGRectMake(20, 20, 50, 50);
        self.addPhotoButton.hidden=NO;
        
    }
}

-(void)removeMyView:(UIImageView*)imageV{
    if (_photoArray.count>0) {
        //移除删除imageview 并修改contentSize
        self.imageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*_photoArray.count, SCREEN_HEIGHT);
        for (int i=0; i<_photoArray.count+deleteCount; i++) {
            UIImageView *imageall=(UIImageView*)[self.imageScrollView viewWithTag:100+i];
            UIButton *button=(UIButton*)[imageall viewWithTag:1100+i];
            if (i<imageV.tag-100) {
                
            }
            if (i==imageV.tag-100) {
                continue;
            }
            if (i>imageV.tag-100) {
                
                imageall.frame=CGRectMake(imageall.frame.origin.x-SCREEN_WIDTH, imageall.frame.origin.y, imageall.frame.size.width, imageall.frame.size.height);
                imageall.tag--;
                button.tag--;
                NSLog(@"imageall.tag--%ld   delButton.tag--%ld",(long)imageall.tag,(long)button.tag);
            }
            
        }
        [imageV removeFromSuperview];
        imageV =nil;
    }else{
        [_imageScrollView removeFromSuperview];
        _imageScrollView = nil;
        
        [_fullImageView removeFromSuperview];
        _fullImageView = nil;
        [self reloadAddButton];
    }
}


-(void)backKeyboard{
    [self.writeTextView resignFirstResponder];
    
}
-(void)deletePic:(UIButton*)sender{
    buttonTag=sender.tag;
    if (isdele==NO) {
        UIActionSheet* mySheet = [[UIActionSheet alloc]
                                  initWithTitle:@"要删除这张照片么"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"删除",nil];
        [mySheet showInView:self.view];
    }else{
        isdele=NO;
        UIImageView *imageV=(UIImageView *)[self.imageScrollView viewWithTag:sender.tag-1000];
        imageV.userInteractionEnabled=NO;
        CGPoint fromPoint=imageV.center;
        CGPoint toPoint =CGPointMake(sender.center.x+SCREEN_WIDTH*(sender.tag-1100), sender.center.y);
        NSLog(@"%f----%f",toPoint.x,toPoint.y);
        UIBezierPath *movePath = [UIBezierPath bezierPath];
        [movePath moveToPoint:fromPoint];
        [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x,fromPoint.y)];
        CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnim.path = movePath.CGPath;
        moveAnim.removedOnCompletion = YES;
        CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
        scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
        scaleAnim.removedOnCompletion = YES;
        CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
        opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
        opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
        opacityAnim.removedOnCompletion = YES;
        CAAnimationGroup *animGroup = [CAAnimationGroup animation];
        animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim,opacityAnim, nil];
        animGroup.duration = 1;
        [imageV.layer addAnimation:animGroup forKey:nil];
        
        [_photoArray removeObjectAtIndex:imageV.tag-100];
        deleteCount++;
        [self performSelector:@selector(removeMyView:) withObject:imageV afterDelay:1.0f];
    }
    
    
    
    
    
    
}

-(void)getPicture:(UIButton*)sender{
    switch (sender.tag) {
        case 2100:
        {
            if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
                
                return;
                
            }
            //调用照相机
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;  //调用相机
            //        picker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;  //调用相册
            [self presentViewController:picker animated:YES completion:NULL];//进入照相界面
        }
            break;
        case 2101:
        {
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            picker.number = _photoArray.count;
            picker.maximumNumberOfSelection = 10;
            
            picker.assetsFilter = [ALAssetsFilter allAssets];
            picker.delegate = self;
            //        picker.showsCancelButton = NO;
            [self presentViewController:picker animated:YES completion:NULL];
        }
            break;
        case 2102:
        {
            [UIView animateWithDuration:0.25 animations:^{
                self.customActionView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.customActionView.frame.size.height);
            }];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)clickAddPhoto:(UIButton *)sender{
    if (sender.isSelected) {
        if ([self.writeTextView isFirstResponder]) {
            [self.writeTextView resignFirstResponder];
            [sender setSelected:YES];
            [UIView animateWithDuration:0.25 animations:^{
                self.customActionView.frame=CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, self.customActionView.frame.size.height);
                [self.view bringSubviewToFront:self.customActionView];
            }];
        }else{
            [self.writeTextView resignFirstResponder];
            [sender setSelected:NO];
            [UIView animateWithDuration:0.25 animations:^{
                self.customActionView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.customActionView.frame.size.height);
            }];
        }
        
    }else{
        [self.writeTextView resignFirstResponder];
        [sender setSelected:YES];
        [UIView animateWithDuration:0.25 animations:^{
            self.customActionView.frame=CGRectMake(0, SCREEN_HEIGHT-200, SCREEN_WIDTH, self.customActionView.frame.size.height);
            [self.view bringSubviewToFront:self.customActionView];
        }];
    }
    
}


//看大图
-(void)bigImage:(UIButton *)sender{
    
    [_writeTextView resignFirstResponder];
    
    //大图滚动view
    if (self.imageScrollView==nil) {
        self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        self.imageScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*_photoArray.count, SCREEN_HEIGHT);
        self.imageScrollView.pagingEnabled = YES;
        
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOutAction:)];
    //点击那张图片  _fullImageView 就显示那张图片
    if (_fullImageView==nil) {
        
        _fullImageView = [[UIImageView alloc] init];
        
        _fullImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    NSLog(@"%ld",(long)sender.tag);
    _fullImageView.image = [_photoArray objectAtIndex:sender.tag-1];
    _fullImageView.frame = [sender convertRect:sender.bounds toView:sender.window];
    _frame = _fullImageView.frame;
    self.imageScrollView.contentOffset = CGPointMake((sender.tag-1)*SCREEN_WIDTH, 0);
    self.imageScrollView.backgroundColor = [UIColor clearColor];
    
    [sender.window addSubview:self.imageScrollView];
    [sender.window addSubview:_fullImageView];
    [UIView animateWithDuration:0.3f animations:^{
        _fullImageView.frame=self.imageScrollView.frame;
        self.imageScrollView.backgroundColor = [UIColor blackColor];
    } completion:^(BOOL finished) {
        [self.imageScrollView addGestureRecognizer:tap];
        _fullImageView.hidden=YES;
        //图片
        for (int i = 0; i<_photoArray.count; i++) {
            //大图的图片
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            imageView.contentMode= UIViewContentModeScaleAspectFit;
            imageView.tag=i+100;
            imageView.userInteractionEnabled=YES;
            [self.imageScrollView addSubview:imageView];
            imageView.image=[_photoArray objectAtIndex:i];
            //            //大图的删除按钮
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=CGRectMake(256, 10, 50, 50);
            [button setImageEdgeInsets:UIEdgeInsetsMake(15, 17, 15, 17)];
            button.tag=i+1100;
            [button setImage:[UIImage imageNamed:@"shanchu.png"] forState:UIControlStateNormal];
            
            
            [button addTarget:self action:@selector(deletePic:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:button];
            
        }
    }];
}
//缩小
-(void)zoomOutAction:(UIGestureRecognizer*)tap{
    if (self.imageScrollView.contentOffset.x/SCREEN_WIDTH<=4) {
        _frame.origin.x =20+(self.imageScrollView.contentOffset.x/SCREEN_WIDTH)*(50+7.5);
    }else{
        _frame.origin.x =20+((self.imageScrollView.contentOffset.x/SCREEN_WIDTH)-5)*(50+7.5);
        
    }
    
    _fullImageView.image =  [_photoArray objectAtIndex:self.imageScrollView.contentOffset.x/SCREEN_WIDTH];
    _fullImageView.hidden = NO;
    [_imageScrollView removeFromSuperview];
    [UIView animateWithDuration:.3 animations:^{
        _fullImageView.frame = _frame;
        _imageScrollView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        NSLog(@"缩小时所剩%lu",(unsigned long)_photoArray.count);
        for (int i=0; i<_photoArray.count; i++) {
            UIImageView *imageV=(UIImageView *)[self.imageScrollView viewWithTag:100+i];
            [imageV removeFromSuperview];
            imageV =nil;
            
        }
        [_imageScrollView removeFromSuperview];
        _imageScrollView = nil;
        
        [_fullImageView removeFromSuperview];
        _fullImageView = nil;
        
        [self reloadAddButton];
    }];
    
}


#pragma mark - 导航栏方法;
-(void)sendBtn:(id)sender{
    [self.writeTextView resignFirstResponder];
   // sender.enabled = NO;
    if (USER_ID) {
        if (self.writeTextView.text.length<15||self.writeTextView.text.length>100) {
            [self showMsg:@"请输入15~100长度"];
            return;
        }
    }
}

#pragma mark - view cycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.addPhotoButton.hidden=NO;
    [self reloadAddButton];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.25 animations:^{
        self.customActionView.frame=CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.customActionView.frame.size.height);
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

#pragma mark-UI control

//拍摄完成后要执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (_photoArray.count>9) {
        [self showMsg:@"最多10张"];
        return;
    }
    [_photoArray addObject:image];
    //图片存入相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//点击Cancel按钮后执行方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        isdele=YES;
        UIImageView *imageV=(UIImageView *)[self.imageScrollView viewWithTag:buttonTag-1000];
        UIButton *button=(UIButton*)[imageV viewWithTag:buttonTag];
        [self deletePic:button];
        
    }else if (buttonIndex==1){
        isdele=NO;
        
    }
    
}

#pragma mark - Assets Picker Delegate
- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (int i=0;i<assets.count;i++) {
        ALAssetRepresentation *representation = [[assets objectAtIndex:i] defaultRepresentation];
        UIImage *image = [UIImage imageWithCGImage:[representation fullResolutionImage]];
        [images addObject:image];
    }
    [_photoArray addObjectsFromArray:images];
    NSLog(@"_photoArray = %@",_photoArray);
    //[self.addPhotoButton setImage:images[i] forState:UIControlStateNormal];
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@",assets[0]);
    
}


#pragma mark-UITextViewDelegate-
//将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    if (textView.text.length>100) {
        [self showMsg:@"请输入15~100长度"];
        NSLog(@"请输入15~100长度");
        return NO;
    }
    
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length>100) {
        [self showMsg:@"请输入15~100长度"];
        NSLog(@"请输入15~100长度");
    }else{
        self.surplusWordsLabel.text=[NSString stringWithFormat:@"亲,还差%u个字哦",15-textView.text.length];
    }
    
    if (textView.text.length < 15 || textView.text.length > 100) {
        UIButton *rightBtn = (UIButton *)[self.navigationItem.rightBarButtonItem.customView viewWithTag:3001];
        [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.surplusWordsLabel.hidden = NO;
        rightBtn.enabled=NO;
    }else{
        UIButton *rightBtn = (UIButton *)[self.navigationItem.rightBarButtonItem.customView viewWithTag:3001];
        rightBtn.enabled=YES;
        [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.surplusWordsLabel.hidden = YES;
        
    }
    
}




@end
