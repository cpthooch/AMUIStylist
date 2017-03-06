//
//  UIView_AMUIStyleSpec.m
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "UIView+AMUIStyle.h"
#import "AMUIStylist.h"


@interface UIView_AMUIStyleStub : UIView
- (instancetype) initWithStylist:(AMUIStylist *)stylist;
@end

@implementation UIView_AMUIStyleStub {
	AMUIStylist *_stylist;
}

- (instancetype) initWithStylist:(AMUIStylist *)stylist {
	self = [self initWithFrame:CGRectMake(0, 0, 1, 1)];
	if (self) {
		_stylist = stylist;
	}
	return self;
}

- (AMUIStylist *) am_stylist {
	return _stylist;
}

@end


SpecBegin(UIView_AMUIStyle)

describe(@"UIView AMUIStyle", ^{

	__block UIView *view;
	
	beforeEach(^{
		view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
	});
	
	it(@"should not have any style set by default", ^{
		expect(view.am_style).to.beNil();
	});
	
	it(@"should store specified style", ^{
		view.am_style = @"fancy";
		expect(view.am_style).to.equal(@"fancy");
	});
	
	it(@"should be able to store more than one style", ^{
		view.am_style = @"fancy, swag";
		expect(view.am_style).to.equal(@"fancy, swag");
	});
	
	it(@"should be able to add a style", ^{
		view.am_style = @"fancy";
		[view am_addStyle:@"swag"];
		expect(view.am_style).to.equal(@"fancy, swag");
	});
	
	it(@"should be able to add several styles at heat", ^{
		view.am_style = @"fancy";
		[view am_addStyle:@"swag, punk"];
		expect(view.am_style).to.equal(@"fancy, swag, punk");
	});
	
	it(@"should be able to add style which is already there", ^{
		view.am_style = @"fancy, swag";
		[view am_addStyle:@"fancy"];
		expect(view.am_style).to.equal(@"fancy, swag, fancy");
	});
	
	it(@"should remove all entries of specified style", ^{
		view.am_style = @"fancy, swag, fancy";
		[view am_removeStyle:@"fancy"];
		expect(view.am_style).to.equal(@"swag");
	});
	
	it(@"should be able to remove several styles at heat", ^{
		view.am_style = @"fancy, swag, punk";
		[view am_removeStyle:@"fancy, punk"];
		expect(view.am_style).to.equal(@"swag");
	});

	it(@"should be no style if last entry removed", ^{
		view.am_style = @"swag";
		[view am_removeStyle:@"swag"];
		expect(view.am_style).to.beNil();
	});
	
	afterEach(^{
		view = nil;
	});
});

describe(@"UIView AMUIStyle", ^{
	
	__block UIView *view;
	__block id stylist;
	
	beforeEach(^{
		stylist = mock(AMUIStylist.self);
		view = [[UIView_AMUIStyleStub alloc] initWithStylist:stylist];
	});
	
	it(@"calls AMUIStylist monitor method when style set", ^{
		view.am_style = @"fancy";
		[MKTVerify(stylist) monitor:view];
	});
	
	it(@"calls AMUIStylist kick method when style removed", ^{
		view.am_style = @"fancy";
		view.am_style = nil;
		[MKTVerify(stylist) kick:view];
	});
	
	afterEach(^{
		view = nil;
		stylist = nil;
	});
});

SpecEnd
