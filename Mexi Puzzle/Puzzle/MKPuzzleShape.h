//
//  MKPuzzleShape.h
//  Dream Puzzle
//
//  Created by iMacPro05 on 31/8/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MKPuzzleShape : NSObject

@property (assign, nonatomic) CGSize size;
@property (assign, nonatomic) CGSize magine;

-(id) initWithSize:(CGSize)size magine:(CGSize)magine;

-(CGMutablePathRef)pathWithScale:(CGFloat)scale typeTop:(int)typeTop typeRight:(int)typeRight typeDown:(int)typeDown typeLeft:(int)typeLeft;

@end
