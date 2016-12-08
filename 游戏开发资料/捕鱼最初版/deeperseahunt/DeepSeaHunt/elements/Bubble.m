//
//  Bubble.m
//  DeepSeaHunt
//
//  Created by 东海 阮 on 12-8-15.
//  Copyright 2012年 akn. All rights reserved.
//

#import "Bubble.h"
#import "GameDefine.h"


@implementation Bubble
- (void)setActions
{	float x = random() % (int)GAME_SCENE_SIZE.width;
    float y = random() % (int)GAME_SCENE_SIZE.height;
	self.position = ccp(x, y);
	id flyToGoal = [CCMoveTo actionWithDuration:(GAME_SCENE_SIZE.height - self.position.y) / 20  position:ccp(self.position.x, GAME_SCENE_SIZE.height)];
	id finish = [CCCallFunc actionWithTarget:self selector:@selector(clean)];
	[self runAction:[CCSequence actions:flyToGoal, finish, nil]];
}

+ (id)bubbleWithFile:(NSString *)fileSrc
{
	self = [Bubble spriteWithFile:fileSrc];
	return self;
}

- (void)clean
{
	[self unscheduleAllSelectors];
	self.visible = NO;
	
}
@end