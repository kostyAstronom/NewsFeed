//
//  StoryTableCell.m
//  NewsFeed
//
//  Created by Romanchuk, Konstantin on 10.04.2018.
//  Copyright © 2018 Romanchuk, Konstantin. All rights reserved.
//

#import "StoryTableCell.h"

@implementation StoryTableCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(StoryTableCell.class);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
