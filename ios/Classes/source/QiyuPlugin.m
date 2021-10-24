#import "QiyuPlugin.h"
#if __has_include(<qiyu/qiyu-Swift.h>)
#import <qiyu/qiyu-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "qiyu-Swift.h"
#endif

@implementation QiyuPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftQiyuPlugin registerWithRegistrar:registrar];
}
@end
