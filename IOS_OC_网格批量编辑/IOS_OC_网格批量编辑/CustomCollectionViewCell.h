//
//  CustomCollectionViewCell.h
//  IOS_OC_网格批量编辑
//
//  Created by 张东辉 on 2020-4-14.
//  Copyright © 2020 ZDH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imgV;
@property(nonatomic,strong)UILabel *nameLabael;
@property(nonatomic,strong)UIImageView *selectImgV;
@property(nonatomic,assign)BOOL isSelectGo;
@end

NS_ASSUME_NONNULL_END
