//
//  OmniReplacements.h
//  Disk Inventory X
//
//  Replacement categories for OmniFoundation and OmniAppKit functionality.
//  These provide the minimal subset of methods that were used from the Omni frameworks.
//

#import <Cocoa/Cocoa.h>

#pragma mark - NSString (OFReplacements)

@interface NSString (OFReplacements)

+ (BOOL) isEmptyString: (NSString *) string;
+ (NSString *) horizontalEllipsisString;

@end

#pragma mark - NSDictionary (OFReplacements)

@interface NSDictionary (OFReplacements)

- (BOOL) boolForKey: (NSString *) key;

@end

#pragma mark - NSMutableDictionary (OFReplacements)

@interface NSMutableDictionary (OFReplacements)

- (void) setBoolValue: (BOOL) value forKey: (NSString *) key;

@end

#pragma mark - NSMutableArray (OFReplacements)

@interface NSMutableArray (OFReplacements)

- (void) insertObject: (id) anObject inArraySortedUsingSelector: (SEL) selector;

@end

#pragma mark - NSAlert (DIXAdditions)

@interface NSAlert (DIXAdditions)

// Shows an informational alert with a single OK button: as a sheet on `window`
// if one is given, otherwise app-modal. Replaces NSBeginInformationalAlertSheet().
+ (void) dix_showInformationalAlertWithMessage: (NSString *) message
                               informativeText: (NSString *) informativeText
                                     forWindow: (NSWindow *) window;

@end

#pragma mark - NSTableView (OAReplacements)

@interface NSTableView (OAReplacements)

- (void) setFont: (NSFont *) font;

@end
