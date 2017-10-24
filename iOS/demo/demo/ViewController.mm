#import "ViewController.h"
#import "NativeLauncher.h"

#define TOKEN "ad3a7c5d83b77b1c62bdcb200575a51d21abe3c7a8650d964ad6ce0247c5b918"

/*
 * 设置是否显示FPS面板
 *   true: 显示面板
 *   false: 隐藏面板
 * Set whether to show FPS panel
 *   true: show FPS panel
 *   false: hide FPS panel
 * */
#define SHOW_FPS true

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterBackground:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(enterForeground:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    /*
     * 设置是否自动关闭启动页
     *   1: 自动关闭启动页
     *   0: 手动关闭启动页
     * Set whether to close the startup page automatically
     *   1. close the startup page automatically
     *   0. close the startup page manually
     * */
    super.launcher.closeLoadingViewAutomatically = 0;
    
    /*
     * 设置是否每次启动都重新下载游戏资源
     *   0: 版本更新才重新下载
     *   1: 每次启动都重新下载
     * Set whether to re-download game resources each time the application starts
     *   0: re-download game resources if version updated
     *   1: re-download game resources each time the application starts
     * */
    super.launcher.clearCache = 0;
    
    /*
     * 设置runtime代码log的等级
     *   0: Debug
     *   1: Info
     *   2: Warning
     *   3: Error
     * Set log level for runtime code
     *   0: Debug
     *   1: Info
     *   2: Warning
     *   3: Error
     * */
    super.launcher.logLevel = 0;
    
    static void (^callback)(NSString*) = ^(NSString* msg)
    {
        if ([msg isEqualToString:RequestingRuntime])
        {
            /*
             * 向服务器请求游戏信息
             * Request the server for game information
             * */
        }
        else if ([msg isEqualToString:LoadingGame])
        {
            /*
             * 下载和加载游戏资源
             * Download and load game resources
             * */
            [self setExternalInterfaces];
            [super.launcher startRuntime:SHOW_FPS];
        }
        else if ([msg isEqualToString:GameStarted])
        {
            /*
             * 游戏启动
             * Game started
             * */
        }
        else if ([msg isEqualToString:RetryRequestingRuntime])
        {
            /*
             * 重新向服务器请求游戏信息
             * Retrying to Request the server for game information
             * */
            [NSThread sleepForTimeInterval:1.0f];
            
            [super.launcher loadRuntime:@TOKEN Callback:callback];
        }
        else if ([msg isEqualToString:LoadRuntimeFailed])
        {
            /*
             * 加载runtime和游戏信息失败
             * Loading runtime and game resources failed
             * */
        }
    };
    
    [super.launcher loadRuntime:@TOKEN Callback:callback];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)setExternalInterfaces
{
    [super.launcher setExternalInterface:@"callNative" Callback:^(NSString* msg) {
        NSLog(@"Egret Launcher %@", msg);
        [super.launcher callExternalInterface:@"callJS" Value:@"message from native"];
    }];
}

- (void)enterBackground:(NSNotification *)notification
{
    [super enterBackground];
}

- (void)enterForeground:(NSNotification *)notification
{
    [super enterForeground];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscape;
}

@end
