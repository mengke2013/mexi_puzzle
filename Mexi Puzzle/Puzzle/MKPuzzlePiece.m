//
//  MKPuzzlePiece.m
//  Dream Puzzle
//
//  Created by iMacPro05 on 28/8/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import "MKPuzzlePiece.h"
#import "MKPuzzle.h"

static CGFloat zOrder = 0;

@interface MKPuzzlePiece()
{
    BOOL _panning;
    
    CGPoint _srcPosition;
     CGPoint _srcDstPosition;

}

@end

@implementation MKPuzzlePiece

@synthesize dstPosition;
@synthesize magineX;
@synthesize magineY;

+(CGFloat) zOrder
{
    return zOrder++;
}

-(void)handleTap :(CGPoint) location;
{
    [super handleTap:location];
}

-(void)handlePan1 : (UIGestureRecognizerState) state location:(CGPoint) location translation:(CGPoint) translation
{
    [super handlePan:state location:location translation:translation];
    if(state == UIGestureRecognizerStateBegan)
    {
        _panning = YES;
//        [self.view setZOrder:[[NSDate date] timeIntervalSince1970]/1000000000];
        int zOrder = [MKPuzzlePiece zOrder];
        [self.view setZOrder:zOrder];
        [self.view setZIndex:zOrder];
    }
    else if(state == UIGestureRecognizerStateEnded)
    {
        if(_panning)
        {
            
            
            _panning = NO;
        }
        
    }
    else if(_panning)
    {
        
    }
}

-(BOOL)handlePan : (UIGestureRecognizerState) state location:(CGPoint) location translation:(CGPoint) translation
{
    if(state == UIGestureRecognizerStateBegan)
    {
        _srcPosition = [self.view spritePosition];
        CGFloat _width = self.view.width;
        CGFloat _height = self.view.height;
        CGFloat _scale = [self.view spriteScale];
        
        if(location.x > _srcPosition.x - _width*_scale/2 + self.magineX*_scale  && location.x < _srcPosition.x + _width*_scale/2 - self.magineX*_scale && location.y > _srcPosition.y - _height*_scale/2 + self.magineY*_scale && location.y < _srcPosition.y + _height*_scale/2-self.magineY*_scale)
        {
            
            _panning = YES;
            
            int zOrder = [MKPuzzlePiece zOrder];
            [self.view setZOrder:zOrder];
            [self.view setZIndex:zOrder];
        }
        
        
        if([self.actionHandler respondsToSelector: @selector(handleStartPick:location:)])
        {
            [self.actionHandler handleStartPick:self location:location];
        }
        
        
    }
    else if(state == UIGestureRecognizerStateEnded)
    {
        if(_panning)
        {
            [self.view setPosition:CGPointMake(_srcPosition.x + translation.x, _srcPosition.y + translation.y)];
            _srcPosition = CGPointMake(FLT_MIN,FLT_MIN);
            _panning = NO;
            
            if([self.actionHandler respondsToSelector: @selector(handleEndPick:location:)])
            {
                [self.actionHandler handleEndPick:self location:location];
            }
            
        }
        
    }
    else if(_panning)
    {
        [self.view setPosition:CGPointMake(_srcPosition.x + translation.x, _srcPosition.y + translation.y)];
        
        if([self.actionHandler respondsToSelector: @selector(handlePicking:location:)])
        {
            [self.actionHandler handlePicking:self location:location];
        }
        
    }
    
    return _panning;
}

-(void)handlePinch : (UIGestureRecognizerState) state scale:(CGFloat)scale
{
    [super handlePinch:state scale:scale];
    
    if(state == UIGestureRecognizerStateBegan)
    {
        _srcPosition = CGPointMake(self.view.spritePosition.x, self.view.spritePosition.y);
        _srcDstPosition = CGPointMake(self.dstPosition.x, self.dstPosition.y);
    }
    else if(state == UIGestureRecognizerStateEnded)
    {
        [self.view setPosition:CGPointMake(_srcPosition.x *scale,_srcPosition.y*scale)];
        self.dstPosition = CGPointMake(_srcDstPosition.x *scale,_srcDstPosition.y*scale);
        
    }
    else
    {
        [self.view setPosition:CGPointMake(_srcPosition.x *scale,_srcPosition.y*scale)];
    }
}


@end
