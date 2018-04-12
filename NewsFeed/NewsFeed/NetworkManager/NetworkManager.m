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
    
    if (self = [super init]) {
        self.defaultURL = @"https://hacker-news.firebaseio.com/v0/";
    }
    return self;
    
}

- (id)initWith:(NSString *)userURL {
    
    if (self = [super init]) {
        self.defaultURL = userURL;
    }
    return self;
    
}

/*- (void)getStoryByID:(NSNumber *)storyID withCompletion:(void (^)(Story *story, NSError *error))completionHahdler {
    
    NSString *newsURL = [NSString stringWithFormat:@"%@item/%@.json", self.defaultURL, storyID];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:newsURL]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *jsonData, NSURLResponse *response, NSError *error) {
        
        Story *story = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
        if (![jsonObject isKindOfClass:[NSArray class]]) {
            NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
            story = [[Story alloc] initWithDictionary:jsonDictionary];
        }
        
        if (completionHahdler) {
            completionHahdler(story, error);
        }
        
    }] resume];
    
}*/

- (void)getStoryByID:(NSNumber *)storyID withCompletion:(void (^)(StoryDB *story, NSError *error))completionHahdler {
    
    NSString *newsURL = [NSString stringWithFormat:@"%@item/%@.json", self.defaultURL, storyID];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:newsURL]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *jsonData, NSURLResponse *response, NSError *error) {
        
        StoryDB *story = [[StoryDB alloc] init];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
        if (![jsonObject isKindOfClass:[NSArray class]]) {
            NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
            [story setupWithDictionary:jsonDictionary];
        }
        
        if (completionHahdler) {
            completionHahdler(story, error);
        }
        
    }] resume];
    
}

- (void)getTopStoriesIDsWithCompletion:(void(^)(NSArray *storiesIDs, NSError *error))completionHandler {
    
    NSString *topStoriesURL = [NSString stringWithFormat:@"%@topstories.json", self.defaultURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:topStoriesURL]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *jsonData, NSURLResponse *response, NSError *error) {
        
        NSMutableArray *tenTopStoriesIDs = [[NSMutableArray alloc] init];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
        if ([jsonObject isKindOfClass:[NSArray class]]) {
            NSArray *topStoriesIDs = (NSArray *)jsonObject;
            for (int i = 0; i < 10; i++){
                tenTopStoriesIDs[i] = topStoriesIDs[i];
            }
        }
        
        if (completionHandler) {
            completionHandler([tenTopStoriesIDs copy], error);
        }
        
    }] resume];
    
}

- (void)getTopStoriesWithCompletion:(void(^)(NSArray<StoryDB *> *stories, NSError *error))completionHandler {
    
    NSMutableArray<StoryDB *> *topStories = [[NSMutableArray alloc] init];
    __block NSError *networkError;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    [self getTopStoriesIDsWithCompletion:^(NSArray *storiesIDs, NSError *error) {
        
        if (error || !storiesIDs ) {
            networkError = error;
            dispatch_group_leave(group);
            return;
        }
        for (NSNumber *storyID in storiesIDs) {
            dispatch_group_enter(group);
            [self getStoryByID:storyID withCompletion:^(StoryDB *story, NSError *error) {
                
                if (story) {
                    [topStories addObject:story];
                }
                
                if (error) {
                    networkError = error;
                }
                
                dispatch_group_leave(group);
            }];
        }
        dispatch_group_leave(group);
        
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completionHandler) {
            completionHandler([topStories copy], networkError);
        }
    });
    
}

- (void)getHTMLByStory:(StoryDB *)story withCompletion:(void(^)(NSURLRequest *htmlStory, NSError *error))completionHandler {
    
    NSString *storyURL = story.url;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:storyURL]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *jsonData, NSURLResponse *response, NSError *error) {
        /*
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        
        if ([jsonObject isKindOfClass:[NSArray class]]) {
            NSArray *topStoriesIDs = (NSArray *)jsonObject;
            for (int i = 0; i < 10; i++){
                tenTopStoriesIDs[i] = topStoriesIDs[i];
            }
        }
        */
        if (completionHandler) {
            completionHandler(request, error);
        }
        
    }] resume];
    
}

@end
