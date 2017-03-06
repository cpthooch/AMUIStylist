# AMUIStylist
Declarative styling facilities for UIKit components.

## Capabilities

### Declarative way of styling UI elements. 
Forget about
```objc
someButton.backgroundColor = kGreenColor;
```
Use semantic style names
```objc
someButton.am_style = @"awesome-action-button";
```

### Single style assignment instead of a bunch of settings, e.g. above example effectively is
```objc
[someButton setBackgroundColor:[UIColor greenColor]];
[someButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
[someButton setImage:[UIImage imageNamed:@"awesome-button"] forState:UIControlStateNormal];
...
```

### Single style may be applied to several objects
```objc
someButton.am_style = @"awesome-action-button";
otherButton.am_style = @"awesome-action-button";
loginButton.am_style = @"awesome-action-button";
```

### Singe object may have several styles, applied consequently
```objc
someButton.am_style = @"large-text, awesome-action-button";
```

### am_style is KVC compliant property so it can be set directly via Interface Builder
![style_ib](https://cloud.githubusercontent.com/assets/1440284/23611694/68fc9fa4-0289-11e7-8852-23835073d14b.png)

### Style definitions support code completion
![completion](https://cloud.githubusercontent.com/assets/1440284/23615306/057f4540-0297-11e7-97e6-4c150bf36fd7.png)

### Styles support inheritance
This will produce combined style from inputFieldStyle settings plus ```setSecureTextEntry```
```objc
UITextField *passwordFieldStyle = style(UITextField.self, inputFieldStyle);
[passwordFieldStyle setSecureTextEntry:YES];
```

### Styles organized into style sheets which support hot switching
```objc
[AMUIStylist sharedStylist].styleSheet = [AMUIStyleSheet getSheet:@"swag"];
```
![preview](https://cloud.githubusercontent.com/assets/1440284/23611732/8ff33a82-0289-11e7-90c7-5a692d02e4e7.gif)

For more examples please take a look at included demo app and test cases.

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
