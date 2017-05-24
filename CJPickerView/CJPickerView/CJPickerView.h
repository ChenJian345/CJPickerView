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

@interface CJPickerView : UIView

@property (nonatomic, strong) UIView *barContentView;
@property (nonatomic, strong) UIButton *btnCancel;
@property (nonatomic, strong) UIButton *btnConfirm;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePickerView;

- (instancetype)initWithType:(CJPICKERVIEW_STYPE)style;

@end
