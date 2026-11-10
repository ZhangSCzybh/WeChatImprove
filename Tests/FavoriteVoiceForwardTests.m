#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSFavoriteVoiceForwardAdapter.h"

static NSUInteger checks;
#define CHECK(value) do { checks++; if (!(value)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#value); exit(1); } } while (0)
static void Drain(void) { [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.02]]; }
static BOOL Wait(BOOL (^predicate)(void)) {
    NSDate *deadline=[NSDate dateWithTimeIntervalSinceNow:2];
    while (!predicate() && deadline.timeIntervalSinceNow>0) Drain();
    return predicate();
}

// The native voice accessors are forwarded to an extension by CMessageWrap.
@interface VoiceExtension : NSObject
@property(nonatomic, copy) NSData *m_dtVoice;
@property(nonatomic) unsigned int m_uiVoiceTime,m_uiVoiceFormat,m_uiVoiceForwardFlag;
@end
@implementation VoiceExtension
@end
@interface CMessageWrap : NSObject
@property(nonatomic, strong) VoiceExtension *m_extendInfoWithMsgType;
@property(nonatomic, copy) NSString *m_nsFromUsr,*m_nsToUsr,*m_nsContent,*m_nsClientMsgID,*m_nsRealChatUsr,*m_nsMsgSource,*m_nsRevokeBatchId;
@property(nonatomic) unsigned int m_uiMessageType,m_uiMesLocalID,m_uiCreateTime,m_uiStatus,m_uiIsSenderStatus,m_uiSendTime,m_uiDownloadStatus;
@property(nonatomic) long long m_n64MesSvrID;
@property(nonatomic, copy) NSData *m_dtVoice;
@property(nonatomic) unsigned int m_uiVoiceTime,m_uiVoiceFormat,m_uiVoiceForwardFlag;
- (instancetype)initWithMsgType:(long long)type;
@end
@implementation CMessageWrap
@dynamic m_dtVoice,m_uiVoiceTime,m_uiVoiceFormat,m_uiVoiceForwardFlag;
- (instancetype)initWithMsgType:(long long)type {
    if ((self=[super init])) { _m_uiMessageType=(unsigned int)type; _m_extendInfoWithMsgType=[VoiceExtension new]; }
    return self;
}
- (id)forwardingTargetForSelector:(SEL)selector {
    return [_m_extendInfoWithMsgType respondsToSelector:selector] ? _m_extendInfoWithMsgType : [super forwardingTargetForSelector:selector];
}
@end

