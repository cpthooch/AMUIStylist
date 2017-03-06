//
//  AMUIStyleBase.m
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "AMUIStyleBase.h"


@interface AMInvocationCollection : NSObject
@property (nonatomic, copy, readonly) NSArray *recordedInvocations;
- (void) recordInvocation:(NSInvocation *)invocation;
@end

@implementation AMInvocationCollection {
	NSMutableArray *_mutableRecordedInvocations;
}

- (instancetype) init {
	self = [super init];
	if (self) {
		_mutableRecordedInvocations = NSMutableArray.array;
	}
	return self;
}

- (NSArray *) recordedInvocations {
	return _mutableRecordedInvocations;
}

- (void) recordInvocation:(NSInvocation *)invocation {
	if (!invocation.argumentsRetained) {
		[invocation retainArguments];
	}
	invocation.target = nil;
	[_mutableRecordedInvocations addObject:invocation];
}

@end


@interface AMUIStyleBase ()
@property (nonatomic, strong) AMInvocationCollection *invocationCollection;
@end

@implementation AMUIStyleBase

- (instancetype) init {
	if (self) {
		self.invocationCollection = AMInvocationCollection.new;
	}
	return self;
}

- (void) applyTo:(id)client {
    [self.invocationCollection.recordedInvocations
     enumerateObjectsUsingBlock:^(NSInvocation *_Nonnull invocation, NSUInteger idx, BOOL *_Nonnull stop) {
         [invocation invokeWithTarget:client];
     }];
}

- (void) forwardInvocation:(NSInvocation *)invocation {
	[self recordInvocation:invocation];
}

- (void) recordInvocation:(NSInvocation *)invocation {
	[self.invocationCollection recordInvocation:invocation];
}

@end
