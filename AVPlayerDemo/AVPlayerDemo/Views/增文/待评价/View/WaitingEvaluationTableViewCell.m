//
//  WaitingEvaluationTableViewCell.m
//  AVPlayerDemo
//
//  Created by mymac on 2017/7/18.
//  Copyright © 2017年 Five gods. All rights reserved.
//

#import "WaitingEvaluationTableViewCell.h"
@interface WaitingEvaluationTableViewCell ()
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *QtyLabel;
@end
@implementation WaitingEvaluationTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

- (void)addSubViews {
    [self.contentView addSubview:self.titleImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.QtyLabel];
}

- (void)updateConstraints {
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(15);
        make.centerY.equalTo(self.contentView);
        make.size.equalTo(CGSizeMake(60, 60));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView.right).offset(15);
        make.top.equalTo(self.titleImageView);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.bottom.equalTo(self.titleImageView);
    }];
    
    [self.QtyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(-15);
        make.bottom.equalTo(self.priceLabel);
    }];
    
    
    
    
    
    [super updateConstraints];
}

- (void)setModel:(WaitingEvaluationGoodsModel *)model shopType:(NSInteger)type {

    if (type == 1) {
        self.QtyLabel.hidden = NO;
    } else {
        self.QtyLabel.hidden = YES;
    }
    
    [self.titleImageView sd_setImageWithURL:[NSURL URLWithString:model.goodsImageUrl]];
    self.nameLabel.text = model.goodsName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",model.goodsPrice];
    self.QtyLabel.text = [NSString stringWithFormat:@"x%ld",model.goodsQty];
    
  
    
    
}



- (UIImageView *)titleImageView {
    if (!_titleImageView ) {
        _titleImageView = [[UIImageView alloc]init];
        
    }
    return _titleImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:15.0f];
        _nameLabel.textColor = [UIColor colorWithHex:333333];
    }
    return _nameLabel;
}

-(UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:15.0f];
        _priceLabel.textColor = [UIColor colorWithHex:333333];
    }
    return _priceLabel;
}


- (UILabel *)QtyLabel {
    if (!_QtyLabel) {
        _QtyLabel = [[UILabel alloc]init];
        _QtyLabel.font = [UIFont systemFontOfSize:15.0f];
        _QtyLabel.textColor = [UIColor colorWithHex:999999];
    }
    return _QtyLabel;
}










- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
