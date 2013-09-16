//
//  MKPuzzlePieceMaker.m
//  Dream Puzzle
//
//  Created by iMacPro05 on 28/8/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import "MKPuzzlePieceMaker.h"
#import "MKPuzzlePiece.h"
#import <mexica/MKSprite.h>
#import "MKPuzzleClassicShape.h"
#import "MKPuzzleStandardShape.h"

@implementation MKPuzzlePieceMaker

+ (NSArray*) piecesWithImage:(UIImage*)image pieceRows:(int)pieceRows pieceCols:(int)pieceCols  puzzleSize:(CGSize)puzzleSize shapeType:(int) shapeType
{
    CGFloat magineX = image.size.width/pieceCols/4;
    CGFloat magineY = image.size.height/pieceRows/4;
//    int rows = sqrt(pieceNumber);
    int rows = pieceRows;
    int cols = pieceCols;
    CGSize size = [image size];
    CGSize pieceSize = CGSizeMake(puzzleSize.width/cols+2*magineX*puzzleSize.width/image.size.width, puzzleSize.height/rows+2*magineY*puzzleSize.height/image.size.height);
    
    NSLog(@"rows:%i,cols:%i",rows,cols);
    int* pieceTypes = [self generatePieceTypes:1 rows:rows cols:cols];
    NSMutableArray* pieces = [[NSMutableArray alloc]init];
    for(int i = 0; i < pieceCols*pieceRows; i++)
    {
        CGPoint piecePoint = CGPointMake(-puzzleSize.width/2 + (puzzleSize.width)/cols *(i%cols) + (puzzleSize.width)/cols/2,
                                         puzzleSize.height/2 - puzzleSize.height/rows *(i/cols) - puzzleSize.height/rows/2);
        
        CGRect pieceRect = CGRectMake(size.width/cols *(i%cols), size.height/rows *(i/cols), size.width/cols+2*magineX, size.height/rows+2*magineY);
        UIImage* resizedImage = [self resizeImage:image magine:CGSizeMake(2*magineX, 2*magineY)];
        UIImage* cropedPieceImage = [self cropPieceImage:resizedImage rect:pieceRect];//[self convertGLToULCoor:pieceRect imageSize:[image size]]];
        MKPuzzleShape* shape = nil;
        if(shapeType == STANDARD_SHAPE)
        {
            shape = [[MKPuzzleStandardShape alloc]initWithSize:CGSizeMake([cropedPieceImage size].width-2*magineX, [cropedPieceImage size].height-2*magineY) magine:CGSizeMake(magineX, magineY)];
        }
        else if(shapeType == CLASSIC_SHAPE)
        {
            shape = [[MKPuzzleClassicShape alloc]initWithSize:CGSizeMake([cropedPieceImage size].width-2*magineX, [cropedPieceImage size].height-2*magineY) magine:CGSizeMake(magineX, magineY)];
        }

        UIImage* pieceImage = [self pieceImage:cropedPieceImage shape:shape bevelDeepth:puzzleSize.width/cols/20 typeTop:pieceTypes[i*4] typeRight:pieceTypes[i*4+1] typeDown:pieceTypes[i*4+2] typeLeft:pieceTypes[i*4+3]];
        MKPuzzlePiece* piece = [[MKPuzzlePiece alloc]init:pieceImage size:pieceSize];
        piece.magineX=pieceSize.width/6;
        piece.magineY=pieceSize.height/6;
        [piece.view setPosition:piecePoint];
        piece.view.scallable = YES;
        piece.view.draggable = YES;
        ((MKPuzzlePiece*)piece).dstPosition = piecePoint;
        int zOrder = [MKPuzzlePiece zOrder];
        [piece.view  setZOrder:zOrder];
        [piece.view  setZIndex:zOrder];
        [pieces addObject:piece];

    }
	return pieces;
}

+(UIImage*) pieceImage:(UIImage*)image shape:(MKPuzzleShape*)shape bevelDeepth:(int)bevelDeepth typeTop:(int)typeTop typeRight:(int)typeRight typeDown:(int)typeDown typeLeft:(int)typeLeft
{
    CGMutablePathRef pathRef = [shape pathWithScale:0 typeTop:typeTop typeRight:typeRight typeDown:typeDown typeLeft:typeLeft];
    UIImage* clipedPieceImage = [self clipPieceImage:image pathRef:pathRef];
    UIImage* beveledPieceImage = [self bevelPieceImage:clipedPieceImage pathRefOut:pathRef pathRefIn:[shape pathWithScale:bevelDeepth typeTop:typeTop typeRight:typeRight typeDown:typeDown typeLeft:typeLeft]];
    return beveledPieceImage;
}

