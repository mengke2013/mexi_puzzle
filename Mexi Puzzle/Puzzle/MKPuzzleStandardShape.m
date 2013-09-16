//
//  MKClassicPuzzleShape.m
//  Dream Puzzle
//
//  Created by iMacPro05 on 31/8/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import "MKPuzzleStandardShape.h"
#import "MKPuzzle.h"

@implementation MKPuzzleStandardShape

-(CGMutablePathRef)pathWithScale:(CGFloat)scale typeTop:(int)typeTop typeRight:(int)typeRight typeDown:(int)typeDown typeLeft:(int)typeLeft
{
    //    CGMutablePathRef* pathRef = malloc(2*sizeof(CGMutablePathRef));
    
    CGFloat _scale = scale;
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathMoveToPoint(pathRef, NULL, _scale+self.magine.width, _scale+self.magine.height);
    
    [self addPath:pathRef scale:_scale startPoint:CGPointMake(self.magine.width, self.magine.height) type1:0 type2:typeTop];
    [self addPath:pathRef scale:_scale startPoint:CGPointMake(self.magine.width, self.magine.height) type1:1 type2:typeRight];
    [self addPath:pathRef scale:_scale startPoint:CGPointMake(self.magine.width, self.magine.height) type1:2 type2:typeDown];
    [self addPath:pathRef scale:_scale startPoint:CGPointMake(self.magine.width, self.magine.height) type1:3 type2:typeLeft];
    
    
    return pathRef;
    
}

