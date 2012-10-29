//
//  RootNavC.h
//  Bicyclette
//
//  Created by Nicolas Bouilleaud on 29/09/12.
//  Copyright (c) 2012 Nicolas Bouilleaud. All rights reserved.
//

@class Station;

// Autorotation Management for iOS 6
@interface RootNavC : UINavigationController

- (void) setCities:(NSArray*)cities;

- (void) zoomInStation:(Station*)station;

@end
