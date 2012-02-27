//
//  NovaToggleButton.h
//  NovaButtons
//
//  Created by xixi197 on 12-1-16.
//  Copyright (c) 2012年 NovaCold. All rights reserved.
//

#import "NovaBaseButton.h"

@interface NovaToggleButton : NovaBaseButton {
    BOOL _on;
    BOOL _canSelfToggle;//自我恢复
    
    float _onopacityExit;
    
    NSColor *_ontextColor;
    
    CGImageRef _onimage;
    CGColorRef _onimageColor;
}

@property (nonatomic, assign) BOOL canSelfToggle;
@property (nonatomic, assign) float onopacityExit;

@property (nonatomic, strong) NSColor *ontextColor;

- (void)setOn:(BOOL)on;
- (BOOL)isOn;

- (void)setOnImage:(CGImageRef)image withRect:(NSRect)rect;

- (void)setOnimageColor:(CGColorRef)color;

@end
