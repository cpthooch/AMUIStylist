//
//  AMUIStyle.m
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "AMUIStyle.h"


@interface AMUIStyle ()
@property (nonatomic, strong, readonly) Class styledClass;
@end


@implementation AMUIStyle {
	NSMutableArray *_baseStyles;
}

- (NSArray *) baseStyles {
	return _baseStyles.copy;
}

- (instancetype) initWithClass:(Class)aClass {
	self = [super init];
	if (self) {
		_styledClass = aClass;
		_baseStyles = [NSMutableArray array];
	}
	return self;
}

/// \todo Should allow to inherit any style, i.e. remove styledClass compliance check.
///		  Thus it's possible to group different styles for specific target classes under
///		  single logical style.
///
- (void) inherit:(AMUIStyle *)baseStyle {
	BOOL notYetInherited = baseStyle && [self.baseStyles indexOfObjectIdenticalTo:baseStyle] == NSNotFound;
	if (notYetInherited && [self.styledClass isSubclassOfClass:baseStyle.styledClass]) {
		[_baseStyles addObject:baseStyle];
	}
}

- (void) applyTo:(id)client {
	if (client && ([client isKindOfClass:_styledClass] || ([_styledClass conformsToProtocol:@protocol(UIAppearance)] && [client isKindOfClass:UIView.appearance.class]))) {
		Underscore.array(self.baseStyles).each(^(AMUIStyle *baseStyle) {
			[baseStyle applyTo:client];
		});
		[super applyTo:client];
	}
}

- (NSString *) description {
	return [[@"AMUIStyle<" stringByAppendingString:NSStringFromClass(self.styledClass)] stringByAppendingString:@">"];
}

- (NSMethodSignature *) methodSignatureForSelector:(SEL)aSelector {
	return [self.styledClass instanceMethodSignatureForSelector:aSelector];
}


#pragma mark NSObject protocol

- (BOOL) isKindOfClass:(Class)aClass {
	return [self.styledClass isSubclassOfClass:aClass];
}

- (BOOL) respondsToSelector:(SEL)aSelector {
	return [self.styledClass instancesRespondToSelector:aSelector];
}

@end


id am_style(Class targetClass) {
	return [[AMUIStyle alloc] initWithClass:targetClass];
}
