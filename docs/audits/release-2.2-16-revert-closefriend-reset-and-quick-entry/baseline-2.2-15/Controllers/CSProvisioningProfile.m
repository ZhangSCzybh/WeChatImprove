#import "CSProvisioningProfile.h"

NSDictionary *CSProvisioningProfileDictionaryFromData(NSData *data) {
    if (data.length == 0) {
        return nil;
    }

    // A mobileprovision is a binary CMS envelope containing a UTF-8 plist.
    // Decode only the plist: the surrounding certificates/signature are not text.
    NSData *opening = [@"<plist" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *closing = [@"</plist>" dataUsingEncoding:NSUTF8StringEncoding];
    NSRange start = [data rangeOfData:opening options:0 range:NSMakeRange(0, data.length)];
    if (start.location == NSNotFound) {
        return nil;
    }
    NSUInteger contentStart = NSMaxRange(start);
    NSRange end = [data rangeOfData:closing options:0
                            range:NSMakeRange(contentStart, data.length - contentStart)];
    if (end.location == NSNotFound) {
        return nil;
    }

    NSData *plistData = [data subdataWithRange:NSMakeRange(start.location,
                                                         NSMaxRange(end) - start.location)];
    id profile = [NSPropertyListSerialization propertyListWithData:plistData
                                                          options:NSPropertyListImmutable
                                                           format:NULL
                                                            error:NULL];
    return [profile isKindOfClass:NSDictionary.class] ? profile : nil;
}
