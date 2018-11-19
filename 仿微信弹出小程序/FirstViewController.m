//
//  FirstViewController.m
//  仿微信弹出小程序
//
//  Created by ° 郭伟 on 2018/11/16.
//  Copyright © 2018年 guowei. All rights reserved.
//
#define GWIDTH  [UIScreen mainScreen].bounds.size.width
#define GHEIGHT [UIScreen mainScreen].bounds.size.height
#import "FirstViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, assign) BOOL isShowFunctionalUnit;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *centerView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微信";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
}


- (UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, GWIDTH, GHEIGHT - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.bounces = YES;
        _tableView.showsVerticalScrollIndicator = YES;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"微信1111";
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)topView
{
    if(!_topView)
    {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, -60, GWIDTH, 60)];
        _topView.backgroundColor = [UIColor blackColor];
        
        _centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GWIDTH, 60)];
        _centerView.backgroundColor = [UIColor orangeColor];
        [_topView addSubview:_centerView];
    }
    return _topView;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f", -scrollView.contentOffset.y);

    if (scrollView.contentOffset.y >= -60) {
        [self.topView setFrame:CGRectMake(0, -60-scrollView.contentOffset.y, GWIDTH, 60)];
        [self.centerView setFrame:CGRectMake(0, 0, GWIDTH, 60)];
    } else {
        [self.topView setFrame:CGRectMake(0, 0, GWIDTH, 60-scrollView.contentOffset.y)];
        [self.centerView setFrame:CGRectMake(0, -scrollView.contentOffset.y - (-scrollView.contentOffset.y) / 2 - 30, GWIDTH, 60)];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSLog(@"%f", scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < -40 && self.tableView.contentInset.top != 60) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.tableView setContentInset:UIEdgeInsetsMake(60, 0, 0, 0)];
        }];
    } else if (scrollView.contentOffset.y > -180) {
        [UIView animateWithDuration:0.2 animations:^{
            [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            [self.tableView setContentInset:self.tableView.contentInset];
        }];
    }
}




@end
