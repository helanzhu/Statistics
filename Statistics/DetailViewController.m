//
//  DetailViewController.m
//  Statistics
//
//  Created by chenqg on 2019/11/15.
//  Copyright © 2019 chenqg. All rights reserved.
//

#import "DetailViewController.h"

static NSString *const Identify = @"TablIdentifyeCell";

@interface DetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情页";
    [self.view addSubview:self.tableview];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identify];
    NSString *textStr = [NSString stringWithFormat:@"商品ID:%@",@(indexPath.row)];
    cell.textLabel.text = textStr;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:Identify];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

@end
