//
//  MKPuzzleClassicShape.m
//  Dream Puzzle
//
//  Created by iMacPro05 on 11/9/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import "MKPuzzleClassicShape.h"
#import "MKPuzzle.h"

@implementation MKPuzzleClassicShape


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
            if(type2 == 1)
            {
                CGPathAddCurveToPoint(pathRef, NULL, pointX + (size.width*2/5), pointY+size.height/15+scale, pointX + (size.width*2/5), pointY+size.height/15+scale, pointX + (size.width*2/5), pointY+size.height/30+scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX + (size.width*2/5) + scale, pointY+size.height/30);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX + (size.width*2/5)-size.width/30 + scale, pointY-size.height/20, pointX + (size.width/3)-size.width/60 + scale, pointY-size.height/20, pointX + (size.width/3) + scale, pointY-size.height/10);
                
                 CGPathAddLineToPoint(pathRef, NULL, pointX + (size.width/3), pointY-size.height/10+scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX + (size.width/2), pointY-size.height/10-size.height/10+scale, pointX + (size.width/2), pointY-size.height/10-size.height/10+scale, pointX + (size.width*2/3), pointY-size.height/10+scale);
                
                 CGPathAddLineToPoint(pathRef, NULL, pointX + (size.width*2/3) - scale, pointY-size.height/10);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX + (size.width*2/3)+size.width/60 - scale, pointY-size.height/20, pointX + (size.width*3/5)+size.width/30 - scale, pointY-size.height/20, pointX + (size.width*3/5) - scale, pointY+size.height/30);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX + (size.width*3/5), pointY+size.height/30+scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX + (size.width*3/5), pointY+size.height/15+scale, pointX + (size.width*3/5), pointY+size.height/15+scale, pointX - scale + size.width,pointY + scale);
            }
            else
            {
                CGPathAddCurveToPoint(pathRef, NULL, pointX + (size.width*2/5), pointY-size.height/15+scale, pointX + (size.width*2/5), pointY-size.height/15+scale, pointX + (size.width*2/5), pointY-size.height/30+scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX + (size.width*2/5) - scale, pointY-size.height/30);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX + (size.width*2/5)-size.width/30 - scale, pointY+size.height/20, pointX + (size.width/3)-size.width/60 - scale, pointY+size.height/20, pointX + (size.width/3) - scale, pointY+size.height/10);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX + (size.width/3), pointY+size.height/10+scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX + (size.width/2), pointY+size.height/10+size.height/10+scale, pointX + (size.width/2), pointY+size.height/10+size.height/10+scale, pointX + (size.width*2/3), pointY+size.height/10+scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX + (size.width*2/3) + scale, pointY+size.height/10);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX + (size.width*2/3)+size.width/60 + scale, pointY+size.height/20, pointX + (size.width*3/5)+size.width/30 + scale, pointY+size.height/20, pointX + (size.width*3/5) + scale, pointY-size.height/30);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX + (size.width*3/5), pointY-size.height/30+scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX + (size.width*3/5), pointY-size.height/15+scale, pointX + (size.width*3/5), pointY-size.height/15+scale, pointX - scale + size.width,pointY + scale);
            }
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
            if(type2 == 1)
            {

                CGPathAddCurveToPoint(pathRef, NULL, pointX-size.width/15-scale, pointY + (size.height*2/5), pointX-size.width/15-scale, pointY + (size.height*2/5), pointX-size.width/30-scale, pointY + (size.height*2/5));
                
                CGPathAddLineToPoint(pathRef, NULL, pointX-size.width/30, pointY + (size.height*2/5) + scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX + size.width/20, pointY + (size.height*2/5) - size.height/30 + scale, pointX+size.width/20, pointY + (size.height/3)-size.height/60 + scale, pointX+size.width/10,  pointY + (size.height/3) + scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX+size.width/10-scale, pointY + (size.height/3));
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX+size.width/10+size.width/10-scale, pointY + (size.height/2), pointX+size.width/10+size.width/10-scale, pointY + (size.height/2), pointX+size.width/10-scale,  pointY + (size.height*2/3));
                
                CGPathAddLineToPoint(pathRef, NULL, pointX+size.width/10, pointY + (size.height*2/3) - scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX+size.width/20, pointY + (size.height*2/3)+size.height/60 - scale, pointX+size.width/20, pointY + (size.height*3/5)+size.height/30 - scale, pointX-size.width/30,  pointY + (size.height*3/5) - scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX-size.width/30-scale, pointY + (size.height*3/5));
                
                CGPathAddCurveToPoint(pathRef, NULL,  pointX-size.width/15-scale,pointY + (size.height*3/5), pointX-size.width/15-scale,pointY + (size.height*3/5),pointX - scale,  pointY - scale + size.height);
            }
            else
            {
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX+size.width/15-scale, pointY + (size.height*2/5), pointX+size.width/15-scale, pointY + (size.height*2/5), pointX+size.width/30-scale, pointY + (size.height*2/5));
                
                CGPathAddLineToPoint(pathRef, NULL, pointX+size.width/30, pointY + (size.height*2/5) - scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX -size.width/20, pointY + (size.height*2/5) - size.height/30 - scale, pointX-size.width/20, pointY + (size.height/3)-size.height/60 - scale, pointX-size.width/10,  pointY + (size.height/3) - scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX-size.width/10-scale, pointY + (size.height/3));
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX-size.width/10-size.width/10-scale, pointY + (size.height/2), pointX-size.width/10-size.width/10-scale, pointY + (size.height/2), pointX-size.width/10-scale,  pointY + (size.height*2/3));
                
                CGPathAddLineToPoint(pathRef, NULL, pointX-size.width/10, pointY + (size.height*2/3) + scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX-size.width/20, pointY + (size.height*2/3)+size.height/60 + scale, pointX-size.width/20, pointY + (size.height*3/5)+size.height/30 + scale, pointX+size.width/30,  pointY + (size.height*3/5) + scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX+size.width/30-scale, pointY + (size.height*3/5));
                
                CGPathAddCurveToPoint(pathRef, NULL,  pointX+size.width/15-scale,pointY + (size.height*3/5), pointX+size.width/15-scale,pointY + (size.height*3/5),pointX - scale,  pointY - scale + size.height);
            }
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
            if(type2 == 1)
            {
                CGPathAddCurveToPoint(pathRef, NULL, pointX - (size.width*2/5), pointY-size.height/15-scale, pointX - (size.width*2/5), pointY-size.height/15-scale, pointX - (size.width*2/5), pointY-size.height/30-scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX - (size.width*2/5) - scale, pointY-size.height/30);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX - (size.width*2/5) + size.width/30 - scale, pointY+size.height/20, pointX - (size.width/3)+size.width/60 - scale, pointY+size.height/20, pointX - (size.width/3) - scale, pointY+size.height/10);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX - (size.width/3), pointY+size.height/10-scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX - (size.width/2), pointY+size.height/10+size.height/10-scale, pointX - (size.width/2), pointY+size.height/10+size.height/10-scale, pointX - (size.width*2/3), pointY+size.height/10-scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX - (size.width*2/3) + scale, pointY+size.height/10);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX - (size.width*2/3)-size.width/60 + scale, pointY+size.height/20, pointX - (size.width*3/5)-size.width/30 + scale, pointY+size.height/20, pointX - (size.width*3/5) + scale, pointY-size.height/30);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX - (size.width*3/5), pointY-size.height/30-scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX - (size.width*3/5), pointY-size.height/15-scale, pointX - (size.width*3/5), pointY-size.height/15-scale, pointX + scale - size.width,pointY - scale);
            }
            else
            {
                CGPathAddCurveToPoint(pathRef, NULL, pointX - (size.width*2/5), pointY+size.height/15-scale, pointX - (size.width*2/5), pointY+size.height/15-scale, pointX - (size.width*2/5), pointY+size.height/30-scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX - (size.width*2/5) + scale, pointY+size.height/30);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX - (size.width*2/5) + size.width/30 + scale, pointY-size.height/20, pointX - (size.width/3)+size.width/60 + scale, pointY-size.height/20, pointX - (size.width/3) + scale, pointY-size.height/10);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX - (size.width/3), pointY-size.height/10-scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX - (size.width/2), pointY-size.height/10-size.height/10-scale, pointX - (size.width/2), pointY-size.height/10-size.height/10-scale, pointX - (size.width*2/3), pointY-size.height/10-scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX - (size.width*2/3) - scale, pointY-size.height/10);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX - (size.width*2/3)-size.width/60 - scale, pointY-size.height/20, pointX - (size.width*3/5)-size.width/30 - scale, pointY-size.height/20, pointX - (size.width*3/5) - scale, pointY+size.height/30);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX - (size.width*3/5), pointY+size.height/30-scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX - (size.width*3/5), pointY+size.height/15-scale, pointX - (size.width*3/5), pointY+size.height/15-scale, pointX + scale - size.width,pointY - scale);
            }
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
//            CGPathAddLineToPoint(pathRef, NULL, pointX + scale, pointY - size.height/2);
            if(type2 == 1)
            {
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX+size.width/15+scale, pointY - (size.height*2/5), pointX+size.width/15+scale, pointY - (size.height*2/5), pointX+size.width/30+scale, pointY - (size.height*2/5));
                
                CGPathAddLineToPoint(pathRef, NULL, pointX+size.width/30, pointY - (size.height*2/5) - scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX - size.width/20, pointY - (size.height*2/5) + size.height/30 - scale, pointX-size.width/20, pointY - (size.height/3)+size.height/60 - scale, pointX-size.width/10,  pointY - (size.height/3) - scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX-size.width/10+scale, pointY - (size.height/3));
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX-size.width/10-size.width/10+scale, pointY - (size.height/2), pointX-size.width/10-size.width/10+scale, pointY - (size.height/2), pointX-size.width/10+scale,  pointY - (size.height*2/3));
                
                CGPathAddLineToPoint(pathRef, NULL, pointX-size.width/10, pointY - (size.height*2/3) + scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX-size.width/20, pointY - (size.height*2/3)-size.height/60 + scale, pointX-size.width/20, pointY - (size.height*3/5)-size.height/30 + scale, pointX+size.width/30,  pointY - (size.height*3/5) + scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX+size.width/30+scale, pointY - (size.height*3/5));
                
                CGPathAddCurveToPoint(pathRef, NULL,  pointX+size.width/15+scale,pointY - (size.height*3/5), pointX+size.width/15+scale,pointY - (size.height*3/5),pointX + scale,  pointY + scale - size.height);
            }
            else
            {
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX-size.width/15+scale, pointY - (size.height*2/5), pointX-size.width/15+scale, pointY - (size.height*2/5), pointX-size.width/30+scale, pointY - (size.height*2/5));
                
                CGPathAddLineToPoint(pathRef, NULL, pointX-size.width/30, pointY - (size.height*2/5) + scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX + size.width/20, pointY - (size.height*2/5) + size.height/30 + scale, pointX+size.width/20, pointY - (size.height/3)+size.height/60 + scale, pointX+size.width/10,  pointY - (size.height/3) + scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX+size.width/10+scale, pointY - (size.height/3));
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX+size.width/10+size.width/10+scale, pointY - (size.height/2), pointX+size.width/10+size.width/10+scale, pointY - (size.height/2), pointX+size.width/10+scale,  pointY - (size.height*2/3));
                
                CGPathAddLineToPoint(pathRef, NULL, pointX+size.width/10, pointY - (size.height*2/3) - scale);
                
                CGPathAddCurveToPoint(pathRef, NULL, pointX+size.width/20, pointY - (size.height*2/3)-size.height/60 - scale, pointX+size.width/20, pointY - (size.height*3/5)-size.height/30 - scale, pointX-size.width/30,  pointY - (size.height*3/5) - scale);
                
                CGPathAddLineToPoint(pathRef, NULL, pointX-size.width/30+scale, pointY - (size.height*3/5));
                
                CGPathAddCurveToPoint(pathRef, NULL,  pointX-size.width/15+scale,pointY - (size.height*3/5), pointX-size.width/15+scale,pointY - (size.height*3/5),pointX + scale,  pointY + scale - size.height);
            }
        }
    }
    
}

@end
