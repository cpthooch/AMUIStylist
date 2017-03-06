//
//  AMUIStyle.h
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "AMUIStyleBase.h"

@interface AMUIStyle : AMUIStyleBase

@property (nonatomic, readonly) NSArray *baseStyles;

- (instancetype) initWithClass:(Class)aClass;

- (void) inherit:(AMUIStyle *)baseStyle;
- (void) applyTo:(id)client;

@end


FOUNDATION_EXPORT id am_style(Class targetClass);

/// \param first argument is of \a Class type.
/// \param rest arguments - list of base styles to be inherited.
#define style(...) \
	metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__))(STYLE0(__VA_ARGS__))(STYLE1(__VA_ARGS__))

#define STYLE0(CLASS) am_style(CLASS)

#define STYLE1(CLASS, BASES...) \
	({ \
		AMUIStyle *s = am_style(CLASS); \
		STYLE_INHERIT_ALL(s, BASES); \
		(id)s; \
	})

#define STYLE_INHERIT_ALL(STYLE, ...) \
	metamacro_foreach_cxt(STYLE_INHERIT,, STYLE, __VA_ARGS__) \

#define STYLE_INHERIT(INDEX, STYLE, BASE) \
	[STYLE inherit:((id)BASE)];
