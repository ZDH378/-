//
//  CustomCollectionViewCell.m
//  IOS_OC_网格批量编辑
//
//  Created by 张东辉 on 2020-4-14.
//  Copyright © 2020 ZDH. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@implementation CustomCollectionViewCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    //self.backgroundColor = [UIColor grayColor];//[UIColor colorWithRed:95/255.0 green:95/255.0 blue:95/255.0 alpha:0.1];
    if (self)
        self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5;
    {
        self.isSelectGo = NO;
        [self addSubview:self.nameLabael];
        [self.nameLabael addSubview:self.selectImgV];
        
 
        self.nameLabael.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.selectImgV.frame = CGRectMake( self.frame.size.width-40, 10, 30, 30);
        
        
        
    }
    
    
    return self;
}
-(void)isEditDidChange:(NSString *)str{
    if ([str isEqualToString:@"yes"]) {
        self.selectImgV.hidden = NO;
    }else{
        
    }
    
}
-(UIImageView *)imgV {
    if(!_imgV) {
        _imgV = [[UIImageView alloc]init];

        
    }
    return _imgV ;
}
-(UILabel *)nameLabael {
    if(!_nameLabael) {
        _nameLabael  = [[UILabel alloc]init];
        _nameLabael.textAlignment = NSTextAlignmentCenter;
        _nameLabael.font = [UIFont systemFontOfSize:30 weight:3];
        _nameLabael.textColor = [UIColor whiteColor];

    
    }
    return _nameLabael ;
}
-(UIImageView *)selectImgV {
    if(!_selectImgV) {
        _selectImgV  = [[UIImageView alloc]init];
        _selectImgV.image = [UIImage imageNamed:@"select_no"];
    }
    return _selectImgV ;
}

@end
