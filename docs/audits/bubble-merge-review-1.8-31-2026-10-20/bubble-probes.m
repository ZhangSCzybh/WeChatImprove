// Review-only probes. No source patch, preferences use NSArgumentDomain only.
#define main CSExistingBubbleRegressionMain
#include "../../../Tests/BubbleStyleAdapterTests.m"
#undef main
static UIImage *Padded(CGFloat top,CGFloat bottom) {
    CGImageRef cg=CSBubbleCreateTemplate((CSBubbleRGBA){.5,.5,.5,1},10,0,2,(CSBubbleInsets){top,2,bottom,4},NO);
    UIImage *image=[UIImage imageWithCGImage:cg scale:2 orientation:UIImageOrientationUp];CGImageRelease(cg);
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top+12,14,bottom+12,16) resizingMode:UIImageResizingModeStretch];
}
int main(void) { @autoreleasepool {
    Settings(NO);CSBubbleStyleStart();
    UIImageView *metric=[UIImageView new];metric.frame=CGRectMake(0,0,180,100);metric.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;
    YYImage *dynamic=[YYImage new];dynamic.decodeImageLM=Padded(1,3);dynamic.decodeImageDM=Padded(4,6);metric.image=dynamic;
    UIEdgeInsets measured={0};BOOL valid=CSBubbleStyleVisibleInsets(metric,&measured);
    printf("dark_insets: valid=%d top=%.2f bottom=%.2f expected_dark_top=4 expected_dark_bottom=6\n",valid,measured.top,measured.bottom);
    CHECK(valid && measured.top==1 && measured.bottom==3);

    Settings(YES);
    BubbleCell *cell=[BubbleCell new];cell.background=[YYAsyncImageView new];cell.background.frame=CGRectMake(0,0,180,100);
    TextMessageViewModel *m=[TextMessageViewModel new];m.messageWrap=[BubbleWrap new];m.messageWrap.m_uiMessageType=1;cell.viewModel=m;
    YYImage *native=[YYImage imageWithUIImage:Padded(1,3)];cell.background.image=native;
    CSBubbleStyleApply(cell);CHECK(cell.background->m_image==native);
    m.bgBubbleInfo=[BubbleInfo new];CSBubbleStyleApply(cell);BOOL stuck=cell.background->m_image==native;
    CSBubbleStyleNativeChanged(cell);BOOL recovered=cell.background->m_image!=native;
    printf("late_bubble_metadata: ordinary_apply_still_native=%d explicit_invalidation_recovers=%d\n",stuck,recovered);
    CHECK(stuck && recovered);CSBubbleStyleDetach(cell);

    YYImage *pending=[YYImage deferredImageWithUIImage:Padded(1,3)];
    cell.background.image=native;cell.background.highlightedImage=pending;CSBubbleStyleApply(cell);
    BOOL before=CSBubbleStyleVisibleInsets(cell.background,&measured);
    cell.background.highlighted=YES;RunDisplay([cell.background newAsyncDisplayTask],YES,NO);Drain();
    BOOL after=CSBubbleStyleVisibleInsets(cell.background,&measured);
    printf("pressed_state_insets: normal_styled=%d measurable_before_press=%d measurable_after_press=%d top=%.2f bottom=%.2f\n",cell.background->m_image!=native,before,after,measured.top,measured.bottom);
    CHECK(!before && after && measured.top==1 && measured.bottom==3);
    CSBubbleStyleDetach(cell);Settings(NO);
} return 0; }
