//
//  PokemonCell.h
//  SADemo
//
//  Created by zhuopin on 2019/4/5.
//

#import <UIKit/UIKit.h>
#import "PokemonModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PokemonCell : UITableViewCell
@property (nonatomic, strong) PokemonModel *model;
@end

NS_ASSUME_NONNULL_END
