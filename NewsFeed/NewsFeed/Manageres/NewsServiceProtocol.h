//
//  NewsServiceProtocol.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 13.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "StoryDB+MyExtension.h"
#import "Story.h"

@protocol NewsServiceProtocol

- (void)getTopStoriesWithCompletion:(void(^)(NSArray<Story *> *stories, NSError *error))completionHandler;

@end