@interface FavoritesItemDataField : NSObject
@property(nonatomic) int dataType;
@property(nonatomic) unsigned int duration;
@property(nonatomic) unsigned long long dataSize;
@property(nonatomic, copy) NSString *dataId,*dataMd5,*dataFmt;
@property(nonatomic) BOOL recording;
- (BOOL)isRecording;
@end
@implementation FavoritesItemDataField
- (BOOL)isRecording { return _recording; }
@end
@interface FavoritesItem : NSObject
@property(nonatomic) int type;
@property(nonatomic) unsigned int localId,favId;
@property(nonatomic, copy) NSArray *dataList;
@end
@implementation FavoritesItem
@end
@interface FavDataItemWrap : NSObject
@property(nonatomic, strong) FavoritesItem *parent;
@property(nonatomic, strong) FavoritesItemDataField *dataItem;
@end
@implementation FavDataItemWrap
@end
@interface ThrowingFavoriteWrapper : FavDataItemWrap
@end
@implementation ThrowingFavoriteWrapper
- (FavoritesItem *)parent { [NSException raise:@"favorite-parent" format:@"injected"]; return nil; }
@end
static unsigned long long WrongFavoriteParentABI(id object,SEL command) { (void)object; (void)command; CHECK(NO); return 0; }
// Same-shaped arbitrary wrappers must never enter the favorite-only replacement path.
@interface UnrelatedFavoriteWrapper : NSObject
@property(nonatomic, strong) FavoritesItem *parent;
@property(nonatomic, strong) FavoritesItemDataField *dataItem;
@end
@implementation UnrelatedFavoriteWrapper
@end
static FavoritesItem *VoiceFavorite(void) {
    FavoritesItemDataField *field=[FavoritesItemDataField new];
    field.dataType=3; field.duration=1234; field.dataSize=5; field.dataId=@"favorite-audio";
    field.dataMd5=@""; field.dataFmt=@"amr";
    FavoritesItem *item=[FavoritesItem new]; item.type=3; item.localId=71; item.favId=91; item.dataList=@[field];
    return item;
}
@interface FavoriteDetail : NSObject { @public id m_favItem; }
@end
@implementation FavoriteDetail
@end
@interface Contact : NSObject
@property(nonatomic, copy) NSString *m_nsUsrName;
@end
@implementation Contact
@end
static Contact *Recipient(NSString *name) { Contact *contact=[Contact new]; contact.m_nsUsrName=name; return contact; }
@interface ForwardLogic : NSObject
@property(nonatomic, copy) NSArray *contacts;
@property(nonatomic, copy) NSArray *messages;
@property(nonatomic) NSUInteger nativeForwardCalls,nativeClearCalls;
@property(nonatomic, strong) NSMutableArray *fallbackCalls;
- (id)getToContacts;
- (id)getMessages;
- (void)nativeForwardMsgList:(id)messages target:(id)target batchID:(id)batchID;
@end
@implementation ForwardLogic
- (instancetype)init { if ((self=[super init])) _fallbackCalls=[NSMutableArray array]; return self; }
- (id)getToContacts { return _contacts; }
- (id)getMessages { return _messages; }
- (void)nativeForwardMsgList:(id)messages target:(id)target batchID:(id)batchID {
    (void)target; (void)batchID;
    for (id contact in _contacts) for (id source in messages)
        CSMessageNativeInvoke(self,@"ForwardMsg:ToContact:",@[source,contact]);
}
@end
#import "FavoriteVoiceHooksUnderTest.h"
@interface Environment : NSObject <CSMessageActionEnvironment>
@property(nonatomic, copy) NSString *account;
@property(nonatomic, strong) NSMutableDictionary *services;
@end
@implementation Environment
- (instancetype)init { if ((self=[super init])) { _account=@"me"; _services=[NSMutableDictionary dictionary]; } return self; }
- (NSString *)currentAccountID { return _account; }
- (id)serviceNamed:(NSString *)name { return _services[name]; }
- (id)controllerForCell:(id)cell { (void)cell; CHECK(NO); return nil; }
@end
@interface MessageManager : NSObject
@property(nonatomic, strong) NSMutableArray *inserts;
@property(nonatomic, copy) void (^afterInsert)(void);
- (void)AddLocalMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap;
@end
@implementation MessageManager
- (instancetype)init { if ((self=[super init])) _inserts=[NSMutableArray array]; return self; }
- (void)AddLocalMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap {
    CHECK(wrap.m_uiMesLocalID==0 && wrap.m_n64MesSvrID==0);
    CHECK([wrap.m_nsFromUsr isEqual:@"me"] && [wrap.m_nsToUsr isEqual:target]);
    [_inserts addObject:@[target,wrap]]; wrap.m_uiMesLocalID=(unsigned int)_inserts.count+100;
    if (_afterInsert) _afterInsert();
}
@end
@interface Uploader : NSObject
@property(nonatomic, strong) NSMutableArray *uploads;
- (void)ResendVoiceMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap;
@end
@implementation Uploader
- (instancetype)init { if ((self=[super init])) _uploads=[NSMutableArray array]; return self; }
- (void)ResendVoiceMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap {
    CHECK(wrap.m_uiMesLocalID>0); [_uploads addObject:@[target,wrap]];
}
@end
@interface AudioSender : NSObject
@property(nonatomic, strong) Uploader *uploader;
@property(nonatomic) NSUInteger unsafeCalls;
- (id)uploaderForMsgWrap:(CMessageWrap *)wrap;
- (void)ResendVoiceMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap;
@end
@implementation AudioSender
- (id)uploaderForMsgWrap:(CMessageWrap *)wrap { CHECK(wrap.m_uiMesLocalID==0); return _uploader; }
- (void)ResendVoiceMsg:(NSString *)target MsgWrap:(CMessageWrap *)wrap { (void)target; (void)wrap; _unsafeCalls++; }
@end

