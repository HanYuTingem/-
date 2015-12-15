//
//  ITTXibViewUtils.m
//  iTotemFrame
//
//  Created by pipixia on 13-12-24.
//  Copyright (c) 2013年 pipixia. All rights reserved.
//

#import "ITTXibViewUtils.h"

@implementation ITTXibViewUtils

+ (id)loadViewFromXibNamed:(NSString*)xibName withFileOwner:(id)fileOwner{
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:xibName owner:fileOwner options:nil];
    if (array && [array count]) {
        return array[0];
    } else {
        return nil;
    }
}

+ (id)loadViewFromXibNamed:(NSString*)xibName {
    return [ITTXibViewUtils loadViewFromXibNamed:xibName withFileOwner:self];
}

@end
