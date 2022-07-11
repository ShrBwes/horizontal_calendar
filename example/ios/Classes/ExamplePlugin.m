#import "ExamplePlugin.h"
#if __has_include(<example/example-Swift.h>)
#import <example/example-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "example-Swift.h"
#endif

@implementation ExamplePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftExamplePlugin registerWithRegistrar:registrar];
}
@end
