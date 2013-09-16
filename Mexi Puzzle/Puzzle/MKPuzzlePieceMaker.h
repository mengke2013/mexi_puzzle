//
//  MKPuzzlePieceMaker.h
//  Dream Puzzle
//
//  Created by iMacPro05 on 28/8/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import <Foundation/Foundation.h>

enum
{
    STANDARD_SHAPE,
    CLASSIC_SHAPE,
    DREAM_PUZZLE_SHAPE
};

@interface MKPuzzlePieceMaker : NSObject

+ (NSArray*) piecesWithImage:(UIImage*)image pieceRows:(int)pieceRows pieceCols:(int)pieceCols  puzzleSize:(CGSize)puzzleSize shapeType:(int)shapeType;

@end
