#import "CSMomentsMasonryLayout.h"
#import "CSMomentsMasonryGeometry.h"

static const CGFloat CSMomentsPageMargin = 8;

@implementation CSMomentsMasonryLayout {
    NSMutableArray<UICollectionViewLayoutAttributes *> *_attributes;
    NSMutableDictionary<NSIndexPath *, UICollectionViewLayoutAttributes *> *_itemAttributes;
    UICollectionViewLayoutAttributes *_headerAttributes;
    UICollectionViewLayoutAttributes *_footerAttributes;
    CGSize _contentSize;
    CGFloat _cardWidth;
}
@synthesize heightForItem = _heightForItem;
@synthesize headerHeight = _headerHeight;
@synthesize footerHeight = _footerHeight;

- (CGFloat)cardWidth { return _cardWidth; }
- (CGFloat)firstCardTop { return self.headerHeight + CSMomentsPageMargin; }

- (void)setHeightForItem:(CGFloat (^)(NSIndexPath *, CGFloat))heightForItem {
    _heightForItem = [heightForItem copy];
    [self invalidateLayout];
}

- (void)setHeaderHeight:(CGFloat)headerHeight {
    CGFloat value = isfinite(headerHeight) && headerHeight > 0 ? headerHeight : 0;
    if (_headerHeight == value) return;
    _headerHeight = value;
    [self invalidateLayout];
}

- (void)setFooterHeight:(CGFloat)footerHeight {
    CGFloat value = isfinite(footerHeight) && footerHeight > 0 ? footerHeight : 0;
    if (_footerHeight == value) return;
    _footerHeight = value;
    [self invalidateLayout];
}

- (void)prepareLayout {
    [super prepareLayout];
    _attributes = [NSMutableArray array];
    _itemAttributes = [NSMutableDictionary dictionary];
    _headerAttributes = nil;
    _footerAttributes = nil;
    _contentSize = CGSizeZero;
    _cardWidth = 0;

    UICollectionView *collectionView = self.collectionView;
    NSInteger sectionCount = collectionView.numberOfSections;
    if (!collectionView || sectionCount < 1) return;
    CGFloat width = collectionView.bounds.size.width;
    CSMomentsMasonryGeometry geometry;
    if (!CSMomentsMasonryInitialize(&geometry, width, CSMomentsPageMargin, 8, 14, self.headerHeight)) return;
    _cardWidth = geometry.cardWidth;

    if (self.headerHeight > 0) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
        _headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:path];
        _headerAttributes.frame = CGRectMake(0, 0, width, self.headerHeight);
        [_attributes addObject:_headerAttributes];
    }

    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [collectionView numberOfItemsInSection:section];
        for (NSInteger item = 0; item < itemCount; item++) {
            NSIndexPath *path = [NSIndexPath indexPathForItem:item inSection:section];
            CGFloat height = self.heightForItem ? self.heightForItem(path, _cardWidth) : _cardWidth;
            CSMomentsMasonryFrame frame;
            if (!CSMomentsMasonryAppend(&geometry, height, &frame) &&
                !CSMomentsMasonryAppend(&geometry, _cardWidth, &frame)) continue;
            UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
            attributes.frame = CGRectMake(frame.x, frame.y, frame.width, frame.height);
            [_attributes addObject:attributes];
            _itemAttributes[path] = attributes;
        }
    }

    CGFloat bottom = CSMomentsMasonryBottom(&geometry);
    if (self.footerHeight > 0) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:sectionCount - 1];
        _footerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:path];
        _footerAttributes.frame = CGRectMake(0, bottom, width, self.footerHeight);
        [_attributes addObject:_footerAttributes];
    }
    _contentSize = CGSizeMake(width, bottom + self.footerHeight);
}

- (CGSize)collectionViewContentSize { return _contentSize; }

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *visible = [NSMutableArray array];
    for (UICollectionViewLayoutAttributes *attributes in _attributes) {
        if (CGRectIntersectsRect(attributes.frame, rect)) [visible addObject:attributes];
    }
    return visible;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return _itemAttributes[indexPath];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) attributes = _headerAttributes;
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) attributes = _footerAttributes;
    return [attributes.indexPath isEqual:indexPath] ? attributes : nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return newBounds.size.width != self.collectionView.bounds.size.width;
}
@end
