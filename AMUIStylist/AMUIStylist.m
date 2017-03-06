//
//  AMUIStylist.m
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "AMUIStylist.h"
#import "AMUIStyleSheet.h"
#import "AMUIStyle.h"
#import "NSObject+AMUIStyle.h"
#import "AMWeakProxy.h"

static AMUIStylist *__sharedStylist;

@interface AMUIStylist ()
@end

@implementation AMUIStylist {
	NSMutableArray *_clients;
}

+ (void) initialize {
    if (!__sharedStylist) {
        // init will also assign __sharedStylist; this redundant assignment is for static analyzer happiness
        __sharedStylist = [[self alloc] init];
    }
}

+ (instancetype) sharedStylist {
	return __sharedStylist;
}

+ (instancetype) alloc {
    return __sharedStylist ?: [super alloc];
}

- (instancetype) init {
    @synchronized (self.class) {
        if (!__sharedStylist) {
            self = [super init];
            if (self) {
                _styleSheet = AMUIStyleSheet.defaultStyleSheet;
                _clients = [NSMutableArray array];
            }
            __sharedStylist = self;
        }
        // in multithreaded environment several alloc-s may have created several instances up to the moment; taking first
        self = __sharedStylist;
    }
	return self;
}

- (void) setStyleSheet:(AMUIStyleSheet *)styleSheet {
	if (_styleSheet != styleSheet) {
		_styleSheet = styleSheet;
	}
	[self _gc];
	Underscore.arrayEach(_clients, ^(id item){
		[self makeUp:item];
	});
}

- (void) makeUp:(id)client {
	if (![client respondsToSelector:@selector(am_getStyle)])
		return;

	NSArray *styles = self.styleSheet[[client am_getStyle]];
	Underscore.arrayEach(styles, ^(AMUIStyle *style){
		[style applyTo:client];
	});
	if ([client isKindOfClass:UIView.self]) {
		[client setNeedsDisplay];
        [client setNeedsLayout];
	}
}

- (void) monitor:(id)client {
	if (client) {
		[_clients addObject:[AMWeakProxy.alloc initWithObject:client]];
	}
}

- (void) kick:(id)client {
	if (client) {
		NSArray *filtered = Underscore.reject(_clients, ^BOOL(id item){
			return [item isEqual:client];
		});
		if (filtered.count != _clients.count) {
			_clients = [filtered mutableCopy];
		}
	}
}

- (NSArray *) clients {
	return _clients.copy;
}

- (void) _gc {
	NSArray *filtered = Underscore.reject(_clients, ^BOOL(AMWeakProxy *item){
		return item.isDisposed;
	});
	if (filtered.count != _clients.count) {
		_clients = [filtered mutableCopy];
	}
}

@end
