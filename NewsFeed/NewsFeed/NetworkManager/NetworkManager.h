//
//  NetworkManager.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 06.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoryDB+CoreDataProperties.h"
#import "Story.h"

@interface NetworkManager : NSObject

@property NSString *defaultURL;

- (id)initWith:(NSString *)userURL;
- (void)getStoryByID:(NSNumber *)storyID withCompletion:(void (^)(StoryDB *story, NSError *error))completionHahdler;
- (void)getTopStoriesIDsWithCompletion:(void(^)(NSArray *storiesIDs, NSError *error))completionHandler;
- (void)getTopStoriesWithCompletion:(void(^)(NSArray<StoryDB *> *stories, NSError *error))completionHandler;
- (void)getHTMLByStory:(StoryDB *)story withCompletion:(void(^)(NSURLRequest *htmlStory, NSError *error))completionHandler;

@end
