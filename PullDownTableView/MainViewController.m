//
//  MainViewController.m
//  PullDownTableView
//
//  Created by LiuMingchuan on 15/10/18.
//  Copyright © 2015年 LMC. All rights reserved.
//

#import "MainViewController.h"
#import "UITableView+LMCPullDownTableView.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"PullDownTableview"];
    
    _pullDownTableView.delegate = self;
    _pullDownTableView.dataSource = self;

    [_pullDownTableView setPullDownImage:[UIImage imageNamed:@"road.jpg"]];
    
    // Do any additional setup after loading the view.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Title%ld",indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"SubTitle%ld",indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_pullDownTableView pullDown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