@interface HeldFavoriteMedia : CSFavoriteVoiceMediaProvider
@property(nonatomic, strong) NSMutableDictionary *callbacks;
@property(nonatomic, strong) NSMutableArray<NSString *> *requests,*cancellations;
@property(nonatomic) BOOL sourceCurrent;
- (void)finish:(NSString *)identifier;
- (BOOL)sourceIsCurrentForContext:(CSFavoriteVoiceContext *)context;
@end
@implementation HeldFavoriteMedia
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment {
    if ((self=[super initWithEnvironment:environment])) {
        _callbacks=[NSMutableDictionary dictionary]; _requests=[NSMutableArray array]; _cancellations=[NSMutableArray array]; _sourceCurrent=YES;
    }
    return self;
}
- (void)prepareContext:(CSFavoriteVoiceContext *)context operationID:(NSString *)identifier completion:(void (^)(CSMessageVoiceResource *,NSString *))completion {
    CHECK([context.accountID isEqual:@"me"] && context.accountEpoch>0);
    [_requests addObject:identifier]; _callbacks[identifier]=[completion copy];
}
// Keep the native completion after cancellation to test truly late events.
- (void)cancelOperationID:(NSString *)identifier { [_cancellations addObject:identifier]; }
- (BOOL)sourceIsCurrentForContext:(CSFavoriteVoiceContext *)context { (void)context; return _sourceCurrent; }
- (void)finish:(NSString *)identifier {
    void (^completion)(CSMessageVoiceResource *,NSString *)=_callbacks[identifier]; CHECK(completion!=nil);
    completion([[CSMessageVoiceResource alloc] initWithData:[@"audio" dataUsingEncoding:NSUTF8StringEncoding] durationMilliseconds:1234 format:0],nil);
}
@end

