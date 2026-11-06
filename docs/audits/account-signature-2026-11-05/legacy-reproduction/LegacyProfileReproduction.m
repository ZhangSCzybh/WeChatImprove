#import <Foundation/Foundation.h>

// Exact legacy parser from CSAccountDetailViewController.m, except that its
// caller supplies fixture data instead of reading the installed host bundle.
static NSDictionary *LegacyReadProfile(NSData *profileData) {
    NSString *profileString = [[NSString alloc] initWithData:profileData encoding:NSASCIIStringEncoding];
    if (!profileString) return nil;
    NSScanner *scanner = [NSScanner scannerWithString:profileString];
    NSString *plistString = nil;
    [scanner scanUpToString:@"<plist" intoString:nil];
    if ([scanner scanUpToString:@"</plist>" intoString:&plistString]) {
        plistString = [plistString stringByAppendingString:@"</plist>"];
        NSData *plistData = [plistString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *plistDict = [NSPropertyListSerialization propertyListWithData:plistData
                                                                           options:NSPropertyListImmutable
                                                                            format:nil
                                                                             error:&error];
        if (plistDict && !error) return plistDict;
    }
    return nil;
}

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        printf("Foundation OS: %s\n", NSProcessInfo.processInfo.operatingSystemVersionString.UTF8String);
        for (int index = 1; index < argc; index++) {
            NSString *path = [NSString stringWithUTF8String:argv[index]];
            NSData *data = [NSData dataWithContentsOfFile:path];
            NSString *ascii = data ? [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] : nil;
            NSDictionary *profile = data ? LegacyReadProfile(data) : nil;
            NSData *marker = [@"<plist" dataUsingEncoding:NSUTF8StringEncoding];
            NSRange markerRange = data ? [data rangeOfData:marker options:0 range:NSMakeRange(0, data.length)] : NSMakeRange(NSNotFound, 0);
            NSUInteger nulCount = 0, nonASCIICount = 0;
            if (markerRange.location != NSNotFound) {
                const uint8_t *bytes = data.bytes;
                for (NSUInteger offset = 0; offset < markerRange.location; offset++) {
                    if (bytes[offset] == 0) nulCount++;
                    if (bytes[offset] > 127) nonASCIICount++;
                }
            }
            NSDictionary *row = @{
                @"fixture": path.lastPathComponent,
                @"bytes": @(data.length),
                @"fileReadable": @(data != nil),
                @"legacyASCIIStringCreated": @(ascii != nil),
                @"legacyASCIIStringLength": @(ascii.length),
                @"bytesBeforeXMLPlist": markerRange.location == NSNotFound ? (id)NSNull.null : @(markerRange.location),
                @"nulBytesBeforeXMLPlist": @(nulCount),
                @"nonASCIIBytesBeforeXMLPlist": @(nonASCIICount),
                @"legacyDictionaryCreated": @(profile != nil),
                @"legacyTeamName": profile[@"TeamName"] ?: NSNull.null,
                @"legacyTeamIdentifier": profile[@"TeamIdentifier"] ?: NSNull.null
            };
            NSData *json = [NSJSONSerialization dataWithJSONObject:row options:NSJSONWritingSortedKeys error:nil];
            puts([[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding].UTF8String);
        }
    }
    return 0;
}
