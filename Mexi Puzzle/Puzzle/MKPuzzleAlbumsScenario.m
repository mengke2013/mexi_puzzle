//
//  MKPuzzlePictureAlbums.m
//  Dream Puzzle
//
//  Created by iMacPro05 on 10/9/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import "MKPuzzleAlbumsScenario.h"
#import <mexica/MKSprite.h>

@interface MKPuzzleAlbumsScenario()
{
    NSArray* imageFileNames;
    NSMutableArray* imageEntities;
    MKSprite* albumsPanelSprite;
}

@end

@implementation MKPuzzleAlbumsScenario

@synthesize previewScenario;

-(id) initWithScene:(MKScene*)scene size:(CGSize)size
{
    
	if (self=[super initWithScene:scene size:size])
    {
        albumsPanelSprite = [[MKSprite alloc]initWithSize:size];
        [scene addChildern:albumsPanelSprite];
        
        imageFileNames = [[NSArray alloc]initWithObjects:@"puzzle-beach.jpg",@"puzzle-castle.jpg", nil];
        imageEntities = [[NSMutableArray alloc]init];
        for(int i = 0; i < [imageFileNames count]; i++)
        {
            UIImage* image = [UIImage imageNamed:[imageFileNames objectAtIndex:i]];
            MKSprite* imageSprite = [[MKSprite alloc]init:image size:CGSizeMake(100, 100)];
            [imageSprite setPosition:CGPointMake(-size.width/2 + 160*(i%2) + 80, size.height/2 - 160*((int)(i/2)) - 80)];
            [albumsPanelSprite addChildern:imageSprite];
            
            MKEntity* imageEntity = [[MKEntity alloc]initWithSprite:imageSprite];
            imageEntity.actionHandler = self;
            [imageEntities addObject:imageEntity];
        }
        
        
    }
    return self;
}

-(void)start
{
    albumsPanelSprite.visible = YES;
    [albumsPanelSprite setZIndex:100];
    [albumsPanelSprite setZOrder:100];
    
    for(MKEntity* imageEntity in imageEntities)
    {
        imageEntity.view.visible = YES;
        [imageEntity.view setZOrder:101];
        [imageEntity.view setZIndex:101];
    }
}

-(void)end
{
    
    albumsPanelSprite.visible = NO;
    [albumsPanelSprite setZOrder:-100];
    [albumsPanelSprite setZIndex:-100];
    
    for(MKEntity* imageEntity in imageEntities)
    {
        imageEntity.view.visible = NO;
        [imageEntity.view setZOrder:-100];
        [imageEntity.view setZIndex:-100];
    }
}

-(void)update:(double)time
{
    
}

-(void)handleTapping:(MKEntity*)entity location:(CGPoint) location
{
    //    if(entity == imageEntity)
    {
        NSString* selectedImageFileName = [imageFileNames objectAtIndex: [imageEntities indexOfObject:entity]];
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"puzzle" ofType:@"plist"];
        BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        if(fileExists){
            NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
            [ plistDict setObject:selectedImageFileName forKey:@"ImageFileName" ];
            [ plistDict writeToFile:filePath atomically:YES ];
            
        }else {
            NSLog(@"File Not Found");
            exit(1);  // if file not found exit the application.
        }
        
        
        
        
        
        [self end];
        [previewScenario start];
    }
}

@end