@interface Fixture : NSObject
@property(nonatomic, copy) NSString *suite;
@property(nonatomic, strong) NSUserDefaults *defaults;
@property(nonatomic, strong) Environment *environment;
@property(nonatomic, strong) CSMessageActionPreferences *preferences;
@property(nonatomic, strong) CSMessageActionCoordinator *accounts;
@property(nonatomic, strong) HeldFavoriteMedia *media;
@property(nonatomic, strong) CSFavoriteVoiceForwardAdapter *adapter;
@property(nonatomic, strong) MessageManager *manager;
@property(nonatomic, strong) AudioSender *audio;
@property(nonatomic, strong) FavoriteDetail *controller;
@property(nonatomic, strong) FavoritesItem *item;
@property(nonatomic, strong) NSMutableArray<CMessageWrap *> *previews;
@property(nonatomic, strong) NSMutableArray<ForwardLogic *> *logics;
@property(nonatomic, strong) NSMutableArray<NSString *> *feedback;
- (void)setFavoriteEnabled:(BOOL)enabled;
- (ForwardLogic *)openPicker;
@end
@implementation Fixture
- (instancetype)init {
    if ((self=[super init])) {
        _suite=[@"favorite-voice-tests." stringByAppendingString:NSUUID.UUID.UUIDString];
        _defaults=[[NSUserDefaults alloc] initWithSuiteName:_suite];
        [_defaults setBool:NO forKey:CSMessageActionVoiceForwardEnabledKey];
        [_defaults setBool:YES forKey:CSMessageActionFavoriteVoiceForwardEnabledKey];
        _preferences=[[CSMessageActionPreferences alloc] initWithDefaults:_defaults];
        _environment=[Environment new]; _manager=[MessageManager new]; _audio=[AudioSender new]; _audio.uploader=[Uploader new];
        _environment.services[@"CMessageMgr"]=_manager; _environment.services[@"AudioSender"]=_audio;
        _accounts=[[CSMessageActionCoordinator alloc] initWithEnvironment:_environment preferences:_preferences mediaProvider:[CSMessageMediaProvider new]];
        _media=[[HeldFavoriteMedia alloc] initWithEnvironment:_environment];
        _adapter=[[CSFavoriteVoiceForwardAdapter alloc] initWithEnvironment:_environment preferences:_preferences accountCoordinator:_accounts mediaProvider:_media sendAdapter:[[CSMessageSendAdapter alloc] initWithEnvironment:_environment]];
        _controller=[FavoriteDetail new]; _item=VoiceFavorite(); _controller->m_favItem=_item;
        _previews=[NSMutableArray array]; _logics=[NSMutableArray array]; _feedback=[NSMutableArray array];
        __weak typeof(self) weakSelf=self;
        _adapter.presentVoiceWrap=^BOOL(id wrap,id controller) {
            Fixture *self=weakSelf; CHECK(controller==self.controller);
            ForwardLogic *logic=[ForwardLogic new]; logic.contacts=@[Recipient(@"A")]; logic.messages=@[wrap];
            [self.previews addObject:wrap]; [self.logics addObject:logic]; favoriteHookAdapter=self.adapter;
            [logic forwardMessage:wrap];
            return YES;
        };
        _adapter.feedbackHandler=^(NSString *message) { [weakSelf.feedback addObject:message]; };
    }
    return self;
}
- (void)dealloc { [_adapter cancelAll]; [_defaults removePersistentDomainForName:_suite]; }
- (void)setFavoriteEnabled:(BOOL)enabled {
    [_defaults setBool:enabled forKey:CSMessageActionFavoriteVoiceForwardEnabledKey]; [_preferences requestRefresh];
    CHECK(Wait(^BOOL{ return self.preferences.snapshot.favoriteVoiceForwardEnabled==enabled; }));
}
- (ForwardLogic *)openPicker {
    NSUInteger before=_logics.count; [_adapter forwardItem:_item fromController:_controller]; CHECK(_media.requests.count>0);
    [_media finish:_media.requests.lastObject]; CHECK(_logics.count==before+1); return _logics.lastObject;
}
@end

static void TestAdmissionAndMenu(void) {
    Fixture *f=[Fixture new]; CHECK(!f.preferences.snapshot.voiceForwardEnabled && f.preferences.snapshot.favoriteVoiceForwardEnabled);
    CHECK([f.adapter canForwardItem:f.item]); CHECK(![f.adapter canForwardItem:[NSObject new]]);
    CHECK([f.adapter menuEnableType:0x70 delegate:f.controller]==0x70);
    [f.adapter withDetailMenuForController:f.controller perform:^{
        CHECK([f.adapter menuEnableType:0x70 delegate:f.controller]==0x71);
        CHECK([f.adapter menuEnableType:0x60 delegate:[FavoriteDetail new]]==0x60);
    }];
    CHECK([f.adapter menuEnableType:0x60 delegate:f.controller]==0x60);
    for (NSNumber *type in @[@1,@2,@8,@14]) { f.item.type=type.intValue; CHECK(![f.adapter canForwardItem:f.item]); }
    f.item.type=3; FavoritesItemDataField *field=f.item.dataList.firstObject;
    field.dataType=2; CHECK(![f.adapter canForwardItem:f.item]); field.dataType=3;
    field.recording=YES; CHECK(![f.adapter canForwardItem:f.item]); field.recording=NO;
    f.item.dataList=@[field,field]; CHECK(![f.adapter canForwardItem:f.item]); f.item.dataList=@[field];
    [f setFavoriteEnabled:NO]; CHECK(![f.adapter canForwardItem:f.item]);
    [f.adapter forwardItem:f.item fromController:f.controller]; CHECK(f.media.requests.count==0);
}

