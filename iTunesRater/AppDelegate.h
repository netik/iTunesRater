//
//  AppDelegate.h
//  iTunesRater
//
//  Created by John Adams on 2/23/13.
//  Copyright (c) 2013 John Adams. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (IBAction)saveAction:(id)sender;

- (IBAction)run_0_nogenre:(id)sender;

- (IBAction)run_0_blues:(id)sender;
- (IBAction)run_0_country:(id)sender;
- (IBAction)run_0_folk:(id)sender;
- (IBAction)run_0_hiphop:(id)sender;
- (IBAction)run_0_jazz:(id)sender;
- (IBAction)run_0_metal:(id)sender;
- (IBAction)run_0_punk:(id)sender;
- (IBAction)run_0_reggae:(id)sender;
- (IBAction)run_0_rock:(id)sender;

- (IBAction)run_1_techno:(id)sender;
- (IBAction)run_2_techno:(id)sender;
- (IBAction)run_3_techno:(id)sender;

- (IBAction)run_1_hiphop:(id)sender;
- (IBAction)run_2_hiphop:(id)sender;
- (IBAction)run_3_hiphop:(id)sender;

- (IBAction)run_1_metal:(id)sender;
- (IBAction)run_2_metal:(id)sender;
- (IBAction)run_3_metal:(id)sender;

- (IBAction)run_1_rock:(id)sender;
- (IBAction)run_2_rock:(id)sender;
- (IBAction)run_3_rock:(id)sender;

- (void) runScript:(NSString *)script;

@end

