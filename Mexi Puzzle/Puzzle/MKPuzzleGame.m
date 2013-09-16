//
//  MKPuzzleGame.m
//  Dream Puzzle
//
//  Created by iMacPro05 on 27/8/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import "MKPuzzleGame.h"
#import <mexica/MKScene.h>
#import <mexica/MKLabel.h>
#import <mexica/MKSprite.h>
#import <mexica/MKMoveAction.h>
#import <mexica/MKScaleAction.h>
#import <mexica/MKRotateAction.h>
#import "MKPuzzleFrame.h"
#import "MKPuzzlePiece.h"
#import "MKPuzzlePieceMaker.h"
#import "MKPuzzleAlbumsScenario.h"
#import "MKPuzzlePreviewScenario.h"
#import "MKPuzzlePlayScenario.h"

@interface MKPuzzleGame()
{
    MKScene* _scene;
    MKPuzzleFrame* frame;
    MKEntity* frameBox;
    
    float _intelegentGap;
    
    MKPuzzleAlbumsScenario* albumsScenario;
    MKPuzzlePreviewScenario* previewScenario;
    MKPuzzlePlayScenario* playScenario;
}

@end

@implementation MKPuzzleGame

-(void)setupGame:(MKScene*)scene size:(CGSize)size
{
    _scene = scene;
    [_scene setZIndex:-2];

    albumsScenario = [[MKPuzzleAlbumsScenario alloc]initWithScene:scene size:size];
    previewScenario = [[MKPuzzlePreviewScenario alloc]initWithScene:scene size:size];
    playScenario = [[MKPuzzlePlayScenario alloc]initWithScene:scene size:size];
    
    albumsScenario.previewScenario = previewScenario;
    previewScenario.playScenario= playScenario;
    previewScenario.albumsScenario = albumsScenario;
    playScenario.albumsScenario = albumsScenario;
    
    [albumsScenario start];
}

-(void) update:(double)time
{
    
}

-(void)handleTapping:(MKEntity*)entity location:(CGPoint) location
{

}

-(void)handleStartPick:(MKEntity*)entity location:(CGPoint) location
{

}

-(void)handleEndPick:(MKEntity*)entity location:(CGPoint) location
{

}


@end