static void TestRecipientsAndFreshVoice(void) {
    Fixture *f=[Fixture new]; FavoritesItemDataField *field=f.item.dataList.firstObject; NSArray *sourceFields=f.item.dataList;
    [f.adapter forwardItem:f.item fromController:f.controller]; [f.adapter forwardItem:f.item fromController:f.controller];
    CHECK(f.media.requests.count==1); [f.media finish:f.media.requests.lastObject];
    ForwardLogic *logic=f.logics.lastObject; CMessageWrap *preview=f.previews.lastObject;
    CHECK(preview.m_uiMessageType==34 && preview.m_uiMesLocalID==0 && preview.m_n64MesSvrID==0);
    CHECK(f.manager.inserts.count==0 && f.audio.uploader.uploads.count==0);
    CHECK([f.adapter suppressesNativeSuccessForLogic:logic]);
    CHECK(![f.adapter handleLogic:[ForwardLogic new] source:preview target:Recipient(@"A")]);
    CHECK([f.adapter handleLogic:logic source:preview target:Recipient(@"A")]); CHECK(f.manager.inserts.count==0);
    logic.contacts=@[Recipient(@"A"),Recipient(@"A"),Recipient(@"B")]; [f.adapter confirmLogic:logic];
    logic.contacts=@[Recipient(@"C")]; [f.adapter confirmLogic:logic];
    CHECK([f.adapter handleLogic:logic source:preview target:Recipient(@"C")]);
    CHECK(![f.adapter handleLogic:logic source:[NSObject new] target:Recipient(@"A")]);
    CHECK((![f.adapter handleLogic:logic source:@[preview,preview] target:Recipient(@"A")]));
    CHECK(f.manager.inserts.count==0);
    CHECK([f.adapter handleLogic:logic source:@[preview] target:Recipient(@"A")]);
    CHECK([f.adapter handleLogic:logic source:preview target:Recipient(@"A")]);
    CHECK([f.adapter handleLogic:logic source:preview target:Recipient(@"B")]);
    CHECK(f.manager.inserts.count==2 && f.audio.uploader.uploads.count==2 && f.audio.unsafeCalls==0);
    CMessageWrap *first=f.manager.inserts[0][1], *second=f.manager.inserts[1][1];
    CHECK(first!=second && first!=preview && second!=preview);
    CHECK(![first.m_nsClientMsgID isEqual:second.m_nsClientMsgID] && first.m_nsClientMsgID.length>0);
    CHECK(first.m_uiVoiceTime==1234 && second.m_uiVoiceTime==1234 && first.m_uiVoiceFormat==0);
    CHECK([first.m_dtVoice isEqual:[@"audio" dataUsingEncoding:NSUTF8StringEncoding]] && second.m_uiDownloadStatus==9);
    CHECK(first.m_uiVoiceForwardFlag==0 && second.m_uiVoiceForwardFlag==0);
    CHECK(f.item.localId==71 && f.item.favId==91 && f.item.dataList==sourceFields);
    CHECK([field.dataId isEqual:@"favorite-audio"] && field.duration==1234 && field.dataSize==5);
    CHECK(preview.m_uiMesLocalID==0 && preview.m_n64MesSvrID==0);
    // Native success completion followed by clearData must not repeat or cancel completed target handoffs.
    [f.adapter finishLogic:logic cancelled:NO]; [f.adapter finishLogic:logic cancelled:YES];
    CHECK([f.adapter handleLogic:logic source:preview target:Recipient(@"A")]);
    CHECK([f.adapter suppressesNativeSuccessForLogic:logic]); CHECK(f.audio.uploader.uploads.count==2);
    // Native can reuse a logic without calling forwardMessage: before ForwardMsgList.
    CMessageWrap *ordinary=[[CMessageWrap alloc] initWithMsgType:1]; logic.messages=@[ordinary];
    CHECK(![f.adapter handleLogic:logic source:ordinary target:Recipient(@"A")]);
    CHECK(![f.adapter suppressesNativeSuccessForLogic:logic]);
    logic.messages=@[]; CHECK(![f.adapter suppressesNativeSuccessForLogic:logic]);
    [f.adapter bindLogic:logic source:ordinary]; CHECK(![f.adapter suppressesNativeSuccessForLogic:logic]);
}

