//
//  MyTableViewCell.m
//  DragDrop
//
//  Created by Daniel Burke on 1/10/13.
//  Copyright (c) 2013 Daniel Burke. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _itemName = [[UILabel alloc] initWithFrame:CGRectMake(5.f, 5., 200.f, 25.f)];
        [self addSubview:_itemName];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
