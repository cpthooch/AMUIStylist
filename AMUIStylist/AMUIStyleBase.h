//
//  AMUIStyleBase.h
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMUIStyleBase : NSProxy

- (instancetype) init;
- (void) applyTo:(id)client;

@end
