//
//  SingleNewsViewController.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 11.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "SingleNewsViewController.h"

@interface SingleNewsViewController ()

@end

@implementation SingleNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpWith:[self story]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpWith:(Story *)story {
    
    if (story) {
        self.title = story.title;
        
        NSTimeInterval timestamp = (NSTimeInterval)[story.time doubleValue];
        NSDate *updatetimestamp = [NSDate dateWithTimeIntervalSince1970:timestamp];
        self.timeLabel.text = [NSString stringWithFormat:@"%@", updatetimestamp];
        self.timeLabel.text = [NSString stringWithFormat:@"%@", story.time];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:story.storedHtml]];
    }
    
}

@end
