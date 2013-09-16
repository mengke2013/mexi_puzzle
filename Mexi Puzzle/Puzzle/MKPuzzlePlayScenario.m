//
//  MKPuzzlePlayScenario.m
//  Dream Puzzle
//
//  Created by iMacPro05 on 10/9/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import "MKPuzzlePlayScenario.h"
#import "MKPuzzleFrame.h"
#import "MKPuzzlePiece.h"
#import "MKPuzzlePieceMaker.h"

@interface MKPuzzlePlayScenario()
{
    MKPuzzleFrame* frame;
    
    CGSize _size;
    float _intelegentGap;
}

@end

@implementation MKPuzzlePlayScenario

@synthesize albumsScenario;

-(id) initWithScene:(MKScene*)scene size:(CGSize)size
{
    
	if (self=[super initWithScene:scene size:size])
    {
        _size = size;
        
        frame = [[MKPuzzleFrame alloc]initWithSize:size];
        [frame.view setZIndex:-1];
        [scene addChildern:frame.view];
        
        _intelegentGap = 10;
        
    }
    return self;
}

-(void)start
{

    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"puzzle" ofType:@"plist"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
    if(fileExists){
        NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        int shapeType = [[plistDict objectForKey:@"puzzleType"]intValue];
        NSString* imageFile = [plistDict objectForKey:@"ImageFileName"];
        UIImage* image = [UIImage imageNamed:imageFile];
        NSArray* pieces = [MKPuzzlePieceMaker piecesWithImage:image pieceRows:12 pieceCols:8 puzzleSize:_size shapeType:shapeType];
        for(MKPuzzlePiece* piece in pieces)
        {
            [frame addEntity:piece];
            piece.actionHandler=self;
        }
        
    }else {
        NSLog(@"File Not Found");
        exit(1);  // if file not found exit the application.
    }
    
    
}

-(void)end
{
    
}

-(void)update:(double)time
{
    
}

-(void)handleEndPick:(MKEntity*)entity location:(CGPoint) location
{
    MKPuzzlePiece* piece = (MKPuzzlePiece*)entity;
    CGPoint piecePosition = [piece.view spritePosition];
    if(piecePosition.x > piece.dstPosition.x - _intelegentGap && piecePosition.x < piece.dstPosition.x + _intelegentGap && piecePosition.y > piece.dstPosition.y - _intelegentGap && piecePosition.y < piece.dstPosition.y + _intelegentGap)
    {
        [piece.view setPosition:piece.dstPosition];
    }
    //    [frameBox removeEntity:entity];
    //    [frame addEntity:entity];
}

@end
