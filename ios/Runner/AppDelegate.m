#include "AppDelegate.h"
#import <Flutter/Flutter.h>
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"samples.flutter.io/battery"
                                            binaryMessenger:controller];
    
    
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"lang" isEqualToString:call.method]) {
            NSString *language = NSBundle.mainBundle.preferredLocalizations.firstObject;
            result(language);
        }
    }];
    
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for сustomization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