+(UIImage*)bevelPieceImage:(UIImage*) image pathRefOut:(CGPathRef) pathRefOut pathRefIn:(CGPathRef) pathRefIn
{
    UIGraphicsBeginImageContext([image size]);
    CGContextRef context=(UIGraphicsGetCurrentContext());
    //revert context
    CGContextTranslateCTM(context, 0.0f, image.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextDrawImage(context, CGRectMake(0,0,image.size.width, image.size.height),image.CGImage);
    //revert context
    CGContextTranslateCTM(context, 0.0f, image.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    size_t num_locations = 2;
    CGFloat locations[2] = {1.0, 0.0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[8] = {0,0,0,0.9, 1,1,1,0.9};
    CGGradientRef gradient;
    
    int pathRefSize = 0;
    
//    for(int i = 0; i < pathRefSize; ++i)
    {
        CGContextSaveGState(context);
        CGContextAddPath(context, pathRefOut);
        CGContextClip(context);
        gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, num_locations);
        CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake([image size].width, [image size].height), 0);
        CGContextRestoreGState(context);
    }
    
    CGContextSaveGState(context);
    CGContextAddPath(context, pathRefIn);
    CGContextClip(context);
    //revert context
    CGContextTranslateCTM(context, 0.0f, image.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextDrawImage(context, CGRectMake(0,0,image.size.width, image.size.height),image.CGImage);
    //revert context
    CGContextTranslateCTM(context, 0.0f, image.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    CGContextRestoreGState(context);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage*)resizeImage:(UIImage*) image magine:(CGSize)magine
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width + magine.width, image.size.height + magine.height));
    CGContextRef context=(UIGraphicsGetCurrentContext());
    //revert context
    CGContextTranslateCTM(context, 0.0f, image.size.height+magine.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
//    CGContextClipToRect(context, CGRectMake(30,30,image.size.width,image.size.height));
    CGContextDrawImage(context, CGRectMake(magine.width/2,magine.height/2,image.size.width,image.size.height),image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage*)cropPieceImage:(UIImage*) image rect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage* newImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return newImage;
}

+(UIImage*)clipPieceImage:(UIImage*) image pathRef:(CGPathRef)pathRef
{
    UIGraphicsBeginImageContext(image.size);
//    CGColorSpaceRef colorRef = CGColorSpaceCreateDeviceRGB();
//    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, image.size.width*4, colorRef, kCGImageAlphaPremultipliedFirst);
    CGContextRef context=(UIGraphicsGetCurrentContext());
    
    
    CGContextAddPath(context, pathRef);
    CGContextClip(context);

    //revert context
    CGContextTranslateCTM(context, 0.0f, image.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);
    
    CGContextDrawImage(context, CGRectMake(0,0,image.size.width, image.size.height),image.CGImage);

    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(CGRect) convertGLToULCoor:(CGRect)rect imageSize:(CGSize)imageSize
{
    return CGRectMake(rect.origin.x + imageSize.width/2, imageSize.height/2 - rect.origin.y, rect.size.width, rect.size.height);
}

+(int*) generatePieceTypes:(int)_type rows:(int) rows cols:(int) cols
{
    int* pieceTypes = malloc(sizeof(int)*rows*cols*4);
    
    int top = 2;
    int right = 2;
    int down = 2;
    int left = 2;
    for(int i = 0; i < rows; i++)
    {
        for(int j = 0; j < cols; j++)
        {
            if(i == 0 && j == 0)
            {
                top = 2;
                right = (random() % 2);
                down = (random() % 2);
                left = 2;
            }
            else if(i == 0 && j == cols - 1)
            {
                top = 2;
                right = 2;
                down = (random() % 2);
                left = 1 - pieceTypes[(i * cols + (j-1))*4 + 1];
            }
            else if(i == 0)
            {
                top = 2;
                right = (random() % 2);
                down = (random() % 2);
                left = 1 - pieceTypes[(i * cols + (j-1))*4 + 1];
            }
            else if(i == rows - 1 && j == 0)
            {
                top = 1 - pieceTypes[((i-1) * cols + j)*4 + 2];
                right = (random() % 2);
                down = 2;
                left = 2;
            }
            else if(i == rows -1 && j == cols -1)
            {
                top = 1 - pieceTypes[((i-1) * cols + j)*4 + 2];
                right = 2;
                down = 2;
                left = 1 - pieceTypes[(i * cols + (j-1))*4 + 1];
            }
            else if(i == rows -1)
            {
                top = 1 - pieceTypes[((i-1) * cols + j)*4 + 2];
                right = (random() % 2);
                down = 2;
                left = 1 - pieceTypes[(i * cols + (j-1))*4 + 1];
            }
            else if(j == 0)
            {
                top = 1 - pieceTypes[((i-1) * cols + j)*4 + 2];
                right = (random() % 2);
                down = (random() % 2);
                left = 2;
            }
            else if(j == cols - 1)
            {
                top = 1 - pieceTypes[((i-1) * cols + j)*4 + 2];
                right = 2;
                down = (random() % 2);
                left = 1 - pieceTypes[(i * cols + (j-1))*4 + 1];
            }
            else
            {
                top = 1 - pieceTypes[((i-1) * cols + j)*4 + 2];
                right = (random() % 2);
                down = (random() % 2);
                left = 1 - pieceTypes[(i * cols + (j-1))*4 + 1];
            }
            
            pieceTypes[(i * cols + j)*4 + 0] = top;
            pieceTypes[(i * cols + j)*4 + 1] = right;
            pieceTypes[(i * cols + j)*4 + 2] = down;
            pieceTypes[(i * cols + j)*4 + 3] = left;
        }
    }
    
    return pieceTypes;
    
}


@end
