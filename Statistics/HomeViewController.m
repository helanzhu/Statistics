//
//  HomeViewController.m
//  Statistics
//
//  Created by chenqg on 2019/11/15.
//  Copyright © 2019 chenqg. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailViewController.h"

@interface HomeViewController ()
@property (strong, nonatomic) IBOutlet UILabel *gestureLabel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    
    UITapGestureRecognizer *tapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureClicked:)];
       [self.gestureLabel addGestureRecognizer:tapgesture];
}


- (void)gestureClicked:(UITapGestureRecognizer *)gesture{
    NSLog(@"手势埋点");
}

- (IBAction)onCollectPressed:(UIButton *)sender {
    
}
- (IBAction)onSharedPressed:(UIButton *)sender {
    
}
- (IBAction)onEnterDetailPressed:(UIButton *)sender {
    
    DetailViewController *detailVC = [[DetailViewController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
