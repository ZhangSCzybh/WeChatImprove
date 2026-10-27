// Real bridge/projection/adapter, isolated native cache + formatter doubles.
static NSString *EntrySummary(CSGroupProjection *p) { return CSGroupReadObject([p rowAtDisplayPath:Path(0)],@"foldedEntrySummary"); }
static NSString *EntryPrefix(CSGroupProjection *p) { return CSGroupReadObject([p rowAtDisplayPath:Path(0)],@"foldedEntryPrefix"); }
static NSString *EntrySource(CSGroupProjection *p) { return CSGroupReadObject([p rowAtDisplayPath:Path(0)],@"foldedEntrySummarySource"); }
static NativeSession *SummarySession(NSString *name,NSString *display,unsigned int time,NSString *text) {
    NativeSession *s=FoldedSession(name,0);s.m_uLastTime=time;s.m_msgWrap=[NativeMessage new];
    s.m_msgWrap.m_n64MesSvrID=0xF000000000000000ULL+time;s.m_msgWrap.fixtureDigest=text;
    s.m_msgWrap.fixtureChatName=name;s.m_msgWrap.fixtureDisplayName=display;return s;
}
static NativeCellData *EntryCache(NativeSession *s,NSString *prefix,NSString *text) {
    NativeCellData *d=[NativeCellData new];NativeSession *aggregate=FoldedSession(@"chatroom_session_box",0);
    aggregate.m_msgWrap=[s.m_msgWrap copy];d.m_sessionInfo=aggregate;d.m_n64MesSvrID=s.m_msgWrap.m_n64MesSvrID;
    d.m_prefixTextForQuoteMessage=prefix;d.m_textForMessageLabel=text;return d;
}
static void RunFoldedSummaryTests(void) {
    NSString *oldAccount=account;CSCloseFriendSnapshot *oldPolicy=policy;id oldService=foldedService,oldCache=cellDataService;BOOL oldEnabled=groupEnabled;
    account=@"summary-fixture";policy=Policy(@[@"hidden@chatroom"],NO,200);groupEnabled=YES;
    MainFrameCellDataManager *cache=[MainFrameCellDataManager new];cache.cache=[NSMutableDictionary dictionary];cellDataService=cache;
    ChatBoxMgr *manager=[ChatBoxMgr new];foldedService=manager;
    NativeSession *older=SummarySession(@"old@chatroom",@"家庭群",100,@"明天到");
    NativeSession *newer=SummarySession(@"new@chatroom",@"工作群",200,@"[图片]");
    NativeSession *hidden=SummarySession(@"hidden@chatroom",@"隐藏群",400,@"secret");
    NativeSession *private=SummarySession(@"friend",@"张三",300,@"你好");
    NativeSession *outside=SummarySession(@"other@chatroom",@"其他组",500,@"outside");
    manager.sourceSessions=@[outside,older,hidden,private,newer];
    WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll],*tab=[WESessionTabItem tabWithType:WETabTypeCustom];
    tab.tabId=@"summary-tab";tab.sessionUserNames=@[older.m_nsUserName,newer.m_nsUserName,hidden.m_nsUserName];NSArray *tabs=@[all,tab];
    CSGroupListAdapter *adapter=[CSGroupListAdapter new];adapter.controller=[NativeHost new];adapter.preferences=[Preferences new];
    NSArray *native=@[@[Row(0,@"chatroom_session_box",CSGroupRowKindAggregate,CSGroupRowCategoryGroup,99)]];
    void (^publish)(void)=^{ adapter.projection=[adapter projectionForSections:native tabs:tabs selectedTabID:tab.tabId accountID:account]; };
    publish();
    Check([EntrySummary(adapter.projection) isEqual:@"[图片]"] && [EntryPrefix(adapter.projection) isEqual:@"工作群: "],@"cold-start group uses separate native conversation prefix and native message, not sender prefix");
    Check([EntrySource(adapter.projection) isEqual:@"native_formatter"] && prefixCalls>0 && digestCalls>0,@"cold-start invokes native aggregate prefix builder and digest without opening folded list");
    Check(lastFormattedMessage!=newer.m_msgWrap && newer.m_msgWrap.displayChanges==0 && cache.mutations==0,@"formatting mutates only copied message, not live session or native cache");
    Check([CSGroupReadObject(adapter.projection.sections[0][0],@"foldedEntrySummaryUserName") isEqual:newer.m_nsUserName],@"newest visible child excludes newer hidden and outside-group messages");
    CSGroupProjection *same=adapter.projection;publish();Check(same==adapter.projection,@"unchanged two-part summary reuses immutable projection");
    tab.sessionUserNames=@[private.m_nsUserName];publish();
    Check([EntryPrefix(adapter.projection) isEqual:@"张三: "] && [EntrySummary(adapter.projection) isEqual:@"你好"],@"private prefix/message order and separator come from native builder");
    tab.sessionUserNames=@[older.m_nsUserName,newer.m_nsUserName,hidden.m_nsUserName];
    NativeCellData *entry=EntryCache(newer,@"原生缓存名称: ",@"原生入口正文");cache.cache[@"chatroom_session_box"]=entry;publish();
    Check([EntryPrefix(adapter.projection) isEqual:@"原生缓存名称: "] && [EntrySummary(adapter.projection) isEqual:@"原生入口正文"] && [EntrySource(adapter.projection) isEqual:@"entry_cache"],@"exact native entry cache copies both fields verbatim with signed/unsigned high message IDs");
    NSUInteger calls=digestCalls;publish();Check(digestCalls>=calls && cache.mutations==0,@"entry cache lookup never uses cache-creating getCellData:");
    same=adapter.projection;entry.m_prefixTextForQuoteMessage=@"改名: ";publish();Check(same!=adapter.projection && [EntryPrefix(adapter.projection) isEqual:@"改名: "],@"name-only native change invalidates summary reuse");
    for(NSString *text in @[@"[图片]",@"[动画表情]",@"[链接] 标题",@"[引用] 原文",@"[语音] 3秒",@"撤回了一条消息",@"系统通知",@"[微信红包]"]) {
        entry.m_textForMessageLabel=text;publish();Check([EntrySummary(adapter.projection) isEqual:text],@"native entry type placeholders pass through without plugin mapping");
    }
    NSMutableString *mutable=[@"原生正文" mutableCopy];entry.m_textForMessageLabel=mutable;publish();NSString *saved=EntrySummary(adapter.projection);[mutable appendString:@" mutated"];Check([saved isEqual:@"原生正文"],@"native text is immutable snapshot, not live model storage");
    entry.m_textForMessageLabel=[[NSAttributedString alloc] initWithString:@"原生可见文本"];publish();Check([EntrySummary(adapter.projection) isEqual:@"原生可见文本"],@"native attributed visible text retained while UI style remains native");
    entry.m_n64MesSvrID++;publish();Check([EntrySummary(adapter.projection) isEqual:@"[图片]"] && [EntrySource(adapter.projection) isEqual:@"native_formatter"],@"distinct high-bit message ID rejects cached entry and formats current message");entry.m_n64MesSvrID--;
    entry.m_sessionInfo.m_msgWrap.fixtureChatName=outside.m_nsUserName;publish();Check([EntryPrefix(adapter.projection) isEqual:@"工作群: "],@"same ID but another conversation cannot supply entry prefix or text");
    cache.cache[@"chatroom_session_box"]=EntryCache(outside,@"其他组: ",@"secret");publish();Check([EntrySummary(adapter.projection) isEqual:@"[图片]"],@"global aggregate latest from another group is never fallback");
    [cache.cache removeAllObjects];
    for(NSString *text in @[@"[图片]",@"[表情]",@"[引用] 文本",@"[链接] 原生标题"]) {
        newer.m_msgWrap.fixtureDigest=text;publish();Check([EntrySummary(adapter.projection) isEqual:text] && [EntryPrefix(adapter.projection) isEqual:@"工作群: "],@"uncached types preserve native digest while name stays separate");
    }
    newer.m_msgWrap.fixtureDisplayName=@"1234567890超长群名";publish();Check([EntryPrefix(adapter.projection) isEqual:@"1234567890超长群名: "],@"long explicit native name is retained for native label truncation, never cut to ten chars by plugin");
    newer.m_msgWrap.fixtureDisplayName=@"生成群名... ";publish();Check([EntryPrefix(adapter.projection) isEqual:@"生成群名... : "],@"already shortened native generated group name passes through unchanged");
    newer.m_msgWrap.fixtureDisplayName=@"工作群";
    older.sortTimeOverride=600;publish();Check([EntryPrefix(adapter.projection) isEqual:@"家庭群: "] && [EntrySummary(adapter.projection) isEqual:@"明天到"],@"latest visible conversation change updates both fields atomically");older.sortTimeOverride=0;
    older.m_bIsTop=YES;older.m_uTopTime=700;publish();Check([EntryPrefix(adapter.projection) isEqual:@"家庭群: "],@"native pinned effective time remains the ordering source");
    older.m_bIsTop=NO;older.m_uTopTime=0;older.m_uUnTopTime=700;publish();Check([EntryPrefix(adapter.projection) isEqual:@"家庭群: "],@"native untop effective time remains the ordering source");
    older.m_uUnTopTime=0;older.sortTime=700;publish();Check([EntryPrefix(adapter.projection) isEqual:@"家庭群: "],@"native sort override remains independent of lexical/list order");older.sortTime=0;
    older.m_uLastTime=0;older.m_msgWrap.fixtureSessionTime=800;publish();Check([EntryPrefix(adapter.projection) isEqual:@"家庭群: "],@"native message session time remains available for ordering");older.m_msgWrap.fixtureSessionTime=0;older.m_uLastTime=100;
    policy=Policy(@[newer.m_nsUserName,hidden.m_nsUserName],NO,201);publish();Check([EntryPrefix(adapter.projection) isEqual:@"家庭群: "],@"hiding latest child advances to next visible child's native prefix/body");
    tab.sessionUserNames=@[newer.m_nsUserName,hidden.m_nsUserName];publish();Check(adapter.projection.sections[0].count==0 && !EntrySummary(adapter.projection),@"all children hidden removes entry and text");
    policy=Policy(@[hidden.m_nsUserName],NO,202);tab.sessionUserNames=@[newer.m_nsUserName];
    newer.m_msgWrap.fixtureDigest=nil;publish();Check(!EntrySummary(adapter.projection),@"missing source text never borrows other group or invented placeholder");
    newer.m_msgWrap.fixtureDigest=@"刷新后就绪";publish();Check([EntrySummary(adapter.projection) isEqual:@"刷新后就绪"],@"next list refresh automatically retries an initially absent digest");
    newer.m_uLastTime=0;newer.m_msgWrap.m_uiCreateTime=0;publish();Check([EntrySummary(adapter.projection) isEqual:@"刷新后就绪"],@"all zero time fields cannot veto verified text");
    newer.missingAuxSortGetters=YES;publish();Check([EntrySummary(adapter.projection) isEqual:@"刷新后就绪"],@"missing optional time selectors do not gate digest");newer.missingAuxSortGetters=NO;
    newer.m_msgWrap.aliasCopy=YES;publish();Check(!EntrySummary(adapter.projection) && newer.m_msgWrap.displayChanges==0,@"aliasing copy is rejected without live-message mutation");newer.m_msgWrap.aliasCopy=NO;
    newer.m_msgWrap.m_n64MesSvrID=0;publish();Check([EntrySummary(adapter.projection) isEqual:@"刷新后就绪"],@"unsynced message formats through stable snapshot with no server ID");
    onDigest=^{epoch++;};publish();Check(adapter.projection.sections.count==0,@"account epoch transition during formatting rejects old text");onDigest=nil;
    onDigest=^{policy=Policy(@[],YES,203);};publish();Check(adapter.projection.sections.count==0,@"privacy revision transition rejects both old prefix and text");onDigest=nil;
    onDigest=^{account=@"other-account";};publish();Check(adapter.projection.sections.count==0,@"account switch rejects cached/formatter values");onDigest=nil;account=@"summary-fixture";
    policy=Policy(@[],YES,204);onDigest=^{newer.m_uLastTime++;};publish();Check([EntrySummary(adapter.projection) isEqual:@"刷新后就绪"],@"time-only changes during format do not invalidate message identity");onDigest=nil;
    onDigest=^{((NativeMessage *)lastFormattedMessage).fixtureChatName=@"outside";};publish();Check(!EntrySummary(adapter.projection),@"formatter cannot rebind the copied message to another conversation");onDigest=nil;
    onDigest=^{newer.m_msgWrap=[NativeMessage new];};publish();Check(!EntrySummary(adapter.projection),@"message replacement during formatting rejects old pair");onDigest=nil;
    WrongCellDataGetter *wrong=[WrongCellDataGetter new];cellDataService=wrong;publish();Check(wrong.calls==0,@"wrong native method return type is rejected before invocation");cellDataService=cache;
    tab.sessionUserNames=@[private.m_nsUserName];cache.onRead=^{epoch++;};publish();Check(adapter.projection.sections.count==0,@"epoch changes during cache lookup reject publication");cache.onRead=nil;
    publish();Check([EntryPrefix(adapter.projection) isEqual:@"张三: "] && cache.mutations==0 && manager.sourceSessions.count==5,@"fresh account snapshot recovers without modifying native collection or counters");
    NSArray *rows=CSGroupCopyFoldedRows();
    for(NSNumber *kind in @[@0,@1,@2,@3]) {
        CSGroupProjection *child=[[CSGroupProjection alloc] initWithSections:@[rows] tabs:tabs selectedTabID:kind.intValue==1 ? all.tabId : tab.tabId filterDuplicates:kind.intValue==2 accountID:account hiddenUserNames:kind.intValue==3 ? [NSSet setWithObject:@"other"] : [NSSet set] privacyRevision:kind.intValue==0 ? 203 : 204 previousProjection:nil];
        CSGroupProjection *parent=[[CSGroupProjection alloc] initWithSections:native tabs:tabs selectedTabID:tab.tabId filterDuplicates:NO accountID:account hiddenUserNames:[NSSet set] unmaskedAggregateUserNames:[NSSet set] privacyRevision:204 scopeFoldedEntry:YES foldedProjection:child previousProjection:nil];
        Check(!EntrySummary(parent) && !EntryPrefix(parent),@"mismatched child account/policy/group/filter provenance cannot publish either text part");
    }
    account=oldAccount;policy=oldPolicy;foldedService=oldService;cellDataService=oldCache;groupEnabled=oldEnabled;
}
