//
//  transform3DAppDelegate.m
//  transform3D
//
//  Created by 藤川 宏之 on 09/01/22.
//  Copyright ニフティ株式会社 2009. All rights reserved.
//

#import "transform3DAppDelegate.h"

@implementation transform3DAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
	baseTransform = CATransform3DIdentity;	// 基本行列
	baseTransform.m34 = -0.002f;	// 透視投影の角度を決める
    [window makeKeyAndVisible];
	// 加速度計の起動
	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:0.2f];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];
	//
}


- (void)dealloc {
    [window release];
    [super dealloc];
}

#pragma mark UIAccelerometerDelegate
// 加速度計割り込み
- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	CGFloat len = sqrt(pow(acceleration.x, 2.0) + pow(acceleration.y, 2.0));
	CGFloat x = acceleration.x / len;
	CGFloat y = acceleration.y / len;
	// 透視投影の基本行列を変換して回転させる
	CATransform3D trans = CATransform3DRotate(baseTransform, acos(acceleration.z / len), -y, x, 0.0f);
	// アニメーションを行う
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2f];		// 次の割り込みまでにアニメーション処理を終了させる
	imageView.layer.transform = trans;		// アニメーション終了時の状態を通知
	[UIView commitAnimations];				// アニメーション実行
	// デバッグ情報出力
	NSLog(@"---------------");
	NSLog(@"x=%0.2f y=%0.2f z=%0.2f", acceleration.x, acceleration.y, acceleration.z);
	NSLog(@"%0.3f, %0.3f, %0.3f, %0.3f", trans.m11, trans.m12, trans.m13, trans.m14);
	NSLog(@"%0.3f, %0.3f, %0.3f, %0.3f", trans.m21, trans.m22, trans.m23, trans.m24);
	NSLog(@"%0.3f, %0.3f, %0.3f, %0.3f", trans.m31, trans.m32, trans.m33, trans.m34);
	NSLog(@"%0.3f, %0.3f, %0.3f, %0.3f", trans.m41, trans.m42, trans.m43, trans.m44);
}

@end
