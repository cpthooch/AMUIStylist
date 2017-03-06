//
//  AMUIStylistSpec.m
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "AMUIStylist.h"
#import "AMUIStyleSheet.h"
#import "AMUIStyle.h"
#import "UIView+AMUIStyle.h"


@interface AMUIStylistSpecStyleSheet : AMUIStyleSheet
- (void) setStyles:(NSDictionary *)styles;
@end

@implementation AMUIStylistSpecStyleSheet {
	NSDictionary *_styles;
}

- (instancetype) init {
	self = [super init];
	if (self) {
	}
	return self;
}

- (NSDictionary *) styles {
	return _styles;
}

- (void) setStyles:(NSDictionary *)styles {
	_styles = styles;
}

@end


SpecBegin(AMUIStylist)

describe(@"AMUIStylist", ^{
	
	__block AMUIStylist *stylist;
	
	context(@"sharedStylist", ^{
		beforeEach(^{
			stylist = [AMUIStylist sharedStylist];
		});
		
		it(@"returns object instance", ^{
			expect(stylist).toNot.beNil();
		});
		
		it(@"initially uses default style sheet", ^{
			expect(stylist.styleSheet).to.beIdenticalTo(AMUIStyleSheet.defaultStyleSheet);
		});
	});
	
	context(@"makeUp", ^{
		
		__block AMUIStyle *style;
		__block UIView *view;
		
		beforeEach(^{
			style = mock(AMUIStyle.self);
			id styleSheet = [AMUIStyleSheet getSheet:@"stylistspec"];
			[styleSheet setStyles: @{ @"fancy": style }];
			stylist = [AMUIStylist new];
			stylist.styleSheet = styleSheet;
			view = mock(UIView.self);
			[given([view am_getStyle]) willReturn:@"fancy"];
		});
		
		it(@"should call applyTo method of view style", ^{
			[stylist makeUp:view];
			[MKTVerify(style) applyTo:view];
		});
		
		afterEach(^{
			style = nil;
			view = nil;
		});
	});
	
	context(@"monitor", ^{
		
		__block UIView *view;
		
		beforeEach(^{
			stylist = [AMUIStylist new];
			view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
		});
		
		it(@"should add view to clients list", ^{
			[stylist monitor:view];
			id entry = Underscore.find(stylist.clients, ^BOOL(id item){
				return [item isEqual:view];
			});
			expect(entry).toNot.beNil();
		});
		
		afterEach(^{
			view = nil;
		});
	});
	
	context(@"kick", ^{
		
		__block UIView *view;
		
		beforeEach(^{
			view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
			stylist = [AMUIStylist new];
			[stylist monitor:view];
		});
		
		it(@"should remove view from clients list", ^{
			[stylist kick:view];
			id entry = Underscore.find(stylist.clients, ^BOOL(id item){
				return [item isEqual:view];
			});
			expect(entry).to.beNil();
		});
		
		afterEach(^{
			view = nil;
		});
	});
	
	context(@"setStyleSheet", ^{
		
		__block id styleSheet;
		__block AMUIStyle *style;
		__block UIView *view;
		
		beforeEach(^{
			stylist = [AMUIStylist new];
			style = mock(AMUIStyle.self);
			styleSheet = [AMUIStyleSheet getSheet:@"stylistspec"];
			[styleSheet setStyles: @{ @"fancy": style }];
			view = mock(UIView.self);
			[given([view am_getStyle]) willReturn:@"fancy"];
			[stylist monitor:view];
		});
		
		it(@"should call applyTo method of new style on monitored view", ^{
			[stylist setStyleSheet:styleSheet];
			[MKTVerify(style) applyTo:view];
		});
		
		afterEach(^{
			style = nil;
			view = nil;
		});
	});
	
	afterEach(^{
		stylist = nil;
	});
});

SpecEnd
