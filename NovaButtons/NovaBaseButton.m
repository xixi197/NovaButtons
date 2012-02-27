//
//  NovaBaseButton.m
//  NovaButtons
//
//  Created by xixi197 on 12-2-9.
//  Copyright (c) 2012年 NovaCold. All rights reserved.
//

#import "NovaBaseButton.h"

@implementation NovaBaseButton

@synthesize isDown = _isDown;
@synthesize isEntered = _isEntered;
@synthesize isDownToAction = _isDownToAction;

@synthesize textY = _textY;
@synthesize imageY = _imageY;
@synthesize opacityExit = _opacityExit;

@synthesize text = _text;
@synthesize textFont = _textFont;
@synthesize textColor = _textColor;
@synthesize textColorDown = _textColorDown;
@synthesize textAlignment = _textAlignment;

+ (Class)cellClass {
    return [NSActionCell class];
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _isEnabled = YES;
        _textY = 0;
        _imageY = 1;
        _opacityExit = 0.4;

        [self setWantsLayer:YES];
//        [self setAlphaValue:1];
//        [self.layer setOpacity:1];//有动画

        _text = nil;
        _textFont = [NSFont systemFontOfSize:18];
        _textColor = [NSColor blackColor];
        _textColorDown = [NSColor blackColor];
        _textAlignment = NSCenterTextAlignment;

        [self myAddTrackingArea];
    }
    return self;
}

- (void)dealloc {
    if (_image) CGImageRelease(_image);
    if (_imageColor) CGColorRelease(_imageColor);
    if (_imageColorDown) CGColorRelease(_imageColorDown);
    if (_backColor) CGColorRelease(_backColor);
    if (_backColorDown) CGColorRelease(_backColorDown);
    [self myRemoveTrackingArea];
}

- (void)drawBack:(CGColorRef)color {
    if (color) {
        CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
        
        CGContextSetFillColorWithColor(context, color);
        CGContextFillRect(context, [self bounds]);
    }
}

- (void)drawImage:(CGImageRef)image withColor:(CGColorRef)color withY:(float)Y {
    if (image) {        
        float x = (self.bounds.size.width - CGImageGetWidth(image)) / 2;
        float y = (self.bounds.size.height - CGImageGetHeight(image)) / 2 - Y;
        
        CGRect rect = CGRectMake(x, y, CGImageGetWidth(image), CGImageGetHeight(image));
        
        CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
        
        if (color == NULL) {
            CGContextDrawImage(context, rect, image);
        } else {
            CGContextSetFillColorWithColor(context, color);
            
            CGContextSaveGState(context);
            CGContextClipToMask(context, rect, image);
            CGContextFillRect(context, self.bounds);
            CGContextRestoreGState(context);
        }
    }
}

- (void)drawText:(NSFont *)font color:(NSColor *)color alignment:(NSTextAlignment)alignment withY:(float)Y {
    if (_text) {
        NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle alloc] init];
        [textStyle setAlignment:(alignment != -1) ? alignment : NSCenterTextAlignment];
        
        NSDictionary *stringAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                font ? font : [NSFont systemFontOfSize: 18],
                NSFontAttributeName,
                
                textStyle,
                NSParagraphStyleAttributeName,
                
                color ? color : [NSColor whiteColor],
                NSForegroundColorAttributeName,
                
                nil];

        NSSize size = [_text sizeWithAttributes:stringAttributes];
        CGRect rect = self.bounds;
        rect.origin.y -= (rect.size.height - size.height) / 2 - Y;
        [_text drawInRect:rect withAttributes:stringAttributes];
    }
}

- (void)drawDown {
    [self drawBack:_backColorDown];
    [self drawImage:_image withColor:_imageColorDown withY:_imageY];
    [self drawText:_textFont color:_textColorDown alignment:_textAlignment withY:_textY];
    [self setAlphaValue:1];
}

- (void)drawEntered {
    [self drawBack:_backColor];
    [self drawImage:_image withColor:_imageColor withY:0];
    [self drawText:_textFont color:_textColor alignment:_textAlignment withY:_textY];
    [self setAlphaValue:1];
}

