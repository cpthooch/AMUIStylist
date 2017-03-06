//
//  AMUIStyleSpec.m
//
//  Copyright © 2015 Aleksandr Malkov.
//  All rights reserved.
//

#import "AMUIStyle.h"

SpecBegin(AMUIStyle)

describe(@"AMUIStyle", ^{
	
	__block id style;
	
	context(@"", ^{
		beforeEach(^{
			style = [[AMUIStyle alloc] initWithClass:UIButton.class];
		});
		
		it(@"exist", ^{
			expect(style).toNot.beNil();
		});
		
		it(@"responds to setTitleColor: forState: UIButton message", ^{
			void (^block)() = ^{
				[style setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
			};
			expect(block).toNot.raiseAny();
		});
		
		it(@"applies title to UIButton selected state", ^{
			UIButton *button = mock(UIButton.class);
			[style setTitle:@"foo bar" forState:UIControlStateSelected];
			[style applyTo:button];
			[MKTVerify(button) setTitle:@"foo bar" forState:UIControlStateSelected];
		});
		
		it(@"applies color to UIButton disabled state", ^{
			UIButton *button = mock(UIButton.class);
			[style setTitleColor:UIColor.magentaColor forState:UIControlStateDisabled];
			[style applyTo:button];
			[MKTVerify(button) setTitleColor:UIColor.magentaColor forState:UIControlStateDisabled];
		});
	});

	
	context(@"", ^{
		beforeEach(^{
			style = [[AMUIStyle alloc] initWithClass:UILabel.class];
		});
		
		it(@"applies bold system font of size 42 to UILabel", ^{
			UILabel *label = mock(UILabel.class);
			[style setFont:[UIFont boldSystemFontOfSize:42]];
			[style applyTo:label];
			[MKTVerify(label) setFont:[UIFont boldSystemFontOfSize:42]];
		});
		
		it(@"should not apply UILabel style to UIButton object", ^{
			UIButton *button = mock(UIButton.class);
			[style setTextAlignment:NSTextAlignmentRight];
			expect(^{ [style applyTo:button]; }).toNot.raiseAny();
		});

		it(@"applies italic system font of size 12 AND yellow text color to UILabel", ^{
			UILabel *label = mock(UILabel.class);
			[style setFont:[UIFont italicSystemFontOfSize:12]];
			[style setTextColor:UIColor.yellowColor];
			[style applyTo:label];
			[MKTVerify(label) setFont:[UIFont italicSystemFontOfSize:12]];
			[MKTVerify(label) setTextColor:UIColor.yellowColor];
		});
	});
	
	
	context(@"", ^{
		__block id childStyle;
		
		beforeEach(^{
			childStyle = [AMUIStyle.alloc initWithClass:UIButton.class];
			[childStyle setTitleColor:UIColor.purpleColor forState:UIControlStateHighlighted];
			
			style = [[AMUIStyle alloc] initWithClass:UITextField.class];
			[style inherit:childStyle];
		});
		
		it(@"ignores inherited styles with incompatible class", ^{
			expect([style baseStyles]).to.beEmpty();
		});
	});
	
	
	context(@"", ^{
		__block id childStyle;
		
		beforeAll(^{
			childStyle = [AMUIStyle.alloc initWithClass:UIView.class];
			[childStyle setBackgroundColor:UIColor.orangeColor];
		});
		
		beforeEach(^{
			style = [[AMUIStyle alloc] initWithClass:UITextField.class];
			[style inherit:childStyle];
		});
		
		it(@"should apply orange background from inherited style", ^{
			UITextField *field = mock(UITextField.class);
			[style applyTo:field];
			[MKTVerify(field) setBackgroundColor:UIColor.orangeColor];
		});
		
		it(@"should apply orange background from inherited style AND rounded rect border from inheriting style", ^{
			UITextField *field = mock(UITextField.class);
			[style setBorderStyle:UITextBorderStyleBezel];
			[style applyTo:field];
			[MKTVerify(field) setBackgroundColor:UIColor.orangeColor];
			[MKTVerify(field) setBorderStyle:UITextBorderStyleBezel];
		});
		
		it(@"should redefine orange background from inherited style with magenta background in inheriting style", ^{
			UITextField *field = mock(UITextField.class);
			[style setBackgroundColor:UIColor.magentaColor];
			[style applyTo:field];
			[MKTVerify(field) setBackgroundColor:UIColor.magentaColor];
		});
	});
	
	afterEach(^{
		style = nil;
	});
});

SpecEnd
