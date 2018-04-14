//
//  NewsServiceFactory.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 13.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "NewsServiceFactory.h"
#import "MockNetworkManager.h"
#import "NetworkManager.h"
#import "NewsService.h"

@implementation NewsServiceFactory

+ (id<NewsServiceProtocol>)getService {
    return [NewsService new];
}

@end
