//
//  Styles.m
//
//  Created by Alex Malkoff on 05.03.17.
//  Copyright © 2017 cpthooch. All rights reserved.
//

@import CoreText;
#import "Styles.h"
#import "AMUIStyleSheet.h"
#import "AMUIStyle.h"
#import "AMUIStylist.h"

#define RGBColor(r, g, b) [UIColor colorWithRed:r / 255. green:g / 255. blue:b / 255. alpha:1.0]

NSString *const kApplicationStyle = @"application";
NSString *const kMainContainerStyle = @"main-container";
NSString *const kToolbarStyle = @"toolbar";
NSString *const kStyleSwitchStyle = @"style-switch";
NSString *const kMainTitleStyle = @"main-title";
NSString *const kLogoImageStyle = @"logo-image";
NSString *const kInputContainerStyle = @"input-container";
NSString *const kInputLabelStyle = @"input-label";
NSString *const kInputFieldContainerStyle = @"input-field-container";
NSString *const kInputFieldStyle = @"input-field";
NSString *const kMainButtonStyle = @"main-button";
NSString *const kMainButtonTitleStyle = @"main-button-title";


static NSString *const kDefaultRegularFontName = @"HelveticaNeue";
static NSString *const kDefaultLightFontName = @"HelveticaNeue-Light";
static NSString *const kDefaultBoldFontName = @"HelveticaNeue-Medium";

static UIFont *fontWithNameAndSize(NSString *fontName, CGFloat size) {
    UIFont *font = [UIFont fontWithName:fontName size:size];
    if (font == nil) {
        font = (__bridge_transfer UIFont *)CTFontCreateWithName((__bridge CFStringRef)fontName, size, NULL);
    }
    return font;
}


#pragma mark - CommonStyleSheetBase
///
/// CommonStyleSheetBase
/// --------------------
@interface CommonStyleSheetBase : AMUIStyleSheet
- (void) initStyles:(NSMutableDictionary *)styles;

- (UIFont *) regularFontWithSize:(CGFloat)size;
- (UIFont *) lightFontWithSize:(CGFloat)size;
- (UIFont *) boldFontWithSize:(CGFloat)size;
@end

@implementation CommonStyleSheetBase {
    NSDictionary *_styles;
}

- (NSDictionary *) styles {
    return _styles;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        NSMutableDictionary *styles = [NSMutableDictionary dictionary];
        [self initStyles:styles];
        _styles = [styles copy];
    }
    return self;
}

- (void) initStyles:(NSMutableDictionary *)styles {
}

- (UIFont *) regularFontWithSize:(CGFloat)size {
    return fontWithNameAndSize(kDefaultRegularFontName, size);
}

- (UIFont *) lightFontWithSize:(CGFloat)size {
    return fontWithNameAndSize(kDefaultLightFontName, size);
}

- (UIFont *) boldFontWithSize:(CGFloat)size {
    return fontWithNameAndSize(kDefaultBoldFontName, size);
}

@end


#pragma mark - DaylightStyleSheet
///
/// DaylightStyleSheet
/// ------------------
@interface DaylightStyleSheet : CommonStyleSheetBase
@end

@implementation DaylightStyleSheet

- (void) initStyles:(NSMutableDictionary *)styles {
    [super initStyles:styles];
    
    UIApplication *applicationStyle = style(UIApplication.self);
    [applicationStyle setStatusBarStyle:UIStatusBarStyleDefault];
    styles[kApplicationStyle] = applicationStyle;
    
    UIView *mainContainerStyle = style(UIView.self);
    [mainContainerStyle setBackgroundColor:RGBColor(250, 250, 250)];
    styles[kMainContainerStyle] = mainContainerStyle;
    
    UIToolbar *toolbarStyle = style(UIToolbar.self);
    [toolbarStyle setBarTintColor:RGBColor(255, 219, 190)];
    styles[kToolbarStyle] = toolbarStyle;
    
    UISegmentedControl *styleSwitchStyle = style(UISegmentedControl.self);
    [styleSwitchStyle setTintColor:RGBColor(105, 167, 150)];
    styles[kStyleSwitchStyle] = styleSwitchStyle;
    
    UILabel *mainTitleStyle = style(UILabel.self);
    [mainTitleStyle setTextColor:UIColor.darkTextColor];
    [mainTitleStyle setFont:[self lightFontWithSize:24]];
    [mainTitleStyle setText:@"Daylight mode title"];
    styles[kMainTitleStyle] = mainTitleStyle;
    
    UIImageView *logoImageStyle = style(UIImageView.self);
    [logoImageStyle setBackgroundColor:UIColor.whiteColor];
    [logoImageStyle setTintColor:UIColor.blackColor];
    styles[kLogoImageStyle] = logoImageStyle;
    
    UIView *inputContainerStyle = style(UIView.self);
    [inputContainerStyle setBackgroundColor:RGBColor(230, 230, 230)];
    styles[kInputContainerStyle] = inputContainerStyle;
    
    UILabel *inputLabelStyle = style(UILabel.self);
    [inputLabelStyle setTextColor:RGBColor(160, 160, 160)];
    [inputLabelStyle setFont:[self lightFontWithSize:12]];
    styles[kInputLabelStyle] = inputLabelStyle;
    
    UIView *inputFieldContainerStyle = style(UIView.self);
    [inputFieldContainerStyle setBackgroundColor:UIColor.whiteColor];
    styles[kInputFieldContainerStyle] = inputFieldContainerStyle;
    
    UITextField *inputFieldStyle = style(UITextField.self);
    [inputFieldStyle setTextColor:UIColor.darkTextColor];
    [inputFieldStyle setFont:[self lightFontWithSize:21]];
    styles[kInputFieldStyle] = inputFieldStyle;
    
    UIButton *mainButtonStyle = style(UIButton.self);
    [mainButtonStyle setBackgroundColor:RGBColor(134, 221, 196)];
    [mainButtonStyle setTitleColor:UIColor.darkTextColor forState:UIControlStateNormal];
    styles[kMainButtonStyle] = mainButtonStyle;

    UILabel *mainButtonTitleStyle = style(UILabel.self);
    [mainButtonTitleStyle setTextColor:[UIColor colorWithWhite:0.3 alpha:0.5]];
    [mainButtonTitleStyle setFont:[self lightFontWithSize:24]];
    styles[kMainButtonTitleStyle] = mainButtonTitleStyle;
}

