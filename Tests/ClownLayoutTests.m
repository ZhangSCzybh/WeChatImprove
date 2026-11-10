#import <Foundation/Foundation.h>
#import "CSClownLayout.h"
#import <math.h>

static NSUInteger checks;
#define CHECK(condition) do { checks++; if (!(condition)) { NSLog(@"FAIL line %d: %s", __LINE__, #condition); exit(1); } } while (0)
static BOOL Near(CGFloat first, CGFloat second) { return fabs(first - second) < 0.00001; }

static void TestImages(void) {
    CGSize landscape = CSClownImageSize(CGSizeMake(1000, 500), 400);
    CHECK(Near(landscape.width, 240) && Near(landscape.height, 120));
    CGSize portrait = CSClownImageSize(CGSizeMake(500, 1000), 400);
    CHECK(Near(portrait.width, 150) && Near(portrait.height, 300));
    CGSize wide = CSClownImageSize(CGSizeMake(1200, 300), 2000);
    CHECK(Near(wide.width, 300) && Near(wide.height, 75));
    CGSize small = CSClownImageSize(CGSizeMake(30, 20), 400);
    CHECK(CGSizeEqualToSize(small, CGSizeMake(30, 20)));
    CGSize narrow = CSClownImageSize(CGSizeMake(500, 1000), 100);
    CHECK(Near(narrow.width, 60) && Near(narrow.height, 120));
    for (NSValue *value in @[[NSValue valueWithSize:NSMakeSize(0, 10)],
        [NSValue valueWithSize:NSMakeSize(-1, 10)], [NSValue valueWithSize:NSMakeSize(10, NAN)],
        [NSValue valueWithSize:NSMakeSize(INFINITY, 10)]]) {
        NSSize input = value.sizeValue;
        CHECK(CGSizeEqualToSize(CSClownImageSize(CGSizeMake(input.width, input.height), 400), CGSizeZero));
    }
    for (NSNumber *width in @[@0, @(-1), @(NAN), @(INFINITY)]) {
        CHECK(CGSizeEqualToSize(CSClownImageSize(CGSizeMake(100, 100), width.doubleValue), CGSizeZero));
    }
    CGSize extreme = CSClownImageSize(CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX), CGFLOAT_MAX);
    CHECK(isfinite(extreme.width) && isfinite(extreme.height) && extreme.width > 0 && extreme.height > 0);
    CHECK(Near(extreme.width, extreme.height) && extreme.width <= 300 && extreme.height <= 300);

    CGRect native = CGRectMake(80, 20, 100, 50);
    CGRect incoming = CSClownResizeFrame(native, CGSizeMake(50, 120), NO);
    CGRect outgoing = CSClownResizeFrame(native, CGSizeMake(50, 120), YES);
    CHECK(CGRectEqualToRect(incoming, CGRectMake(80, 20, 50, 120)));
    CHECK(CGRectEqualToRect(outgoing, CGRectMake(130, 20, 50, 120)));
    CHECK(Near(CGRectGetMaxX(outgoing), CGRectGetMaxX(native)) && Near(CGRectGetMinX(incoming), CGRectGetMinX(native)));
    CHECK(CGRectEqualToRect(CSClownResizeFrame(native, CGSizeZero, YES), CGRectZero));
    CHECK(CGRectEqualToRect(CSClownResizeFrame(CGRectMake(NAN, 0, 100, 100), CGSizeMake(30, 30), NO), CGRectZero));
    CHECK(CGRectEqualToRect(CSClownResizeFrame(CGRectMake(0, 0, -1, 10), CGSizeMake(30, 30), YES), CGRectZero));
    CHECK(CGRectEqualToRect(CSClownResizeFrame(CGRectMake(CGFLOAT_MAX, 0, CGFLOAT_MAX, 10), CGSizeMake(30, 30), YES), CGRectZero));
    CHECK(CGRectEqualToRect(CSClownResizeFrame(CGRectMake(0, CGFLOAT_MAX, 10, 10), CGSizeMake(30, CGFLOAT_MAX), NO), CGRectZero));
}

static void TestRows(void) {
    CHECK(Near(CSClownProjectedRowHeight(100, 60, 20), 60));
    CHECK(Near(CSClownProjectedRowHeight(100, 60, 120), 160));
    CHECK(Near(CSClownProjectedRowHeight(100, 60, 60), 100));
    CHECK(Near(CSClownProjectedRowHeight(10, 80, 5), 1));
    CHECK(Near(CSClownProjectedRowHeight(0, 0, 0), 1));
    CHECK(Near(CSClownProjectedRowHeight(100, NAN, 30), 100));
    CHECK(Near(CSClownProjectedRowHeight(100, 30, INFINITY), 100));
    CHECK(Near(CSClownProjectedRowHeight(100, -1, 20), 100));
    CHECK(Near(CSClownProjectedRowHeight(-1, 30, 20), 1));
    CHECK(Near(CSClownProjectedRowHeight(NAN, 30, 20), 1));
    CHECK(CSClownProjectedRowHeight(CGFLOAT_MAX, 0, CGFLOAT_MAX) == CGFLOAT_MAX);
    CHECK(CSClownProjectedRowHeight(CGFLOAT_MAX, CGFLOAT_MAX, 1) >= 1);
    CHECK(CSClownProjectedRowHeight(1, CGFLOAT_MAX, 0) == 1);
}

