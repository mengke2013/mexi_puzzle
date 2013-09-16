//
//  MKPuzzlePreviewScenario.h
//  Dream Puzzle
//
//  Created by iMacPro05 on 13/9/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import <mexica/MKScene.h>
#import <mexica/MKEntity.h>
#import <mexica/MKScenario.h>

@interface MKPuzzlePreviewScenario : MKScenario

@property(strong, nonatomic) MKScenario* playScenario;
@property(strong, nonatomic) MKScenario* albumsScenario;

@end
