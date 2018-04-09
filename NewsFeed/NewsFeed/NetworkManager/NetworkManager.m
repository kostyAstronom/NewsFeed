//
//  NetworkManager.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 06.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager

- (id)init {
    
    self = [super init];
    self.defaultURL = @"https://hacker-news.firebaseio.com/v0/";
    return self;
    
}

- (id)initWith:(NSString*)userURL {
    
    self = [super init];
    self.defaultURL = userURL;
    return self;
    
}

- (void)getStoryByID:(NSNumber*)itemID withCompletion:(void (^)(Story *story, NSError *error))completionHahdler {
    
    NSString *newsURL = [NSString stringWithFormat:@"%@item/%@.json", self.defaultURL, itemID];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:newsURL]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Data received: %@", myString);
        if(completionHahdler){
            //completionHahdler(nil, error);
        }
        
    }] resume];
    
}

- (NSArray*)getTopStoriesIDsWithCompletion:(void(^)(NSArray *storiesIDs, NSError *error))completionHandler {
    
    NSArray *topStoriesIDs;
    
    NSString *topStoriesURL = [NSString stringWithFormat:@"%@topstories.json", self.defaultURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:topStoriesURL]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"Data received: %@", myString);
        if (completionHandler) {
            completionHandler(@[], error);
        }
        
    }] resume];
    
    return topStoriesIDs;
    
}

- (NSArray*)getTopStoriesWithCompletion:(void(^)(NSArray *stories, NSError *error))completionHandler {
    
    NSArray *topStories;

    [self getTopStoriesIDsWithCompletion:^(NSArray *storiesIDs, NSError *error) {
        
        for(NSNumber *storyID in storiesIDs) {
            [self getStoryByID:storyID withCompletion:^(Story *story, NSError *error) {
                // code
            }];
        }
        
    }];
    
    return topStories;
    
}

@end
