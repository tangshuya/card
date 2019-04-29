//
//  TSYVoucherViewController.m
//  IDCardsFolding
//
//  Created by aaa on 2019/4/25.
//  Copyright © 2019 TangShuya. All rights reserved.
//

// 子控制器--券
#import "TSYVoucherViewController.h"

@interface TSYVoucherViewController ()

@end

@implementation TSYVoucherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(30, 64+50+10, 150, 30)];
    titleLable.text = @"暂无优惠券";
    titleLable.font = [UIFont systemFontOfSize:16];
    [titleLable setTextColor:[UIColor darkGrayColor]];
    [self.view addSubview:titleLable];
}


@end
