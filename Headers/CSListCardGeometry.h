#ifndef CS_LIST_CARD_GEOMETRY_H
#define CS_LIST_CARD_GEOMETRY_H
#include <CoreGraphics/CoreGraphics.h>
#include <math.h>
#include <stdbool.h>

// Preserve usable content even when settings meet an unusually narrow container.
static inline CGRect CSListCardRect(CGRect bounds, CGFloat left, CGFloat right) {
    if (!isfinite(bounds.origin.x) || !isfinite(bounds.origin.y) ||
        !isfinite(bounds.size.width) || !isfinite(bounds.size.height) ||
        bounds.size.width <= 0 || bounds.size.height <= 0) return CGRectNull;
    left = isfinite(left) ? fmax(0, left) : 0;
    right = isfinite(right) ? fmax(0, right) : 0;
    CGFloat budget = fmax(0, bounds.size.width - fmin(120, bounds.size.width));
    CGFloat sum = left + right;
    if (sum > budget && sum > 0) { left *= budget / sum; right *= budget / sum; }
    CGFloat width = fmax(fmin(120, bounds.size.width), bounds.size.width - left - right);
    return CGRectMake(bounds.origin.x + left, bounds.origin.y, width, bounds.size.height);
}

static inline CGFloat CSListCardRadius(CGRect rect, CGFloat radius) {
    if (CGRectIsNull(rect) || !isfinite(radius)) return 0;
    return fmax(0, fmin(radius, fmin(rect.size.width, rect.size.height) / 2));
}

// Bits are independent of UIKit: 1 = top corners, 2 = bottom corners.
static inline unsigned CSListCardEdges(long row, long first, long last) {
    if (first < 0 || last < first || row < first || row > last) return 0;
    return (row == first ? 1u : 0u) | (row == last ? 2u : 0u);
}
#endif
