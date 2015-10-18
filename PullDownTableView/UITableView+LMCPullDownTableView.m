//
//  UITableView+LMCPullDownTableView.m
//  PullDownTableView
//
//  Created by LiuMingchuan on 15/10/18.
//  Copyright © 2015年 LMC. All rights reserved.
//
#define TOPDISTANCE 200
#define MAXPULLDOWNDISTANCE 400
#import "UITableView+LMCPullDownTableView.h"
#import <objc/runtime.h>

@implementation UITableView (LMCPullDownTableView)

/**
 *  key for pulldownimageview
 */
static char pullDownImageViewKey;
/**
 *  key for photoimageview
 */
static char photoImageViewKey;


- (void)setPhotoImageView:(UIImageView *)imageView{
    [self insertSubview:imageView atIndex:1];
    objc_setAssociatedObject(self, &photoImageViewKey, imageView, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)photoImageView {
    return objc_getAssociatedObject(self, &photoImageViewKey);
}

- (void)setPullDownImageView:(UIImageView *)imageView{
    [self insertSubview:imageView atIndex:0];
    objc_setAssociatedObject(self, &pullDownImageViewKey, imageView, OBJC_ASSOCIATION_RETAIN);
}

- (UIImageView *)pullDownImageView {
    return objc_getAssociatedObject(self, &pullDownImageViewKey);
}

/**
 *  implement pull down action
 */
-(void)pullDown{
    
    if (self.contentOffset.y<-TOPDISTANCE) {
        //when tableview slide down,zoom background imageview
        self.pullDownImageView.center = CGPointMake(self.frame.size.width/2, self.contentOffset.y/2);
        CGFloat rate = -self.contentOffset.y/TOPDISTANCE;
        self.pullDownImageView.transform = CGAffineTransformMakeScale(rate, rate);
        self.photoImageView.transform = CGAffineTransformMakeScale(rate, rate);
        if (self.contentOffset.y< -MAXPULLDOWNDISTANCE) {
            //when offset.y bigger than MAXPULLDOWNDISTANCE,set tableview can't slide down
            [self setContentOffset:CGPointMake(self.contentOffset.x, -MAXPULLDOWNDISTANCE)];
        }
    }
}

/**
 *  implement set image action
 *
 *  @param pullDownImage image
 */
- (void)setPullDownImage:(UIImage *)pullDownImage {
    //no vertical indicator
    [self setShowsVerticalScrollIndicator:NO];
    //make space for pulldownimageview
    [self setContentInset:UIEdgeInsetsMake(TOPDISTANCE, 0, 0, 0)];
    //create pulldownimageview
    UIImageView *pullDownImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.contentOffset.y, self.frame.size.width, TOPDISTANCE)];
    [pullDownImageView setImage:pullDownImage];
    //set pulldownimageview
    [self setPullDownImageView:pullDownImageView];
    
    //create photoimageview
    UIImageView *photoImageView = [[UIImageView alloc]init];
    [photoImageView setBounds:CGRectMake(0, 0, 100, 100)];
    photoImageView.layer.cornerRadius = 50;
    photoImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    photoImageView.layer.borderWidth = 5;
    photoImageView.layer.masksToBounds = YES;
    [photoImageView setImage:[UIImage imageNamed:@"self.jpg"]];
    photoImageView.center = pullDownImageView.center;
    [self setPhotoImageView:photoImageView];
    //create photoimageview's tapgesture
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(photoClickAction)];
    tapGesture.numberOfTapsRequired = 1;
    photoImageView.userInteractionEnabled = YES;
    [photoImageView addGestureRecognizer:tapGesture];
    
}

/**
 *  tap action for photo
 */
-(void)photoClickAction {
    //you can set the photopicker action here
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Comment Info" message:@"This can be used for chosing a photo！" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okAction];
    
    [((UIViewController*)self.delegate)presentViewController:alert animated:YES completion:nil];
}

@end