static void TestCancellationAndLateMedia(void) {
    for (NSUInteger mode=0;mode<3;mode++) {
        Fixture *f=[Fixture new]; [f.adapter forwardItem:f.item fromController:f.controller]; NSString *identifier=f.media.requests.lastObject;
        if (mode==0) [f.adapter cancelOperationID:identifier];
        else if (mode==1) [f.adapter cancelAll];
        else [f setFavoriteEnabled:NO];
        CHECK([f.media.cancellations containsObject:identifier]); [f.media finish:identifier];
        CHECK(f.logics.count==0 && f.manager.inserts.count==0 && f.audio.uploader.uploads.count==0);
    }
    Fixture *f=[Fixture new]; ForwardLogic *logic=[f openPicker]; CMessageWrap *preview=f.previews.lastObject;
    [f.adapter finishLogic:logic cancelled:YES]; [f.adapter confirmLogic:logic];
    CHECK([f.adapter handleLogic:logic source:preview target:Recipient(@"A")]);
    CHECK([f.adapter suppressesNativeSuccessForLogic:logic] && f.manager.inserts.count==0);
}

static void TestDisableAndNewIntent(void) {
    Fixture *f=[Fixture new]; ForwardLogic *old=[f openPicker]; CMessageWrap *oldPreview=f.previews.lastObject;
    [f.adapter confirmLogic:old]; [f setFavoriteEnabled:NO];
    CHECK([f.adapter suppressesNativeSuccessForLogic:old]);
    CHECK([f.adapter handleLogic:old source:oldPreview target:Recipient(@"A")]); CHECK(f.manager.inserts.count==0);
    [f setFavoriteEnabled:YES]; CHECK([f.adapter handleLogic:old source:oldPreview target:Recipient(@"A")]);
    CHECK(f.manager.inserts.count==0);
    ForwardLogic *fresh=[f openPicker]; [f.adapter confirmLogic:fresh];
    CHECK([f.adapter handleLogic:fresh source:f.previews.lastObject target:Recipient(@"A")]);
    CHECK(f.manager.inserts.count==1 && f.audio.uploader.uploads.count==1);
}

static void TestAccountGenerations(void) {
    for (NSUInteger mode=0;mode<3;mode++) {
        Fixture *f=[Fixture new]; [f.adapter forwardItem:f.item fromController:f.controller]; NSString *identifier=f.media.requests.lastObject;
        NSUInteger epoch=f.accounts.accountEpoch;
        if (mode==0) { [f.accounts accountWillChange]; [f.accounts accountDidChange]; }
        else if (mode==1) { CSMessageActionAccountWillChangeAtNativeBoundary(); CSMessageActionAccountDidChangeAtNativeBoundary(); }
        else { f.environment.account=@"other-account"; }
        [f.media finish:identifier]; CHECK(f.logics.count==0 && f.manager.inserts.count==0);
        CHECK(f.accounts.accountEpoch>epoch);
    }
    Fixture *f=[Fixture new]; ForwardLogic *logic=[f openPicker]; CMessageWrap *preview=f.previews.lastObject;
    [f.adapter confirmLogic:logic]; [f.accounts accountWillChange]; [f.accounts accountDidChange];
    CHECK([f.adapter handleLogic:logic source:preview target:Recipient(@"A")]);
    CHECK([f.adapter suppressesNativeSuccessForLogic:logic] && f.manager.inserts.count==0);
}

