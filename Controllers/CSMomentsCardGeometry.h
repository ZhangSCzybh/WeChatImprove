#ifndef CSMomentsCardGeometry_h
#define CSMomentsCardGeometry_h

#include <stdbool.h>
#include <float.h>
#include <math.h>

typedef struct {
    double x, y, width, height;
} CSMomentsCardRect;

typedef struct {
    double coverHeight, titleHeight, locationY, locationHeight;
    double nicknameHeight, timestampY, timestampHeight, authorY, authorHeight, height;
} CSMomentsCardMetrics;

typedef struct {
    CSMomentsCardRect avatar, nickname, timestamp, likeIcon, likeCount, commentIcon, commentCount;
} CSMomentsCardFooter;

typedef struct {
    CSMomentsCardRect background, icon, text;
} CSMomentsCardLocation;

enum {
    CSMomentsCardContentPadding = 12,
    CSMomentsCardInformationRowHeight = 40,
    CSMomentsCardAvatarSide = 28
};

static inline double CSMomentsCardPositive(double value) {
    return isfinite(value) && value > 0 ? value : 0;
}

static inline CSMomentsCardMetrics CSMomentsCardMeasure(bool hasMedia, double width,
    double imageWidth, double imageHeight, double measuredTitleHeight, double titleLineHeight,
    double measuredNicknameHeight, double measuredTimestampHeight, double measuredLocationHeight) {
    CSMomentsCardMetrics result = {0};
    if (!isfinite(width) || width <= 0 || width > DBL_MAX / 8) return result;
    if (hasMedia) {
        double ratio = 1;
        if (isfinite(imageWidth) && imageWidth > 0 && isfinite(imageHeight) && imageHeight > 0) {
            ratio = imageHeight / imageWidth;
            // A long first image remains one cover; crop it to a portrait card.
            if (!isfinite(ratio)) ratio = 1.5;
            if (ratio <= 0) ratio = 1;
        }
        result.coverHeight = width * fmin(ratio, 1.5);
    }
    double lineHeight = CSMomentsCardPositive(titleLineHeight);
    double titleHeight = CSMomentsCardPositive(measuredTitleHeight);
    if (lineHeight && titleHeight) result.titleHeight = fmin(ceil(lineHeight * 2), fmax(ceil(lineHeight), ceil(titleHeight)));
    result.nicknameHeight = ceil(CSMomentsCardPositive(measuredNicknameHeight));
    if (!result.nicknameHeight) result.nicknameHeight = 17;
    result.timestampHeight = ceil(CSMomentsCardPositive(measuredTimestampHeight));
    double textHeight = result.nicknameHeight + (result.timestampHeight ? 2 + result.timestampHeight : 0);
    result.authorHeight = fmax(CSMomentsCardInformationRowHeight, textHeight);
    double contentBottom = result.coverHeight + CSMomentsCardContentPadding + result.titleHeight;
    double locationLineHeight = ceil(CSMomentsCardPositive(measuredLocationHeight));
    if (locationLineHeight) {
        result.locationY = contentBottom + (result.titleHeight ? 8 : 0);
        result.locationHeight = fmax(24, locationLineHeight + 8);
        contentBottom = result.locationY + result.locationHeight;
    }
    result.authorY = contentBottom + (result.titleHeight || result.locationHeight ? 12 : 0);
    result.timestampY = result.authorY + (result.authorHeight - textHeight) / 2
        + result.nicknameHeight + (result.timestampHeight ? 2 : 0);
    result.height = result.authorY + result.authorHeight + CSMomentsCardContentPadding;
    if (!isfinite(result.height)) return (CSMomentsCardMetrics){0};
    return result;
}

