//
//  MKPuzzleFrame.m
//  Dream Puzzle
//
//  Created by iMacPro05 on 28/8/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import "MKPuzzleFrame.h"
#import "MKPuzzlePiece.h"
#import <mexica/MKSprite.h>
#import <mexica/MKMoveAction.h>

@interface MKPuzzleFrame()
{
    NSMutableArray* pieces;
}

@end


@implementation MKPuzzleFrame


-(void)handleTap :(CGPoint) location;
{
    [super handleTap:location];
    MKAction* action = [[MKMoveAction alloc]initWithDuration:0.5 position:CGPointMake(location.x - [self.view spritePosition].x, location.y - [self.view spritePosition].y) complete:nil];
    [self.view runAction:action];
}

-(void)handlePan : (UIGestureRecognizerState) state location:(CGPoint) location translation:(CGPoint) translation
{
    [super handlePan:state location:location translation:translation];
}

-(void)handlePinch : (UIGestureRecognizerState) state scale:(CGFloat)scale
{
    [super handlePinch:state scale:scale];
}

@end
