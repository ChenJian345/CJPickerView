//
//  CJPickerView.m
//  CJPickerView
//
//  Created by Mark C.J. on 23/05/2017.
//  Copyright © 2017 MarkCJ. All rights reserved.
//

#import "CJPickerView.h"
#import "Definitions.h"

/*
 *  Get screen width and screen height.
 */
#define SCREEN_WIDTH                       ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT                      ([UIScreen mainScreen].bounds.size.height)

@implementation CJPickerView

- (instancetype)initWithType:(CJPICKERVIEW_STYPE)style {
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - PICKERVIEW_HEIGHT, SCREEN_WIDTH, PICKERVIEW_HEIGHT)];
    contentView.backgroundColor = [UIColor yellowColor];
    [self addSubview:contentView];
    
    // 添加ContentView
    self.barContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PICKERVIEW_TOP_BAR_HEIGHT)];
    self.barContentView.backgroundColor = [UIColor orangeColor];
    [contentView addSubview:self.barContentView];
    
    self.btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, (PICKERVIEW_TOP_BAR_HEIGHT-30)/2.0, 70, 30)];
    [self.btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.btnCancel.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnCancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.barContentView addSubview:self.btnCancel];

    self.btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, (PICKERVIEW_TOP_BAR_HEIGHT-30)/2.0, 70, 30)];
    [self.btnConfirm setTitle:@"OK" forState:UIControlStateNormal];
    [self.btnConfirm.titleLabel setTextAlignment:NSTextAlignmentRight];
    [self.btnConfirm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.btnConfirm addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.barContentView addSubview:self.btnConfirm];
    
    switch (style) {
        case CJPICKERVIEW_STYPE_DATE:
        {
            [self initDatePickerView];
            [contentView addSubview:self.datePickerView];
        }
            break;
            
        case CJPICKERVIEW_STYPE_TIME:
        {
            [self initDatePickerView];
            self.datePickerView.datePickerMode = UIDatePickerModeTime;
            [contentView addSubview:self.datePickerView];
        }
            break;
            
        case CJPICKERVIEW_STYPE_DATE_AND_TIME:
        {
            [self initDatePickerView];
            self.datePickerView.datePickerMode = UIDatePickerModeDateAndTime;
            [contentView addSubview:self.datePickerView];
        }
            break;
            
        case CJPICKERVIEW_STYPE_COLUMN_ONE:
        {
            
        }
            break;
            
        case CJPICKERVIEW_STYPE_COLUMN_TWO:
        {
            
        }
            break;
            
            
            
        default:
            break;
    }

    [[UIApplication sharedApplication].keyWindow addSubview:self];

    return self;
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)onConfirm {
    [self dismiss];
    
    // TBD
}

- (void)initDatePickerView {
    if (self.datePickerView == nil) {
        self.datePickerView = [[UIDatePicker alloc] init];
        self.datePickerView.frame = CGRectMake(0, CGRectGetHeight(self.barContentView.frame), SCREEN_WIDTH, PICKERVIEW_HEIGHT - PICKERVIEW_TOP_BAR_HEIGHT);
        self.datePickerView.datePickerMode = UIDatePickerModeDate;
        self.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - Set Limit Method

/**
 Set date picker view min and max available date

 @param minDate Minimum Date
 @param maxDate Maximux Date
 */
- (void)setMinDate:(NSDate *)minDate maxDate:(NSDate *)maxDate {
    if (self.datePickerView) {
        if (minDate != nil) {
            self.datePickerView.minimumDate = minDate;
        }
        
        if (maxDate != nil) {
            self.datePickerView.maximumDate = maxDate;
        }
    }
}

@end
