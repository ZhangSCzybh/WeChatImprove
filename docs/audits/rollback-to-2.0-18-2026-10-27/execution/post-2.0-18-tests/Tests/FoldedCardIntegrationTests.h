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
static CSGroupProjection *CardProjection(NSUInteger ordinary,NSUInteger folded) {
    WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll];NSMutableArray *native=[NSMutableArray array],*children=[NSMutableArray array];
    for(NSUInteger n=0;n<ordinary;n++)[native addObject:CardRow(n,[NSString stringWithFormat:@"group-%lu@chatroom",(unsigned long)n])];
    for(NSUInteger n=0;n<folded;n++)[children addObject:CardRow(n,[NSString stringWithFormat:@"folded-%lu@chatroom",(unsigned long)n])];
    [native addObject:[[CSGroupRow alloc] initWithNativePath:Path(ordinary,0) userName:@"chatroom_session_box" kind:CSGroupRowKindAggregate category:CSGroupRowCategoryGroup top:NO unreadCount:99 redDot:YES]];
    CSGroupProjection *child=[[CSGroupProjection alloc] initWithSections:@[children] tabs:@[all] selectedTabID:all.tabId filterDuplicates:NO accountID:@"cards"];
    return [[CSGroupProjection alloc] initWithSections:@[native] tabs:@[all] selectedTabID:all.tabId filterDuplicates:NO accountID:@"cards" hiddenUserNames:[NSSet set] unmaskedAggregateUserNames:[NSSet set] privacyRevision:1 scopeFoldedEntry:YES foldedProjection:child previousProjection:nil];
}
static void FoldedCardIntegrationTests(void) {
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
        Check(height==86,@"independent folded card adds the configured 10-point gap without shrinking native content");
        UITableViewCell *ordinary=Cell(table,1,0);
        UITableViewCell *fold=nativeLayout.boolValue ? [[NewMainFrameCell alloc] initWithFrame:CGRectMake(0,0,390,height)] : [[UITableViewCell alloc] initWithFrame:CGRectMake(0,0,390,height)];
        fold.contentView.frame=fold.bounds;fold.path=Path(2,0);[table addSubview:fold];
        fold.backgroundColor=UIColor.whiteColor;fold.contentView.backgroundColor=UIColor.whiteColor;
        MainFrameItemView *item=(id)View(MainFrameItemView.class,CGRectMake(0,0,390,76));[fold.contentView addSubview:item];
        if(nativeLayout.boolValue)((NewMainFrameCell *)fold)->m_itemView=item;
        item->m_frameHeadView=View(MMHeadImageView.class,CGRectMake(12,14,48,48));[item addSubview:item->m_frameHeadView];
        item->m_nameLabel=(id)View(UILabel.class,CGRectMake(72,14,210,22));item->m_nameLabel.text=@"global title";[item addSubview:item->m_nameLabel];
        item->m_messageLabel=(id)View(UILabel.class,CGRectMake(72,42,240,18));item->m_messageLabel.text=@"other group private preview";[item addSubview:item->m_messageLabel];
        item->m_timeLabel=(id)View(UILabel.class,CGRectMake(300,14,40,16));item->m_timeLabel.text=@"21:31";[item addSubview:item->m_timeLabel];
        CSGroupWithNativeIndices(table,^{CSListCornerSessionDecorate(ordinary,table,Path(1,0),owner);CSListCornerSessionDecorate(fold,table,Path(2,0),owner);});
        UIView *card=Background(fold),*normalCard=Background(ordinary);
        CSCloseFriendUpdateSessionCover(fold,entry);
        Check(CardVisible(card) && CardVisible(normalCard) && card.frame.origin.x==normalCard.frame.origin.x && card.frame.size.width==normalCard.frame.size.width,@"native and fallback folded covers preserve the real shared card background and horizontal margins");
        Check(card.frame.origin.y==10 && card.frame.size.height==76 && !Rounded(card,CGPointMake(1,1)) && !Rounded(card,CGPointMake(1,75)),@"folded entry is a separate card with configured gap and both top/bottom rounded corners");
        Check(!Rounded(normalCard,CGPointMake(1,59)),@"the preceding session closes its bottom corners before the folded card");
        UILabel *summary=CardText(fold,@"1 个会话");
        Check(summary && !CardText(fold,@"other group private preview") && !CardText(fold,@"21:31"),@"shared card retains neutral summary without exposing native global business text");
        Check(!nativeLayout.boolValue || CardVisible(item->m_frameHeadView),@"verified native aggregate icon survives card rendering and privacy presentation");
        UIColor *custom=[UIColor colorWithRed:.15 green:.22 blue:.3 alpha:1];
        [FixtureConfiguration saveNumber:24 forKey:kListCornerRadiusKey];
        [FixtureConfiguration saveNumber:25 forKey:kListLeftMarginKey];[FixtureConfiguration saveNumber:31 forKey:kListRightMarginKey];
        [FixtureConfiguration saveColor:custom redKey:kListDarkModeBgColorRedKey greenKey:kListDarkModeBgColorGreenKey blueKey:kListDarkModeBgColorBlueKey alphaKey:kListDarkModeBgColorAlphaKey];
        fold.contentView.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;table.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;
        HookNewMainFrameCellLayout(fold,^{});CSCloseFriendRefreshSessionCover(fold);
        Check(CardVisible(card) && card.frame.origin.x==25 && card.frame.size.width==334 && card.layer.cornerRadius==24 && [card.backgroundColor isEqual:[FixtureConfiguration.snapshot backgroundForStyle:UIUserInterfaceStyleDark]],@"radius, asymmetric margins and dark card color update on the same visible folded card");
        Check(CardText(fold,@"1 个会话") && !CardText(fold,@"other group private preview"),@"configuration refresh never restores private preview");
        [FixtureConfiguration saveEnabled:NO];HookNewMainFrameCellLayout(fold,^{});CSCloseFriendRefreshSessionCover(fold);
        Check(!card.superview,@"disabling rounding removes the owned folded card instead of freezing it");
        Check(fold.contentView.backgroundColor==UIColor.whiteColor || [fold.contentView.backgroundColor isEqual:UIColor.whiteColor],@"disabling corners restores the native flat content surface");
        if(nativeLayout.boolValue)Check(item.frame.origin.x==0 && item.frame.size.width==390 && item.frame.origin.y==0,@"disabled folded item restores native full-width coordinates");
        Check(CardText(fold,@"1 个会话") && !CardText(fold,@"other group private preview"),@"flat mode keeps neutral text and privacy protection");
        Check(HookSessionRowHeight(owner,table,Path(2,0),76)==76,@"disabled cards retain native row height without an added gap");
        [FixtureConfiguration saveEnabled:YES];
        CSGroupWithNativeIndices(table,^{CSListCornerSessionDecorate(fold,table,Path(2,0),owner);});
        CSCloseFriendRefreshSessionCover(fold);
        UIView *rebuilt=CSListCornerExistingSessionBackground(fold);
        Check(rebuilt && rebuilt!=card && CardVisible(rebuilt) && rebuilt.frame.origin.x==25 && rebuilt.layer.cornerRadius==24,@"reenabling on normal cell delivery rebuilds the shared card using current configuration");
        Check(CardText(fold,@"1 个会话") && !CardText(fold,@"other group private preview"),@"fallback protection relocates into the rebuilt card without revealing global content");
        if(nativeLayout.boolValue) {
            CGRect nativeFrame=CGRectMake(0,0,390,76);
            for(NSUInteger n=0;n<3;n++) {
                item.frame=CSListCornerSessionItemFrame(item,nativeFrame);
                HookNewMainFrameCellLayout(fold,^{});
            }
            Check(CGRectEqualToRect(CSListCornerNativeFrame(item),nativeFrame) && item.frame.origin.y==10,@"native setter and card relayout preserve original coordinates without accumulated insets");
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
