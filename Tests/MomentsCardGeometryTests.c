#include "CSMomentsCardGeometry.h"
#include <stdio.h>
#include <stdlib.h>

static unsigned long Assertions;
#define CHECK(...) do { Assertions++; if (!(__VA_ARGS__)) { \
    fprintf(stderr, "Moments card geometry FAIL %d: %s\n", __LINE__, #__VA_ARGS__); exit(1); \
} } while (0)

static bool Near(double a, double b) { return fabs(a - b) < 0.000001; }
static CSMomentsCardMetrics Measure(bool media, double width, double imageWidth, double imageHeight,
    double titleHeight, double lineHeight, double timestampHeight, double locationHeight) {
    return CSMomentsCardMeasure(media, width, imageWidth, imageHeight, titleHeight, lineHeight, 17, timestampHeight, locationHeight);
}

static void TestNaturalAndBoundedCovers(void) {
    CSMomentsCardMetrics square = Measure(true, 180, 1200, 1200, 18, 18, 0, 0);
    CSMomentsCardMetrics panorama = Measure(true, 180, 1200, 400, 36, 18, 0, 0);
    CSMomentsCardMetrics portrait = Measure(true, 180, 900, 1200, 18, 18, 0, 0);
    CSMomentsCardMetrics longFirst = Measure(true, 180, 900, 18000, 36, 18, 0, 0);
    CHECK(square.coverHeight == 180 && panorama.coverHeight == 60);
    CHECK(Near(portrait.coverHeight, 240) && Near(longFirst.coverHeight, 270));
    CHECK(square.height != panorama.height && panorama.height != portrait.height);
    CHECK(longFirst.titleHeight == 36 && longFirst.height == 382);
    CHECK(longFirst.authorY + longFirst.authorHeight + 12 == longFirst.height);
    CSMomentsCardMetrics noMedia = Measure(false, 180, 900, 18000, 10000, 18, 0, 0);
    CHECK(noMedia.coverHeight == 0 && noMedia.titleHeight == 36 && noMedia.height == 112);
    CSMomentsCardMetrics empty = Measure(false, 180, 0, 0, 0, 18, 0, 0);
    CHECK(empty.titleHeight == 0 && empty.authorY == 12 && empty.height == 64);
    CSMomentsCardMetrics singleLine = Measure(false, 180, 0, 0, 2, 18, 0, 0);
    CHECK(singleLine.titleHeight == 18 && singleLine.height == 94);
}

static void TestInvalidAndExtremeInputs(void) {
    const double invalid[] = {0, -1, NAN, INFINITY, -INFINITY};
    for (unsigned i = 0; i < sizeof(invalid) / sizeof(*invalid); i++) {
        CHECK(Measure(true, invalid[i], 100, 100, 18, 18, 0, 0).height == 0);
        CHECK(Measure(true, 180, invalid[i], 100, 18, 18, 0, 0).coverHeight == 180);
        CHECK(Measure(true, 180, 100, invalid[i], 18, 18, 0, 0).coverHeight == 180);
        CSMomentsCardMetrics bad = CSMomentsCardMeasure(false, 180, 0, 0, invalid[i], invalid[i], invalid[i], invalid[i], invalid[i]);
        CHECK(bad.titleHeight == 0 && bad.nicknameHeight == 17);
        CHECK(bad.timestampHeight == 0 && bad.locationHeight == 0 && bad.height == 64);
    }
    CHECK(Measure(true, DBL_MAX, 1, 1, 18, 18, 0, 0).height == 0);
    CSMomentsCardMetrics extreme = Measure(true, 180, DBL_MIN, DBL_MAX, 18, 18, 0, 0);
    CHECK(isfinite(extreme.height) && Near(extreme.coverHeight, 270));
}

static void TestStackedDateAndDynamicHeight(void) {
    CSMomentsCardMetrics hidden = Measure(true, 180, 900, 1200, 36, 18, 0, 0);
    CSMomentsCardMetrics shown = Measure(true, 180, 900, 1200, 36, 18, 13.2, 0);
    CHECK(shown.timestampHeight == 14 && shown.authorY == 300 && shown.authorHeight == 40);
    CHECK(Near(shown.timestampY, 322.5) && shown.height == 352);
    CHECK(shown.height == hidden.height);
    CSMomentsCardFooter footer = CSMomentsCardFooterMeasure(180, shown, 12, 12);
    CHECK(footer.nickname.x == footer.timestamp.x && footer.nickname.width == footer.timestamp.width);
    CHECK(footer.timestamp.y == footer.nickname.y + footer.nickname.height + 2);
    CHECK(footer.timestamp.y + footer.timestamp.height <= shown.authorY + shown.authorHeight);
    CSMomentsCardMetrics large = CSMomentsCardMeasure(false, 180, 0, 0, 48, 24, 21, 18, 0);
    CHECK(large.authorHeight == 41 && large.authorY == 72 && large.height == 125);
    footer = CSMomentsCardFooterMeasure(180, large, 1000, 1000);
    CHECK(footer.nickname.y == large.authorY && footer.nickname.height == 21);
    CHECK(footer.timestamp.height == 18 && footer.timestamp.y + 18 == large.authorY + 41);
}

static void CheckRect(CSMomentsCardRect view, double width, double top, double bottom) {
    CHECK(isfinite(view.x) && isfinite(view.y) && isfinite(view.width) && isfinite(view.height));
    CHECK(view.x >= -0.000001 && view.width >= 0 && view.x + view.width <= width + 0.000001);
    CHECK(view.y >= top - 0.000001 && view.height >= 0 && view.y + view.height <= bottom + 0.000001);
}

