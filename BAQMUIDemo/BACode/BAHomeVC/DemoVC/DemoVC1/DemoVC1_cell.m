//
//  DemoVC1_cell.m
//  BAQMUIDemo
//
//  Created by 博爱 on 2017/1/9.
//  Copyright © 2017年 boaihome. All rights reserved.
//

#import "DemoVC1_cell.h"
#import "DemoVC1_model.h"

static UIEdgeInsets const kInsets            = {15, 15, 15, 15};
static CGFloat const kUserImageSize          = 35;
static CGFloat const kUserImageMargin_bottom = 5;
static CGFloat const kUserImageMargin_right  = 10;
static CGFloat const kContentMargin_bottom   = 6;


@interface DemoVC1_cell ()

@property (nonatomic, strong) UIImageView  *userImageView;
@property (nonatomic, strong) UILabel      *nameLabel;
@property (nonatomic, strong) UILabel      *contentLabel;
@property (nonatomic, strong) UILabel      *timeLabel;

@end

@implementation DemoVC1_cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{
//    UIImage *userImage = [UIImage qmui_imageWithStrokeColor:[UIColor qmui_randomColor] size:CGSizeMake(kUserImageSize, kUserImageSize) lineWidth:3.0f cornerRadius:kUserImageSize/2];
    _userImageView                  = [[UIImageView alloc] initWithFrame:CGRectMake(kInsets.left, kInsets.top, kUserImageSize, kUserImageSize)];

    _nameLabel                      = [[UILabel alloc] init];
    self.nameLabel.font             = UIFontBoldMake(16);
    self.nameLabel.textColor        = UIColorGray2;
    
    _contentLabel                   = [[UILabel alloc] init];
    self.contentLabel.font          = UIFontMake(17);
    self.contentLabel.textColor     = UIColorGray1;
    self.contentLabel.textAlignment = NSTextAlignmentJustified;
    self.contentLabel.numberOfLines = 0;
    
    _timeLabel                      = [[UILabel alloc] init];
    self.timeLabel.font             = UIFontMake(12);
    self.timeLabel.textColor        = UIColorGray;
    
    [self.contentView addSubview:self.userImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
}

- (void)setModel:(DemoVC1_model *)model
{
    _model = model;
    
    self.nameLabel.text              = model.userName;
    self.userImageView.image         = [UIImage ba_imageToRoundImageWithImage:UIImageMake(model.userImageUrl)];
    self.contentLabel.attributedText = [self ba_attributedStringWithText:model.content lineHeight:25];
    self.timeLabel.text              = model.time;
//    self.timeLabel.text            = @"去年 16：55";

    /*! 在一个段落的最后一行自然对齐 */
    self.contentLabel.textAlignment  = NSTextAlignmentJustified;
    
    [self setNeedsLayout];
}

//- (void)renderWithNameText:(NSString *)nameText contentText:(NSString *)contentText
//{
//    self.nameLabel.text = nameText;
//    self.contentLabel.attributedText = [self ba_attributedStringWithText:contentText lineHeight:26];
//    self.timeLabel.text = @"昨天 18:24";
//    
//    self.contentLabel.textAlignment = NSTextAlignmentJustified;
//    
//    [self setNeedsLayout];
//}

- (NSAttributedString *)ba_attributedStringWithText:(NSString *)text lineHeight:(CGFloat)lineHeight
{
    if (!text.qmui_trim && text.qmui_trim.length <= 0)
    {
        return nil;
    }
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:text attributes:@{NSParagraphStyleAttributeName:[NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:lineHeight lineBreakMode:NSLineBreakByTruncatingTail]}];
    return attributedString;
}

/*! 
 sizeTahtFits 不会改变控件的原始高度->frame
 sizeToFit    会改变控件的原始高度->frame
 */
- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize cellSize      = CGSizeMake(size.width, 0);
    CGFloat content_With = size.width - UIEdgeInsetsGetHorizontalValue(kInsets);
    CGFloat cellHeight   = UIEdgeInsetsGetHorizontalValue(kInsets) + CGRectGetHeight(self.userImageView.bounds) + kUserImageMargin_bottom;
    
    if (self.contentLabel.text.length > 0)
    {
        CGSize contentSize = [self.contentLabel sizeThatFits:CGSizeMake(content_With, CGFLOAT_MAX)];
        cellHeight += (contentSize.height + kContentMargin_bottom);
    }
    
    if (self.timeLabel.text.length > 0)
    {
        CGSize timeSize = [self.timeLabel sizeThatFits:CGSizeMake(content_With, CGFLOAT_MAX)];
        cellHeight += timeSize.height;
    }
    
    cellSize.height = cellHeight;
    return cellSize;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat content_With = CGRectGetWidth(self.contentView.bounds) - UIEdgeInsetsGetHorizontalValue(kInsets);
    
//    self.userImageView.frame = CGRectSetXY(self.userImageView.frame, kInsets.left, kInsets.top);
//    self.userImageView.frame = CGRectMake(kInsets.left, kInsets.top, kUserImageSize, kUserImageSize);
//    self.userImageView.layer.cornerRadius = self.userImageView.width/2;
//    self.userImageView.layer.masksToBounds = YES;
//    
    if (self.nameLabel.text.length > 0)
    {
        CGFloat name_With = content_With - self.userImageView.width - kUserImageMargin_right;
        CGSize nameSize = [self.nameLabel sizeThatFits:CGSizeMake(name_With, CGFLOAT_MAX)];
        
        CGFloat name_x = self.userImageView.x + self.userImageView.width + kUserImageMargin_right;
//        CGFloat name_y = (self.userImageView.y + self.userImageView.height - nameSize.height)/2;
        
        self.nameLabel.frame = CGRectFlatMake(name_x, 0, name_With, nameSize.height);
        self.nameLabel.centerY = self.userImageView.centerY;
    }
    
    if (self.contentLabel.text.length > 0)
    {
        CGSize contentSize = [self.contentLabel sizeThatFits:CGSizeMake(content_With, CGFLOAT_MAX)];
        CGFloat content_y = self.userImageView.y + self.userImageView.height +kUserImageMargin_bottom;
        self.contentLabel.frame = CGRectFlatMake(kInsets.left, content_y, content_With, contentSize.height);
    }
    
    if (self.timeLabel.text.length > 0)
    {
        CGSize timeSize = [self.timeLabel sizeThatFits:CGSizeMake(content_With, CGFLOAT_MAX)];
        CGFloat time_x = self.contentLabel.x;
        CGFloat time_y = self.contentLabel.y + self.contentLabel.height + kContentMargin_bottom;
        self.timeLabel.frame = CGRectFlatMake(time_x, time_y, content_With, timeSize.height);
    }
}


@end
