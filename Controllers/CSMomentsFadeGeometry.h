#pragma once
#include <CoreGraphics/CoreGraphics.h>

// Coordinates are relative to the already-sampled cover. Stretch at the top
// keeps the lower edge and both gradient stops fixed in header coordinates.
typedef struct {
    CGFloat scaleY, translateY, start, end;
} CSMomentsFadeGeometry;

// Continue behind the first cards without moving their layout positions.
static const CGFloat CSMomentsBackdropTail = 44;

static inline CSMomentsFadeGeometry CSMomentsFadeForCover(CGRect cover, CGFloat pull,
                                                        CGFloat firstCardTop, CGFloat nicknameBottom) {
    CGFloat height = CGRectGetHeight(cover);
    if (!(height > 0)) return (CSMomentsFadeGeometry){1, 0, 0, 1};
    CGFloat stretch = MAX(0, pull + CGRectGetMinY(cover));
    CGFloat visualHeight = height + stretch;
    CGFloat bottomInset = MIN(4, height * 0.1);
    CGFloat bottom = CGRectGetMaxY(cover);
    CGFloat end = MIN(bottom - bottomInset, firstCardTop + CSMomentsBackdropTail);
    // Keep a long transition while retaining most photo contrast at the name.
    // Short/landscape images finish before their real pixels run out.
    CGFloat start = MAX(CGRectGetMinY(cover), MAX(end - 140, MIN(nicknameBottom, end - 120)));
    return (CSMomentsFadeGeometry){visualHeight / height, -stretch / 2,
        1 - (bottom - start) / visualHeight, 1 - (bottom - end) / visualHeight};
}
