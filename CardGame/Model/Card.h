//
//  Card.h
//  CardGame
//
//  Created by Jonathan Wong on 3/30/14.
//  Copyright (c) 2014 Jonathan Wong. All rights reserved.
//
//this is another change

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property(strong, nonatomic) NSString *contents;
@property(nonatomic, getter = isMatched) BOOL matched;
@property(nonatomic, getter = isChosen) BOOL chosen;

- (int)match:(NSArray *)otherCards;

@end