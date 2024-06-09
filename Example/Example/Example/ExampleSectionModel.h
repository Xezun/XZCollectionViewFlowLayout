//
//  ExampleSectionModel.h
//  Example
//
//  Created by 徐臻 on 2024/6/1.
//

#import <Foundation/Foundation.h>
#import "ExampleCellModel.h"
@import XZCollectionViewFlowLayout;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ExampleSectionModelLineAlignmentStyle) {
    ExampleSectionModelLineAlignmentStyleLeading,
    ExampleSectionModelLineAlignmentStyleCenter,
    ExampleSectionModelLineAlignmentStyleTraling,
    ExampleSectionModelLineAlignmentStyleJustified,
    ExampleSectionModelLineAlignmentStyleJustifiedLeading,
    ExampleSectionModelLineAlignmentStyleJustifiedCenter,
    ExampleSectionModelLineAlignmentStyleJustifiedTrailing,
    ExampleSectionModelLineAlignmentStyle6,
};

@interface ExampleSectionModel : NSObject

- (instancetype)initWithScrollDirection:(UICollectionViewScrollDirection)scrollDirection;

@property (nonatomic) CGSize headerSize;
@property (nonatomic, copy) NSArray<ExampleCellModel *> *cells;
@property (nonatomic) CGSize footerSize;

@property (nonatomic) CGFloat lineSpacing;
@property (nonatomic) CGFloat interitemSpacing;

@property (nonatomic) UIEdgeInsets edgeInsets;

@property (nonatomic) ExampleSectionModelLineAlignmentStyle lineAlignmentStyle;
@property (nonatomic) XZCollectionViewInteritemAlignment interitemAlignment;
- (XZCollectionViewLineAlignment)lineAlignmentForItemsInLine:(NSInteger)line;

@end

NS_ASSUME_NONNULL_END
