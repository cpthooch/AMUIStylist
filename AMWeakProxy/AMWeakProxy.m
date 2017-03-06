//
//  AMWeakProxy.m
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "AMWeakProxy.h"

@interface AMWeakProxy ()
@property (nonatomic, weak) id target;
@end

@implementation AMWeakProxy

- (instancetype)initWithObject:(id)object {
    self.target = object;
    return self;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature;
    __strong id _self = self.target;
    if (_self) {
        methodSignature = [_self methodSignatureForSelector:aSelector];
    } else {
        // If obj is nil, we need to synthesize a smallest signature (self, _cmd).
        NSString *types = [NSString stringWithFormat:@"%s%s", @encode(id), @encode(SEL)];
        methodSignature = [NSMethodSignature signatureWithObjCTypes:[types UTF8String]];
    }
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.target];
}

- (BOOL) isDisposed {
    return self.target == nil;
}

- (BOOL) isEqual:(id)object {
    BOOL sameClass = object && [object class] == [self class];
    return sameClass ? [self isEqualToWeakProxy:object] : [self isEqualToProxiedObject:object];
}

- (BOOL) isEqualToWeakProxy:(AMWeakProxy *)proxy {
    id _self = self.target;
    id _other = proxy.target;
    return _other && _self && _self == _other;
}

- (BOOL) isEqualToProxiedObject:(id)object {
    id _self = self.target;
    return object && _self && _self == object;
}

- (NSUInteger) hash {
    id _self = self.target;
    return _self ? [_self hash] : 0;
}

- (instancetype) copyWithZone:(NSZone *)zone {
    AMWeakProxy *copy = [[self.class alloc] initWithObject:self.target];
    return copy;
}

@end
