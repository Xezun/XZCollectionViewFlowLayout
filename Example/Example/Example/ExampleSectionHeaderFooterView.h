//
//  ExampleSectionHeaderFooterView.h
//  Example
//
//  Created by 徐臻 on 2024/6/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ExampleSectionHeaderFooterView;

@protocol ExampleSectionHeaderFooterViewDelegate <NSObject>

- (void)didSelectHeaderFooterView:(ExampleSectionHeaderFooterView *)headerFooterView;

@end

@interface ExampleSectionHeaderFooterView : UICollectionReusableView
@property (nonatomic) NSInteger index;
@property (nonatomic, weak) id<ExampleSectionHeaderFooterViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
