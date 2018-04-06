//
//  NewsFeedViewController.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 05.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "NewsFeedViewController.h"

@interface NewsFeedViewController ()
    @property (nonatomic) NSArray *listOfNews;
@end

@implementation NewsFeedViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.listOfNews = @[@"First", @"Second", @"Third", @"Fourth"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listOfNews count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *newsFeedIdentifier = @"NewsFeedItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:newsFeedIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:newsFeedIdentifier];
    }
    
    cell.textLabel.text = [self.listOfNews objectAtIndex:indexPath.row];
    return cell;
}

@end
