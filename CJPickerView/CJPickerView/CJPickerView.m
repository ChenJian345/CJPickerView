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

@interface CJPickerView() <UIPickerViewDataSource, UIPickerViewDelegate>

// Picker View Content View, including bar view and picker view
@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIDatePicker *datePickerView;

@property (nonatomic, retain) NSArray *arrFirstColumnTitles;
@property (nonatomic, retain) NSArray *arrSecondColumnTitles;

@end

@implementation CJPickerView

/**
 Only for select date or time

 @param style CJPICKERVIEW_STYPE
 @return CJPickerView instance
 */
- (instancetype)initWithDateType:(CJPICKERVIEW_STYPE)style {
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    [self initCommonUIComponents];
    
    switch (style) {
        case CJPICKERVIEW_STYPE_DATE:
        {
            [self initDatePickerView];
            [self.contentView addSubview:self.datePickerView];
        }
            break;
            
        case CJPICKERVIEW_STYPE_TIME:
        {
            [self initDatePickerView];
            self.datePickerView.datePickerMode = UIDatePickerModeTime;
            [self.contentView addSubview:self.datePickerView];
        }
            break;
            
        case CJPICKERVIEW_STYPE_DATE_AND_TIME:
        {
            [self initDatePickerView];
            self.datePickerView.datePickerMode = UIDatePickerModeDateAndTime;
            [self.contentView addSubview:self.datePickerView];
        }
            break;
            
        default:
            break;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    return self;
}

/**
 Init picker view for select one or multi columns requirements.
 
 @param style CJPICKERVIEW_STYPE
 @param arrC1Titles First column string titles
 @param arrC2Titles Second column string titles
 @return CJPickerView instance
 */
- (instancetype)initWithColumnType:(CJPICKERVIEW_STYPE)style firstColumn:(NSArray *)arrC1Titles SecondColumn:(NSArray *)arrC2Titles {
    self = [super initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    [self initCommonUIComponents];
    
    switch (style) {
        case CJPICKERVIEW_STYPE_COLUMN_ONE:
        {
            [self initGeneralPickerView];
            [self.contentView addSubview:self.pickerView];
        }
            break;
            
        case CJPICKERVIEW_STYPE_COLUMN_TWO:
        {
            [self initGeneralPickerView];
            [self.contentView addSubview:self.pickerView];
        }
            break;

        default:
            break;
    }
    
    self.arrFirstColumnTitles = arrC1Titles;
    self.arrSecondColumnTitles = arrC2Titles;

    [[UIApplication sharedApplication].keyWindow addSubview:self];

    return self;
}

- (void)dismiss {
    [self removeFromSuperview];
}

- (void)onDateTimeChanged:(NSDate *)date {
    // TBD
}

- (void)onConfirm {
    [self dismiss];
    
    if (self.delegate != nil) {
        if (self.pickerView != nil) {
            if ([self.delegate respondsToSelector:@selector(onResultSelected:)]) {
                NSString *result = nil;
                NSString *firstColumnResult = nil;
                NSString *secondColumnResult = nil;

                if (self.arrFirstColumnTitles != nil && self.arrSecondColumnTitles != nil) {
                    firstColumnResult = [self.arrFirstColumnTitles objectAtIndex:[self.pickerView selectedRowInComponent:0]];
                    secondColumnResult = [self.arrSecondColumnTitles objectAtIndex:[self.pickerView selectedRowInComponent:1]];
                    
                    result = [NSString stringWithFormat:@"%@#%@", firstColumnResult, secondColumnResult];
                } else if (self.arrFirstColumnTitles != nil && self.arrSecondColumnTitles == nil) {
                    result = [self.arrFirstColumnTitles objectAtIndex:[self.pickerView selectedRowInComponent:0]];
                } else {
                    result = [self.arrSecondColumnTitles objectAtIndex:[self.pickerView selectedRowInComponent:1]];
                }
                
                [self.delegate performSelector:@selector(onResultSelected:) withObject:result];
            }
        } else if (self.datePickerView != nil) {
            if ([self.delegate respondsToSelector:@selector(onDateTimeSelected:)]) {
                [self.delegate performSelector:@selector(onDateTimeSelected:) withObject:self.datePickerView.date];
            }
        }
        
    }
}


/**
 Init the UI common components
 */
- (void)initCommonUIComponents {
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - PICKERVIEW_HEIGHT, SCREEN_WIDTH, PICKERVIEW_HEIGHT)];
    self.contentView.backgroundColor = [UIColor blackColor];
    [self addSubview:self.contentView];
    
    // 添加ContentView
    self.barContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, PICKERVIEW_TOP_BAR_HEIGHT)];
    self.barContentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.barContentView];
    
    self.btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, (PICKERVIEW_TOP_BAR_HEIGHT-30)/2.0, 70, 30)];
    [self.btnCancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.btnCancel.titleLabel setTextAlignment:NSTextAlignmentLeft];
    [self.btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnCancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.barContentView addSubview:self.btnCancel];
    
    self.btnConfirm = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-70, (PICKERVIEW_TOP_BAR_HEIGHT-30)/2.0, 70, 30)];
    [self.btnConfirm setTitle:@"OK" forState:UIControlStateNormal];
    [self.btnConfirm.titleLabel setTextAlignment:NSTextAlignmentRight];
    [self.btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnConfirm addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
    [self.barContentView addSubview:self.btnConfirm];
}

/**
 Init the DatePicker view for the date and time select requirement
 */
- (void)initDatePickerView {
    if (self.datePickerView == nil) {
        self.datePickerView = [[UIDatePicker alloc] init];
        self.datePickerView.frame = CGRectMake(0, CGRectGetHeight(self.barContentView.frame), SCREEN_WIDTH, PICKERVIEW_HEIGHT - PICKERVIEW_TOP_BAR_HEIGHT);
        [self.datePickerView setValue:[UIColor whiteColor] forKey:@"textColor"];
        self.datePickerView.datePickerMode = UIDatePickerModeDate;
        [self.datePickerView addTarget:self action:@selector(onDateTimeChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

/**
 Init general picker view for select string or number requiements
 */
- (void)initGeneralPickerView {
    if (self.pickerView == nil) {
        self.pickerView = [[UIPickerView alloc] init];
        self.pickerView.frame = CGRectMake(0, CGRectGetHeight(self.barContentView.frame), SCREEN_WIDTH, PICKERVIEW_HEIGHT - PICKERVIEW_TOP_BAR_HEIGHT);
        // TEST
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
    }
}

#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (self.arrFirstColumnTitles != nil && self.arrSecondColumnTitles != nil) {
        return 2;
    } else {
        return 1;
    }
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.arrFirstColumnTitles.count;
    } else {
        return self.arrSecondColumnTitles.count;
    }
}

#pragma mark - UIPickerViewDelegate

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component NS_AVAILABLE_IOS(6_0) __TVOS_PROHIBITED {
    NSString *title = @"";
    id rowValue = nil;
    if (component == 0) {
        rowValue = [self.arrFirstColumnTitles objectAtIndex:row];
    } else if (component == 1) {
        rowValue = [self.arrSecondColumnTitles objectAtIndex:row];
    }
    
    if (rowValue != nil && [rowValue isKindOfClass:[NSString class]]) {
        title = rowValue;
    }
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : [UIColor yellowColor]}];
    return attrString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    // TBD
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

- (void)setDefaultSelectedRowIndex:(NSInteger)index forColumn:(NSInteger)columnIndex {
    [self.pickerView selectRow:index inComponent:columnIndex animated:NO];
}

@end
