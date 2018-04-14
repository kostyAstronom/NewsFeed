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

- (void)getTopStoriesWithCompletion:(void(^)(NSArray<Story *> *stories, NSError *error))completionHandler {
    
    NSMutableArray<Story *> *topStories = [NSMutableArray new];
    __block NSError *networkError;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    
    [self getTopStoriesIDsWithCompletion:^(NSArray<NSNumber *> *storiesIDs, NSError *error) {
        
        if (error || !storiesIDs ) {
            networkError = error;
            dispatch_group_leave(group);
            return;
        }
        for (NSNumber *storyID in storiesIDs) {
            dispatch_group_enter(group);
            [self getStoryByID:storyID withCompletion:^(Story *story, NSError *error) {
                
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

- (void)getTopStoriesIDsWithCompletion:(void(^)(NSArray<NSNumber *> *storiesIDs, NSError *error))completionHandler {
    
    NSMutableArray *tenTopStoriesIDs = [NSMutableArray new];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@topstories.json", self.defaultURL]]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *jsonData, NSURLResponse *response, NSError *error) {
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        if (error) {
            return;
        }
        if (jsonObject) {
            NSArray<NSNumber *> *topStoriesIDs = (NSArray *)jsonObject;
            for (int i = 0; i < 10 && i < topStoriesIDs.count; i++) {
                tenTopStoriesIDs[i] = topStoriesIDs[i];
            }
        }
        if (completionHandler) {
            completionHandler([tenTopStoriesIDs copy], error);
        }
        
    }] resume];
    
}

- (void)getStoryByID:(NSNumber *)storyID withCompletion:(void (^)(Story *story, NSError *error))completionHahdler {
    
    Story *story = [Story new];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@item/%@.json", self.defaultURL, storyID]]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *jsonData, NSURLResponse *response, NSError *error) {
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        if (error) {
            return;
        }
        if (jsonObject) {
            NSMutableDictionary *jsonDictionary = (NSMutableDictionary *)jsonObject;
            
            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            path = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.html", jsonDictionary[@"id"]]];
            
            NSURL *storyURL = [NSURL URLWithString:jsonDictionary[@"url"]];
            NSData *urlData = [NSData dataWithContentsOfURL:storyURL];
            
            BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];
            if (!fileExists) {
                [urlData writeToFile:path atomically:YES];
            }
            NSURL *storedHtml = [NSURL URLWithString:path];
            
            NSMutableDictionary *dictionary = [NSMutableDictionary new];
            dictionary[@"by"] = jsonDictionary[@"by"];
            dictionary[@"descendants"] = jsonDictionary[@"descendants"];
            dictionary[@"id"] = jsonDictionary[@"id"];
            dictionary[@"kids"] = jsonDictionary[@"kids"];
            dictionary[@"score"] = jsonDictionary[@"score"];
            dictionary[@"time"] = jsonDictionary[@"time"];
            dictionary[@"title"] = jsonDictionary[@"title"];
            dictionary[@"type"] = jsonDictionary[@"type"];
            dictionary[@"url"] = jsonDictionary[@"url"];
            dictionary[@"storedHtml"] = storedHtml;
            
            [story setupWithDictionary:dictionary];
        }
        if (completionHahdler) {
            completionHahdler(story, error);
        }
        
    }] resume];
    
}

- (void)getHTMLByStory:(StoryDB *)story withCompletion:(void(^)(NSURLRequest *htmlStory, NSError *error))completionHandler {
    
    NSString *storyURL = story.url;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:storyURL]];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *jsonData, NSURLResponse *response, NSError *error) {
        
        if (completionHandler) {
            completionHandler(request, error);
        }
        
    }] resume];
    
}

@end
