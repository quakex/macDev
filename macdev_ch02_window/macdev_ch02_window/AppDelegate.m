//
//  AppDelegate.m
//  macdev_ch02_window
//
//  Created by Xu Ling on 09/10/2017.
//  Copyright © 2017 Xu Ling. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSWindow *modalWindow;
@property (nonatomic, strong) NSWindow *myWindow;
@property (nonatomic, assign) NSModalSession sessionCode;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    [self setWindowIcon];
    [self setWindowBKColor];
    [self addButtonToTitleBar];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(windowWillClose:)
                                                 name:NSWindowWillCloseNotification
                                               object:nil];

}

- (void) setWindowIcon {
//    [self.window setRepresentedURL:[NSURL URLWithString:@"WindowTitle"]];
    [self.window setTitle:@"SQLiteApp"];
    NSImage *image = [NSImage imageNamed:@"AppIcon"];
    [[self.window standardWindowButton:NSWindowDocumentIconButton] setImage:image];
}

- (void) setWindowBKColor {
    [self.window setOpaque:NO];
    [self.window setBackgroundColor:[NSColor brownColor]];
}

- (void) addButtonToTitleBar {
    NSView *titleView = [self.window standardWindowButton:NSWindowCloseButton].superview;
    NSButton *button = [[NSButton alloc] init];
    button.title = @"Register";
    float x = self.window.contentView.frame.size.width - 100;
    button.frame = NSMakeRect(x, -10, 80, 40);
    button.bezelStyle = NSBezelStyleRounded;
    [titleView addSubview:button];
}
//关闭最后一个窗口时关闭应用
- (BOOL) applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)application {
    return YES;
}

- (void)windowWillClose:(NSNotification *)notification {
    [[NSApplication sharedApplication] stopModal];
    if (_sessionCode != 0) {
        [[NSApplication sharedApplication]endModalSession:_sessionCode];
    }
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
- (IBAction)createWindowAction:(id)sender {
    [self.myWindow makeKeyAndOrderFront:self];
    [self.myWindow center];
}

- (IBAction)showModalWindow:(id)sender {
    [[NSApplication sharedApplication] runModalForWindow:self.modalWindow];
}

- (IBAction)showSessionWindow:(id)sender {
    _sessionCode = [[NSApplication sharedApplication] beginModalSessionForWindow:self.myWindow];
}

//只能创建一次，why？
- (NSWindow *)myWindow {
    if (!_myWindow) {
        NSRect frame = CGRectMake(0, 0, 200, 200);
        NSUInteger style =  NSTitledWindowMask | NSClosableWindowMask |NSMiniaturizableWindowMask | NSResizableWindowMask;
        _myWindow = [[NSWindow alloc] initWithContentRect:frame styleMask:style backing:NSBackingStoreBuffered defer:YES];
        _myWindow.title = @"New Create Window";
    }
    return _myWindow;
}
@end
