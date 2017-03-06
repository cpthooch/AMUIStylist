//
//  UIView+AMUIStyle.m
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "UIView+AMUIStyle.h"
#import "NSObject+AMUIStyle.h"
#import "AMUIStylist.h"
#import <JRSwizzle/JRSwizzle.h>

@implementation UIView (AMUIStyle)

+ (void) load {
	NSError * __autoreleasing error = nil;
	if (![UIView jr_swizzleMethod:@selector(willMoveToWindow:) withMethod:@selector(__am02365_willMoveToWindow:) error:&error]) {
		NSLog(@"%s ERROR swizling UIView method: %@", __PRETTY_FUNCTION__, error);
	}
}

- (void) __am02365_willMoveToWindow:(UIWindow *)newWindow {
	if (newWindow && self.am_style) {
		[self.am_stylist makeUp:self];
	}
	[self __am02365_willMoveToWindow:newWindow];
}

- (void) am_applyStyle {
	if (self.window) {
		[super am_applyStyle];
	}
}

- (void) am_forcedApplyStyle:(BOOL)recursive {
    [super am_applyStyle];
    if (recursive) {
        for (UIView *sub in self.subviews) {
            [sub am_forcedApplyStyle:recursive];
        }
    }
}


@end
