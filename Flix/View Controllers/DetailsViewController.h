//
//  DetailsViewController.h
//  Flix
//
//  Created by mariobaxter on 6/26/19.
//  Copyright © 2019 mariobaxter. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (nonatomic, strong) NSDictionary *movie;
@property (strong, nonatomic) IBOutlet UIImageView *posterView;
@end

NS_ASSUME_NONNULL_END
