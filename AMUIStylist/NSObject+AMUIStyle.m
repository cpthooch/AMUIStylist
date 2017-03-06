//
//  NSObject+AMUIStyle.m
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "NSObject+AMUIStyle.h"
#import "AMUIStylist.h"

@implementation NSObject (AMUIStyle)

- (AMUIStylist *) am_stylist {
	return AMUIStylist.sharedStylist;
}

/// \note Required for property to be KVC-compliant
- (NSString *) getAm_style {
	NSArray *styles = [self _am_getStyleArray];
	return [self _am_joinStyles:styles];
}

/// \note Required for property to be KVC-compliant
- (void) setAm_style:(NSString *)style {
	NSArray *styles = [self _am_splitStyles:style];
	[self _am_setStyleArray:styles];
}

- (NSString *) am_getStyle {
	return [self getAm_style];
}

- (void) am_setStyle:(NSString *)style {
	[self setAm_style:style];
}

- (void) am_addStyle:(NSString *)style {
	if (style.length) {
		NSArray *styles = [self _am_getStyleArray] ?: @[];
		styles = [styles arrayByAddingObjectsFromArray:[self _am_splitStyles:style]];
		[self _am_setStyleArray:styles];
	}
}

- (void) am_removeStyle:(NSString *)style {
	NSArray *styles = [self _am_getStyleArray];
	if (!style.length || !styles.count) return;
	
	NSSet *toBeRemoved = [NSSet setWithArray:[self _am_splitStyles:style]];
	styles = Underscore.reject(styles, ^BOOL(NSString *item){
		return [toBeRemoved containsObject:item];
	});
	[self _am_setStyleArray:styles];
}


- (void) am_applyStyle {
	[self.am_stylist makeUp:self];
}


- (NSArray *) _am_splitStyles:(NSString *)style {
	NSArray *styles = nil;
	if (style.length) {
		styles = Underscore.arrayMap([style componentsSeparatedByString:@","], ^id(NSString *item){
			return [item stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
		});
	}
	return styles;
}

- (NSString *) _am_joinStyles:(NSArray *)styles {
	return styles.count ? [styles componentsJoinedByString:@", "] : nil;
}

- (NSArray *) _am_getStyleArray {
	return objc_getAssociatedObject(self, @selector(am_getStyle));
}

- (void) _am_setStyleArray:(NSArray *)styles {
	BOOL unmodified = (!styles && !self._am_getStyleArray) || [styles isEqualToArray:self._am_getStyleArray];
	
	NSArray *ivar = styles.count ? styles : nil;
	objc_setAssociatedObject(self, @selector(am_getStyle), ivar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	if (ivar) {
		[self.am_stylist monitor:self];
	}
	else {
		[self.am_stylist kick:self];
	}
	
	if (!unmodified) {
		[self am_applyStyle];
	}
}

@end