static void TestDates(void) {
    NSTimeZone *previous = NSTimeZone.defaultTimeZone;
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    NSDate *date = CSClownDateFromInput(@"2026-11-09 14:42");
    CHECK(date != nil);
    CHECK([CSClownDateInput(date) isEqualToString:@"2026-11-09 14:42"]);
    CHECK([CSClownDateDisplay(date) isEqualToString:@"11月9日 14:42"]);
    CHECK([CSClownDateDisplayWithDetail(date, YES) isEqualToString:@"11月9日 星期一 14:42"]);
    CHECK([CSClownDateDisplayWithDetail(CSClownDateFromInput(@"2026-11-08 14:42"), YES) isEqualToString:@"11月8日 星期日 14:42"]);
    CHECK([CSClownDateDisplayWithDetail(CSClownDateFromInput(@"2026-11-10 14:42"), YES) isEqualToString:@"11月10日 星期二 14:42"]);
    CHECK([CSClownDateDisplayWithDetail(date, NO) isEqualToString:CSClownDateDisplay(date)]);
    CHECK(CSClownDateDisplayWithDetail(nil, YES) == nil);
    CHECK([CSClownDateDisplay(CSClownDateFromInput(@"2026-01-02 03:04")) isEqualToString:@"1月2日 03:04"]);
    CHECK(CSClownDateFromInput(@"2028-02-29 00:00") != nil);
    for (NSString *input in @[@"2026-02-29 00:00", @"2026-04-31 00:00", @"2026-13-01 00:00",
        @"2026-00-01 00:00", @"2026-11-00 00:00", @"2026-11-09 24:00", @"2026-11-09 14:60",
        @"2026-11-09 14:42x", @"2026-11-09 14:42\n", @"2026-11-9 14:42", @"2026/11/09 14:42",
        @"2026-11-09T14:42", @"２０２６-11-09 14:42", @"0000-11-09 14:42", @""]) {
        CHECK(CSClownDateFromInput(input) == nil);
    }
    CHECK(CSClownDateFromInput(nil) == nil);
    CHECK(CSClownDateInput(nil) == nil && CSClownDateDisplay(nil) == nil);
    CHECK(CSClownDateInput([NSDate dateWithTimeIntervalSinceReferenceDate:NAN]) == nil);
    CHECK(CSClownDateDisplay([NSDate dateWithTimeIntervalSinceReferenceDate:INFINITY]) == nil);
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
    CHECK(CSClownDateFromInput(@"2026-03-08 02:30") == nil);
    CHECK(CSClownDateFromInput(@"2026-03-08 01:30") != nil);
    CHECK(CSClownDateFromInput(@"2026-03-08 03:30") != nil);
    NSDate *fall = CSClownDateFromInput(@"2026-11-01 01:30");
    CHECK(fall != nil && [CSClownDateInput(fall) isEqualToString:@"2026-11-01 01:30"]);
    CHECK([CSClownDateInput(date) isEqualToString:@"2026-11-09 01:42"]);
    [NSTimeZone setDefaultTimeZone:previous];
}

static void TestAmounts(void) {
    NSDictionary<NSString *, NSString *> *valid = @{
        @"1":@"1.00", @"12.3":@"12.30", @"0012.3":@"12.30", @"12.34":@"12.34",
        @"0.1":@"0.10", @"0.01":@"0.01", @"000000000.01":@"0.01",
        @"000000001":@"1.00", @"999999999":@"999999999.00", @"999999999.9":@"999999999.90",
        @"999999999.99":@"999999999.99", @"123456789.99":@"123456789.99"
    };
    for (NSString *input in valid) CHECK([CSClownAmountFromInput(input) isEqualToString:valid[input]]);
    for (NSString *input in @[@"", @"0", @"00", @"0.0", @"0.00", @"000000000.00", @"-1", @"+1",
        @".5", @"1.", @"1.234", @"1..2", @"1.2.3", @"1e3", @"1E3", @"1,000", @"1,20",
        @" 1", @"1 ", @"1\n", @"1\t", @"￥1.00", @"¥1.00", @"１.00", @"١.00", @"1。00",
        @"1000000000", @"1000000000.00", @"0000000001", @"0000000000.01", @"NaN", @"Infinity"]) {
        CHECK(CSClownAmountFromInput(input) == nil);
    }
    CHECK(CSClownAmountFromInput(nil) == nil);
    CHECK(CSClownAmountFromInput((NSString *)(id)@1) == nil);
}

int main(void) {
    @autoreleasepool {
        TestImages();
        TestRows();
        TestDates();
        TestAmounts();
        NSLog(@"Clown geometry, date and amount passed %lu checks", (unsigned long)checks);
    }
    return 0;
}
