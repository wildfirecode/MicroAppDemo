#ifndef NativeLauncher_h
#define NativeLauncher_h

#import <UIKit/UIKit.h>

#define RequestingRuntime @"requestingRuntime"
#define RetryRequestingRuntime @"retryRequestingRuntime"
#define LoadingGame @"loadingGame"
#define GameStarted @"gameStarted"
#define LoadRuntimeFailed @"loadRuntimeFailed"

@class NativeViewController;
@interface NativeLauncher : NSObject

- (instancetype)initWithViewController:(NativeViewController*)viewController;
- (void)loadRuntime:(NSString*)token Callback:(void(^)(NSString*))callback;
- (void)startRuntime:(bool)showFPS;
- (void)setExternalInterface:(NSString*)funcName Callback:(void(^)(NSString*))callback;
- (void)callExternalInterface:(NSString*)funcName Value:(NSString*)value;

@property int clearCache;
@property int closeLoadingViewAutomatically;
@property int logLevel;

- (void)update:(double)dt;
- (void)render;
- (void)pause;
- (void)resume;
- (void)destroy;

- (void)showPrompt:(NSString*)str;

@end

#endif /* NativeLauncher_h */
