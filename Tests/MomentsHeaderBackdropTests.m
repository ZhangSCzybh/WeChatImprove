#import "CSMomentsHeaderBackdrop.h"
#import "CSMomentsVisualSurface.h"
#import "CSMomentsMasonryLayout.h"
#import <objc/runtime.h>
#import <math.h>

// Real UIKit and Core Animation; only the private WeChat header is a fixture.
@interface WCListHeaderView : UIView
@property(nonatomic,strong) UIImageView *m_backgroundImageView;
@property(nonatomic,strong) UIView *m_headImageView,*m_nickLabel,*nicknameContainerView;
@end
@implementation WCListHeaderView @end
static NSUInteger Checks;
static void Check(BOOL value,NSString *message) {
    Checks++; if(!value) { fprintf(stderr,"FAIL: %s\n",message.UTF8String); exit(1); }
}
static BOOL Near(CGFloat a,CGFloat b) { return fabs(a-b)<.001; }
static UIImage *Photo(CGSize size) {
    UIGraphicsImageRendererFormat *f=[UIGraphicsImageRendererFormat defaultFormat]; f.scale=1;
    return [[[UIGraphicsImageRenderer alloc] initWithSize:size format:f] imageWithActions:^(UIGraphicsImageRendererContext *ctx) {
        for(NSUInteger y=0;y<(NSUInteger)size.height;y++) {
            [[UIColor colorWithRed:.1+.3*(y%71)/71.0 green:.2 blue:.3 alpha:1] setFill];
            UIRectFill(CGRectMake(0,y,size.width,1));
        }
    }];
}
static WCListHeaderView *Header(CGSize photoSize) {
    WCListHeaderView *h=[[WCListHeaderView alloc] initWithFrame:CGRectMake(0,0,430,335)];
    h.clipsToBounds=YES; h.backgroundColor=UIColor.whiteColor;
    h.m_backgroundImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0,0,430,286)];
    h.m_backgroundImageView.contentMode=UIViewContentModeScaleAspectFill;
    h.m_backgroundImageView.clipsToBounds=YES; h.m_backgroundImageView.image=Photo(photoSize);
    h.m_backgroundImageView.userInteractionEnabled=YES;
    h.m_headImageView=[[UIView alloc] initWithFrame:CGRectMake(345,239,70,70)];
    h.m_nickLabel=[[UIView alloc] initWithFrame:CGRectMake(250,260,90,22)];
    [h addSubview:h.m_backgroundImageView]; [h addSubview:h.m_headImageView]; [h addSubview:h.m_nickLabel]; return h;
}
static UIView *Host(void) {
    UIView *host=[[UIView alloc] initWithFrame:CGRectMake(0,0,430,387)];
    host.userInteractionEnabled=NO; host.layer.zPosition=-1; return host;
}
static BOOL ApplyAtTop(WCListHeaderView *h,UIView *host,CGFloat top) { return CSMomentsHeaderBackdropApply(h,host,top,CGRectGetHeight(h.bounds)+top+8); }
static BOOL Apply(WCListHeaderView *h,UIView *host) { return ApplyAtTop(h,host,0); }
static UIView *Backdrop(UIView *host) { return host.subviews.firstObject; }
static UIImageView *Copy(UIView *host) { return (id)Backdrop(host).subviews.firstObject; }
static CAGradientLayer *Mask(UIView *host) { return (id)Copy(host).layer.mask; }
static CGFloat FadeY(UIView *host,BOOL end) {
    UIImageView *v=Copy(host); CAGradientLayer *m=Mask(host);
    CGFloat stop=[m.locations[end ? m.locations.count-2 : 1] doubleValue];
    return CGRectGetMinY(Backdrop(host).frame)+v.layer.position.y+v.layer.transform.m42+
        (stop-.5)*CGRectGetHeight(v.bounds)*v.layer.transform.m22;
}
static UIImage *Render(UIView *view) {
    [view layoutIfNeeded]; UIGraphicsImageRendererFormat *f=[UIGraphicsImageRendererFormat defaultFormat]; f.scale=1;
    return [[[UIGraphicsImageRenderer alloc] initWithSize:view.bounds.size format:f] imageWithActions:^(UIGraphicsImageRendererContext *ctx) {
        CGContextTranslateCTM(ctx.CGContext,-CGRectGetMinX(view.bounds),-CGRectGetMinY(view.bounds));
        [view.layer renderInContext:ctx.CGContext];
    }];
}
static void Pixel(UIImage *image,NSUInteger x,NSUInteger y,unsigned char *pixel) {
    size_t w=CGImageGetWidth(image.CGImage),h=CGImageGetHeight(image.CGImage);
    NSMutableData *data=[NSMutableData dataWithLength:w*h*4]; CGColorSpaceRef space=CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx=CGBitmapContextCreate(data.mutableBytes,w,h,8,w*4,space,kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    CGContextDrawImage(ctx,CGRectMake(0,0,w,h),image.CGImage);
    memcpy(pixel,(unsigned char *)data.mutableBytes+(y*w+x)*4,4); CGContextRelease(ctx); CGColorSpaceRelease(space);
}
static NSInteger Diff(unsigned char *a,unsigned char *b) { return labs(a[0]-b[0])+labs(a[1]-b[1])+labs(a[2]-b[2]); }
static void TestCompositionAndPixels(void) {
    WCListHeaderView *h=Header(CGSizeMake(430,600)); UIImageView *s=h.m_backgroundImageView;
    UIImage *native=Render(s); CGRect originalFrame=s.frame; CALayer *originalMask=[CALayer layer]; s.layer.mask=originalMask;
    UIView *page=[[UIView alloc] initWithFrame:CGRectMake(0,0,430,540)];
    page.overrideUserInterfaceStyle=UIUserInterfaceStyleLight; page.backgroundColor=CSMomentsPageFill();
    UIView *host=Host(); [page addSubview:host];
    UIView *viewport=[[UIView alloc] initWithFrame:h.frame]; viewport.clipsToBounds=YES;
    [page addSubview:viewport]; [viewport addSubview:h];
    UIView *row=[[UIView alloc] initWithFrame:CGRectMake(0,335,430,100)]; row.backgroundColor=UIColor.redColor; [viewport addSubview:row];
    UIView *card=[[UIView alloc] initWithFrame:CGRectMake(8,343,203,160)]; card.backgroundColor=UIColor.whiteColor;
    card.layer.cornerRadius=14; [page addSubview:card];
    Check(Apply(h,host),@"supported header applies into independent content background");
    Check(h.subviews.count==3 && Backdrop(host).superview==host && viewport.clipsToBounds && h.clipsToBounds,@"native foreground and row clipping stay intact");
    Check(CGRectEqualToRect(s.frame,originalFrame) && s.image==Copy(host).image && !s.hidden && s.userInteractionEnabled,@"native geometry, image and cover tap target are preserved");
    Check(!Backdrop(host).userInteractionEnabled && !Copy(host).userInteractionEnabled,@"visual layers do not intercept taps");
    Check(Near(CGRectGetMaxY(Backdrop(host).frame),387) && FadeY(host,YES)>343,@"photo extends behind first cards");
    Check(Near(CGRectGetMidY(Copy(host).frame),CGRectGetMidY(s.frame)) && Near(CGRectGetWidth(Copy(host).bounds),430),@"spare rows retain native center and zoom");
    Check(Mask(host).locations.count==13 && Mask(host).colors.count==13 && FadeY(host,YES)-FadeY(host,NO)>=120-.001,@"long fade uses eleven eased opacity samples");
    UIImage *light=Render(page); unsigned char a[4],b[4],fill[4],tail[4];
    for(NSNumber *y in @[@10,@60,@120,@210]) { Pixel(native,4,y.unsignedIntegerValue,a); Pixel(light,4,y.unsignedIntegerValue,b); Check(Diff(a,b)<=3,@"unfaded pixels retain native crop"); }
    Pixel(light,4,334,a); Pixel(light,4,335,b); Check(Diff(a,b)<12,@"native header edge has no pixel discontinuity");
    Pixel(light,4,343,tail); Pixel(light,4,400,fill); Check(Diff(tail,fill)>20,@"card-area margin still shows the fading photograph");
    Pixel(light,30,365,a); Check(a[0]>245 && a[1]>245 && a[2]>245,@"opaque card stays above background");
    Pixel(light,4,386,tail); Check(Diff(tail,fill)<=3,@"tail meets actual light fill and native rows stay clipped");
    [viewport removeFromSuperview]; Check(Backdrop(host).superview==host && Copy(host).image!=nil,@"header reuse leaves visible fade tail alive"); [page addSubview:viewport];
    page.overrideUserInterfaceStyle=UIUserInterfaceStyleDark;
    // Offscreen Catalyst fixtures have no window to propagate appearance.
    page.backgroundColor=[CSMomentsPageFill() resolvedColorWithTraitCollection:[UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark]];
    card.backgroundColor=[UIColor.secondarySystemGroupedBackgroundColor resolvedColorWithTraitCollection:[UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark]];
    UIImage *dark=Render(page);
    Pixel(dark,4,386,tail); Pixel(dark,4,400,fill); Check(fill[0]<80 && Diff(tail,fill)<=3,@"same alpha mask meets actual dark fill");
    NSString *preview=NSProcessInfo.processInfo.environment[@"CS_MOMENTS_PREVIEW_DIR"];
    if(preview.length) { [UIImagePNGRepresentation(light) writeToFile:[preview stringByAppendingPathComponent:@"light.png"] atomically:YES]; [UIImagePNGRepresentation(dark) writeToFile:[preview stringByAppendingPathComponent:@"dark.png"] atomically:YES]; }
    CSMomentsHeaderBackdropRemove(h);
    Check(host.subviews.count==0 && s.layer.mask==originalMask && h.clipsToBounds && [h.backgroundColor isEqual:UIColor.whiteColor],@"disable restores native pixels, fill and clipping");
    CSMomentsHeaderBackdropRemove(h); Check(host.subviews.count==0,@"removal is idempotent");
}
static void TestPullAndReplacement(void) {
    WCListHeaderView *h=Header(CGSizeMake(430,900)); UIView *host=Host(); h.m_backgroundImageView.frame=CGRectMake(0,-88,430,374);
    Check(Apply(h,host),@"negative native top applies"); CGFloat start=FadeY(host,NO),end=FadeY(host,YES);
    CGSize size=Copy(host).bounds.size; CGRect nativeFrame=h.m_backgroundImageView.frame;
    for(NSNumber *d in @[@0,@40,@88,@120,@260,@60,@0]) {
        CGFloat pull=d.doubleValue; CSMomentsHeaderBackdropSetPullDistance(h,pull); UIImageView *v=Copy(host);
        CGFloat height=CGRectGetHeight(v.bounds)*v.layer.transform.m22;
        CGFloat center=CGRectGetMinY(Backdrop(host).frame)+v.layer.position.y+v.layer.transform.m42;
        Check(center-height/2<=-pull+.001,@"sample reaches pulled top");
        Check(Near(start,FadeY(host,NO)) && Near(end,FadeY(host,YES)),@"both fade ends remain anchored during pull");
        Check(CGSizeEqualToSize(size,v.bounds.size) && CGRectEqualToRect(nativeFrame,h.m_backgroundImageView.frame),@"pull does not resample native image");
    }
    Check(CATransform3DIsIdentity(Copy(host).layer.transform),@"rebound resets stretch"); UIView *same=Backdrop(host);
    for(NSUInteger i=0;i<8;i++) Check(Apply(h,host) && same==Backdrop(host) && host.subviews.count==1,@"layout reuses a single backdrop");
    UIImageView *retired=h.m_backgroundImageView; CSMomentsHeaderBackdropRemove(h);
    CALayer *nativeMask=[CALayer layer]; retired.layer.mask=nativeMask; Check(Apply(h,host),@"native mask fixture applies");
    UIImageView *next=[[UIImageView alloc] initWithFrame:retired.frame]; next.contentMode=retired.contentMode; next.image=Photo(CGSizeMake(430,286));
    [retired removeFromSuperview]; [h insertSubview:next atIndex:0]; h.m_backgroundImageView=next;
    Check(Apply(h,host) && Copy(host).image==next.image && retired.layer.mask==nativeMask,@"replacement follows new image and restores retired source");
    Check(FadeY(host,YES)<CGRectGetMaxY(next.frame)+88,@"short image fades before real pixels end");
    UIView *nextHost=Host(); Check(Apply(h,nextHost) && host.subviews.count==0 && nextHost.subviews.count==1,@"host replacement transfers one backdrop");
    next.image=nil; Check(!Apply(h,nextHost) && nextHost.subviews.count==0,@"missing native image clears old photograph");
}
static NSInteger WrongGetter(id self,SEL cmd) { return 12; }
@interface CSBackdropCollectionSource : NSObject <UICollectionViewDataSource>
@property(nonatomic,strong) WCListHeaderView *header;
@end
@implementation CSBackdropCollectionSource
- (NSInteger)collectionView:(UICollectionView *)collection numberOfItemsInSection:(NSInteger)section { return 2; }
- (UICollectionViewCell *)collectionView:(UICollectionView *)collection cellForItemAtIndexPath:(NSIndexPath *)path {
    UICollectionViewCell *cell=[collection dequeueReusableCellWithReuseIdentifier:@"card" forIndexPath:path];
    cell.backgroundColor=UIColor.clearColor; cell.contentView.backgroundColor=UIColor.whiteColor;
    cell.contentView.layer.cornerRadius=14; return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collection viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)path {
    UICollectionReusableView *view=[collection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:path];
    view.clipsToBounds=YES; [view addSubview:self.header]; return view;
}
@end
static void TestCollectionScrollAndReuse(void) {
    CSMomentsMasonryLayout *layout=[CSMomentsMasonryLayout new]; layout.headerHeight=335;
    layout.heightForItem=^CGFloat(NSIndexPath *path,CGFloat width) { return 320; };
    CSMomentsBackdropCollectionView *collection=[[CSMomentsBackdropCollectionView alloc] initWithFrame:CGRectMake(0,0,430,220) collectionViewLayout:layout];
    collection.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
    collection.backgroundColor=[CSMomentsPageFill() resolvedColorWithTraitCollection:[UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleLight]];
    [collection registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:@"card"];
    [collection registerClass:UICollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    CSBackdropCollectionSource *source=[CSBackdropCollectionSource new]; source.header=Header(CGSizeMake(430,600));
    collection.dataSource=source; UIView *host=Host(); [collection addSubview:host]; collection.contentBackground=host;
    [collection reloadData]; [collection layoutIfNeeded]; Check(Apply(source.header,host),@"real collection applies backdrop");
    UICollectionViewLayoutAttributes *attributes=[layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    Check(Near(layout.firstCardTop,343) && Near(CGRectGetMinY(attributes.frame),layout.firstCardTop),@"production layout exposes actual unchanged card origin");
    CGSize contentSize=collection.contentSize;
    [collection setContentOffset:CGPointMake(0,340) animated:NO]; [collection layoutIfNeeded];
    Check(CGRectGetMinY(host.frame)==0 && host.superview==collection,@"background remains in content coordinates through collection reuse");
    UIImage *scrolled=Render(collection); unsigned char photo[4],fill[4],card[4];
    Pixel(scrolled,4,3,photo); Pixel(scrolled,4,60,fill); Pixel(scrolled,30,25,card);
    Check(Diff(photo,fill)>20,@"fade tail remains rendered after supplementary header leaves screen");
    Check(card[0]>245 && card[1]>245 && card[2]>245,@"managed collection cell stays above negative-z background");
    Check(CGSizeEqualToSize(contentSize,collection.contentSize),@"background adds no scroll height");
    [collection setContentOffset:CGPointZero animated:NO]; [collection reloadData]; [collection layoutIfNeeded];
    Check(Apply(source.header,host) && host.subviews.count==1,@"reload and return to top reuse a single background");
    CSMomentsHeaderBackdropRemove(source.header); collection.dataSource=nil;
}
static void TestAdmissionAndGeometry(void) {
    UIView *host=Host(); WCListHeaderView *h=Header(CGSizeMake(430,600));
    for(NSNumber *w in @[@320,@390,@430,@844]) {
        h.frame=CGRectMake(0,0,w.doubleValue,335); h.m_backgroundImageView.frame=CGRectMake(0,-88,w.doubleValue,374);
        Check(Apply(h,host),@"rotation and widths reflow independent background");
        Check(Near(CGRectGetWidth(Backdrop(host).frame),w.doubleValue) && Near(CGRectGetMaxY(Backdrop(host).frame),387),@"photo crop does not add header height");
        Check(FadeY(host,NO)<FadeY(host,YES) && isfinite(FadeY(host,YES)),@"fallback geometry remains ordered and finite");
    }
    h.hidden=YES; Check(!Apply(h,host) && host.subviews.count==0,@"hidden header clears background"); h.hidden=NO;
    [h insertSubview:h.m_headImageView atIndex:0]; Check(!Apply(h,host),@"unexpected foreground hierarchy fails closed"); [h addSubview:h.m_headImageView];
    Check(!CSMomentsHeaderBackdropApply(h,h,0,343),@"background cannot enter native clip container");
    Check(!CSMomentsHeaderBackdropApply(h,host,0,NAN),@"nonfinite card boundary is rejected");
    Check(!CSMomentsHeaderBackdropApply(h,host,NAN,343) && !CSMomentsHeaderBackdropApply(h,host,-1,343),@"invalid resting origins are rejected");
    Class changed=objc_allocateClassPair(WCListHeaderView.class,"CSHeaderChangedABI",0);
    class_addMethod(changed,@selector(m_backgroundImageView),(IMP)WrongGetter,"q@:"); objc_registerClassPair(changed); object_setClass(h,changed);
    Check(!Apply(h,host),@"changed getter ABI rejected before dispatch"); object_setClass(h,WCListHeaderView.class); Check(Apply(h,host),@"native ABI restoration reapplies");
    __block BOOL result=YES; dispatch_semaphore_t done=dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT,0),^{ result=Apply(h,host); CSMomentsHeaderBackdropRemove(h); dispatch_semaphore_signal(done); });
    dispatch_semaphore_wait(done,DISPATCH_TIME_FOREVER); Check(!result && host.subviews.count==1,@"off-main calls do not mutate background"); CSMomentsHeaderBackdropRemove(h);
    Check(!CSMomentsHeaderBackdropApply(nil,host,0,343) && !CSMomentsHeaderBackdropApply([UIView new],host,0,343),@"unrelated headers rejected");
}
static void TestNativeTopAndPixels(void) {
    for(NSNumber *inset in @[@0,@44,@88,@100,@103]) {
        CGFloat top=inset.doubleValue;
        WCListHeaderView *h=Header(CGSizeMake(430,900));
        // Photo overscan and the resting table inset are deliberately unequal:
        // beta04 incorrectly used all 200pt of overscan as the resting origin.
        h.clipsToBounds=NO; h.m_backgroundImageView.frame=CGRectMake(0,-200,430,486);
        h.m_headImageView.backgroundColor=UIColor.greenColor;
        h.m_nickLabel.backgroundColor=UIColor.blueColor;
        CGRect sourceFrame=h.m_backgroundImageView.frame;
        UIView *page=[[UIView alloc] initWithFrame:CGRectMake(0,0,430,600)];
        page.backgroundColor=UIColor.whiteColor;
        UITableView *table=[[UITableView alloc] initWithFrame:page.bounds style:UITableViewStylePlain];
        table.backgroundColor=UIColor.clearColor; table.clipsToBounds=NO;
        table.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        table.tableHeaderView=h; [page addSubview:table];
        table.contentInset=UIEdgeInsetsMake(top,0,0,0); table.contentOffset=CGPointMake(0,-top);
        // The native reference is the actual viewport, including its crop and
        // scroll translation, rather than the entire background UIImageView.
        UIImage *native=Render(page);
        CGRect avatar=[h.m_headImageView convertRect:h.m_headImageView.bounds toView:page];
        CGRect nickname=[h.m_nickLabel convertRect:h.m_nickLabel.bounds toView:page];
        Check(Near(CGRectGetMinY(avatar),239+top),@"reference table renders native resting origin");
        UIView *host=Host(); host.frame=CGRectMake(0,0,430,387+top); [page insertSubview:host atIndex:0];
        UIView *viewport=[[UIView alloc] initWithFrame:CGRectMake(0,0,430,335+top)];
        viewport.clipsToBounds=YES; [page addSubview:viewport]; [viewport addSubview:table];
        table.contentInset=UIEdgeInsetsZero; table.contentOffset=CGPointZero;
        table.frame=CGRectMake(0,top,430,600);
        Check(ApplyAtTop(h,host,top),@"backdrop accepts actual resting origin independently of crop");
        UIImage *waterfall=Render(page); unsigned char a[4],b[4];
        for(NSNumber *y in @[@5,@60,@120,@200]) {
            Pixel(native,4,y.unsignedIntegerValue,a); Pixel(waterfall,4,y.unsignedIntegerValue,b);
            Check(Diff(a,b)<=3,@"resting waterfall displays same native pixels from screen top");
        }
        Check(CGRectEqualToRect(avatar,[h.m_headImageView convertRect:h.m_headImageView.bounds toView:page]),@"avatar stays at native screen position");
        Check(CGRectEqualToRect(nickname,[h.m_nickLabel convertRect:h.m_nickLabel.bounds toView:page]),@"nickname stays at native screen position");
        Check(CGRectEqualToRect(sourceFrame,h.m_backgroundImageView.frame),@"native cover frame is never resized to compensate");
        Check(Near(CGRectGetMaxY(Backdrop(host).frame),387+top),@"seam and first-card background move with restored header height");
        CGFloat start=FadeY(host,NO),end=FadeY(host,YES);
        CSMomentsHeaderBackdropSetPullDistance(h,180);
        Check(Near(start,FadeY(host,NO)) && Near(end,FadeY(host,YES)),@"native-height fade stays fixed through pull");
        CSMomentsHeaderBackdropSetPullDistance(h,0);
        CSMomentsHeaderBackdropRemove(h);
        Check(h.m_backgroundImageView.layer.mask==nil && CGRectEqualToRect(sourceFrame,h.m_backgroundImageView.frame),@"removal restores native image after height compensation");
    }
}
int main(void) { @autoreleasepool {
    TestNativeTopAndPixels();
    TestCompositionAndPixels(); TestPullAndReplacement(); TestAdmissionAndGeometry(); TestCollectionScrollAndReuse();
    printf("Moments header backdrop: %lu checks passed (real UIKit pixels, seam, theme, sampling, pull, reuse, replacement, restore).\n",(unsigned long)Checks); return 0;
} }
