//
//  AMWeakProxy.h
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMWeakProxy : NSProxy <NSCopying>

/// Initializes an `AMWeakProxy` object with the specified target object.
/// \param object The target object to be proxied.
/// \return The newly initialized proxy.
///
- (instancetype)initWithObject:(id)object;

@property (nonatomic, readonly) BOOL isDisposed;

- (BOOL) isEqual:(id)object;
- (BOOL) isEqualToWeakProxy:(AMWeakProxy *)proxy;

- (NSUInteger) hash;

@end
