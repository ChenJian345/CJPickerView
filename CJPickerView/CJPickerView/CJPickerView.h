//
//  CJPickerView.h
//  CJPickerView
//
//  Created by Mark C.J. on 23/05/2017.
//  Copyright © 2017 MarkCJ. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PICKERVIEW_HEIGHT               250.0
#define PICKERVIEW_TOP_BAR_HEIGHT       40.0

typedef enum : NSUInteger {
    CJPICKERVIEW_STYPE_DATE,
    CJPICKERVIEW_STYPE_TIME,
    CJPICKERVIEW_STYPE_DATE_AND_TIME,
    CJPICKERVIEW_STYPE_COLUMN_ONE,
    CJPICKERVIEW_STYPE_COLUMN_TWO,
} CJPICKERVIEW_STYPE;

@protocol CJPickerViewDelegate <NSObject>

- (void)onDateTimeSelected:(NSDate *)selectedDate;

- (void)onResultSelected:(NSString *)selectedResultString;

@end

@interface CJPickerView : UIView

@property (nonatomic, strong) UIView *barContentView;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, weak) id<CJPickerViewDelegate> delegate;

/**
 Only for select date or time
 
 @param style CJPICKERVIEW_STYPE
 @return CJPickerView instance
 */
- (instancetype)initWithDateType:(CJPICKERVIEW_STYPE)style;

/**
 Init picker view for select one or multi columns requirements.

 @param style CJPICKERVIEW_STYPE
 @param arrC1Titles First column string titles
 @param arrC2Titles Second column string titles
 @return CJPickerView instance
 */
- (instancetype)initWithColumnType:(CJPICKERVIEW_STYPE)style
                       firstColumn:(NSArray *)arrC1Titles
                      SecondColumn:(NSArray *)arrC2Titles;

/**
 Set date picker view min and max available date
 
 @param minDate Minimum Date
 @param maxDate Maximux Date
 */
- (void)setMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate;

- (void)setDefaultSelectedRowIndex:(NSInteger)index forColumn:(NSInteger)columnIndex;

@end
