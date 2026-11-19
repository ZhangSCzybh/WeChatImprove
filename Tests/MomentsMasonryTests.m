#include "CSMomentsMasonryGeometry.h"
#include <float.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

static unsigned long Assertions;
#define CHECK(...) do { Assertions++; if (!(__VA_ARGS__)) { \
    fprintf(stderr, "Masonry FAIL %d: %s\n", __LINE__, #__VA_ARGS__); exit(1); \
} } while (0)

static bool Near(double left, double right) { return fabs(left - right) < 0.000001; }

static void TestMixedCards(void) {
    CSMomentsMasonryGeometry geometry;
    CHECK(CSMomentsMasonryInitialize(&geometry, 390, 8, 8, 14, 120));
    CHECK(Near(geometry.cardWidth, 183));
    CHECK(Near(CSMomentsMasonryBottom(&geometry), 136));
    const double heights[] = {300, 100, 80, 120, 60};
    const unsigned int columns[] = {0, 1, 1, 1, 0};
    const double tops[] = {128, 128, 242, 336, 442};
    for (size_t index = 0; index < sizeof(heights) / sizeof(*heights); index++) {
        CSMomentsMasonryFrame frame;
        CHECK(CSMomentsMasonryAppend(&geometry, heights[index], &frame));
        CHECK(frame.column == columns[index]);
        CHECK(Near(frame.y, tops[index]));
        CHECK(frame.height == heights[index]);
        CHECK(Near(frame.x, columns[index] ? 199 : 8));
    }
    CHECK(Near(CSMomentsMasonryBottom(&geometry), 510));
    CHECK(Near(CSMomentsMasonryBottom(&geometry) + 44, 554));
}

static void TestTiesAndNaturalHeights(void) {
    CSMomentsMasonryGeometry geometry;
    CSMomentsMasonryFrame first, second, third, fourth;
    CHECK(CSMomentsMasonryInitialize(&geometry, 393, 8, 8, 14, 0));
    CHECK(CSMomentsMasonryAppend(&geometry, 100.25, &first));
    CHECK(CSMomentsMasonryAppend(&geometry, 100.25, &second));
    CHECK(CSMomentsMasonryAppend(&geometry, 2700.5, &third));
    CHECK(CSMomentsMasonryAppend(&geometry, 0.125, &fourth));
    CHECK(first.column == 0 && second.column == 1 && third.column == 0 && fourth.column == 1);
    CHECK(Near(first.width, 184.5) && Near(second.width, first.width));
    CHECK(third.height == 2700.5 && fourth.height == 0.125);
    CHECK(Near(CSMomentsMasonryBottom(&geometry), third.y + third.height + 8));
}

static void TestInvalidGeometry(void) {
    CSMomentsMasonryGeometry geometry;
    CHECK(!CSMomentsMasonryInitialize(NULL, 390, 8, 8, 14, 0));
    const double widths[] = {0, -390, 24, NAN, INFINITY, -INFINITY};
    for (size_t index = 0; index < sizeof(widths) / sizeof(*widths); index++) {
        CHECK(!CSMomentsMasonryInitialize(&geometry, widths[index], 8, 8, 14, 0));
        CHECK(!geometry.valid && CSMomentsMasonryBottom(&geometry) == 0);
    }
    CHECK(!CSMomentsMasonryInitialize(&geometry, 390, -1, 8, 14, 0));
    CHECK(!CSMomentsMasonryInitialize(&geometry, 390, 8, -1, 14, 0));
    CHECK(!CSMomentsMasonryInitialize(&geometry, 390, 8, 8, -1, 0));
    CHECK(!CSMomentsMasonryInitialize(&geometry, 390, 8, 8, NAN, 0));
    CHECK(!CSMomentsMasonryInitialize(&geometry, 390, 8, 8, INFINITY, 0));
    CHECK(!CSMomentsMasonryInitialize(&geometry, 390, 8, 8, 14, NAN));
    CHECK(!CSMomentsMasonryInitialize(&geometry, 390, 8, 8, 14, -1));
    CHECK(!CSMomentsMasonryInitialize(&geometry, DBL_MAX, DBL_MAX / 10, 8, 14, DBL_MAX * 0.85));
    CHECK(CSMomentsMasonryInitialize(&geometry, 390, 8, 8, 14, 0));
    CSMomentsMasonryFrame frame = {19, 23, 7, 11, 1};
    const double heights[] = {0, -2, NAN, INFINITY, -INFINITY};
    for (size_t index = 0; index < sizeof(heights) / sizeof(*heights); index++) {
        CHECK(!CSMomentsMasonryAppend(&geometry, heights[index], &frame));
        CHECK(geometry.itemCount == 0 && geometry.nextY[0] == 8 && geometry.nextY[1] == 8);
        CHECK(frame.x == 19 && frame.y == 23 && frame.height == 11);
    }
    CHECK(!CSMomentsMasonryAppend(NULL, 100, &frame));
    CHECK(!CSMomentsMasonryAppend(&geometry, 100, NULL));
    CHECK(CSMomentsMasonryBottom(NULL) == 0);
    CHECK(CSMomentsMasonryInitialize(&geometry, 390, 8, 8, 14, DBL_MAX * 0.75));
    CHECK(!CSMomentsMasonryAppend(&geometry, DBL_MAX * 0.5, &frame));
    CHECK(geometry.itemCount == 0);
}

static void TestLayoutInvariants(void) {
    const double widths[] = {320, 390, 393, 430, 768, 1024};
    for (size_t widthIndex = 0; widthIndex < sizeof(widths) / sizeof(*widths); widthIndex++) {
        CSMomentsMasonryGeometry geometry;
        CHECK(CSMomentsMasonryInitialize(&geometry, widths[widthIndex], 8, 8, 14, 177.5));
        CSMomentsMasonryFrame frames[512];
        uint32_t random = 8080;
        double maxBottom = 0;
        for (size_t index = 0; index < sizeof(frames) / sizeof(*frames); index++) {
            random = random * 1664525u + 1013904223u;
            double height = 20 + (random % 9000) / 10.0;
            CHECK(CSMomentsMasonryAppend(&geometry, height, &frames[index]));
            CSMomentsMasonryFrame frame = frames[index];
            CHECK(isfinite(frame.x) && isfinite(frame.y) && isfinite(frame.width) && isfinite(frame.height));
            CHECK(frame.height == height && frame.width == geometry.cardWidth);
            CHECK(frame.x >= 8 && frame.x + frame.width <= widths[widthIndex] - 8 + 0.000001);
            CHECK(frame.y >= 185.5);
            for (size_t previous = 0; previous < index; previous++) {
                CSMomentsMasonryFrame other = frames[previous];
                bool separateHorizontally = frame.x + frame.width <= other.x || other.x + other.width <= frame.x;
                bool separateVertically = frame.y + frame.height <= other.y || other.y + other.height <= frame.y;
                CHECK(separateHorizontally || separateVertically);
                if (frame.column == other.column) CHECK(frame.y >= other.y + other.height + 14 - 0.000001);
            }
            maxBottom = fmax(maxBottom, frame.y + frame.height);
            CHECK(Near(CSMomentsMasonryBottom(&geometry), maxBottom + 8));
        }
        CHECK(geometry.itemCount == 512);
    }
}

int main(void) {
    TestMixedCards();
    TestTiesAndNaturalHeights();
    TestInvalidGeometry();
    TestLayoutInvariants();
    printf("Moments masonry: %lu checks passed (mixed heights, ties, natural proportions, invalid inputs, no overlaps, bounds, content height).\n", Assertions);
    return 0;
}
