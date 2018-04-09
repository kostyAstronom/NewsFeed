//
//  Story.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 09.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject {
    
    NSString *author;
    NSNumber *descendants;
    NSNumber *storyID;
    NSArray *kids;
    NSNumber *score;
    NSDate *time;
    NSString *title;
    NSString *url;
    
}

@property NSString *author;
@property NSNumber *descendants;
@property NSNumber *storyID;
@property NSArray *kids;
@property NSNumber *score;
@property NSDate *time;
@property NSString *title;
@property NSString *url;

@end
