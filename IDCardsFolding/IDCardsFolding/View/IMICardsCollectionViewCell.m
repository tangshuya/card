//
//  IMICardsCollectionViewCell.m
//  WifireVportProject
//
//  Created by 汤书亚 on 2018/9/27.
//  Copyright © 2018年 Wifire. All rights reserved.
//

#import "IMICardsCollectionViewCell.h"
#import "UIImage+Compress.h"


//  获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

@interface IMICardsCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *descLable;
@property (weak, nonatomic) IBOutlet UILabel *numLable;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLable;
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;
@property (weak, nonatomic) IBOutlet UIButton *deletButton;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@end
@implementation IMICardsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    UILongPressGestureRecognizer *longPressGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressOnCell:)];
    [self addGestureRecognizer:longPressGes];
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnCell:)];
    [self addGestureRecognizer:panGes];
    self.panGes = panGes;
    self.panGes.enabled = NO;
   
}
- (void)setDataModel:(NSMutableDictionary *)dataModel{
    _dataModel = dataModel;
    NSString *title = _dataModel[@"title"];
    if ([title isEqualToString:@"电卡"]) {
        [self.backImageView setImage:[UIImage imageNamed:@"c_cardbackground"]];
    }else if ([title isEqualToString:@"银行卡"]){
        self.contentView.backgroundColor = RGB(237,83,75);
    }else if ([title isEqualToString:@"老年卡"]){
        self.contentView.backgroundColor = RGB(88,77,209);
    }else{
        self.contentView.backgroundColor = RGB(157,79,214);
    }
    
    self.titleLable.text = title;
    self.descLable.text = _dataModel[@"descTitle"];
    self.createTimeLable.text = _dataModel[@"createTime"];
    NSString *numbers = _dataModel[@"numbers"];
    if (numbers.length>=15) {
        //    取出idcard的前4位，拼接展示。
        NSString *startStr = [numbers substringWithRange:NSMakeRange(0, 4)];
        NSString *middleStr = [numbers substringWithRange:NSMakeRange(4, 4)];
        NSString *midStr = [numbers substringWithRange:NSMakeRange(8, 4)];
        NSString *endStr = [numbers substringWithRange:NSMakeRange(12, 3)];
        self.numLable.text =[NSString stringWithFormat:@"%@  %@  %@  %@",startStr,middleStr,midStr,endStr];
    }else{
        self.numLable.text = numbers;
    }

    
    //    NSDictionary *siteDescDict =   [EncryptionHandleTool dictionaryWithJsonString:_dataModel.siteDesc];
    
    NSDictionary *userInfo = @{
                               @"accessToken":@"e665537828t3rr33",
                               @"mobile":@"13625343634",
                               @"proxyAddr":@"373dew7266615544338383883dddf",
                               @"type":@"6"
                               };
    
        NSData *userInfoData = [NSJSONSerialization dataWithJSONObject:userInfo options:NSJSONWritingPrettyPrinted error:nil];
        NSString *userInfoBase64 = [userInfoData base64EncodedStringWithOptions:0];
    [self.codeImageView setImage:[UIImage createQRImageWithString:userInfoBase64 size:CGSizeMake(95, 95)]];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
}

#pragma mark -
#pragma mark -- -- -- -- -- - Event Response - -- -- -- -- --
- (void)longPressOnCell:(UILongPressGestureRecognizer *)ges {
    if ([self.gestureDelagate respondsToSelector:@selector(collectionViewCell:handlerLongPressGesture:)]) {
        [self.gestureDelagate collectionViewCell:self handlerLongPressGesture:ges];
    }
}

- (void)panOnCell:(UIPanGestureRecognizer *)ges {
    if ([self.gestureDelagate respondsToSelector:@selector(collectionViewCell:handlerPanGesture:)]) {
        [self.gestureDelagate collectionViewCell:self handlerPanGesture:ges];
    }
}



+ (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}



@end