- (void)drawExited {
    [self drawEntered];
    [self setAlphaValue:_opacityExit];
}

- (void)drawDisabled {
    [self drawEntered];
    [self setAlphaValue:0.2];
}

- (void)drawRect:(NSRect)dirtyRect
{
    if (_isEnabled) {
        if (_isEntered) {
            if (_isDown) {
                [self drawDown];
            } else {
                [self drawEntered];
            }
        } else {
            [self drawExited];
        }
    } else {
        [self drawDisabled];
    }
}

- (BOOL)isNovaEnabled {
    return _isEnabled;
}

- (void)setNovaEnabled:(BOOL)flag {
    _isEnabled = flag;
    [self setNeedsDisplay:YES];
}

- (void)setImage:(CGImageRef)image withRect:(NSRect)rect {    
    if (_image) CGImageRelease(_image);
    if (image) _image = CGImageCreateWithImageInRect(image, rect);
    
    [self setNeedsDisplay:YES];
}

- (void)setImageColor:(CGColorRef)color {
    if (_imageColor) CGColorRelease(_imageColor);
    if (color) _imageColor = CGColorRetain(color);
}

- (void)setImageColorDown:(CGColorRef)color {
    if (_imageColorDown) CGColorRelease(_imageColorDown);
    if (color) _imageColorDown = CGColorRetain(color);
}

- (void)setImageColor:(CGColorRef)color1 ImageColorDown:(CGColorRef)color2 {
    [self setImageColor:color1];
    [self setImageColorDown:color2];
}

- (void)setBackColor:(CGColorRef)color {
    if (_backColor) CGColorRelease(_backColor);
    if (color) _backColor = CGColorRetain(color);
}

- (void)setBackColorDown:(CGColorRef)color {
    if (_backColorDown) CGColorRelease(_backColorDown);
    if (color) _backColorDown = CGColorRetain(color);
}

- (void)setBackColor:(CGColorRef)color1 BackColorDown:(CGColorRef)color2 {
    [self setBackColor:color1];
    [self setBackColorDown:color2];
}

- (void)addTarget:(id)theTarget action:(SEL)theAction {
    [self setTarget:theTarget];
    [self setAction:theAction];
    [self setEnabled:YES];
}

- (void)buttonAction {
    [self sendAction:[self action] to:[self target]];
}

- (BOOL)acceptsFirstMouse:(NSEvent *)theEvent {
    return YES;
}

- (void)mouseEntered:(NSEvent *)theEvent {
    if (_isEnabled) {
        _isEntered = YES;
        [self setNeedsDisplay:YES];
    }
}

- (void)mouseExited:(NSEvent *)theEvent {
    if (_isEnabled) {
        _isEntered = NO;
        [self setNeedsDisplay:YES];
    }
}

- (void)mouseDown:(NSEvent *)theEvent {
    if (_isEnabled) {
        if (_isDownToAction) {
            [self buttonAction];
        } else {
            _isDown = YES;
        }
        [self setNeedsDisplay:YES];
    }
}

- (void)mouseUp:(NSEvent *)theEvent {
    if (_isEnabled) {
        if (!_isDownToAction) {
            _isDown = NO;
            if (_isEntered) {
                [self buttonAction];
                [self setNeedsDisplay:YES];
            }
        }
    }
}

- (void)myAddTrackingArea
{
	[self myRemoveTrackingArea];
	
	NSTrackingAreaOptions trackingOptions = NSTrackingEnabledDuringMouseDrag | 
                                            NSTrackingMouseEnteredAndExited |
                                            NSTrackingActiveAlways;
    // note: NSTrackingActiveAlways flags turns off the cursor updating feature
    
	_trackingArea = [[NSTrackingArea alloc]
                     initWithRect:self.bounds
                     options:trackingOptions
                     owner:self
                     userInfo:nil];
    
	[self addTrackingArea:_trackingArea];
}

- (void)myRemoveTrackingArea
{
	if (_trackingArea)
	{
		[self removeTrackingArea:_trackingArea];
		
		_trackingArea = nil;
	}
}

@end
