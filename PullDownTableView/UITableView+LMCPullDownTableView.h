//
//  UITableView+LMCPullDownTableView.h
//  PullDownTableView
//
//  Created by LiuMingchuan on 15/10/18.
//  Copyright © 2015年 LMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (LMCPullDownTableView)
/**
 *  set the pulldownImageview's image
 *
 *  @param pullDownImage image
 */
- (void)setPullDownImage:(UIImage *)pullDownImage;
/**
 *  pull down action
 */
- (void)pullDown;

@end