static void CheckFooter(double width, double likes, double comments, bool largeText, bool date) {
    CSMomentsCardMetrics metrics = CSMomentsCardMeasure(true, width, 4, 3, 40, 20,
        largeText ? 21 : 17, date ? (largeText ? 18 : 15) : 0, 0);
    CSMomentsCardFooter footer = CSMomentsCardFooterMeasure(width, metrics, likes, comments);
    CSMomentsCardRect views[] = {footer.avatar, footer.nickname, footer.timestamp, footer.likeIcon,
        footer.likeCount, footer.commentIcon, footer.commentCount};
    for (unsigned i = 0; i < sizeof(views) / sizeof(*views); i++)
        CheckRect(views[i], width, metrics.authorY, metrics.authorY + metrics.authorHeight);
    CHECK(footer.avatar.x + footer.avatar.width <= footer.nickname.x + 0.000001);
    CHECK(footer.nickname.x == footer.timestamp.x && footer.nickname.width == footer.timestamp.width);
    CHECK(footer.nickname.y + footer.nickname.height <= footer.timestamp.y + 0.000001);
    CHECK(footer.nickname.x + footer.nickname.width <= footer.likeIcon.x + 0.000001);
    CHECK(footer.likeIcon.x + footer.likeIcon.width <= footer.likeCount.x + 0.000001);
    CHECK(footer.likeCount.x + footer.likeCount.width <= footer.commentIcon.x + 0.000001);
    CHECK(footer.commentIcon.x + footer.commentIcon.width <= footer.commentCount.x + 0.000001);
    double center = metrics.authorY + metrics.authorHeight / 2;
    CHECK(Near(footer.avatar.y + footer.avatar.height / 2, center));
    CHECK(Near(footer.likeIcon.y + footer.likeIcon.height / 2, center));
    CHECK(Near(footer.commentIcon.y + footer.commentIcon.height / 2, center));
    if (width >= 156) {
        CHECK(footer.avatar.width == 28 && footer.nickname.width >= 22 - 0.000001);
        CHECK(footer.likeIcon.width == 12 && footer.commentIcon.width == 12);
        CHECK(footer.likeCount.width > 0 && footer.commentCount.width > 0);
        CHECK(Near(footer.commentCount.x + footer.commentCount.width, width - 12));
    }
}

static void TestFooterNoOverlap(void) {
    const double widths[] = {1, 20, 44, 80, 120, 148, 156, 172, 183, 196, 203, 344, 492};
    const double labelWidths[] = {8, 17, 24, 30, 40, 2000};
    for (unsigned w = 0; w < sizeof(widths) / sizeof(*widths); w++)
        for (unsigned l = 0; l < sizeof(labelWidths) / sizeof(*labelWidths); l++)
            for (unsigned c = 0; c < sizeof(labelWidths) / sizeof(*labelWidths); c++)
                for (unsigned flags = 0; flags < 4; flags++)
                    CheckFooter(widths[w], labelWidths[l], labelWidths[c], flags & 1, flags & 2);
    CSMomentsCardMetrics metrics = Measure(false, 180, 0, 0, 36, 18, 14, 0);
    CHECK(CSMomentsCardFooterMeasure(NAN, metrics, 10, 10).avatar.width == 0);
    metrics.authorY = NAN;
    CHECK(CSMomentsCardFooterMeasure(180, metrics, 10, 10).avatar.width == 0);
    metrics = Measure(false, 180, 0, 0, 36, 18, 14, 0);
    CSMomentsCardFooter invalidLabels = CSMomentsCardFooterMeasure(180, metrics, NAN, INFINITY);
    CHECK(invalidLabels.likeCount.width == 0 && invalidLabels.commentCount.width == 0);
}

static void TestOptionalLocationPill(void) {
    for (unsigned width = 1; width <= 500; width += 3) {
        for (unsigned title = 0; title < 2; title++) {
            for (unsigned large = 0; large < 2; large++) {
                double titleHeight = title ? 42 : 0;
                CSMomentsCardMetrics hidden = CSMomentsCardMeasure(true, width, 1, 1, titleHeight, 21, 21, 18, 0);
                CSMomentsCardMetrics shown = CSMomentsCardMeasure(true, width, 1, 1, titleHeight, 21, 21, 18, large ? 18 : 15);
                CHECK(hidden.locationHeight == 0 && hidden.locationY == 0);
                CHECK(shown.locationHeight == (large ? 26 : 24));
                CHECK(shown.locationY >= shown.coverHeight + 12 + shown.titleHeight);
                CHECK(shown.authorY == shown.locationY + shown.locationHeight + 12);
                CHECK(shown.height - hidden.height == shown.locationHeight + (title ? 8 : 12));
                CSMomentsCardLocation pill = CSMomentsCardLocationMeasure(width, shown);
                CheckRect(pill.background, width, shown.locationY, shown.authorY);
                CheckRect(pill.icon, width, shown.locationY, shown.locationY + shown.locationHeight);
                CheckRect(pill.text, width, shown.locationY, shown.locationY + shown.locationHeight);
                CHECK(pill.icon.x + pill.icon.width <= pill.text.x + 0.000001);
                CHECK(pill.text.x + pill.text.width <= pill.background.x + pill.background.width + 0.000001);
                CHECK(CSMomentsCardLocationMeasure(width, hidden).background.height == 0);
            }
        }
    }
}

int main(void) {
    TestNaturalAndBoundedCovers();
    TestInvalidAndExtremeInputs();
    TestStackedDateAndDynamicHeight();
    TestFooterNoOverlap();
    TestOptionalLocationPill();
    printf("Moments card geometry: %lu checks passed (natural covers, two-line titles, optional location, stacked author/date, dynamic fonts, large counts, no overlaps).\n", Assertions);
    return 0;
}
