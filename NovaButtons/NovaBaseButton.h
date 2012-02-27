//
//  NovaBaseButton.h
//  NovaButtons
//
//  Created by xixi197 on 12-2-9.
//  Copyright (c) 2012年 NovaCold. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NovaBaseButton : NSControl {
    BOOL _isDown;
    BOOL _isEntered;
    BOOL _isEnabled;
    
    BOOL _isDownToAction;//按下触发事件

    float _textY;
    float _imageY;
    float _opacityExit;

    NSString *_text;
    NSFont *_textFont;
    NSColor *_textColor;
    NSColor *_textColorDown;
    NSTextAlignment _textAlignment;
    
    CGImageRef _image;
    CGColorRef _imageColor;
    CGColorRef _imageColorDown;
    
    CGColorRef _backColor;
    CGColorRef _backColorDown;
    
    NSTrackingArea *_trackingArea;
}

@property (nonatomic, assign, readonly) BOOL isDown;
@property (nonatomic, assign) BOOL isEntered;

@property (nonatomic, assign) BOOL isDownToAction;

@property (nonatomic, assign) float textY;
@property (nonatomic, assign) float imageY;
@property (nonatomic, assign) float opacityExit;

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSFont *textFont;
@property (nonatomic, strong) NSColor *textColor;
@property (nonatomic, strong) NSColor *textColorDown;
@property (nonatomic, assign) NSTextAlignment textAlignment;

- (void)drawBack:(CGColorRef)color;
- (void)drawImage:(CGImageRef)image withColor:(CGColorRef)color withY:(float)Y;
- (void)drawText:(NSFont *)font color:(NSColor *)color alignment:(NSTextAlignment)alignment withY:(float)Y;

- (void)drawDown;
- (void)drawEntered;
- (void)drawExited;
- (void)drawDisabled;

- (BOOL)isNovaEnabled;
- (void)setNovaEnabled:(BOOL)flag;

- (void)setImage:(CGImageRef)image withRect:(NSRect)rect;

- (void)setImageColor:(CGColorRef)color;
- (void)setImageColorDown:(CGColorRef)color;
- (void)setImageColor:(CGColorRef)color1 ImageColorDown:(CGColorRef)color2;

- (void)setBackColor:(CGColorRef)color;
- (void)setBackColorDown:(CGColorRef)color;
- (void)setBackColor:(CGColorRef)color1 BackColorDown:(CGColorRef)color2;

- (void)addTarget:(id)theTarget action:(SEL)theAction;
- (void)buttonAction;

- (void)myAddTrackingArea;
- (void)myRemoveTrackingArea;

@end
