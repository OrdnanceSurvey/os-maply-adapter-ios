//
//  OSMapsAPI.m
//  MaplyAdapter
//
//  Created by David Haynes on 12/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import "OSMapsAPI.h"

@implementation OSMapsAPI

+ (NSString *)URLForSRS:(NSString *)srs layer:(NSString *)layer service:(NSString *)service {
    NSString *baseURL = @"https://api2.ordnancesurvey.co.uk/mapping_api/v1/service";
    baseURL = [baseURL stringByAppendingPathComponent:@"wmts"];

    NSArray<NSURLQueryItem *> *query = @[
        [NSURLQueryItem queryItemWithName:@"key"
                                    value:[self apiKey]],
        [NSURLQueryItem queryItemWithName:@"height" value:@"256"],
        [NSURLQueryItem queryItemWithName:@"width" value:@"256"],
        [NSURLQueryItem queryItemWithName:@"tilematrixSet"
                                    value:[srs stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]],
        [NSURLQueryItem queryItemWithName:@"version" value:@"1.0.0"],
        [NSURLQueryItem queryItemWithName:@"style" value:@""],
        [NSURLQueryItem queryItemWithName:@"layer"
                                    value:[layer stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]],
        [NSURLQueryItem queryItemWithName:@"SERVICE" value:@"WMTS"],
        [NSURLQueryItem queryItemWithName:@"REQUEST" value:@"GetTile"],
        [NSURLQueryItem queryItemWithName:@"format" value:@"image/png"],
        [NSURLQueryItem queryItemWithName:@"TileMatrix"
                                    value:[[[srs stringByAppendingString:@":"]
                                              stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
                                              stringByAppendingString:@"{z}"]],
        [NSURLQueryItem queryItemWithName:@"TileRow" value:@"{y}"],
        [NSURLQueryItem queryItemWithName:@"TileCol" value:@"{x}"],
    ];
    baseURL = [baseURL stringByAppendingString:@"?"];
    __block NSString *queryString = @"";
    [query enumerateObjectsUsingBlock:^(NSURLQueryItem *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if (queryString.length != 0) {
            queryString = [queryString stringByAppendingString:@"&"];
        }
        queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"%@=%@", obj.name, obj.value]];
    }];
    baseURL = [baseURL stringByAppendingString:queryString];
    return baseURL;
}

+ (NSString *)apiKey {
    return [[NSString stringWithContentsOfURL:[NSBundle.mainBundle URLForResource:@"APIKEY" withExtension:nil]
                                     encoding:NSUTF8StringEncoding
                                        error:nil] stringByReplacingOccurrencesOfString:@"\n"
                                                                             withString:@""];
}

@end