@end


#pragma mark - NightmodeStyleSheet
///
/// NightmodeStyleSheet
/// -------------------
@interface NightmodeStyleSheet : CommonStyleSheetBase
@end

@implementation NightmodeStyleSheet

- (void) initStyles:(NSMutableDictionary *)styles {
    [super initStyles:styles];

    UIApplication *applicationStyle = style(UIApplication.self);
    [applicationStyle setStatusBarStyle:UIStatusBarStyleLightContent];
    styles[kApplicationStyle] = applicationStyle;
    
    UIView *mainContainerStyle = style(UIView.self);
    [mainContainerStyle setBackgroundColor:RGBColor(44, 44, 44)];
    styles[kMainContainerStyle] = mainContainerStyle;

    UIToolbar *toolbarStyle = style(UIToolbar.self);
    [toolbarStyle setBarTintColor:RGBColor(6, 1, 25)];
    styles[kToolbarStyle] = toolbarStyle;
    
    UISegmentedControl *styleSwitchStyle = style(UISegmentedControl.self);
    [styleSwitchStyle setTintColor:RGBColor(13, 67, 88)];
    styles[kStyleSwitchStyle] = styleSwitchStyle;
    
    UILabel *mainTitleStyle = style(UILabel.self);
    [mainTitleStyle setTextColor:UIColor.lightTextColor];
    [mainTitleStyle setFont:[self boldFontWithSize:24]];
    [mainTitleStyle setText:@"Night mode title"];
    styles[kMainTitleStyle] = mainTitleStyle;
    
    UIImageView *logoImageStyle = style(UIImageView.self);
    [logoImageStyle setBackgroundColor:RGBColor(128, 64, 0)];
    [logoImageStyle setTintColor:RGBColor(250, 250, 250)];
    styles[kLogoImageStyle] = logoImageStyle;
    
    UIView *inputContainerStyle = style(UIView.self);
    [inputContainerStyle setBackgroundColor:RGBColor(66, 66, 66)];
    styles[kInputContainerStyle] = inputContainerStyle;

    UILabel *inputLabelStyle = style(UILabel.self);
    [inputLabelStyle setTextColor:RGBColor(140, 140, 140)];
    [inputLabelStyle setFont:[self regularFontWithSize:12]];
    styles[kInputLabelStyle] = inputLabelStyle;
    
    UIView *inputFieldContainerStyle = style(UIView.self);
    [inputFieldContainerStyle setBackgroundColor:RGBColor(51, 51, 51)];
    styles[kInputFieldContainerStyle] = inputFieldContainerStyle;
    
    UITextField *inputFieldStyle = style(UITextField.self);
    [inputFieldStyle setTextColor:UIColor.lightTextColor];
    [inputFieldStyle setFont:[self regularFontWithSize:21]];
    styles[kInputFieldStyle] = inputFieldStyle;
    
    UIButton *mainButtonStyle = style(UIButton.self);
    [mainButtonStyle setTitleColor:UIColor.lightTextColor forState:UIControlStateNormal];
    [mainButtonStyle setBackgroundColor:RGBColor(13, 67, 88)];
    styles[kMainButtonStyle] = mainButtonStyle;
    
    UILabel *mainButtonTitleStyle = style(UILabel.self);
    [mainButtonTitleStyle setTextColor:[UIColor colorWithWhite:0.6 alpha:0.5]];
    [mainButtonTitleStyle setFont:[self boldFontWithSize:24]];
    styles[kMainButtonTitleStyle] = mainButtonTitleStyle;
}

@end


#pragma mark - _DefaultStyleSheetInitializer
///
/// _DefaultStyleSheetInitializer
/// -----------------------------
@interface _DefaultStyleSheetInitializer : NSObject

@end

@implementation _DefaultStyleSheetInitializer

+ (void) load {
    [AMUIStyleSheet registerStyleSheet:[DaylightStyleSheet new] withKey:kDefaultStyleSheetKey];
}

@end


NSString *const daylightStyleSheetKey(void) {
    return DaylightStyleSheet.styleSheetRegistrationKey;
}

NSString *const nightmodeStyleSheetKey(void) {
    return NightmodeStyleSheet.styleSheetRegistrationKey;
}
