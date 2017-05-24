//
//  AppDelegate.m
//  CJPickerView
//
//  Created by Mark C.J. on 23/05/2017.
//  Copyright © 2017 MarkCJ. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

typedef enum : NSUInteger {
    GENDER_FEMALE   = 0,
    GENDER_MALE     = 1,
} SPEEDX_GENDER;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController *controller = [[ViewController alloc] init];
    self.window.rootViewController = controller;
    [self.window makeKeyAndVisible];

    
    float calories = [self calculateCaloriesWithGender:GENDER_MALE weightInKg:60 heightInCm:170 age:25 speedInKMH:10.0 cyclingHours:1.0];
    NSLog(@"卡路里 ： %.2f Cal", calories);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



/**
 Calculate Cycling Calories.
 
 @param gender
 @param weight      weight in kg
 @param height      height in cm
 @param age
 @param speedInKMH  Speed In KM/H
 @param hour
 @return Calories in kCal
 */
- (double)calculateCaloriesWithGender:(SPEEDX_GENDER)gender weightInKg:(double)weight heightInCm:(double)height age:(int)age speedInKMH:(double)speedInKMH cyclingHours:(double)hour {
    double caloriesInKcal = 0.0;
    double bmrValue = [self calculateBMRWithGender:gender weightInKg:weight heightInCm:height age:age];
    double METsValue = [self getMETsWithSpeedInKMH:speedInKMH];
    caloriesInKcal = bmrValue * METsValue / 24.0 * hour;
    
    if (caloriesInKcal < 0) {
        caloriesInKcal = 0;
    }
    
    return caloriesInKcal;
}

/**
 Calculate BMR value.
 
 Women: BMR = 655.1 + ( 9.563 × weight in kg ) + ( 1.850 × height in cm ) – ( 4.676 × age in years )
 
 Men: BMR = 66.5 + ( 13.75 × weight in kg ) + ( 5.003 × height in cm ) – ( 6.755 × age in years )
 
 @return BMR factor value，Double Type
 */
- (double)calculateBMRWithGender:(SPEEDX_GENDER)gender weightInKg:(double)weight heightInCm:(double)height age:(int)age {
    if (gender > 1) {
        return -1;
    }
    
    if (weight < 0) {
        return -2;
    }
    
    if (height < 0) {
        return -3;
    }
    
    if (age <= 0) {
        return -4;
    }
    
    double bmrValue = 0.0;
    switch (gender) {
        case GENDER_MALE:
            bmrValue = 66.5 + (13.75 * weight) + (5.003 * height) - (6.755 * age);
            break;
            
        case GENDER_FEMALE:
            bmrValue = 665.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age);
            break;
    }
    
    return bmrValue;
}


/**
 Get METs factor value by Speed In KM/H
 
 Reference Link: https://sites.google.com/site/compendiumofphysicalactivities/Activity-Categories/bicycling
 
 @return METs factor，Double Type
 */
- (double)getMETsWithSpeedInKMH:(double)speedInKMH {
    if (speedInKMH < 0) {
        return -1;
    }
    
    double METsValue = 7.5;     // Default Value, bicycling, general speed.
    // Convert KM/H to MPH
    double speedInMPH = speedInKMH * 0.62137;
    if (speedInMPH > 0 && speedInMPH <= 5.5) {
        METsValue = 3.5;
    } else if (speedInMPH > 5.5 && speedInMPH <= 9.4) {
        METsValue = 5.8;
    } else if (speedInMPH > 9.4 && speedInMPH <= 11.9) {
        METsValue = 6.8;
    } else if (speedInMPH > 11.9 && speedInMPH <= 13.9) {
        METsValue = 8.0;
    } else if (speedInMPH > 13.9 && speedInMPH <= 15.9) {
        METsValue = 10.0;
    } else if (speedInMPH > 15.9 && speedInMPH <= 20.0) {
        METsValue = 12.0;
    } else if (speedInMPH > 20.0) {
        METsValue = 15.8;
    }
    
    return METsValue;
}



@end
