//
//  PokemonCell.m
//  SADemo
//
//  Created by zhuopin on 2019/4/5.
//

#import "PokemonCell.h"

@implementation PokemonCell

- (void)setModel:(PokemonModel *)model {
    _model = model;
    self.textLabel.text = model.title;
}
@end
