#ifndef CSMomentsMasonryGeometry_h
#define CSMomentsMasonryGeometry_h

#include <math.h>
#include <stdbool.h>
#include <stddef.h>

typedef struct {
    double x, y, width, height;
    unsigned int column;
} CSMomentsMasonryFrame;

typedef struct {
    double width, margin, gap, rowGap, headerHeight, cardWidth;
    double nextY[2];
    size_t itemCount;
    bool valid;
} CSMomentsMasonryGeometry;

/// Invalid inputs leave an empty, unusable geometry.
static inline bool CSMomentsMasonryInitialize(CSMomentsMasonryGeometry *geometry,
                                             double width, double margin,
                                             double gap, double rowGap, double headerHeight) {
    if (!geometry) return false;
    *geometry = (CSMomentsMasonryGeometry){0};
    if (!isfinite(width) || !isfinite(margin) || !isfinite(gap) || !isfinite(rowGap) ||
        !isfinite(headerHeight) || margin < 0 || gap < 0 || rowGap < 0 || headerHeight < 0 ||
        width <= margin * 2 + gap || !isfinite(headerHeight + margin * 2)) return false;
    geometry->width = width;
    geometry->margin = margin;
    geometry->gap = gap;
    geometry->rowGap = rowGap;
    geometry->headerHeight = headerHeight;
    geometry->cardWidth = (width - margin * 2 - gap) / 2;
    geometry->nextY[0] = geometry->nextY[1] = headerHeight + margin;
    geometry->valid = true;
    return true;
}

/// Rejects invalid heights without consuming a slot or moving either column.
static inline bool CSMomentsMasonryAppend(CSMomentsMasonryGeometry *geometry,
                                         double height, CSMomentsMasonryFrame *frame) {
    if (!geometry || !geometry->valid || !frame || !isfinite(height) || height <= 0) return false;
    unsigned int column = geometry->nextY[0] <= geometry->nextY[1] ? 0 : 1;
    double nextY = geometry->nextY[column] + height + geometry->rowGap;
    if (!isfinite(nextY) || !isfinite(nextY + geometry->margin)) return false;
    *frame = (CSMomentsMasonryFrame){
        geometry->margin + column * (geometry->cardWidth + geometry->gap),
        geometry->nextY[column], geometry->cardWidth, height, column
    };
    geometry->nextY[column] = nextY;
    geometry->itemCount++;
    return true;
}

/// Includes top and bottom margins; supplementary footer starts at this value.
static inline double CSMomentsMasonryBottom(const CSMomentsMasonryGeometry *geometry) {
    if (!geometry || !geometry->valid) return 0;
    if (!geometry->itemCount) return geometry->headerHeight + geometry->margin * 2;
    return fmax(geometry->nextY[0], geometry->nextY[1]) - geometry->rowGap + geometry->margin;
}

#endif
