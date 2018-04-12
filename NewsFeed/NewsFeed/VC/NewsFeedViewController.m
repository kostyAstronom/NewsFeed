//
//  NewsFeedViewController.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 05.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "NewsFeedViewController.h"
#import "NetworkManager.h"
#import "StoryTableCell.h"
#import "SingleNewsViewController.h"
#import "StoryDB+CoreDataProperties.h"
#include "AppDelegate.h"

@interface NewsFeedViewController () <UITableViewDelegate, UITableViewDataSource, NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//@property (nonatomic) NSMutableArray *listOfStories;
@property (nonatomic) NSMutableArray<StoryDB *> *listOfStories;
@property (nonatomic) NetworkManager *networkManager;
@property (nonatomic, weak) AppDelegate *appDelegate;

@end

@implementation NewsFeedViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"StoryTableCell" bundle:nil] forCellReuseIdentifier:[StoryTableCell reuseIdentifier]];
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.networkManager = [[NetworkManager alloc] init];
    [self.networkManager getTopStoriesWithCompletion:^(NSArray *stories, NSError *error) {
        
        self.listOfStories = [[NSMutableArray alloc] init];
        

        for (Story *story in stories){
            
            StoryDB *storyDB = [NSEntityDescription insertNewObjectForEntityForName:@"StoryDB" inManagedObjectContext:self.appDelegate.persistentContainer.viewContext];
            
            storyDB.title = story.title;
            storyDB.identifier = story.storyID.intValue;
            storyDB.storedHtml = story.storedHtml;
            storyDB.author = story.by;
            
            [self.listOfStories addObject:storyDB];
        }
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.listOfStories count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    StoryTableCell *cell = (StoryTableCell *)[tableView dequeueReusableCellWithIdentifier:[StoryTableCell reuseIdentifier]];
    
    StoryDB *story = self.listOfStories[indexPath.row];
    
    cell.title.text = story.title;
    cell.by.text = story.author;
    
    cell.title.lineBreakMode = NSLineBreakByWordWrapping;
    cell.title.numberOfLines = 0;
    
    cell.by.lineBreakMode = NSLineBreakByWordWrapping;
    cell.by.numberOfLines = 0;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SingleNewsViewController *singleNewsViewController = [storyboard instantiateViewControllerWithIdentifier:@"SingleNewsViewController"];
    
    [self.navigationController pushViewController:singleNewsViewController animated:YES];
    
    singleNewsViewController.story = [self.listOfStories objectAtIndex:indexPath.row];
   
}

@end
