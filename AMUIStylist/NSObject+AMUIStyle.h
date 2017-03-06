//
//  NSObject+AMUIStyle.h
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMUIStylist;

@interface NSObject (AMUIStyle)

/// Coma separated list of styles, e.g.:
/// \code
///	view.am_style = @"fancy";
///	view.am_style = @"fancy, swag";
/// \endcode
///
@property (nonatomic, getter=am_getStyle, setter=am_setStyle:) NSString *am_style;

/// Appends style so \a am_style property returns \code prev_style + ', style' \endcode
/// \note It's possible that several identical styles appear in object's \a am_style.
/// The latest has precedence, and may redefine previously set attributes.
///
- (void) am_addStyle:(NSString *)style;

/// Removes specified style from object's \a am_style. If \a am_style contains several
/// inclusions of specified style it removes all of them.
///
- (void) am_removeStyle:(NSString *)style;

/// Applies instance styles.
///
- (void) am_applyStyle;

/// Handy AMUIStylist instance accessor.
///
@property (nonatomic, readonly) AMUIStylist *am_stylist;

@end
