//
//  ViewController.m
//  AMUIStylistExample
//
//  Created by Alex Malkoff on 05.03.17.
//  Copyright © 2017 cpthooch. All rights reserved.
//

#import "ViewController.h"
#import "Styles.h"
#import "AMUIStylist.h"
#import "AMUIStyleSheet.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIView *inputContainerView;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *inputFieldContainers;
@property (weak, nonatomic) IBOutlet UIButton *mainButton;

- (IBAction)onStyleSwitchValueChanged:(UISegmentedControl *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat onePx = 1.0 / [UIScreen mainScreen].scale;
    
    self.logoImageView.clipsToBounds = YES;
    self.logoImageView.layer.cornerRadius = 8;
    self.logoImageView.layer.borderWidth = onePx;
    self.logoImageView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.3].CGColor;
    
    self.inputContainerView.clipsToBounds = YES;
    self.inputContainerView.layer.cornerRadius = 5;
    self.inputContainerView.layer.borderWidth = onePx;
    self.inputContainerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.3].CGColor;
    
    [self.inputFieldContainers enumerateObjectsUsingBlock:^(UIView *_Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        view.clipsToBounds = YES;
        view.layer.cornerRadius = 5;
    }];

    self.mainButton.clipsToBounds = YES;
    self.mainButton.layer.cornerRadius = 5;
    self.mainButton.layer.borderWidth = onePx;
    self.mainButton.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:0.2].CGColor;

    self.mainButton.titleLabel.am_style = kMainButtonTitleStyle;
}


- (IBAction)onStyleSwitchValueChanged:(UISegmentedControl *)sender {
    NSString *const selectedStyleSheetKey =
    sender.selectedSegmentIndex == 0 ? daylightStyleSheetKey() : nightmodeStyleSheetKey();
    
    [AMUIStylist sharedStylist].styleSheet = [AMUIStyleSheet getSheet:selectedStyleSheetKey];
}

@end
