//
//  MainViewController.h
//  PullDownTableView
//
//  Created by LiuMingchuan on 15/10/18.
//  Copyright © 2015年 LMC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *pullDownTableView;

@end
