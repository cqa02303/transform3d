//
//  transform3DAppDelegate.h
//  transform3D
//
//  Created by 藤川 宏之 on 09/01/22.
//  Copyright ニフティ株式会社 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface transform3DAppDelegate : NSObject <UIApplicationDelegate, UIAccelerometerDelegate> {
    UIWindow *window;
	IBOutlet UIImageView *imageView;
	CATransform3D baseTransform;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

