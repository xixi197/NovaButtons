//
//  AppDelegate.h
//  NovaButtons
//
//  Created by xixi197 on 12-2-27.
//  Copyright (c) 2012年 NovaCold. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class NovaBaseButton;
@class NovaToggleButton;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    NovaBaseButton *BaseButton1;

    NovaToggleButton *ToggleButton1;
}

@property (assign) IBOutlet NSWindow *window;

@end
