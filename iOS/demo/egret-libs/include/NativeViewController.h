#ifndef NativeViewController_h
#define NativeViewController_h

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

@class NativeLauncher;
@interface NativeViewController : GLKViewController

@property (nonatomic, readonly) GLuint colorRenderbuffer;
@property (nonatomic, readonly) GLuint defaultFramebuffer;
@property (strong, nonatomic) EAGLContext* context;
@property (strong, nonatomic) NativeLauncher* launcher;

- (instancetype)initWithCoder:(NSCoder *)coder;
- (void)enterBackground;
- (void)enterForeground;

@end

#endif /* NativeViewController_h */
