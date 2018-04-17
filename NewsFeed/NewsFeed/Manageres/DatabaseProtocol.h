//
//  DatabaseProtocol.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 17.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "Story.h"

@protocol DatabaseProtocol

- (void)getTopStoriesWithCompletion:(void(^)(NSArray<Story *> *stories, NSError *error))completionHandler;
- (void)saveStory:(Story *)story;
- (void)deleteStory:(Story *)story;

@end
