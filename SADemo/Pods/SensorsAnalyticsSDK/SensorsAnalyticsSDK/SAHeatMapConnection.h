//
//  SAHeatMapConnection.h
//  SensorsAnalyticsSDK
//
//  Created by 王灼洲 on 8/1/17.
//  Copyright © 2015－2018 Sensors Data Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SAHeatMapMessage;

@interface SAHeatMapConnection : NSObject

@property (nonatomic, readonly) BOOL connected;
@property (nonatomic, assign) BOOL useGzip;

- (instancetype)initWithURL:(NSURL *)url;
- (void)setSessionObject:(id)object forKey:(NSString *)key;
- (id)sessionObjectForKey:(NSString *)key;
- (void)sendMessage:(id<SAHeatMapMessage>)message;
- (void)showOpenHeatMapDialog:(NSString *)featureCode withUrl:(NSString *)postUrl isWifi:(BOOL)isWifi;
- (void)close;

@end
