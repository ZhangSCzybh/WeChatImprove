#import "CSClownLayout.h"
#import <math.h>

static BOOL CSClownPositiveSize(CGSize size) {
    return isfinite(size.width) && isfinite(size.height) && size.width > 0 && size.height > 0;
}

CGSize CSClownImageSize(CGSize imageSize, CGFloat availableWidth) {
    if (!CSClownPositiveSize(imageSize) || !isfinite(availableWidth) || availableWidth <= 0) return CGSizeZero;
    CGFloat maxWidth = MIN(300, availableWidth * 0.60);
    if (maxWidth <= 0) return CGSizeZero;
    CGFloat scale = 1;
    if (imageSize.width > maxWidth) scale = maxWidth / imageSize.width;
    if (imageSize.height > 300) scale = MIN(scale, 300 / imageSize.height);
    CGSize result = CGSizeMake(imageSize.width * scale, imageSize.height * scale);
    if (!CSClownPositiveSize(result)) return CGSizeZero;
    // Floating-point multiplication can exceed the limiting dimension by one ulp.
    return CGSizeMake(MIN(maxWidth, result.width), MIN(300, result.height));
}

CGRect CSClownResizeFrame(CGRect nativeFrame, CGSize size, BOOL outgoing) {
    if (!CSClownPositiveSize(size) || !isfinite(nativeFrame.origin.x) || !isfinite(nativeFrame.origin.y) ||
        !isfinite(nativeFrame.size.width) || !isfinite(nativeFrame.size.height) ||
        nativeFrame.size.width < 0 || nativeFrame.size.height < 0) return CGRectZero;
    CGFloat x = nativeFrame.origin.x;
    if (outgoing) {
        CGFloat right = nativeFrame.origin.x + nativeFrame.size.width;
        if (!isfinite(right)) return CGRectZero;
        x = right - size.width;
        if (!isfinite(x)) return CGRectZero;
    }
    if (!isfinite(x + size.width) || !isfinite(nativeFrame.origin.y + size.height)) return CGRectZero;
    return CGRectMake(x, nativeFrame.origin.y, size.width, size.height);
}

CGFloat CSClownProjectedRowHeight(CGFloat nativeHeight, CGFloat nativeContentHeight, CGFloat replacementContentHeight) {
    CGFloat fallback = isfinite(nativeHeight) ? MAX(1, nativeHeight) : 1;
    if (!isfinite(nativeHeight) || nativeHeight < 0 || !isfinite(nativeContentHeight) || nativeContentHeight < 0 ||
        !isfinite(replacementContentHeight) || replacementContentHeight < 0) return fallback;
    if (replacementContentHeight >= nativeContentHeight) {
        CGFloat increase = replacementContentHeight - nativeContentHeight;
        if (increase > CGFLOAT_MAX - nativeHeight) return CGFLOAT_MAX;
        CGFloat result = nativeHeight + increase;
        return isfinite(result) ? MAX(1, result) : CGFLOAT_MAX;
    }
    CGFloat decrease = nativeContentHeight - replacementContentHeight;
    return decrease >= nativeHeight ? 1 : MAX(1, nativeHeight - decrease);
}

static NSDateFormatter *CSClownDateFormatter(NSString *format) {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.timeZone = NSTimeZone.defaultTimeZone;
    formatter.calendar = calendar;
    formatter.timeZone = calendar.timeZone;
    formatter.lenient = NO;
    formatter.dateFormat = format;
    return formatter;
}

NSDate *CSClownDateFromInput(NSString *input) {
    if (![input isKindOfClass:NSString.class] || input.length != 16) return nil;
    for (NSUInteger index = 0; index < input.length; index++) {
        unichar character = [input characterAtIndex:index];
        if (index == 4 || index == 7) { if (character != '-') return nil; }
        else if (index == 10) { if (character != ' ') return nil; }
        else if (index == 13) { if (character != ':') return nil; }
        else if (character < '0' || character > '9') return nil;
    }
    NSDateFormatter *formatter = CSClownDateFormatter(@"yyyy-MM-dd HH:mm");
    NSDate *date = [formatter dateFromString:input];
    // ICU may normalize a nonexistent local time even with lenient disabled.
    return date && [[formatter stringFromDate:date] isEqualToString:input] ? date : nil;
}

NSString *CSClownDateInput(NSDate *date) {
    if (![date isKindOfClass:NSDate.class] || !isfinite(date.timeIntervalSinceReferenceDate)) return nil;
    return [CSClownDateFormatter(@"yyyy-MM-dd HH:mm") stringFromDate:date];
}

NSString *CSClownDateDisplay(NSDate *date) {
    return CSClownDateDisplayWithDetail(date, NO);
}

NSString *CSClownDateDisplayWithDetail(NSDate *date, BOOL detail) {
    if (![date isKindOfClass:NSDate.class] || !isfinite(date.timeIntervalSinceReferenceDate)) return nil;
    NSDateFormatter *formatter = CSClownDateFormatter(detail ? @"M月d日 EEEE HH:mm" : @"M月d日 HH:mm");
    formatter.weekdaySymbols = @[@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六"];
    return [formatter stringFromDate:date];
}

NSString *CSClownAmountFromInput(NSString *input) {
    if (![input isKindOfClass:NSString.class] || input.length == 0 || input.length > 12) return nil;
    NSRange decimal = [input rangeOfString:@"."];
    NSUInteger integerDigits = decimal.location == NSNotFound ? input.length : decimal.location;
    NSUInteger fractionalDigits = decimal.location == NSNotFound ? 0 : input.length - decimal.location - 1;
    if (integerDigits == 0 || integerDigits > 9 || fractionalDigits > 2 ||
        (decimal.location != NSNotFound && fractionalDigits == 0)) return nil;
    unsigned long long integer = 0, fraction = 0;
    for (NSUInteger index = 0; index < input.length; index++) {
        if (index == decimal.location) continue;
        unichar character = [input characterAtIndex:index];
        if (character < '0' || character > '9') return nil;
        if (index < integerDigits) integer = integer * 10 + character - '0';
        else fraction = fraction * 10 + character - '0';
    }
    if (fractionalDigits == 1) fraction *= 10;
    if (integer == 0 && fraction == 0) return nil;
    return [NSString stringWithFormat:@"%llu.%02llu", integer, fraction];
}
