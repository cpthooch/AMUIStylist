//
//  AMUIStylist.h
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMUIStyleSheet;

@interface AMUIStylist : NSObject

@property (nonatomic, strong) AMUIStyleSheet *styleSheet;

+ (instancetype) sharedStylist;

/// Applies current style of specified client according to current style sheet.
///
- (void) makeUp:(id)client;

/// Adds specified client to monitoring to reaply its style in case of style sheet
/// switching.
///
- (void) monitor:(id)client;

/// Removes specified client from tracking.
/// \see monitor:
///
- (void) kick:(id)client;

/// List of ACWeakProxy-s of currently tracked clients.
/// \see ACWeakProxy
/// \see monitor:
///
@property (nonatomic, readonly) NSArray *clients;

@end
