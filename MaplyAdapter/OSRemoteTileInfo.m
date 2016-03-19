//
//  OSRemoteTileInfo.m
//  MaplyAdapter
//
//  Created by David Haynes on 07/01/2016.
//  Copyright © 2016 Ordnance Survey. All rights reserved.
//

#import "OSRemoteTileInfo.h"

@implementation OSRemoteTileInfo

- (NSURLRequest *)requestForTile:(MaplyTileID)tileID {
    int matrix = tileID.level - 3;
    int col = tileID.x;
    int row = ((int)(1 << tileID.level) - tileID.y) - 1;

    NSString *fullURLStr = [[[self.baseURL
        stringByReplacingOccurrencesOfString:@"{z}"
                                  withString:[@(matrix) stringValue]]
        stringByReplacingOccurrencesOfString:@"{x}"
                                  withString:[@(col) stringValue]]
        stringByReplacingOccurrencesOfString:@"{y}"
                                  withString:[@(row) stringValue]];

    return [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullURLStr]];
}

@end
