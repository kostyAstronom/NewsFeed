//
//  Story.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 09.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Story : NSObject 

@property NSString *by;
@property NSNumber *descendants;
@property NSNumber *storyID;
@property NSArray *kids;
@property NSNumber *score;
@property NSNumber *time;
@property NSString *title;
@property NSString *url;
@property NSURL *storedHtml;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
