//
//  NetworkManager.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 06.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Story.h"

@interface NetworkManager : NSObject {
    
    NSString *defaultURL;
    
}

@property NSString *defaultURL;

- (id)initWith:(NSString*)userURL;
- (void)getStoryByID:(NSNumber*)itemID withCompletion:(void (^)(Story *story, NSError *error))completionHahdler;
- (NSArray*)getTopStoriesIDsWithCompletion:(void(^)(NSArray *storiesIDs, NSError *error))completionHandler;
- (NSArray*)getTopStoriesWithCompletion:(void(^)(NSArray *stories, NSError *error))completionHandler;

@end