static void TestSourceAndSubmissionRevalidation(void) {
    Fixture *f=[Fixture new]; ForwardLogic *logic=[f openPicker]; [f.adapter confirmLogic:logic]; f.media.sourceCurrent=NO;
    CHECK([f.adapter handleLogic:logic source:f.previews.lastObject target:Recipient(@"A")]); CHECK(f.manager.inserts.count==0);
    Fixture *boundary=[Fixture new]; ForwardLogic *pending=[boundary openPicker]; [boundary.adapter confirmLogic:pending];
    __weak Fixture *weakBoundary=boundary;
    boundary.manager.afterInsert=^{ [weakBoundary.accounts accountWillChange]; [weakBoundary.accounts accountDidChange]; };
    CHECK([boundary.adapter handleLogic:pending source:boundary.previews.lastObject target:Recipient(@"A")]);
    CHECK(boundary.manager.inserts.count==1 && boundary.audio.uploader.uploads.count==0);
    CHECK([boundary.adapter handleLogic:pending source:boundary.previews.lastObject target:Recipient(@"A")]); CHECK(boundary.manager.inserts.count==1);
}

static void TestNativeHookDispatchAndCleanup(void) {
    Fixture *f=[Fixture new]; ForwardLogic *logic=[f openPicker]; CMessageWrap *preview=f.previews.lastObject;
    CHECK(logic.nativeForwardCalls==1); logic.contacts=@[Recipient(@"A"),Recipient(@"A"),Recipient(@"B")];
    [logic ForwardMsgList:@[preview] ToContact:nil WithRevokeBatchId:nil];
    CHECK(f.manager.inserts.count==2 && f.audio.uploader.uploads.count==2 && logic.fallbackCalls.count==0);
    FavoriteForwardManager *manager=[FavoriteForwardManager new]; [manager OnForwardMessageSend:logic];
    CHECK(logic.nativeClearCalls==1 && logic.messages==nil && logic.contacts==nil);
    CHECK([manager.nativeEvents isEqual:@[@"OnForwardMessageSend"]]);
    CHECK(![logic bShowSendSuccessView] && [logic bHiddenSendSuccessToastView]);
    [logic ForwardMsg:preview ToContact:Recipient(@"A")]; CHECK(logic.fallbackCalls.count==0);
    // Native logic reuse can dispatch ordinary messages before forwardMessage: is called again.
    CMessageWrap *ordinary=[[CMessageWrap alloc] initWithMsgType:1]; logic.messages=@[ordinary];
    [logic ForwardMsg:ordinary ToContact:Recipient(@"A")]; CHECK(logic.fallbackCalls.count==1);
    CHECK([logic bShowSendSuccessView] && ![logic bHiddenSendSuccessToastView]);
    [logic clearData]; CHECK([logic bShowSendSuccessView] && ![logic bHiddenSendSuccessToastView]);
    [logic forwardMessage:ordinary]; [logic ForwardMsg:ordinary ToContact:Recipient(@"B")];
    CHECK(logic.nativeForwardCalls==2 && logic.fallbackCalls.count==2);
    CHECK(f.manager.inserts.count==2 && f.audio.uploader.uploads.count==2);

    Fixture *cancelled=[Fixture new]; ForwardLogic *cancelLogic=[cancelled openPicker]; CMessageWrap *cancelPreview=cancelled.previews.lastObject;
    [manager OnForwardMessageCancel:cancelLogic]; CHECK(cancelLogic.nativeClearCalls==1);
    [cancelLogic ForwardMsg:cancelPreview ToContact:Recipient(@"A")];
    CHECK(cancelLogic.fallbackCalls.count==0 && cancelled.manager.inserts.count==0);
    CHECK(![cancelLogic bShowSendSuccessView] && [cancelLogic bHiddenSendSuccessToastView]);
    CHECK(([manager.nativeEvents isEqual:@[@"OnForwardMessageSend",@"OnForwardMessageCancel"]]));
}

