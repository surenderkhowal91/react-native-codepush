#import <React/RCTBridgeModule.h>
#import <React/RCTLog.h>
#import <React/RCTReloadCommand.h>

@interface AppReloader : NSObject <RCTBridgeModule>
@end

@implementation AppReloader

RCT_EXPORT_MODULE(AppReloader);

RCT_EXPORT_METHOD(restartApp)
{
  RCTLogInfo(@"[AppReloader] restartApp called");
  RCTTriggerReloadCommandListeners(@"user_initiated_restart");
}

@end
