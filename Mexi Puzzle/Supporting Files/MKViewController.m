//
//  MKViewController.m
//  Dream Puzzle
//
//  Created by iMacPro05 on 26/8/13.
//  Copyright (c) 2013 iMacPro05. All rights reserved.
//

#import "MKViewController.h"
#import <mexica/MKScene.h>
#import <mexica/MKSprite.h>
#import <mexica/MKAction.h>
#import <mexica/MKBaseGame.h>
#import "MKPuzzleGame.h"


@interface MKViewController () {
    MKBaseGame* game;
    MKScene* scene;
}

@property (strong, nonatomic) EAGLContext *context;
@property (nonatomic, strong, readwrite) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong, readwrite) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, strong, readwrite) UIPinchGestureRecognizer *pinchRecognizer;

-(void)setupGame;

@end

@implementation MKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [EAGLContext setCurrentContext:self.context];
    
    glEnable(GL_DEPTH_TEST);

    
    
    {  // Create a tap recognizer and add it to the view.
        UITapGestureRecognizer *recognizer;
        recognizer =
        [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleTapFrom:)];
        [self.view addGestureRecognizer:recognizer];
        self.tapRecognizer = recognizer;
        recognizer.delegate = self;
    }
    
    
    {  // Create a pan recognizer and add it to the view.
        UIPanGestureRecognizer *recognizer;
        recognizer =
        [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handlePanFrom:)];
        [self.view addGestureRecognizer:recognizer];
        self.panRecognizer = recognizer;
        recognizer.delegate = self;
    }
    
    {  // Create a pinch recognizer and add it to the view.
        UIPinchGestureRecognizer *recognizer;
        recognizer =
        [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handlePinchFrom:)];
        [self.view addGestureRecognizer:recognizer];
        self.pinchRecognizer = recognizer;
        recognizer.delegate = self;
    }
    
    [self setupGame];
}

-(void)setupGame
{
    scene = [[MKScene alloc] initWithImage:nil size:CGSizeMake(self.view.bounds.size.width*2,self.view.bounds.size.height*2) width:self.view.bounds.size.width height:self.view.bounds.size.height];
    scene.visible = NO;
//    game = [[MKBaseGame alloc]init];
    game = [[MKPuzzleGame alloc]init];
    [game setupGame:scene size:self.view.bounds.size];
}

- (void)dealloc
{
    [EAGLContext setCurrentContext:self.context];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    scene = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [EAGLContext setCurrentContext:self.context];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
    
    scene = nil;
}


#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    NSTimeInterval interval = [self timeSinceLastDraw];
    [scene update:interval];
    [game update:interval];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
//        glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    [scene draw];
    
}

-(BOOL)shouldAutorotate
{
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch
{
    BOOL     result = NO;
    
    if(gestureRecognizer == self.tapRecognizer ||
       gestureRecognizer == self.panRecognizer ||
       gestureRecognizer == self.pinchRecognizer)
    {
        result = YES;
    }
    
    return result;
}


- (void)handleTapFrom:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:self.view];
    [scene onTap:CGPointMake(location.x - self.view.bounds.size.width/2, self.view.bounds.size.height/2-location.y)];
}


- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:self.view];
    CGPoint translation = [recognizer translationInView:self.view];
    [scene onPan:[recognizer state] location:CGPointMake(location.x - self.view.bounds.size.width/2, self.view.bounds.size.height/2-location.y) translation:CGPointMake(translation.x, -translation.y)];
}

- (void)handlePinchFrom:(UIPinchGestureRecognizer *)recognizer
{
    CGFloat scale = [recognizer scale];
    [scene onPinch:[recognizer state] scale:scale];
    
    if ([recognizer state] == UIGestureRecognizerStateBegan ||
        [recognizer state] == UIGestureRecognizerStateChanged)
    {

        
    }
}

@end
