//
//  MKPuzzlePiece.h
//  Dream Puzzle
//
//  Created by iMacPro05 on 28/8/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mexica/MKEntity.h>


@interface MKPuzzlePiece : MKEntity <MKSpriteActionHandler>

@property(assign, nonatomic)CGPoint dstPosition;
@property(assign, nonatomic)CGFloat magineX;
@property(assign, nonatomic)CGFloat magineY;

+(CGFloat) zOrder;

@end
