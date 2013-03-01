//
//  AppDelegate.m
//  iTunesRater
//
//  Created by John Adams on 2/23/13.
//  Copyright (c) 2013 John Adams. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize songInfo;

- (void) updateTrackInfo:(NSNotification *)notification {
    NSDictionary *information = [notification userInfo];
  //  NSLog(@"track information: %@", information);

    if (([information valueForKey:@"Artist"] != NULL) &&
        ([information valueForKey:@"Name"] != NULL)) {
        [songInfo setStringValue:
         [NSString stringWithFormat:@"%@ - %@", [information valueForKey:@"Artist"], [information valueForKey:@"Name"]]];
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    NSDistributedNotificationCenter *dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc addObserver:self selector:@selector(updateTrackInfo:) name:@"com.apple.iTunes.playerInfo" object:nil];
    
}

- (void) receiveNotification:(NSNotification *) notification {
    if ([@"com.apple.iTunes.playerInfo" isEqualToString:@"com.apple.iTunes.playerInfo"]) {
        NSLog (@"Successfully received the test notification!");
    }}

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "net.retina.iTunesRater" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    return [appSupportURL URLByAppendingPathComponent:@"net.retina.iTunesRater"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"iTunesRater" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    } else {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"iTunesRater.storedata"];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _persistentStoreCoordinator = coordinator;
    
    return _persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) 
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];

    return _managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (void)runScript:(NSString *)script {
//    NSLog(@"Running script \"%@\"",script);
    NSString* path = [[NSBundle mainBundle] pathForResource:script ofType:@"scpt"];

    NSURL* url = [NSURL fileURLWithPath:path];
    NSDictionary* errors = [NSDictionary dictionary];
    
    NSAppleScript* appleScript =
        [[NSAppleScript alloc] initWithContentsOfURL:url error:&errors];
            [appleScript executeAndReturnError:nil];
    /*
    NSString *question = NSLocalizedString(@"Error when executing Applescript", @"Applescript error question message");
    NSString *okButton = NSLocalizedString(@"Ok", @"Ok button title");

    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:question];
    [alert addButtonWithTitle:okButton];
    
    NSInteger answer = [alert runModal];
     */
    
}

- (IBAction)run_0_nogenre:(id)sender {
    [self runScript:@"0"];
}


- (IBAction)run_0_blues:(id)sender {
    [self runScript:@"0blues"];
}

- (IBAction)run_0_country:(id)sender {
    [self runScript:@"0country"];
}

- (IBAction)run_0_folk:(id)sender {
    [self runScript:@"0folk"];
}

- (IBAction)run_0_hiphop:(id)sender {
    [self runScript:@"0hiphop"];
}

- (IBAction)run_0_jazz:(id)sender {
    [self runScript:@"0jazz"];
}

- (IBAction)run_0_metal:(id)sender {
    [self runScript:@"0metal"];

}

- (IBAction)run_0_punk:(id)sender {
    [self runScript:@"0punk"];

}

- (IBAction)run_0_reggae:(id)sender {
    [self runScript:@"0reggae"];

}

- (IBAction)run_0_rock:(id)sender {
    [self runScript:@"0rock"];

}

- (IBAction)run_1_techno:(id)sender {
    [self runScript:@"1techno"];
}

- (IBAction)run_2_techno:(id)sender {
    [self runScript:@"2techno"];
}

- (IBAction)run_3_techno:(id)sender {
    [self runScript:@"3techno"];
}

- (IBAction)run_1_hiphop:(id)sender {
    [self runScript:@"1hiphop"];
}

- (IBAction)run_2_hiphop:(id)sender {
    [self runScript:@"2hiphop"];
}

- (IBAction)run_3_hiphop:(id)sender {
    [self runScript:@"3hiphop"];
}

- (IBAction)run_1_metal:(id)sender {
    [self runScript:@"1metal"];

}

- (IBAction)run_2_metal:(id)sender {
    [self runScript:@"2metal"];
}

- (IBAction)run_3_metal:(id)sender {
    [self runScript:@"3metal"];
}

- (IBAction)run_1_rock:(id)sender {
    [self runScript:@"1rock"];

}

- (IBAction)run_2_rock:(id)sender {
    [self runScript:@"2rock"];

}

- (IBAction)run_3_rock:(id)sender {
    [self runScript:@"3rock"];

}

- (IBAction)skip_15_seconds:(id)sender {
    [self runScript:@"skip15"];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (!_managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {

        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

@end
