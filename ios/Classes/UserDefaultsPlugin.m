#import "UserDefaultsPlugin.h"

static NSString *const CHANNEL_NAME = @"flutter.memspace.io/user_defaults";
static NSString *const DEFAULT_NAME = @"[DEFAULT]";

@implementation UserDefaultsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:CHANNEL_NAME
            binaryMessenger:[registrar messenger]];
  UserDefaultsPlugin* instance = [[UserDefaultsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSDictionary *arguments = [call arguments];
  NSString *name = arguments[@"name"];
  NSUserDefaults *defaults;
  if (name == DEFAULT_NAME) {
    defaults = [NSUserDefaults standardUserDefaults];
  } else {
    defaults = [[NSUserDefaults alloc] initWithSuiteName:name];
  }

  if ([@"get" isEqualToString:call.method]) {
    NSString *key = arguments[@"key"];
    NSDictionary *data = @{
        key : [defaults objectForKey:key]
    };
    result(data);
  else   if ([@"set" isEqualToString:call.method]) {
    NSString *key = arguments[@"key"];
    id value = arguments[@"value"];
    [defaults setObject:value forKey:key];
    [defaults synchronize];
    result(@YES);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
