//
//  ViewController.m
//  CJPickerView
//
//  Created by Mark C.J. on 23/05/2017.
//  Copyright © 2017 MarkCJ. All rights reserved.
//

#import "ViewController.h"
#import "CJPickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];

    UIButton *btnPickData = [[UIButton alloc] initWithFrame:CGRectMake(20, 100, 100, 30)];
    btnPickData.layer.borderColor = [UIColor blackColor].CGColor;
    btnPickData.layer.borderWidth = 1.0;
    btnPickData.layer.cornerRadius = 5.0;
    [btnPickData setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnPickData setTitle:@"Date Picker" forState:UIControlStateNormal];
    [self.view addSubview:btnPickData];
    
    [btnPickData addTarget:self action:@selector(showDatePickerView) forControlEvents:UIControlEventTouchUpInside];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Handler
- (void)showDatePickerView {
    CJPickerView *pickerView = [[CJPickerView alloc] initWithType:CJPICKERVIEW_STYPE_DATE_AND_TIME];
}

@end
