//
//  AppDelegate.m
//  NovaButtons
//
//  Created by xixi197 on 12-2-27.
//  Copyright (c) 2012年 NovaCold. All rights reserved.
//

#import "AppDelegate.h"
#import "NovaBaseButton.h"
#import "NovaToggleButton.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application

    NSString *path = [[NSBundle mainBundle] pathForImageResource:@"37x-Checkmark.png"];
    NSImage *image = [[NSImage alloc] initWithContentsOfFile:path];
    CGImageRef preImage = [image CGImageForProposedRect:nil context:nil hints:nil];
    
    CGColorRef blackcolor = CGColorCreateGenericRGB(0, 0, 0, 1);
    CGColorRef orangecolor = CGColorCreateGenericRGB(1, 0.5, 0, 1);
    CGColorRef redcolor = CGColorCreateGenericRGB(1, 0, 0, 1);
    
    BaseButton1 = [[NovaBaseButton alloc] initWithFrame:NSMakeRect(20, 94, 37, 37)];
    [BaseButton1 setImage:preImage withRect:NSMakeRect(0, 0, image.size.width, image.size.height)];
    [BaseButton1 setImageColor:blackcolor ImageColorDown:orangecolor];
    [BaseButton1 addTarget:self action:@selector(colorAction:)];
    [[_window contentView] addSubview:BaseButton1];
    
    ToggleButton1 = [[NovaToggleButton alloc] initWithFrame:NSMakeRect(20, 19, 37, 37)];
    [ToggleButton1 setImage:preImage withRect:NSMakeRect(0, 0, image.size.width, image.size.height)];
    [ToggleButton1 setImageColor:blackcolor ImageColorDown:orangecolor];
    [ToggleButton1 setOnimageColor:redcolor];
    [ToggleButton1 addTarget:self action:@selector(colorAction:)];
    [[_window contentView] addSubview:ToggleButton1];
    
    CGColorRelease(blackcolor);
    CGColorRelease(orangecolor);
    CGColorRelease(redcolor);
}

- (void)colorAction:(id)sender {
    
}

@end
