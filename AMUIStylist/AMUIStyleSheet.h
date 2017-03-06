//
//  AMUIStyleSheet.h
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN NSString *const kDefaultStyleSheetKey;

/// This class also supports custom subscripting, e.g.:
/// \code
///	AMUIStyleSheet *styleSheet = AMUIStyleSheet.defaultStyleSheet;
///	AMUIStyle *awesomeBtnStyle = styleSheet[@"awesome_btn"];
///	\endcode
///
/// It also uses introspection at the moment of class initialisation to
/// find and automatically register all AMUIStyleSheet subclasses except
/// those, whos effective name starts with double underscore '__'. They
/// are treated hidden, e.g.:
/// AMUI__HiddenStyleSheet or __HiddenStyleSheet or just __Hidden.
///
@interface AMUIStyleSheet : NSObject

@property (nonatomic, readonly) NSDictionary *styles;

/// Style sheet registration key, computed based on class name.
+ (NSString *) styleSheetRegistrationKey;
/// External registration of style sheet.
+ (void) registerStyleSheet:(AMUIStyleSheet *)styleSheet withKey:(NSString *)key;

/// Array of all registered style sheets
+ (NSArray *) allSheets;
+ (AMUIStyleSheet *) defaultStyleSheet;
+ (nullable AMUIStyleSheet *) getSheet:(NSString *)sheetName;

- (NSArray *) getStyle:(NSString *)styleKey;
- (NSArray *) objectForKeyedSubscript:(NSString *)styleKey;

@end

NS_ASSUME_NONNULL_END
