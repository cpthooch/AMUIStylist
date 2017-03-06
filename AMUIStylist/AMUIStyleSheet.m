//
//  AMUIStyleSheet.m
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "AMUIStyleSheet.h"
#import "AMUIStyle.h"

NSString *const kDefaultStyleSheetKey = @"default";

static NSSet *_getSubclassesOfClass(Class parentClass) {
    int numClasses = objc_getClassList(NULL, 0);
    __unsafe_unretained Class *classes = NULL;
    
    classes = (__unsafe_unretained Class *) malloc(sizeof(Class) * numClasses);
    numClasses = objc_getClassList(classes, numClasses);
    
    NSMutableSet *result = [NSMutableSet set];
    for (NSInteger i = 0; i < numClasses; i++) {
        Class superClass = classes[i];
        do {
            superClass = class_getSuperclass(superClass);
        } while(superClass && superClass != parentClass);
        
        if (superClass != nil) {
            [result addObject:classes[i]];
        }
    }
    
    free(classes);
    return result;
}

@implementation AMUIStyleSheet

+ (NSMutableDictionary *) _sheets {
	static NSMutableDictionary *__sheets;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		__sheets = [NSMutableDictionary dictionary];
	});
	return __sheets;
}

+ (void) _registerSheets {
    NSSet *styleSheetClassSet = _getSubclassesOfClass(self);
	[styleSheetClassSet enumerateObjectsUsingBlock:^(Class _Nonnull sheetClass, BOOL * _Nonnull stop) {
		[self _registerSheetClass:sheetClass];
	}];
}

+ (void) _registerSheetClass:(const Class _Nonnull)sheetClass {
	NSString *sheetName = [sheetClass styleSheetRegistrationKey];
    // style sheet classes with double underscore before essential name are treated as hidden
	if (sheetName.length && ![sheetName hasPrefix:@"__"]) {
        [self registerStyleSheet:[[sheetClass alloc] init] withKey:sheetName];
	}
}

+ (void) initialize {
	if (self == AMUIStyleSheet.self) {
		[self _registerSheets];
	}
}

+ (NSString *) styleSheetRegistrationKey {
    NSString *sheetClassName = NSStringFromClass(self);
    NSString *sheetName = sheetClassName;
    if ([sheetName hasPrefix:@"AMUI"]) {
        sheetName = [sheetName substringFromIndex:@"AMUI".length];
    }
    if ([sheetName hasSuffix:@"StyleSheet"]) {
        sheetName = [sheetName substringToIndex:sheetName.length - @"StyleSheet".length];
    }
    return sheetName.lowercaseString;
}

+ (void) registerStyleSheet:(AMUIStyleSheet * _Nonnull)styleSheet withKey:(NSString * _Nonnull)key {
    self._sheets[key] = styleSheet;
}

+ (NSArray *) allSheets {
	return self._sheets.allKeys ?: @[];
}

+ (instancetype) getSheet:(NSString *)sheetName {
	return self._sheets[sheetName];
}

+ (instancetype) defaultStyleSheet {
    return [self getSheet:kDefaultStyleSheetKey];
    //[self getSheet:UIApplication.isIPad ? @"defaultpad" : @"defaultphone"];
}

- (NSDictionary *) styles {
	return @{};
}

- (NSArray *) getStyle:(NSString *)styleKey {
	NSArray *styleTags = Underscore.arrayMap([styleKey componentsSeparatedByString:@","], ^id(NSString *item){
		return [item stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
	});
	NSArray *styles = Underscore.reject([self.styles objectsForKeys:styleTags notFoundMarker:NSNull.null], ^BOOL(id style){
		return style == NSNull.null;
	});
	return styles;
}

- (NSArray *) objectForKeyedSubscript:(NSString *)styleKey {
	return [self getStyle:styleKey];
}

@end

