//
//  KissAppDelegate.h
//  Demo-IOS
//
//  Created by Dominik Pich on 19.06.12.
//  Copyright (c) 2012 Kiss. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KissViewController;

@interface KissAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) KissViewController *viewController;

@end
