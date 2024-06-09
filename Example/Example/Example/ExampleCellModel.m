//
//  ExampleCellModel.m
//  Example
//
//  Created by 徐臻 on 2024/6/1.
//

#import "ExampleCellModel.h"
@import XZExtensions;

@implementation ExampleCellModel
- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    self = [super init];
    if (self) {
        if (scrollDirection == UICollectionViewScrollDirectionVertical) {
            CGFloat width = 30 + arc4random_uniform(80);
            CGFloat height = 30 + arc4random_uniform(30);
            _size = CGSizeMake(width, height);
        } else {
            CGFloat width = 30 + arc4random_uniform(80);
            CGFloat height = 30 + arc4random_uniform(30);
            _size = CGSizeMake(height, width);
        }
        
        _color = rgb(arc4random());
        _interitemAlignment = XZCollectionViewInteritemAlignmentMedian;
    }
    return self;
}
@end
