// Production presentation on host native view doubles; no device pixel claim.
static BOOL Visible(UIView *view) { if(!view)return NO;for(UIView *v=view;v;v=v.superview)if(v.hidden)return NO;return YES; }
static UILabel *VisibleLabel(UIView *view,NSString *text) {
    if(!Visible(view))return nil;
    if([view isKindOfClass:UILabel.class] && [((UILabel *)view).text isEqual:text])return (UILabel *)view;
    for(UIView *child in view.subviews){UILabel *found=VisibleLabel(child,text);if(found)return found;}return nil;
}
static UILabel *Prefix(MainFrameItemView *item) { for(UIView *v in item.subviews)if(v.tag==10001001)return (id)v;return nil; }
static void NativeFoldedLayoutTests(void) {
    policy=Policy(NO);
    NewMainFrameCell *cell=[[NewMainFrameCell alloc] initWithFrame:CGRectMake(0,0,390,76)];
    UIView *content=[[UIView alloc] initWithFrame:cell.bounds];[cell addSubview:content];
    UIView *card=[[UIView alloc] initWithFrame:CGRectMake(15,0,360,76)];[content addSubview:card];
    MainFrameItemView *item=[[MainFrameItemView alloc] initWithFrame:card.frame];cell->m_itemView=item;[content addSubview:item];
    item->m_frameHeadView=[[UIView alloc] initWithFrame:CGRectMake(12,14,48,48)];[item addSubview:item->m_frameHeadView];
    item->m_nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(72,14,150,22)];item->m_nameLabel.text=@"折叠的聊天";
    item->m_messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(72,42,276,18)];item->m_messageLabel.text=@"another group secret";
    item->m_timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(300,14,48,16)];item->m_timeLabel.text=@"10:24";
    item->m_unreadCountView=[[UIView alloc] initWithFrame:CGRectMake(45,0,18,18)];[item->m_frameHeadView addSubview:item->m_unreadCountView];
    for(UILabel *label in @[item->m_nameLabel,item->m_messageLabel,item->m_timeLabel]){
        label.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];label.textColor=UIColor.labelColor;[item addSubview:label];
    }
    item->m_messageLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    [item quoteMessageLable:item->m_messageLabel prefixText:@"global name: "];
    UIView *separator=[[UIView alloc] initWithFrame:CGRectMake(87,75.5,288,.5)];[content addSubview:separator];
    CGRect cellFrame=cell.frame,cardFrame=card.frame,iconFrame=item->m_frameHeadView.frame,titleFrame=item->m_nameLabel.frame;
    UIFont *titleFont=item->m_nameLabel.font,*bodyFont=item->m_messageLabel.font;UIColor *bodyColor=item->m_messageLabel.textColor;
    CSCloseFriendUpdateSessionCover(cell,ScopedRow(4,YES,1));
    CSCloseFriendSessionCover *cover=objc_getAssociatedObject(cell,&CoverKey);
    UILabel *title=VisibleLabel(cell,@"折叠的聊天"),*body=VisibleLabel(cell,@"[图片]"),*prefix=Prefix(item);
    Check(body==item->m_messageLabel && Visible(body) && cover.summaryLabel.hidden,@"native parity: actual native message label replaces the plugin overlay");
    Check(Visible(prefix) && [prefix.text isEqual:@"visible-3: "] && prefix.superview==item && body.superview==item,@"native parity: separate name and message labels preserve native delimiter/order");
    Check(prefix.frame.origin.x==72 && body.frame.origin.x==ceil(CGRectGetMaxX(prefix.frame)) && body.frame.origin.y==prefix.frame.origin.y,@"native quote owns label width/position with no invented gap");
    Check(title==item->m_nameLabel && title.font==titleFont && CGRectEqualToRect(title.frame,titleFrame) && !title.adjustsFontSizeToFitWidth && title.font.pointSize>=17,@"native title keeps text/font/frame with no count or shrink");
    Check(prefix.font==bodyFont && prefix.textColor==bodyColor && body.font==bodyFont && body.textColor==bodyColor && !body.adjustsFontSizeToFitWidth,@"two labels inherit native typography/color without overrides");
    Check(Visible(card) && Visible(content) && Visible(item->m_frameHeadView) && Visible(separator) && CGRectEqualToRect(cell.frame,cellFrame) && CGRectEqualToRect(card.frame,cardFrame) && CGRectEqualToRect(item->m_frameHeadView.frame,iconFrame),@"card geometry, native icon, row height and separator unchanged");
    Check(!Visible(item->m_timeLabel) && !Visible(item->m_unreadCountView) && !VisibleLabel(cell,@"global name: ") && !VisibleLabel(cell,@"another group secret"),@"no global prefix/body/time/unread leakage");
    CGRect written=body.frame;NSUInteger childCount=item.subviews.count;
    for(NSUInteger i=0;i<12;i++)CSCloseFriendRefreshSessionCover(cell);
    Check(CGRectEqualToRect(body.frame,written) && item.subviews.count==childCount,@"repeated quote restores base origin and never accumulates labels or indentation");
    UILabel *time=item->m_timeLabel;[time removeFromSuperview];item->m_timeLabel=nil;CSCloseFriendRefreshSessionCover(cell);
    Check(VisibleLabel(cell,@"[图片]") && item.subviews.count==childCount-1,@"absence of native time area does not gate valid summary or create a time label");
    item->m_timeLabel=time;[item addSubview:time];
    [item removeQuoteMessageLabel];body.frame=CGRectMake(78,43,240,19);body.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];body.textColor=UIColor.secondaryLabelColor;
    [item quoteMessageLable:body prefixText:@"new global: "];
    UIView *late=[[UIView alloc] initWithFrame:CGRectMake(300,40,20,20)];[item addSubview:late];
    __block NSUInteger layouts=0;HookMainFrameItemLayout(item,^{layouts++;});prefix=Prefix(item);
    Check(layouts==1 && prefix.frame.origin.x==78 && prefix.frame.origin.y==43 && body.frame.size.height==19,@"native relayout supplies fresh origin/vertical geometry before scoped quote");
    Check(prefix.font==body.font && prefix.textColor==body.textColor && !Visible(late) && !Visible(time),@"theme/dynamic-font update propagates through native quote while private extras stay hidden");
    for(NSNumber *width in @[@190,@360,@440]) {
        item.frame=CGRectMake(15,0,width.doubleValue,76);CSCloseFriendRefreshSessionCover(cell);
        MainFrameItemView *reference=[[MainFrameItemView alloc] initWithFrame:item.frame];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(78,43,240,19)];reference->m_messageLabel=label;
        label.font=body.font;label.textColor=body.textColor;label.text=@"[图片]";[reference addSubview:label];
        [reference quoteMessageLable:label prefixText:@"visible-3: "];
        Check(CGRectEqualToRect(label.frame,body.frame) && CGRectEqualToRect(Prefix(reference).frame,Prefix(item).frame),@"narrow/wide card delegates exactly the native name/body width contract");
        Check(title.font==titleFont && CGRectEqualToRect(title.frame,titleFrame),@"width changes never shrink or relayout native title");
    }
    // Long text remains native-owned: no plugin ellipsis, font scale or ratio.
    CSGroupRow *longRow=ScopedRow(4,YES,1);
    if([longRow respondsToSelector:NSSelectorFromString(@"foldedEntryPrefix")]) [longRow setValue:@"1234567890... : " forKey:@"foldedEntryPrefix"];
    NSString *longBody=[@"很长的原生消息" stringByPaddingToLength:200 withString:@"很长的原生消息" startingAtIndex:0];
    [longRow setValue:longBody forKey:@"foldedEntrySummary"];CSCloseFriendUpdateSessionCover(cell,longRow);
    Check([Prefix(item).text isEqual:@"1234567890... : "] && [body.text isEqual:longBody] && body.lineBreakMode==NSLineBreakByTruncatingTail && !body.adjustsFontSizeToFitWidth,@"native-shortened name and long body keep native tail truncation without plugin text/size edits");
    for(NSUInteger state=0;state<3;state++) {
        policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:state==0 ? @"other" : @"fixture" profile:@{@"enabled":@YES,@"friends":state==2 ? @[@"visible-3"] : @[],@"groups":@[],@"options":@{}} revealed:NO revision:state==1 ? 2 : 1 blocked:NO];
        CSCloseFriendRefreshSessionCover(cell);
        Check(!Prefix(item) && !Visible(body) && !VisibleLabel(cell,longBody),@"account/revision/visibility change removes both stale native labels");
        policy=Policy(NO);CSCloseFriendUpdateSessionCover(cell,longRow);
    }
    FoldedQuoteHook=^{policy=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"other" profile:@{} revealed:NO revision:1 blocked:YES];};
    CSCloseFriendUpdateSessionCover(cell,longRow);FoldedQuoteHook=nil;
    Check(!Prefix(item) && !Visible(body),@"policy change inside native renderer cannot expose old pair for even one frame");
    policy=Policy(NO);CSCloseFriendUpdateSessionCover(cell,longRow);
    // Native can replace the pair before prepareForReuse; never undo fresh data.
    [item removeQuoteMessageLabel];body.text=@"fresh ordinary text";body.frame=CGRectMake(72,42,276,18);
    CSCloseFriendUpdateSessionCover(cell,nil);
    Check([body.text isEqual:@"fresh ordinary text"] && Visible(body) && Visible(time) && !Prefix(item),@"ordinary reuse preserves fresh native text and clears only owned prefix");
    CSCloseFriendUpdateSessionCover(cell,ScopedRow(2,YES,1));
    Check([Prefix(item).text isEqual:@"visible-1: "] && [body.text isEqual:@"[图片]"],@"folded-ordinary-folded reuse uses current pair");
    CSCloseFriendUpdateSessionCover(cell,nil);
    Check(!body.text.length && !Prefix(item),@"removing still-owned pair never restores stale global or group text");
}
