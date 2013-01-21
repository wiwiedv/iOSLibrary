//
//  DescriptionTextfieldCell.m
//  TestApplication
//
//  Created by Dominik Schiller on 20.01.13.
//  Copyright (c) 2013 WiWi-Edv. All rights reserved.
//

#import "DescriptionTextfieldCell.h"

@implementation DescriptionTextfieldCell

@synthesize description, textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
