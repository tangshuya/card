//
//  TSYButton.m
//  IDCardsFolding
//
//  Created by aaa on 2019/4/25.
//  Copyright © 2019 TangShuya. All rights reserved.
//

#import "TSYButton.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0                                                     \
blue:((float)(rgbValue & 0xFF))/255.0                                                               \
alpha:1.0]
@implementation TSYButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        [self setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [self setTitleColor:UIColorFromRGB(0x158aaa) forState:UIControlStateSelected];
    }
    return self;
}

/**
 *  重写这个方法的目的：去除高亮状态下所做的一切操作
 */
- (void)setHighlighted:(BOOL)highlighted {}

@end
