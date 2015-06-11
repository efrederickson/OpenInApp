//
//  OIAAppTableViewCell.h
//  OpenInApp
//
//  Created by Elijah Frederickson on 6/9/15.
//  Copyright (c) 2015 Elijah Frederickson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OIAAppTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *appTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *appUrlLabel;
@end
