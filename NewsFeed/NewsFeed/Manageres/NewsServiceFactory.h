//
//  NewsServiceFactory.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 13.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsServiceProtocol.h"

@interface NewsServiceFactory : NSObject

+ (id<NewsServiceProtocol>)getService;

@end