static FavDataItemWrap *WrappedFavorite(FavoritesItem *item) {
    FavDataItemWrap *wrapper=[FavDataItemWrap new]; wrapper.parent=item; wrapper.dataItem=item.dataList.firstObject; return wrapper;
}
static void TestFavoriteListHookEntries(void) {
    for (NSUInteger mode=0;mode<3;mode++) {
        Fixture *f=[Fixture new]; favoriteHookAdapter=f.adapter;
        MyFavoritesViewController *list=[MyFavoritesViewController new];
        FavoritesItem *item=VoiceFavorite(); FavDataItemWrap *wrapper=WrappedFavorite(item);
        if (mode==2) wrapper.dataItem=nil; // Native whole-item wrapper constructor leaves this unset.
        id object=mode ? (id)wrapper : item; NSArray *input=@[object];
        [list forwardData:input];
        CHECK(list.nativeInputs.count==0 && f.media.requests.count==1);
        CHECK(f.manager.inserts.count==0 && f.audio.uploader.uploads.count==0 && f.logics.count==0);
        CHECK(item.localId==71 && item.favId==91 && item.dataList.count==1);
        CHECK(mode==2 ? wrapper.dataItem==nil : wrapper.dataItem==item.dataList.firstObject);
        [f.adapter cancelAll];
    }
    for (NSUInteger mode=0;mode<14;mode++) {
        Fixture *f=[Fixture new]; favoriteHookAdapter=f.adapter;
        MyFavoritesViewController *list=[MyFavoritesViewController new]; FavoritesItem *item=VoiceFavorite();
        FavDataItemWrap *wrapper=WrappedFavorite(item); FavoritesItemDataField *field=item.dataList.firstObject;
        id input=@[wrapper];
        if (mode==0) item.type=14; // Note containing a voice field.
        else if (mode==1) item.type=18; // Record/collection outer type.
        else if (mode==2) { item.type=14; input=@[item]; }
        else if (mode==3) { item.dataList=@[field,field]; }
        else if (mode==4) wrapper.dataItem=VoiceFavorite().dataList.firstObject; // Equal metadata, different object.
        else if (mode==5) { FavoritesItemDataField *other=[FavoritesItemDataField new]; other.dataType=2; item.dataList=@[other]; wrapper.dataItem=other; }
        else if (mode==6) { UnrelatedFavoriteWrapper *other=[UnrelatedFavoriteWrapper new]; other.parent=item; other.dataItem=field; input=@[other]; }
        else if (mode==7) input=@[item,wrapper];
        else if (mode==8) input=@[];
        else if (mode==9) input=wrapper; // The verified native list entry expects an array.
        else if (mode==10) { [f setFavoriteEnabled:NO]; input=@[item]; }
        else if (mode==11) [f setFavoriteEnabled:NO];
        else if (mode==12) {
            Class wrong=objc_allocateClassPair(FavDataItemWrap.class,"WrongFavParentABI",0); CHECK(wrong!=Nil);
            CHECK(class_addMethod(wrong,@selector(parent),(IMP)WrongFavoriteParentABI,"Q16@0:8")); objc_registerClassPair(wrong);
            input=@[[wrong new]];
        }
        else if (mode==13) input=@[[ThrowingFavoriteWrapper new]];
        [list forwardData:input];
        CHECK(list.nativeInputs.count==1 && list.nativeInputs.firstObject==input);
        CHECK(f.media.requests.count==0 && f.manager.inserts.count==0 && f.audio.uploader.uploads.count==0);
    }
}

int main(void) {
    @autoreleasepool {
        CHECK(NSThread.isMainThread);
        TestAdmissionAndMenu(); TestRecipientsAndFreshVoice(); TestCancellationAndLateMedia();
        TestDisableAndNewIntent(); TestAccountGenerations(); TestSourceAndSubmissionRevalidation(); TestNativeHookDispatchAndCleanup(); TestFavoriteListHookEntries();
        fprintf(stdout,"Favorite voice forwarding tests passed (%lu checks)\n",(unsigned long)checks);
    }
    return 0;
}