static inline CSMomentsCardFooter CSMomentsCardFooterMeasure(double width, CSMomentsCardMetrics metrics,
    double preferredLikesWidth, double preferredCommentsWidth) {
    CSMomentsCardFooter result = {0};
    if (!isfinite(width) || width <= 0 || !isfinite(metrics.authorY) ||
        !isfinite(metrics.authorHeight) || metrics.authorHeight <= 0 ||
        !isfinite(metrics.nicknameHeight) || !isfinite(metrics.timestampHeight)) return result;
    double padding = fmin(CSMomentsCardContentPadding, width / 2);
    double innerWidth = fmax(0, width - 2 * padding);
    double avatarSide = fmin(CSMomentsCardAvatarSide, innerWidth);
    double avatarGap = fmin(6, fmax(0, innerWidth - avatarSide));
    double remaining = fmax(0, innerWidth - avatarSide - avatarGap);
    double minimumNickname = fmin(22, remaining);
    double interactionGap = fmin(6, fmax(0, remaining - minimumNickname));
    double interactionBudget = fmax(0, remaining - minimumNickname - interactionGap);
    // The two icons and their gaps shrink together only at unusably narrow widths.
    double fixedScale = fmin(1, interactionBudget / 34);
    double iconSide = 12 * fixedScale, iconGap = 2 * fixedScale, groupGap = 6 * fixedScale;
    double likesWidth = fmin(30, CSMomentsCardPositive(preferredLikesWidth));
    double commentsWidth = fmin(30, CSMomentsCardPositive(preferredCommentsWidth));
    double labelsWidth = likesWidth + commentsWidth;
    double labelBudget = fmax(0, interactionBudget - 34 * fixedScale);
    double labelScale = labelsWidth > 0 ? fmin(1, labelBudget / labelsWidth) : 0;
    likesWidth *= labelScale;
    commentsWidth *= labelScale;
    double groupsWidth = 34 * fixedScale + likesWidth + commentsWidth;
    double groupsX = width - padding - groupsWidth;
    double nicknameX = padding + avatarSide + avatarGap;
    double rowY = metrics.authorY, rowHeight = metrics.authorHeight;
    double textHeight = metrics.nicknameHeight + (metrics.timestampHeight ? 2 + metrics.timestampHeight : 0);
    double textY = rowY + (rowHeight - textHeight) / 2;
    double textWidth = fmax(0, groupsX - interactionGap - nicknameX);
    result.avatar = (CSMomentsCardRect){padding, rowY + (rowHeight - avatarSide) / 2, avatarSide, avatarSide};
    result.nickname = (CSMomentsCardRect){nicknameX, textY, textWidth, metrics.nicknameHeight};
    result.timestamp = (CSMomentsCardRect){nicknameX, metrics.timestampY, textWidth, metrics.timestampHeight};
    result.likeIcon = (CSMomentsCardRect){groupsX, rowY + (rowHeight - iconSide) / 2, iconSide, iconSide};
    double likesX = groupsX + iconSide + iconGap;
    result.likeCount = (CSMomentsCardRect){likesX, rowY, likesWidth, rowHeight};
    double commentX = likesX + likesWidth + groupGap;
    result.commentIcon = (CSMomentsCardRect){commentX, rowY + (rowHeight - iconSide) / 2, iconSide, iconSide};
    result.commentCount = (CSMomentsCardRect){commentX + iconSide + iconGap, rowY, commentsWidth, rowHeight};
    return result;
}

static inline CSMomentsCardLocation CSMomentsCardLocationMeasure(double width, CSMomentsCardMetrics metrics) {
    CSMomentsCardLocation result = {0};
    if (!isfinite(width) || width <= 0 || !isfinite(metrics.locationY) ||
        !isfinite(metrics.locationHeight) || metrics.locationHeight <= 0) return result;
    double padding = fmin(CSMomentsCardContentPadding, width / 2);
    double innerWidth = fmax(0, width - 2 * padding);
    double inset = fmin(8, innerWidth / 2);
    double contentWidth = fmax(0, innerWidth - 2 * inset);
    double iconSide = fmin(14, contentWidth);
    double gap = fmin(4, fmax(0, contentWidth - iconSide));
    result.background = (CSMomentsCardRect){padding, metrics.locationY, innerWidth, metrics.locationHeight};
    result.icon = (CSMomentsCardRect){padding + inset,
        metrics.locationY + (metrics.locationHeight - iconSide) / 2, iconSide, iconSide};
    result.text = (CSMomentsCardRect){padding + inset + iconSide + gap, metrics.locationY,
        fmax(0, contentWidth - iconSide - gap), metrics.locationHeight};
    return result;
}

#endif
