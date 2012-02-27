//
//  NovaToggleButton.m
//  NovaButtons
//
//  Created by xixi197 on 12-1-16.
//  Copyright (c) 2012年 NovaCold. All rights reserved.
//

#import "NovaToggleButton.h"

@implementation NovaToggleButton

@synthesize canSelfToggle = _canSelfToggle;
@synthesize onopacityExit = _onopacityExit;

@synthesize ontextColor = _ontextColor;

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _canSelfToggle = YES;
        _onopacityExit = _opacityExit;
        _ontextColor = _textColor;
    }
    return self;
}

- (void)dealloc {
    if (_onimage) CGImageRelease(_onimage);
    if (_onimageColor) CGColorRelease(_onimageColor);
}

- (void)drawDown {
    [self drawBack:_backColorDown];
    [self drawImage:(_on && _onimage) ? _onimage : _image
          withColor:_imageColorDown
              withY:1];
    [self drawText:_textFont color:_textColorDown alignment:_textAlignment withY:_textY];
    [self setAlphaValue:1];
}

- (void)drawEntered {
    [self drawBack:_backColor];
    [self drawImage:(_on && _onimage) ? _onimage : _image
          withColor:(_on && _onimageColor) ? _onimageColor : _imageColor
              withY:0];
    [self drawText:_textFont color:(_on && _ontextColor) ? _ontextColor : _textColor alignment:_textAlignment withY:_textY];
    [self setAlphaValue:1];
}

- (void)drawExited {
    [super drawExited];
    [self setAlphaValue:_on ? _onopacityExit : _opacityExit];
}

- (void)setOn:(BOOL)on {
    _on = on;
    [self setNeedsDisplay:YES];
}

- (BOOL)isOn {
    return _on;
}

- (void)setOnImage:(CGImageRef)image withRect:(NSRect)rect
{
    if (_onimage) CGImageRelease(_onimage);
    if (image) _onimage = CGImageCreateWithImageInRect(image, rect);
    
    [self setNeedsDisplay:YES];
}

- (void)setOnimageColor:(CGColorRef)color {
    if (_onimageColor) CGColorRelease(_onimageColor);
    if (color) _onimageColor = CGColorRetain(color);
}

- (void)buttonAction {
    if (_canSelfToggle) {
        _on = !_on;
        [self sendAction:[self action] to:[self target]];
    } else {
//        if (!_on) {
            _on = YES;
            [self sendAction:[self action] to:[self target]];
//        }
    }
}

@end
