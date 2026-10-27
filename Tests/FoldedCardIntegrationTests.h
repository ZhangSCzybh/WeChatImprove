#include "FoldedSummaryFixtures.h"
// The real projection, card renderer and privacy presentation run on the same cell.
static BOOL CardVisible(UIView *view) {
    if(!view.superview)return NO;
    for(UIView *p=view;p;p=p.superview)if(p.hidden)return NO;
    return YES;
}
static UILabel *CardText(UIView *view,NSString *text) {
    if(view.hidden)return nil;
    if([view isKindOfClass:UILabel.class] && [((UILabel *)view).text isEqual:text])return (UILabel *)view;
    for(UIView *child in view.subviews){UILabel *found=CardText(child,text);if(found)return found;}return nil;
}
static void CheckFoldedTextLayout(UITableViewCell *cell,NSString *phase) {
    UILabel *title=CardText(cell,@"折叠的聊天"),*summary=CardText(cell,@"[图片]"),*prefix=CardText(cell,@"folded-0@chatroom: ");
    if (![cell isKindOfClass:NewMainFrameCell.class]) { Check(title && !summary,[phase stringByAppendingString:@": unknown native structure retains neutral protection"]);return; }
    
    Check(title && summary && title.numberOfLines==1 && !title.adjustsFontSizeToFitWidth && title.font.pointSize>=17,[phase stringByAppendingString:@": native title has no count or font shrinking"]);
    Check(summary.textAlignment==NSTextAlignmentLeft && title.textAlignment==NSTextAlignmentLeft && prefix.frame.origin.x==title.frame.origin.x && summary.frame.origin.x==ceil(CGRectGetMaxX(prefix.frame)),[phase stringByAppendingString:@": native child summary shares title left edge"]);
}
static CSGroupProjection *CardProjectionAt(NSUInteger ordinary,NSUInteger folded,NSUInteger position) {
    WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll];NSMutableArray *native=[NSMutableArray array],*children=[NSMutableArray array];
    for(NSUInteger n=0;n<=ordinary;n++) {
        if(n==position)[native addObject:[[CSGroupRow alloc] initWithNativePath:Path(n,0) userName:@"chatroom_session_box" kind:CSGroupRowKindAggregate category:CSGroupRowCategoryGroup top:NO unreadCount:99 redDot:YES]];
        else [native addObject:CardRow(n,[NSString stringWithFormat:@"group-%lu@chatroom",(unsigned long)n])];
    }
    for(NSUInteger n=0;n<folded;n++)[children addObject:SummaryFixtureRow(Path(n,0),[NSString stringWithFormat:@"folded-%lu@chatroom",(unsigned long)n],@"[图片]",@(n+1))];
    CSGroupProjection *child=[[CSGroupProjection alloc] initWithSections:@[children] tabs:@[all] selectedTabID:all.tabId filterDuplicates:NO accountID:@"cards" hiddenUserNames:[NSSet set] privacyRevision:1 previousProjection:nil];
    return [[CSGroupProjection alloc] initWithSections:@[native] tabs:@[all] selectedTabID:all.tabId filterDuplicates:NO accountID:@"cards" hiddenUserNames:[NSSet set] unmaskedAggregateUserNames:[NSSet set] privacyRevision:1 scopeFoldedEntry:YES foldedProjection:child previousProjection:nil];
}
static CSGroupProjection *CardProjection(NSUInteger ordinary,NSUInteger folded) { return CardProjectionAt(ordinary,folded,ordinary); }
static void FoldedContinuousSectionTests(void) {
    for(NSNumber *style in @[@(UIUserInterfaceStyleLight),@(UIUserInterfaceStyleDark)]) {
        for(NSUInteger position=0;position<3;position++) {
            Configure();[FixtureConfiguration saveNumber:19 forKey:kListNormalSessionTopMarginKey];
            UITableView *table=Table();id owner=Owner(CSListCornerPageSession,table);
            CSGroupProjection *projection=CardProjectionAt(2,4,position);
            CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.active=YES;adapter.projection=(id)projection;table.groupAdapter=adapter;
            adapter.nativeToDisplay=@{Path(10,0):Path(0,0),Path(20,0):Path(1,0),Path(30,0):Path(2,0)};table.throwsOnQuery=YES;
            CGFloat bottom=0;UIView *previous=nil;
            for(NSUInteger i=0;i<3;i++) {
                __block CGFloat height=0;NSIndexPath *native=Path((i+1)*10,0);
                CSGroupWithNativeIndices(table,^{height=HookSessionRowHeight(owner,table,native,76);});
                UITableViewCell *cell=Cell(table,i,0);cell.frame=CGRectMake(0,bottom,390,height);cell.contentView.frame=cell.bounds;
                cell.contentView.traitCollection.userInterfaceStyle=style.integerValue;
                CSGroupWithNativeIndices(table,^{CSListCornerSessionDecorate(cell,table,native,owner);});
                UIView *card=Background(cell);CGRect frame=[card convertRect:card.bounds toView:table];
                Check(height==76 && card.frame.origin.y==0 && card.frame.size.height==76,@"folded row and both neighbors never add a row gap even with nonzero normalGap");
                Check(Rounded(card,CGPointMake(1,1))==(i!=0) && Rounded(card,CGPointMake(1,75))==(i!=2),@"only section first/last have exterior corners regardless of folded entry position");
                if(previous) {
                    CGRect before=[previous convertRect:previous.bounds toView:table];
                    Check(Near(CGRectGetMaxY(before),frame.origin.y) && Near(before.origin.x,frame.origin.x) && Near(before.size.width,frame.size.width),@"adjacent session and folded card surfaces share width and meet without a seam or gap");
                }
                Check([card.backgroundColor isEqual:[FixtureConfiguration.snapshot backgroundForStyle:style.integerValue]],@"continuous folded card keeps shared light/dark background");
                previous=card;bottom+=height;
            }
        }
    }
}
static void FoldedCardIntegrationTests(void) {
    FoldedContinuousSectionTests();
    Configure();[FixtureConfiguration saveNumber:10 forKey:kListNormalSessionTopMarginKey];
    for(NSNumber *nativeLayout in @[@YES,@NO]) {
        UITableView *table=Table();id owner=Owner(CSListCornerPageSession,table);
        CSGroupProjection *projection=CardProjection(2,1);
        CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.active=YES;adapter.projection=(id)projection;table.groupAdapter=adapter;
        adapter.nativeToDisplay=@{Path(0,0):Path(0,0),Path(1,0):Path(1,0),Path(2,0):Path(2,0)};table.throwsOnQuery=YES;
        CSGroupRow *entry=projection.sections[0].lastObject;
        Check(projection.sections[0].count==3 && entry.foldedEntryScoped,@"folded aggregate is a real projected row, not a footer");
        __block CGFloat height=0;
        CSGroupWithNativeIndices(table,^{height=HookSessionRowHeight(owner,table,Path(2,0),76);});
        Check(height==76,@"folded row retains native height without an extra normalGap");
        UITableViewCell *ordinary=Cell(table,1,0);
        UITableViewCell *fold=nativeLayout.boolValue ? [[NewMainFrameCell alloc] initWithFrame:CGRectMake(0,0,390,height)] : [[UITableViewCell alloc] initWithFrame:CGRectMake(0,0,390,height)];
        fold.contentView.frame=fold.bounds;fold.path=Path(2,0);[table addSubview:fold];
        fold.backgroundColor=UIColor.whiteColor;fold.contentView.backgroundColor=UIColor.whiteColor;
        MainFrameItemView *item=(id)View(MainFrameItemView.class,CGRectMake(0,0,390,76));[fold.contentView addSubview:item];
        if(nativeLayout.boolValue)((NewMainFrameCell *)fold)->m_itemView=item;
        item->m_frameHeadView=View(MMHeadImageView.class,CGRectMake(12,14,48,48));[item addSubview:item->m_frameHeadView];
        item->m_nameLabel=(id)View(UILabel.class,CGRectMake(72,14,150,22));item->m_nameLabel.text=@"折叠的聊天";[item addSubview:item->m_nameLabel];
        item->m_messageLabel=(id)View(UILabel.class,CGRectMake(184,42,100,18));item->m_messageLabel.text=@"other group private preview";[item addSubview:item->m_messageLabel];
        UILabel *globalPrefix=(id)View(UILabel.class,CGRectMake(72,42,112,18));globalPrefix.tag=10001001;globalPrefix.text=@"global: ";[item addSubview:globalPrefix];
        item->m_timeLabel=(id)View(UILabel.class,CGRectMake(300,14,40,16));item->m_timeLabel.text=@"21:31";[item addSubview:item->m_timeLabel];
        CSGroupWithNativeIndices(table,^{CSListCornerSessionDecorate(ordinary,table,Path(1,0),owner);CSListCornerSessionDecorate(fold,table,Path(2,0),owner);});
        UIView *card=Background(fold),*normalCard=Background(ordinary);
        CSCloseFriendUpdateSessionCover(fold,entry);
        Check(CardVisible(card) && CardVisible(normalCard) && card.frame.origin.x==normalCard.frame.origin.x && card.frame.size.width==normalCard.frame.size.width,@"native and fallback folded covers preserve the real shared card background and horizontal margins");
        Check(card.frame.origin.y==0 && card.frame.size.height==76 && Rounded(card,CGPointMake(1,1)) && !Rounded(card,CGPointMake(1,75)),@"last folded row joins the section with square top edges and only bottom corners");
        Check(Rounded(normalCard,CGPointMake(1,59)),@"the preceding session keeps square bottom edges adjoining the folded row");
        UILabel *summary=CardText(fold,@"[图片]");
        Check((nativeLayout.boolValue ? summary!=nil : summary==nil) && !CardText(fold,@"other group private preview") && !CardText(fold,@"21:31"),@"shared card retains scoped native summary without exposing native global business text");
        CheckFoldedTextLayout(fold,@"light card");
        if(nativeLayout.boolValue) {
            UILabel *prefix=nil;for(UIView *v in item.subviews)if(v.tag==10001001)prefix=(id)v;
            Check(prefix && CardVisible(prefix) && CardVisible(item->m_messageLabel),@"native parity: card contains native prefix plus native body label");
        }
        Check(!nativeLayout.boolValue || CardVisible(item->m_frameHeadView),@"verified native aggregate icon survives card rendering and privacy presentation");
        UIColor *custom=[UIColor colorWithRed:.15 green:.22 blue:.3 alpha:1];
        [FixtureConfiguration saveNumber:24 forKey:kListCornerRadiusKey];
        [FixtureConfiguration saveNumber:25 forKey:kListLeftMarginKey];[FixtureConfiguration saveNumber:31 forKey:kListRightMarginKey];
        [FixtureConfiguration saveColor:custom redKey:kListDarkModeBgColorRedKey greenKey:kListDarkModeBgColorGreenKey blueKey:kListDarkModeBgColorBlueKey alphaKey:kListDarkModeBgColorAlphaKey];
        fold.contentView.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;table.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;
        HookNewMainFrameCellLayout(fold,^{});CSCloseFriendRefreshSessionCover(fold);
        Check(CardVisible(card) && card.frame.origin.x==25 && card.frame.size.width==334 && Rounded(card,CGPointMake(6,6)) && !Rounded(card,CGPointMake(3,73)) && [card.backgroundColor isEqual:[FixtureConfiguration.snapshot backgroundForStyle:UIUserInterfaceStyleDark]],@"radius, asymmetric margins and dark card color update on the same visible folded card");
        Check((nativeLayout.boolValue ? CardText(fold,@"[图片]")!=nil : CardText(fold,@"[图片]")==nil) && !CardText(fold,@"other group private preview"),@"configuration refresh never restores private preview");
        CheckFoldedTextLayout(fold,@"dark card after live radius/margin change");
        [FixtureConfiguration saveEnabled:NO];HookNewMainFrameCellLayout(fold,^{});CSCloseFriendRefreshSessionCover(fold);
        Check(!card.superview,@"disabling rounding removes the owned folded card instead of freezing it");
        Check(fold.contentView.backgroundColor==UIColor.whiteColor || [fold.contentView.backgroundColor isEqual:UIColor.whiteColor],@"disabling corners restores the native flat content surface");
        if(nativeLayout.boolValue)Check(item.frame.origin.x==0 && item.frame.size.width==390 && item.frame.origin.y==0,@"disabled folded item restores native full-width coordinates");
        Check((nativeLayout.boolValue ? CardText(fold,@"[图片]")!=nil : CardText(fold,@"[图片]")==nil) && !CardText(fold,@"other group private preview"),@"flat mode keeps scoped text and privacy protection");
        CheckFoldedTextLayout(fold,@"flat after disabling corners");
        Check(HookSessionRowHeight(owner,table,Path(2,0),76)==76,@"disabled cards retain native row height without an added gap");
        [FixtureConfiguration saveEnabled:YES];
        CSGroupWithNativeIndices(table,^{CSListCornerSessionDecorate(fold,table,Path(2,0),owner);});
        CSCloseFriendRefreshSessionCover(fold);
        UIView *rebuilt=CSListCornerExistingSessionBackground(fold);
        Check(rebuilt && rebuilt!=card && CardVisible(rebuilt) && rebuilt.frame.origin.x==25 && Rounded(rebuilt,CGPointMake(6,6)) && !Rounded(rebuilt,CGPointMake(3,73)),@"reenabling on normal cell delivery rebuilds the shared card using current configuration");
        Check((nativeLayout.boolValue ? CardText(fold,@"[图片]")!=nil : CardText(fold,@"[图片]")==nil) && !CardText(fold,@"other group private preview"),@"fallback protection relocates into the rebuilt card without revealing global content");
        CheckFoldedTextLayout(fold,@"reenabled card");
        if(nativeLayout.boolValue) {
            CGRect nativeFrame=CGRectMake(0,0,390,76);
            for(NSUInteger n=0;n<3;n++) {
                item.frame=CSListCornerSessionItemFrame(item,nativeFrame);
                HookNewMainFrameCellLayout(fold,^{});
            }
            Check(CGRectEqualToRect(CSListCornerNativeFrame(item),nativeFrame) && item.frame.origin.y==0,@"native setter and card relayout preserve original coordinates without accumulated insets");
        }
        [FixtureConfiguration saveEnabled:NO];HookNewMainFrameCellLayout(fold,^{});CSCloseFriendRefreshSessionCover(fold);
        Check(!rebuilt.superview && (!nativeLayout.boolValue || (item.frame.origin.x==0 && item.frame.origin.y==0)),@"second disable removes the rebuilt card and restores native item coordinates");
        CSCloseFriendUpdateSessionCover(fold,nil);
        Check(CardVisible(item) && !item->m_messageLabel.hidden,@"ordinary reuse restores hidden native content after removing the folded display");
        Configure();[FixtureConfiguration saveNumber:10 forKey:kListCornerRadiusKey];
    }
    CSGroupProjection *empty=CardProjection(0,0);
    Check(empty.sections[0].count==0,@"empty group has no folded card or artificial placeholder row");
}
