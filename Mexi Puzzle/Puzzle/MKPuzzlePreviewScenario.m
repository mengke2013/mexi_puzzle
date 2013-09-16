//
//  MKPuzzlePreviewScenario.m
//  Dream Puzzle
//
//  Created by iMacPro05 on 13/9/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import "MKPuzzlePreviewScenario.h"
#import <mexica/MKSprite.h>
#import <mexica/MKLabel.h>

@interface MKPuzzlePreviewScenario()
{
    MKSprite* previewPanelSprite;
    MKSprite* previewPictureSprite;
    
    MKLabel* _playLable;
    MKLabel* _backLable;
    MKEntity* _backBtn;
    MKEntity* _playBtn;
}

@end

@implementation MKPuzzlePreviewScenario

@synthesize playScenario;
@synthesize albumsScenario;

-(id) initWithScene:(MKScene*)scene size:(CGSize)size
{
    
	if (self=[super initWithScene:scene size:size])
    {
        previewPanelSprite = [[MKSprite alloc]initWithSize:size];
        [scene addChildern:previewPanelSprite];
        
        previewPictureSprite = [[MKSprite alloc]initWithSize:CGSizeMake(size.width/2, size.height/2)];
        [previewPictureSprite setPosition:CGPointMake(0, size.height/4 - 10)];
        [previewPanelSprite addChildern:previewPictureSprite];
        
        _playLable = [MKLabel labelWithString:@"Play" fontName:@"Marker Felt" fontSize:32 fontColor:[UIColor blackColor]];
        [_playLable setPosition:CGPointMake(size.width/2 - 80, -size.height/2 + 80)];
        [previewPanelSprite addChildern:_playLable];
        _playBtn = [[MKEntity alloc]initWithSprite:_playLable];
        _playBtn.actionHandler = self;
        
        _backLable = [MKLabel labelWithString:@"Back" fontName:@"Marker Felt" fontSize:32 fontColor:[UIColor blackColor]];
        [_backLable setPosition:CGPointMake(-size.width/2 + 80, -size.height/2 + 80)];
        [previewPanelSprite addChildern:_backLable];
        _backBtn = [[MKEntity alloc]initWithSprite:_backLable];
        _backBtn.actionHandler = self;
        
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
        [previewPictureSprite setImage:image];
        
    }else {
        NSLog(@"File Not Found");
        exit(1);  // if file not found exit the application.
    }
    
    
    previewPanelSprite.visible = YES;
    [previewPanelSprite setZIndex:100];
    [previewPanelSprite setZOrder:100];
    
    previewPictureSprite.visible = YES;
    [previewPictureSprite setZIndex:102];
    [previewPictureSprite setZOrder:102];
    
    _playLable.visible = YES;
    [_playLable setZIndex:101];
    [_playLable setZOrder:101];
    
    _backLable.visible = YES;
    [_backLable setZIndex:101];
    [_backLable setZOrder:101];
    
}

-(void)end
{
    
    previewPanelSprite.visible = NO;
    [previewPanelSprite setZOrder:-100];
    [previewPanelSprite setZIndex:-100];
    previewPictureSprite.visible = NO;
    [previewPictureSprite setZIndex:-102];
    [previewPictureSprite setZOrder:-102];
    _playLable.visible = NO;
    [_playLable setZIndex:-101];
    [_playLable setZOrder:-101];
    _backLable.visible = NO;
    [_backLable setZIndex:-101];
    [_backLable setZOrder:-101];
    
}

-(void)update:(double)time
{
    
}

-(void)handleTapping:(MKEntity*)entity location:(CGPoint) location
{
    if(entity == _playBtn)
    {
        //        NSString* selectedImageFileName = [imageFileNames objectAtIndex: [imageEntities indexOfObject:entity]];
        //        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"puzzle" ofType:@"plist"];
        //        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        //        if(fileExists){
        //            NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        //            [ plistDict setObject:selectedImageFileName forKey:@"ImageFileName" ];
        //            [ plistDict writeToFile:filePath atomically:YES ];
        //
        //        }else {
        //            NSLog(@"File Not Found");
        //            exit(1);  // if file not found exit the application.
        //        }
        
        
        
        
        
        [self end];
        [playScenario start];
    }
    else if(entity == _backBtn)
    {
        [self end];
        [albumsScenario start];
    }
}

@end
