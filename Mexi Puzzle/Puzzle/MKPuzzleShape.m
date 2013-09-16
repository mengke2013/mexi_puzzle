//
//  MKPuzzleShape.m
//  Dream Puzzle
//
//  Created by iMacPro05 on 31/8/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import "MKPuzzleShape.h"

@interface MKPuzzleShape()
{
    
}

@end

@implementation MKPuzzleShape

@synthesize size=_size;
@synthesize magine=_magine;

-(id) initWithSize:(CGSize)size magine:(CGSize)magine
{
	if( (self=[super init]) )
    {
		_size = size;
        _magine = magine;
	}
	return self;
}

-(CGMutablePathRef)pathWithScale:(CGFloat)scale typeTop:(int)typeTop typeRight:(int)typeRight typeDown:(int)typeDown typeLeft:(int)typeLeft
{
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, scale, scale);
    CGPathAddLineToPoint(pathRef, NULL, -scale + _size.width, scale);
    CGPathAddLineToPoint(pathRef, NULL, -scale + _size.width, -scale + _size.height);
    CGPathAddLineToPoint(pathRef, NULL, scale, -scale + _size.height);
    CGPathCloseSubpath(pathRef);
    return pathRef;
}


@end
