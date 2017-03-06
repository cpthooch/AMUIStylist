//
//  AMUIStyleSheetSpec.m
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "AMUIStyleSheet.h"
#import "AMUIStyle.h"


@interface AMUIStyleSheetSpecStyleSheet : AMUIStyleSheet
+ (id) fancyStyle;
+ (id) swagStyle;
@end

@implementation AMUIStyleSheetSpecStyleSheet {
	NSDictionary *_styles;
}

+ (id) fancyStyle {
	static id __fancyStyle;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		__fancyStyle = style(UIButton.self);
	});
	return __fancyStyle;
}

+ (id) swagStyle {
	static id __swagStyle;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		__swagStyle = style(UILabel.self);
	});
	return __swagStyle;
}

- (NSDictionary *) styles {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSMutableDictionary *styles = NSMutableDictionary.dictionary;
		styles[@"fancy_btn"] = AMUIStyleSheetSpecStyleSheet.fancyStyle;
		styles[@"swag_lbl"] = AMUIStyleSheetSpecStyleSheet.swagStyle;
		_styles = styles.copy;
	});
	return _styles;
}

@end


SpecBegin(AMUIStyleSheet)

describe(@"AMUIStyleSheet", ^{
	
	__block AMUIStyleSheet *styleSheet;
	
	it(@"default style sheet should exist", ^{
		expect([AMUIStyleSheet defaultStyleSheet]).toNot.beNil();
	});

	context(@"stub style sheet", ^{
		beforeEach(^{
			styleSheet = [AMUIStyleSheet getSheet:@"stylesheetspec"];
		});
		
		it(@"should exist", ^{
			expect(styleSheet).toNot.beNil();
		});
		
		it(@"should contain 'fancy btn' style", ^{
			expect(styleSheet[@"fancy_btn"]).to.equal(@[AMUIStyleSheetSpecStyleSheet.fancyStyle]);
		});
		
		it(@"should contain 'swag lbl' style", ^{
			expect([styleSheet getStyle:@"swag_lbl"]).to.equal(@[AMUIStyleSheetSpecStyleSheet.swagStyle]);
		});
	});
	
	afterEach(^{
		styleSheet = nil;
	});
});

SpecEnd
