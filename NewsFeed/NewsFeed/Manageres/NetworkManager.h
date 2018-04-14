//
//  NetworkManager.h
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 06.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsServiceProtocol.h"

@interface NetworkManager : NSObject <NewsServiceProtocol>

@property NSString *defaultURL;

- (id)initWith:(NSString *)userURL;

@end
