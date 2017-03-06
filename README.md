# AMUIStylist
Declarative styling facilities for UIKit components.

## Capabilities

1. Declarative way of styling UI elements. 
Forget about:
```objc
someButton.backgroundColor = kGreenColor;
```
Use semantic style names:
```objc
someButton.am_style = @"awesome-action-button";
```

2. Single style assignment instead of a bunch of settings, e.g. above example effectively appears:
```objc
[someButton setBackgroundColor:[UIColor greenColor]];
[someButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
[someButton setImage:[UIImage imageNamed:@"awesome-button"] forState:UIControlStateNormal];
...
```

3. Single style may be applied to several objects:
```objc
someButton.am_style = @"awesome-action-button";
otherButton.am_style = @"awesome-action-button";
loginButton.am_style = @"awesome-action-button";
```

4. Singe object may have several styles, applied consequently:
```objc
someButton.am_style = @"large-text, awesome-action-button";
```

5. ```am_style``` is KVC compliant property so it could be set directly in Interface Builder:

6. Style definitions support code completion:
```objc
UITextField *inputFieldStyle = style(UITextField.self);
[inputFieldStyle setTextColor:UIColor.darkTextColor];
[inputFieldStyle setFont:[self lightFontWithSize:21]];
```

7. Styles support inheritance:
```objc
UITextField *passwordFieldStyle = style(UITextField.self, inputFieldStyle);
[passwordFieldStyle setSecureTextEntry:YES];
```

8. Styles organized into style sheets which support hot switching on the fly:
```objc
[AMUIStylist sharedStylist].styleSheet = [AMUIStyleSheet getSheet:@"swag"];
```

For more examples please take a look at included demo app.

## Launching demo app

To install dependencies:
```bash
cd Example
pod install
```

Open ```AMUIStylistExample.xcworkspace``` with Xcode and hit Run.

## Dependencies
Currently AMUIStylist depends on:
* [Underscore.m](https://github.com/robb/Underscore.m)
* [libextobjc](https://github.com/jspahrsummers/libextobjc)
* [JRSwizzle](https://github.com/rentzsch/jrswizzle)

Unit tests require:
* [Specta](https://github.com/specta/specta)
* [Expecta](https://github.com/specta/expecta)
* [OCMockito](https://github.com/jonreid/OCMockito)

## TODO
1. Get rid of library dependencies.
2. Create podspec.