-(void) addPath:(CGMutablePathRef)pathRef scale:(CGFloat)scale startPoint:(CGPoint)startPoint type1:(int)type1 type2:(int)type2
{
    CGSize size = CGSizeMake((self.size.width), self.size.height);
    
    CGFloat pointX = startPoint.x;
    CGFloat pointY = startPoint.y;
    
    if(type1 ==1)
    {
        pointX = startPoint.x+size.width;
        pointY = startPoint.y;
    }
    else if(type1 ==2)
    {
        pointX = startPoint.x+size.width;
        pointY = startPoint.y+size.height;
    }
    else if(type1 ==3)
    {
        pointX = startPoint.x;
        pointY = startPoint.y+size.height;
    }
    
    
    if(type1==0)
    {
        
        if(type2==2)
        {
            CGPathAddLineToPoint(pathRef, NULL, pointX - scale + size.width,pointY + scale);
        }
        else
        {
            CGPathAddLineToPoint(pathRef, NULL, pointX + (size.width/2), pointY + scale);
            
            if(type2 == 1)
            {
                CGPathAddLineToPoint(pathRef, NULL, pointX + (size.width/2), pointY);
                CGPathAddArc(pathRef, NULL, pointX + size.width/2, pointY-self.magine.height/2, self.magine.height/2-scale, MKMathDegreesToRadians(270),  MKMathDegreesToRadians(-90), YES);
            }
            else
            {
                CGPathAddArc(pathRef, NULL, pointX + size.width/2, pointY+self.magine.height/2, self.magine.height/2+scale,scale==0?MKMathDegreesToRadians(270):MKMathDegreesToRadians(180)+asin((self.magine.height/2-scale)/(self.magine.height/2+scale)), scale==0?MKMathDegreesToRadians(-90):MKMathDegreesToRadians(0)-asin((self.magine.height/2-scale)/(self.magine.height/2+scale)),                                                    YES);
            }
            
            CGPathAddLineToPoint(pathRef, NULL, pointX + (size.width/2), pointY + scale);
            CGPathAddLineToPoint(pathRef, NULL, pointX - scale + size.width,pointY + scale);
        }
    }
    if(type1==1)
    {
        if(type2==2)
        {
            CGPathAddLineToPoint(pathRef, NULL, pointX - scale, pointY - scale + size.height);
        }
        else
        {
            CGPathAddLineToPoint(pathRef, NULL, pointX - scale, pointY  + (size.height/2));
            if(type2 == 1)
            {
                CGPathAddLineToPoint(pathRef, NULL, pointX, pointY + (size.height/2));
                CGPathAddArc(pathRef, NULL, pointX+self.magine.width/2, pointY + size.height/2, self.magine.width/2-scale, MKMathDegreesToRadians(180),  MKMathDegreesToRadians(-180), YES);
            }
            else
            {
                CGPathAddArc(pathRef, NULL, pointX - self.magine.width/2,pointY + size.height/2, self.magine.width/2+scale,scale==0?MKMathDegreesToRadians(180):MKMathDegreesToRadians(-90)+asin((self.magine.width/2-scale)/(self.magine.width/2+scale)), scale==0?MKMathDegreesToRadians(-180):MKMathDegreesToRadians(90)-asin((self.magine.width/2-scale)/(self.magine.width/2+scale)),                                                    YES);
            }
            
            
            CGPathAddLineToPoint(pathRef, NULL, pointX - scale, pointY + size.height/2);
            CGPathAddLineToPoint(pathRef, NULL, pointX - scale, pointY - scale + size.height);
        }
    }
    else if(type1==2)
    {
        if(type2==2)
        {
            CGPathAddLineToPoint(pathRef, NULL, pointX + scale - size.width,pointY - scale);
        }
        else
        {
            CGPathAddLineToPoint(pathRef, NULL, pointX - size.width/2, pointY - scale);
            if(type2 == 1)
            {
                CGPathAddLineToPoint(pathRef, NULL, pointX - size.width/2, pointY);
                CGPathAddArc(pathRef, NULL, pointX - size.width/2, pointY+self.magine.height/2, self.magine.height/2-scale, MKMathDegreesToRadians(-90),  MKMathDegreesToRadians(270), YES);
            }
            else
            {
                CGPathAddArc(pathRef, NULL, pointX - size.width/2, pointY-self.magine.height/2, self.magine.height/2+scale,scale==0?MKMathDegreesToRadians(-90):MKMathDegreesToRadians(0)+asin((self.magine.height/2-scale)/(self.magine.height/2+scale)), scale==0?MKMathDegreesToRadians(270):MKMathDegreesToRadians(180)-asin((self.magine.height/2-scale)/(self.magine.height/2+scale)),                                                    YES);
            }
            
            
            CGPathAddLineToPoint(pathRef, NULL, pointX - size.width/2, pointY - scale);
            CGPathAddLineToPoint(pathRef, NULL, pointX + scale - size.width,pointY - scale);
        }
    }
    if(type1==3)
    {
        if(type2==2)
        {
            CGPathAddLineToPoint(pathRef, NULL, pointX + scale, pointY + (type2==1?scale:-scale) - size.height);
        }
        else
        {
            CGPathAddLineToPoint(pathRef, NULL, pointX + scale, pointY - size.height/2);
            if(type2 == 1)
            {
                CGPathAddLineToPoint(pathRef, NULL, pointX, pointY - size.height/2);
                CGPathAddArc(pathRef, NULL, pointX-self.magine.width/2, pointY - size.height/2, self.magine.width/2-scale, MKMathDegreesToRadians(-180),  MKMathDegreesToRadians(180), YES);
            }
            else
            {
                CGPathAddArc(pathRef, NULL, pointX + self.magine.width/2,pointY - size.height/2, self.magine.width/2+scale,scale==0?MKMathDegreesToRadians(-180):MKMathDegreesToRadians(90)+asin((self.magine.width/2-scale)/(self.magine.width/2+scale)), scale==0?MKMathDegreesToRadians(180):MKMathDegreesToRadians(-90)-asin((self.magine.width/2-scale)/(self.magine.width/2+scale)),                                                    YES);
            }
            CGPathAddLineToPoint(pathRef, NULL, pointX + scale, pointY - size.height/2);
            CGPathAddLineToPoint(pathRef, NULL, pointX + scale, pointY + (type2==1?scale:-scale) - size.height);
        }
    }
    
}

@end
