//
//  TableViewCell.m
//  iosProjects
//
//  Created by chao on 2021/8/19.
//  Copyright © 2021 ChaoYuW. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;

@end

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//
//    self.headView.layer.cornerRadius = 20;
//    self.headView.layer.masksToBounds = YES;
//    self.headView.layer.shadowColor = UIColor.darkGrayColor.CGColor;
//    self.headView.layer.shadowOffset = CGSizeMake(0, 0);
//    self.headView.layer.shadowOpacity = 0.5;
       // 阴影半径，默认3
//    self.headView.layer.shadowRadius = 5;
    
//    self.titleLab.layer.cornerRadius = 20;
//    self.titleLab.layer.masksToBounds = YES;
    
//    self.contentView.layer.cornerRadius = 20;
//    self.contentView.layer.masksToBounds = YES;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.headView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20.f, 20.f)];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.headView.bounds;
//    maskLayer.path = path.CGPath;
//    self.headView.layer.mask = maskLayer;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
