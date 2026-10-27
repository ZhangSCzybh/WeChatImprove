// Behavioral layout/privacy checks against the production presentation source.
static BOOL Visible(UIView *view) { for(UIView *v=view;v;v=v.superview)if(v.hidden)return NO;return YES; }
static UILabel *VisibleLabel(UIView *view,NSString *text) {
    if(!Visible(view))return nil;
    if([view isKindOfClass:UILabel.class] && [((UILabel *)view).text isEqual:text])return (UILabel *)view;
    for(UIView *child in view.subviews){UILabel *found=VisibleLabel(child,text);if(found)return found;}return nil;
}
static void NativeFoldedLayoutTests(void) {
    policy=Policy(NO);
    NewMainFrameCell *cell=[[NewMainFrameCell alloc] initWithFrame:CGRectMake(0,0,390,76)];
    UIView *content=[[UIView alloc] initWithFrame:cell.bounds];[cell addSubview:content];
    UIView *card=[[UIView alloc] initWithFrame:CGRectMake(15,0,360,76)];card.backgroundColor=UIColor.systemBackgroundColor;[content addSubview:card];
    MainFrameItemView *item=[[MainFrameItemView alloc] initWithFrame:card.frame];cell->m_itemView=item;[content addSubview:item];
    item->m_frameHeadView=[[UIView alloc] initWithFrame:CGRectMake(12,14,48,48)];[item addSubview:item->m_frameHeadView];
    item->m_nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(72,14,210,22)];item->m_nameLabel.text=@"global title";
    item->m_messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(72,42,240,18)];item->m_messageLabel.text=@"another group secret";
    item->m_timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(300,14,48,16)];item->m_timeLabel.text=@"10:24";
    item->m_unreadCountView=[[UIView alloc] initWithFrame:CGRectMake(45,0,18,18)];
    // A badge nested inside the retained avatar must still be hidden.
    [item->m_frameHeadView addSubview:item->m_unreadCountView];
    for(UILabel *label in @[item->m_nameLabel,item->m_messageLabel,item->m_timeLabel]){
        label.font=[UIFont preferredFontForTextStyle:UIFontTextStyleBody];label.textColor=UIColor.labelColor;[item addSubview:label];
    }
    item->m_messageLabel.font=[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
    UIView *separator=[[UIView alloc] initWithFrame:CGRectMake(87,75.5,288,.5)];[content addSubview:separator];
    CGRect originalCell=cell.frame,originalCard=card.frame,originalIcon=item->m_frameHeadView.frame;
    NSUInteger originalNativeChildren=item.subviews.count;
    CSCloseFriendUpdateSessionCover(cell,ScopedRow(1,YES,1));
    UILabel *title=VisibleLabel(cell,@"折叠的聊天（1）"),*summary=VisibleLabel(cell,@"1 个会话");
    Check(Visible(content) && Visible(card) && Visible(item) && Visible(item->m_frameHeadView) && Visible(separator),@"folded row retains native content, card, aggregate icon and separator");
    Check(CGRectEqualToRect(cell.frame,originalCell) && CGRectEqualToRect(card.frame,originalCard) && CGRectEqualToRect(item->m_frameHeadView.frame,originalIcon),@"folded row retains ordinary session height, margins and icon geometry");
    Check(title && summary && [title.superview isDescendantOfView:item] && title.superview.backgroundColor.transparent,@"folded row has two neutral lines inside native item without a full-cell opaque slab");
    Check(title && summary && CGRectEqualToRect([title convertRect:title.bounds toView:cell],[item->m_nameLabel convertRect:item->m_nameLabel.bounds toView:cell]) && CGRectEqualToRect([summary convertRect:summary.bounds toView:cell],[item->m_messageLabel convertRect:item->m_messageLabel.bounds toView:cell]),@"neutral title/summary follow native two-line insets and vertical spacing");
    Check(title.font==item->m_nameLabel.font && summary.font==item->m_messageLabel.font && title.textColor==item->m_nameLabel.textColor && summary.textColor==item->m_messageLabel.textColor,@"neutral typography follows native label fonts and colors");
    Check(!Visible(item->m_nameLabel) && !Visible(item->m_messageLabel) && !Visible(item->m_timeLabel) && !Visible(item->m_unreadCountView),@"native global title, preview, time and nested unread badge stay concealed");
    Check([item->m_messageLabel.text isEqual:@"another group secret"] && [item->m_timeLabel.text isEqual:@"10:24"],@"presentation never rewrites native message/time models or labels");
    UIView *cover=title.superview;NSUInteger children=item.subviews.count;
    item->m_messageLabel.hidden=NO;item->m_timeLabel.hidden=NO;item->m_unreadCountView.hidden=NO;
    item->m_messageLabel.frame=CGRectMake(80,43,230,19);item->m_messageLabel.textColor=UIColor.secondaryLabelColor;
    UIView *late=[[UIView alloc] initWithFrame:CGRectMake(300,40,20,20)];[item addSubview:late];
    __block NSUInteger originalLayouts=0;
    HookMainFrameItemLayout(item,^{originalLayouts++;});summary=VisibleLabel(cell,@"1 个会话");
    Check(originalLayouts==1,@"native item layout executes exactly once before privacy presentation repair");
    Check(summary && summary.superview==cover && CGRectEqualToRect(summary.frame,item->m_messageLabel.frame) && summary.textColor==item->m_messageLabel.textColor,@"native relayout/theme updates neutral summary geometry and color without another cover");
    Check(!Visible(late) && !Visible(item->m_timeLabel) && !Visible(item->m_unreadCountView) && Visible(item->m_frameHeadView),@"native relayout hides new business content while retaining aggregate icon");
    for(NSUInteger n=0;n<8;n++)CSCloseFriendRefreshSessionCover(cell);
    Check(item.subviews.count==children+1 && CGRectEqualToRect(cell.frame,originalCell),@"repeated folded rendering adds no rows, overlays or height changes");
    CSCloseFriendUpdateSessionCover(cell,ScopedRow(0,NO,1));
    Check(VisibleLabel(cell,@"折叠的聊天") && !VisibleLabel(cell,@"1 个会话") && !Visible(item->m_messageLabel),@"unknown source retains neutral text without old group count or global preview");
    CSCloseFriendUpdateSessionCover(cell,nil);
    Check(Visible(item->m_nameLabel) && Visible(item->m_messageLabel) && Visible(item->m_timeLabel) && Visible(item->m_unreadCountView) && Visible(late) && item.subviews.count==originalNativeChildren+1,@"ordinary-cell reuse restores native hidden states and removes only owned overlay");
}
