#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "CSMessageActionCoordinator.h"
#import "CSMessageSendAdapter.h"
#import "CSVoiceForwardAdapter.h"
#import "CSMessageActionMenuAdapter.h"
#import "CSMessageActionDiagnostics.h"
static NSUInteger checks=0;
#define CHECK(x) do { checks++; if (!(x)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#x); exit(1); } } while(0)
static void Drain(void) { NSDate *end=[NSDate dateWithTimeIntervalSinceNow:0.03]; [NSRunLoop.currentRunLoop runUntilDate:end]; }
static BOOL Wait(BOOL (^predicate)(void)) { NSDate *end=[NSDate dateWithTimeIntervalSinceNow:3]; while (!predicate() && end.timeIntervalSinceNow>0) Drain(); return predicate(); }
// Native payload methods live on the type extension; CMessageWrap forwards them.
@interface TestPayloadExtension : NSObject
@property(nonatomic, copy) NSString *m_nsEmoticonMD5,*m_nsAppAttachID;
@property(nonatomic) unsigned int m_uiVoiceTime,m_uiVoiceFormat,m_uiVoiceForwardFlag,m_uiVoiceCancelFlag,m_uiAppDataSize,m_uiGameType,m_uiGameContent;
@property(nonatomic, copy) NSData *m_dtVoice;
@property(nonatomic, strong) id m_oImageInfo;
@property(nonatomic) BOOL m_bAppAttachExistInSvr;
@end
@implementation TestPayloadExtension
@end
@interface CMessageWrap : NSObject <NSCopying>
@property(nonatomic, copy) NSString *m_nsFromUsr,*m_nsToUsr,*m_nsContent,*m_nsClientMsgID,*m_nsRealChatUsr,*path,*m_nsMsgSource,*m_nsRevokeBatchId;
@property(nonatomic) unsigned int m_uiMessageType,m_uiMesLocalID,m_uiCreateTime,m_uiStatus,m_uiSendTime,m_uiIsSenderStatus,m_uiDownloadStatus;
@property(nonatomic) long long m_n64MesSvrID;
@property(nonatomic, strong) NSMutableDictionary *m_dicForwardParas;
@property(nonatomic) BOOL file,record;
@property(nonatomic, strong) TestPayloadExtension *m_extendInfoWithMsgType;
@property(nonatomic, copy) NSString *m_nsEmoticonMD5,*m_nsAppAttachID;
@property(nonatomic) unsigned int m_uiVoiceTime,m_uiVoiceFormat,m_uiVoiceForwardFlag,m_uiVoiceCancelFlag,m_uiAppDataSize,m_uiGameType,m_uiGameContent;
@property(nonatomic, copy) NSData *m_dtVoice;
@property(nonatomic, strong) id m_oImageInfo;
@property(nonatomic) BOOL m_bAppAttachExistInSvr;
- (instancetype)initWithMsgType:(long long)type;
@end
@implementation CMessageWrap
@dynamic m_uiGameType,m_uiGameContent,m_nsEmoticonMD5,m_nsAppAttachID,m_uiVoiceTime,m_uiVoiceFormat,m_uiVoiceForwardFlag,m_uiVoiceCancelFlag,m_uiAppDataSize,m_dtVoice,m_oImageInfo,m_bAppAttachExistInSvr;
- (instancetype)initWithMsgType:(long long)type { if ((self=[super init])) { _m_uiMessageType=type; _m_extendInfoWithMsgType=[TestPayloadExtension new]; } return self; }
- (id)forwardingTargetForSelector:(SEL)selector { return [_m_extendInfoWithMsgType respondsToSelector:selector] ? _m_extendInfoWithMsgType : [super forwardingTargetForSelector:selector]; }
- (id)copyWithZone:(NSZone *)zone { (void)zone; CMessageWrap *copy=[[CMessageWrap alloc] initWithMsgType:_m_uiMessageType]; copy.m_nsFromUsr=_m_nsFromUsr; copy.m_nsToUsr=_m_nsToUsr; copy.m_nsContent=_m_nsContent; copy.m_uiMesLocalID=_m_uiMesLocalID; copy.m_n64MesSvrID=_m_n64MesSvrID; copy.m_uiVoiceTime=self.m_uiVoiceTime; copy.m_uiVoiceFormat=self.m_uiVoiceFormat; copy.m_uiDownloadStatus=self.m_uiDownloadStatus; copy.m_dtVoice=self.m_dtVoice; copy.m_nsEmoticonMD5=self.m_nsEmoticonMD5; copy.m_uiGameType=self.m_uiGameType; copy.m_uiGameContent=self.m_uiGameContent; copy.m_nsAppAttachID=self.m_nsAppAttachID; copy.path=_path; copy.m_dicForwardParas=_m_dicForwardParas; copy.m_oImageInfo=self.m_oImageInfo; copy.file=_file; copy.record=_record; copy.m_uiAppDataSize=self.m_uiAppDataSize; copy.m_bAppAttachExistInSvr=self.m_bAppAttachExistInSvr; return copy; }
- (NSString *)getVoicePath { CHECK(NSThread.isMainThread); return self.path; }
+ (NSString *)getPathOfAudio:(CMessageWrap *)wrap { CHECK(NSThread.isMainThread); return wrap.path; }
+ (void)GetPathOfAppDataByUserName:(NSString *)chat andMessageWrap:(CMessageWrap *)wrap retStrPath:(NSString * __autoreleasing *)path { CHECK([chat isEqualToString:@"chat"]); *path=wrap.path; }
- (BOOL)IsFileMsg { return _file; }
+ (BOOL)IsRecordOrNoteMsg:(CMessageWrap *)wrap { return wrap.record; }
@end
@interface TestWrongPayloadExtension : NSObject
@property(nonatomic, copy) NSString *m_uiVoiceTime;
@end
@implementation TestWrongPayloadExtension
@end
@interface TestWrongForwardTarget : CMessageWrap
@end
@implementation TestWrongForwardTarget
- (id)forwardingTargetForSelector:(SEL)selector { (void)selector; return [TestPayloadExtension new]; }
@end
@interface TestUnrelatedForwarder : NSObject
@property(nonatomic, strong) TestPayloadExtension *m_extendInfoWithMsgType;
@end
@implementation TestUnrelatedForwarder
- (id)forwardingTargetForSelector:(SEL)selector { (void)selector; return _m_extendInfoWithMsgType; }
@end
@interface TestImageInfo : NSObject <NSCopying>
@property(nonatomic, copy) NSString *assetId;
@end
@implementation TestImageInfo
- (id)copyWithZone:(NSZone *)zone { (void)zone; TestImageInfo *copy=[TestImageInfo new]; copy.assetId=_assetId; return copy; }
@end
@interface CaptureVideoInfo : NSObject
@property(nonatomic) BOOL m_bForward;
@property(nonatomic, copy) NSString *m_nsSpecifiedChatName;
@end
@implementation CaptureVideoInfo
@end
static NSMutableArray *factoryInputs;
@interface ForwardMsgUtil : NSObject
@end
@implementation ForwardMsgUtil
+ (id)imgMsgFromMsgWrap:(CMessageWrap *)source { [factoryInputs addObject:source]; CHECK(source.m_uiMesLocalID==42); [(TestImageInfo *)source.m_oImageInfo setAssetId:@"factory-owned"]; return [source copy]; }
+ (id)cardMsgFromMsgWrap:(CMessageWrap *)source { [factoryInputs addObject:source]; return [source copy]; }
+ (id)appMsgFromMsgWrap:(CMessageWrap *)source { [factoryInputs addObject:source]; CHECK(source.m_uiMesLocalID==42); return [source copy]; }
+ (id)GenForwardVideoFromMsgWrap:(CMessageWrap *)source { [factoryInputs addObject:source]; CHECK(!source.m_dicForwardParas[@"CaptureVideoInfo"]); CaptureVideoInfo *video=[CaptureVideoInfo new]; video.m_nsSpecifiedChatName=@"incorrect-recipient"; return video; }
@end
@interface MMMenuItem : NSObject
@property(nonatomic, copy) NSString *title;
@property(nonatomic, weak) id target;
@property(nonatomic) SEL action;
@property(nonatomic, strong) id iconImage;
@property(nonatomic) NSInteger linePosition,menuType;
@end
@implementation MMMenuItem
- (instancetype)initWithTitle:(NSString *)title icon:(id)icon target:(id)target action:(SEL)action { if ((self=[super init])) { _title=title; _iconImage=icon; _target=target; _action=action; } return self; }
- (instancetype)initWithTitle:(NSString *)title target:(id)target action:(SEL)action { return [self initWithTitle:title icon:nil target:target action:action]; }
@end
@interface TestCell : NSObject
@property(nonatomic, strong) CMessageWrap *wrap;
@property(nonatomic, strong) id viewModel;
@property(nonatomic) NSUInteger favoriteCalls;
@property(nonatomic, weak) id nextResponder;
@property(nonatomic) BOOL revokeAllowed;
@property(nonatomic, copy) void (^forwardHandler)(void);
- (id)getCurrentMessageWrap;
@end
@implementation TestCell
- (id)getCurrentMessageWrap { return _wrap; }
- (BOOL)canShowRevokeMsgMenuItemForMessage:(id)wrap { CHECK(wrap==_wrap); return _revokeAllowed; }
- (void)onForward:(id)sender { (void)sender; if (_forwardHandler) _forwardHandler(); }
- (void)doFavorite { _favoriteCalls++; }
@end
@interface TestWrongControllerCell : TestCell
@end
@implementation TestWrongControllerCell
- (NSUInteger)getViewController { CHECK(NO); return 1; }
@end
@interface TestThrowingControllerCell : TestCell
@end
@implementation TestThrowingControllerCell
- (id)getViewController { [NSException raise:@"controller" format:@"injected"]; return nil; }
@end
@interface TestMessageViewModel : NSObject
@property(nonatomic, strong) CMessageWrap *messageWrap;
@end
@implementation TestMessageViewModel
@end
@interface TestMessageCellDelegate : NSObject
@property(nonatomic, weak) id controller;
- (id)getViewController;
@end
@implementation TestMessageCellDelegate
- (id)getViewController { return _controller; }
@end
#import "RepeatMenuHooksUnderTest.h"
#import "MenuObservationHooksUnderTest.h"
@interface TestController : NSObject
@property(nonatomic, strong) NSMutableArray *calls;
@property(nonatomic, copy) void (^confirmation)(void);
@property(nonatomic) BOOL textThrows;
@property(nonatomic, strong) id m_logicController;
@end
@implementation TestController
- (instancetype)init { if ((self=[super init])) _calls=[NSMutableArray array]; return self; }
- (void)SendTextMessage:(id)text { [_calls addObject:@[@"text",text]]; if (_textThrows) [NSException raise:@"after-text" format:@"injected after side effect"]; }
- (void)SendTextMessage:(id)text externInfo:(id)extra { (void)extra; [_calls addObject:@[@"alternate",text]]; }
- (void)deleteNode:(id)wrap withDB:(BOOL)withDB animated:(BOOL)animated { CHECK(withDB==YES && animated==YES); [_calls addObject:@[@"delete",wrap]]; }
- (void)revokeMsgByNodeView:(id)wrap { [_calls addObject:@[@"revoke",wrap]]; }
- (void)cs_confirmMessageAction:(void (^)(void))confirmation { _confirmation=confirmation; }
- (void)startReplyWithMessageWrap:(id)wrap { [_calls addObject:@[@"quote",wrap]]; }
@end
@interface TestUploader : NSObject
@property(nonatomic, strong) NSMutableArray *calls;
@property(nonatomic) BOOL throws;
@end
@implementation TestUploader
- (instancetype)init { if ((self=[super init])) _calls=[NSMutableArray array]; return self; }
- (void)ResendVoiceMsg:(NSString *)chat MsgWrap:(id)wrap { [_calls addObject:@[chat,wrap]]; if (_throws) [NSException raise:@"after-upload" format:@"injected"]; }
@end
@interface TestAudio : NSObject
@property(nonatomic, strong) TestUploader *uploader;
@property(nonatomic) NSUInteger unsafeCalls;
@end
@implementation TestAudio
- (id)uploaderForMsgWrap:(id)wrap { CHECK(CSMessageNativeUnsigned(wrap,@"m_uiMesLocalID")==0); return _uploader; }
- (void)ResendVoiceMsg:(id)chat MsgWrap:(id)wrap { (void)chat; (void)wrap; _unsafeCalls++; }
@end
@interface TestManager : NSObject
@property(nonatomic, strong) NSMutableArray *calls;
@property(nonatomic) BOOL insertThrows;
@property(nonatomic,strong) CMessageWrap *storedWrap;
@end
@implementation TestManager
- (instancetype)init { if ((self=[super init])) _calls=[NSMutableArray array]; return self; }
- (id)GetMsg:(NSString *)chat LocalID:(unsigned int)localID { CHECK([chat isEqual:@"chat"] && localID==42); return _storedWrap; }
- (void)AddLocalMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap { CHECK(wrap.m_uiMesLocalID==0); [_calls addObject:@[@"insert",chat,wrap]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+100; if (_insertThrows) [NSException raise:@"after-insert" format:@"injected"]; }
- (void)AddMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap { [_calls addObject:@[@"add",chat,wrap]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+200; }
- (void)AddEmoticonMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap { [_calls addObject:@[@"emoji",chat,wrap]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+300; }
- (id)AddVideoMsg:(NSString *)from ToUsr:(NSString *)to VideoInfo:(CaptureVideoInfo *)video MsgType:(unsigned int)type { CHECK(type==43 && [from isEqual:@"me"] && [to isEqual:video.m_nsSpecifiedChatName] && video.m_bForward); [_calls addObject:@[@"video",to,video]]; CMessageWrap *output=[[CMessageWrap alloc] initWithMsgType:type]; output.m_uiMesLocalID=(unsigned)_calls.count+400; output.m_nsToUsr=to; return output; }
- (void)AddAppMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap Data:(NSData *)data Scene:(unsigned int)scene { CHECK(scene==1 && wrap.m_uiMesLocalID==0); [_calls addObject:@[@"app-data",chat,wrap,data ?: NSNull.null]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+500; }
- (void)AddAppMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap DataPath:(NSString *)path Scene:(unsigned int)scene { CHECK(scene==1 && wrap.m_uiMesLocalID==0); [_calls addObject:@[@"app-path",chat,wrap,path]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+600; }
- (void)AddRecordMsg:(NSString *)chat MsgWrap:(CMessageWrap *)wrap { CHECK(wrap.m_uiMesLocalID==0); [_calls addObject:@[@"record",chat,wrap]]; wrap.m_uiMesLocalID=(unsigned)_calls.count+700; }
@end
@interface TestEnvironment : NSObject <CSMessageActionEnvironment>
@property(nonatomic, copy) NSString *account;
@property(nonatomic) NSUInteger accountReads, controllerLookups;
@property(nonatomic, strong) NSMutableDictionary *services;
@property(nonatomic, weak) TestController *controller;
@end
@implementation TestEnvironment
- (instancetype)init { if ((self=[super init])) { _account=@"me"; _services=[NSMutableDictionary dictionary]; } return self; }
- (NSString *)currentAccountID { _accountReads++; return _account; }
- (id)serviceNamed:(NSString *)name { return _services[name]; }
- (id)controllerForCell:(id)cell { (void)cell; _controllerLookups++; return _controller; }
@end
@interface TestContact : NSObject
@property(nonatomic, copy) NSString *m_nsUsrName;
@end
@implementation TestContact
@end
static TestContact *Contact(NSString *name) { TestContact *contact=[TestContact new]; contact.m_nsUsrName=name; return contact; }
// Native-shaped entry: MMContext returns an NSProxy, not a concrete service.
@interface CContactMgr : NSObject
@property(nonatomic, strong) TestContact *contact;
- (id)getSelfContact;
@end
@implementation CContactMgr
- (id)getSelfContact { return _contact; }
@end
@interface MMServiceWrapper : NSProxy
@property(nonatomic, strong) id service;
@property(nonatomic) NSUInteger invocations;
@end
@implementation MMServiceWrapper
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector { return [_service methodSignatureForSelector:selector]; }
- (void)forwardInvocation:(NSInvocation *)invocation { _invocations++; [invocation invokeWithTarget:_service]; }
- (BOOL)respondsToSelector:(SEL)selector { return [_service respondsToSelector:selector]; }
- (id)forwardingTargetForSelector:(SEL)selector { (void)selector; return nil; }
@end
static NSMutableDictionary *nativeServices;
@interface CMessageMgr : TestManager
@end
@implementation CMessageMgr
@end
@interface AudioSender : TestAudio
@end
@implementation AudioSender
@end
@interface VoiceMsgDownloader : NSObject
@property(nonatomic) NSUInteger downloads;
- (void)downloadMsg:(id)wrap;
@end
@implementation VoiceMsgDownloader
- (void)downloadMsg:(id)wrap { CHECK(wrap); _downloads++; }
@end
static MMServiceWrapper *WrappedService(id service) { MMServiceWrapper *wrapper=[MMServiceWrapper alloc]; wrapper.service=service; return wrapper; }
@interface MMContext : NSObject
+ (id)currentContext;
- (id)getService:(Class)serviceClass;
@end
@implementation MMContext
+ (id)currentContext { static MMContext *context; if (!context) context=[MMContext new]; return context; }
- (id)getService:(Class)serviceClass { return nativeServices[NSStringFromClass(serviceClass)]; }
@end
@interface BaseMsgContentViewController : NSObject
@property(nonatomic, strong) id m_delegate;
@end
@interface BaseMsgContentLogicController : TestController
@end
@implementation BaseMsgContentLogicController
@end
@implementation BaseMsgContentViewController
@end
@interface TestLogic : NSObject
@property(nonatomic, copy) NSArray *targets;
@end
@implementation TestLogic
- (id)getToContacts { return _targets; }
@end
#import "VoiceForwardCleanupHooksUnderTest.h"
@interface HeldMedia : CSMessageMediaProvider
@property(nonatomic, strong) NSMutableDictionary *callbacks;
@end
@implementation HeldMedia
- (instancetype)init { if ((self=[super init])) _callbacks=[NSMutableDictionary dictionary]; return self; }
- (void)prepareVoiceForContext:(CSMessageActionContext *)context operationID:(NSString *)identifier completion:(void (^)(CSMessageVoiceResource *))completion { (void)context; _callbacks[identifier]=[completion copy]; }
// Preserve cancelled callbacks to inject genuinely late native completion events.
- (void)cancelOperationID:(NSString *)identifier { (void)identifier; }
- (void)finish:(NSString *)identifier { void (^callback)(CSMessageVoiceResource *)=_callbacks[identifier]; if (callback) callback([[CSMessageVoiceResource alloc] initWithData:[@"audio" dataUsingEncoding:NSUTF8StringEncoding] durationMilliseconds:1234 format:0]); }
@end
@interface RecordingSender : CSMessageSendAdapter
@property(nonatomic, strong) NSMutableArray *calls;
@end
@implementation RecordingSender
- (instancetype)initWithEnvironment:(id<CSMessageActionEnvironment>)environment { if ((self=[super initWithEnvironment:environment])) _calls=[NSMutableArray array]; return self; }
- (CSMessagePreparedSend *)prepareContext:(CSMessageActionContext *)context targetID:(NSString *)target voice:(CSMessageVoiceResource *)voice { (void)context; CHECK(voice.durationMilliseconds==1234); return [[CSMessagePreparedSend alloc] initWithWrap:nil routeName:@"host-test-native-boundary" submission:^{ [self.calls addObject:target]; return [target isEqualToString:@"A"] ? CSMessageActionSubmissionStateAccepted : CSMessageActionSubmissionStateFailedBeforeAcceptance; }]; }
@end
static TestCell *Cell(unsigned int type) { TestCell *cell=[TestCell new]; cell.wrap=[[CMessageWrap alloc] initWithMsgType:type]; cell.wrap.m_nsFromUsr=@"chat"; cell.wrap.m_nsToUsr=@"me"; cell.wrap.m_uiMesLocalID=42; cell.wrap.m_n64MesSvrID=900; cell.wrap.m_nsContent=@"Unicode 你好\nline 2"; return cell; }
static CSMessageActionContext *Context(TestCell *cell,id controller) { return [CSMessageActionContext contextWithCell:cell controller:controller accountID:@"me" accountEpoch:1 conversationID:@"chat" bindingGeneration:1]; }
static CSMessageActionPreferences *Preferences(NSUserDefaults *defaults) { [defaults setBool:YES forKey:CSMessageActionGestureEnabledKey]; [defaults setBool:YES forKey:CSMessageActionRepeatEnabledKey]; [defaults setBool:YES forKey:CSMessageActionVoiceForwardEnabledKey]; return [[CSMessageActionPreferences alloc] initWithDefaults:defaults]; }
static void TestNativeTextAndFeedback(NSUserDefaults *defaults) {
    TestEnvironment *environment=[TestEnvironment new]; BaseMsgContentViewController *controller=[BaseMsgContentViewController new];
    BaseMsgContentLogicController *logic=[BaseMsgContentLogicController new]; controller.m_delegate=logic;
    CSMessageSendAdapter *sender=[[CSMessageSendAdapter alloc] initWithEnvironment:environment]; TestCell *cell=Cell(1);
    cell.wrap.m_nsContent=@"plain text 👋🏽\nsecond line";
    CSMessageActionContext *context=Context(cell,controller);
    CSMessagePreparedSend *route=[sender prepareContext:context targetID:@"chat" voice:nil]; CHECK(route);
    CHECK([route submit]==CSMessageActionSubmissionStateUnknown); CHECK(logic.calls.count==1 && [logic.calls[0][1] isEqual:cell.wrap.m_nsContent]);
    [route submit]; CHECK(logic.calls.count==1); CHECK(![sender prepareContext:context targetID:@"other-chat" voice:nil]);
    controller.m_delegate=[TestController new]; CHECK(![sender prepareContext:context targetID:@"chat" voice:nil]); controller.m_delegate=logic;
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:environment preferences:Preferences(defaults) mediaProvider:[CSMessageMediaProvider new]];
    NSMutableArray *feedback=[NSMutableArray array]; coordinator.feedbackHandler=^(NSString *message){ [feedback addObject:message]; };
    NSString *operation=[coordinator executeContext:context action:CSMessageActionRepeat entry:CSMessageActionEntryMenuRepeat];
    CHECK(Wait(^BOOL{ return [coordinator resultsForOperationID:operation][@"chat"] && [[coordinator resultsForOperationID:operation][@"chat"] integerValue]==CSMessageActionSubmissionStateUnknown; })); CHECK(feedback.count==0); CHECK(logic.calls.count==2);
    logic.textThrows=YES; operation=[coordinator executeContext:context action:CSMessageActionRepeat entry:CSMessageActionEntryMenuRepeat];
    CHECK(Wait(^BOOL{ return feedback.count==1; })); CHECK([[coordinator resultsForOperationID:operation][@"chat"] integerValue]==CSMessageActionSubmissionStateUnknown); CHECK(logic.calls.count==3);
    [feedback removeAllObjects]; TestManager *manager=[TestManager new]; environment.services[@"CMessageMgr"]=manager;
    for (NSNumber *type in @[@3,@49]) {
        TestCell *payload=Cell(type.unsignedIntValue);
        NSString *payloadOperation=[coordinator executeContext:Context(payload,controller) action:CSMessageActionRepeat entry:CSMessageActionEntryMenuRepeat];
        CHECK(Wait(^BOOL{ return [[coordinator resultsForOperationID:payloadOperation][@"chat"] integerValue]==CSMessageActionSubmissionStateUnknown; }));
        CHECK(!feedback.count); CHECK(payload.wrap.m_uiMesLocalID==42);
    }
    CHECK(manager.calls.count==2);
}
static void TestProductionAdmission(NSUserDefaults *defaults) {
    CContactMgr *contacts=[CContactMgr new]; contacts.contact=Contact(@"me");
    MMServiceWrapper *proxy=WrappedService(contacts); nativeServices=[NSMutableDictionary dictionaryWithObject:proxy forKey:@"CContactMgr"];
    CHECK(!CSMessageNativeSupports(proxy,@"getSelfContact",@"@",@[]));
    CSMessageNativeEnvironment *environment=[CSMessageNativeEnvironment new];
    CHECK([environment serviceNamed:@"CContactMgr"]==proxy);
    CHECK(!class_getInstanceMethod(object_getClass(proxy),@selector(getSelfContact)));
    BaseMsgContentViewController *controller=[BaseMsgContentViewController new];
    TestCell *cell=Cell(34); cell.nextResponder=controller;
    CHECK([environment controllerForCell:cell]==controller);
    CSMessageActionPreferences *preferences=Preferences(defaults);
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:environment preferences:preferences mediaProvider:[CSMessageMediaProvider new]];
    CSMessageActionContext *context=[coordinator captureContextForCell:cell controller:nil bindingGeneration:1];
    CSMessageActionMenuAdapter *menu=[[CSMessageActionMenuAdapter alloc] initWithCoordinator:coordinator];
    NSArray *items=[menu itemsByAddingActionsForCell:cell items:@[]];
    BOOL gesture=[coordinator canExecuteContext:context action:CSMessageActionRepeat entry:CSMessageActionEntryGesture];
    fprintf(stderr,"production admission: account=%s context=%s menus=%lu gesture=%s\n",environment.currentAccountID.UTF8String ?: "nil",context ? "yes" : "nil",(unsigned long)items.count,gesture ? "yes" : "no");
    CHECK([environment.currentAccountID isEqual:@"me"]);
    CHECK(context && [context.accountID isEqual:@"me"]); CHECK(items.count==2); CHECK(gesture);
    CHECK(proxy.invocations>0); // Dispatch must retain native proxy account-context forwarding.
    CHECK(!CSMessageNativeSupports(proxy,@"getSelfContact",@"I",@[]));
    CHECK(!CSMessageActionObjectGetter(proxy,@selector(getSelfContact))); // No arbitrary core getter widening.
    MMServiceWrapper *unregistered=WrappedService(contacts);
    CHECK(!CSMessageNativeSupports(unregistered,@"getSelfContact",@"@",@[]));
    // Exercise production service discovery and sending routes against wrapped services.
    CMessageMgr *manager=[CMessageMgr new]; MMServiceWrapper *managerProxy=WrappedService(manager); nativeServices[@"CMessageMgr"]=managerProxy;
    AudioSender *audio=[AudioSender new]; TestUploader *uploader=[TestUploader new]; audio.uploader=uploader; MMServiceWrapper *audioProxy=WrappedService(audio); nativeServices[@"AudioSender"]=audioProxy;
    CSMessageSendAdapter *sender=[[CSMessageSendAdapter alloc] initWithEnvironment:environment];
    CSMessageVoiceResource *voice=[[CSMessageVoiceResource alloc] initWithData:[@"audio" dataUsingEncoding:NSUTF8StringEncoding] durationMilliseconds:1234 format:0];
    CSMessagePreparedSend *route=[sender prepareContext:context targetID:@"chat" voice:voice];
    CHECK(route); CHECK([route submit]==CSMessageActionSubmissionStateUnknown);
    CHECK(manager.calls.count==1 && uploader.calls.count==1); CHECK(managerProxy.invocations==1 && audioProxy.invocations==1); CHECK(audio.unsafeCalls==0);
    CHECK(!CSMessageNativeSupports(managerProxy,@"AddLocalMsg:MsgWrap:",@"v",(@[@"@",@"I"])));
    VoiceMsgDownloader *downloader=[VoiceMsgDownloader new]; MMServiceWrapper *downloaderProxy=WrappedService(downloader); nativeServices[@"VoiceMsgDownloader"]=downloaderProxy;
    id service=[environment serviceNamed:@"VoiceMsgDownloader"]; CHECK(CSMessageNativeSupports(service,@"downloadMsg:",@"v",(@[@"@"]))); CSMessageNativeInvoke(service,@"downloadMsg:",@[cell.wrap]); CHECK(downloader.downloads==1 && downloaderProxy.invocations==1);
    // A changed active service/account invalidates old captured menus and gesture requests.
    CContactMgr *nextContacts=[CContactMgr new]; nextContacts.contact=Contact(@"other"); nativeServices[@"CContactMgr"]=WrappedService(nextContacts);
    CHECK(![coordinator validateContext:context]); CHECK([[menu itemsByAddingActionsForCell:cell items:@[]] count]==0);
    CHECK(![coordinator canExecuteContext:context action:CSMessageActionRepeat entry:CSMessageActionEntryGesture]);
    nativeServices[@"CContactMgr"]=contacts; CHECK([environment.currentAccountID isEqual:@"me"]); // Native raw-service opt-in remains supported.
    nativeServices=nil;
}
static void TestNativeBoundary(void) {
    TestController *controller=[TestController new]; TestCell *cell=Cell(1); CSMessageActionContext *context=Context(cell,controller); CHECK(context);
    CHECK(CSMessageNativeSupports(controller,@"deleteNode:withDB:animated:",@"v",(@[@"@",@"B",@"B"])));
    CHECK(!CSMessageNativeSupports(controller,@"deleteNode:withDB:animated:",@"v",(@[@"@",@"@",@"@"])));
    CSMessageNativeInvoke(controller,@"deleteNode:withDB:animated:",@[cell.wrap,@YES,@YES]); CHECK(controller.calls.count==1);
    CMessageWrap *forwarded=Cell(34).wrap;
    CHECK(!class_getInstanceMethod(CMessageWrap.class,@selector(m_uiVoiceTime)));
    CHECK(!CSMessageActionObjectGetter(forwarded,@selector(m_dtVoice))); // Core context boundary stays concrete-only.
    CHECK(CSMessageNativeSupports(forwarded,@"setM_uiVoiceTime:",@"v",(@[@"I"])));
    CHECK(!CSMessageNativeSupports(forwarded,@"setM_uiVoiceTime:",@"v",(@[@"@"])));
    CHECK(CSMessageNativeSet(forwarded,@"setM_uiVoiceTime:",@1234,YES)); CHECK(forwarded.m_uiVoiceTime==1234);
    CHECK(CSMessageNativeUnsigned(forwarded,@"m_uiVoiceTime")==1234);
    NSData *payload=[@"forwarded-audio" dataUsingEncoding:NSUTF8StringEncoding]; forwarded.m_dtVoice=payload;
    CHECK([CSMessageActionNativeObject(forwarded,@"m_dtVoice") isEqual:payload]);
    CHECK(!CSMessageActionNativeObject(forwarded,@"m_uiVoiceTime"));
    CHECK(!CSMessageNativeSupports([[TestWrongForwardTarget alloc] initWithMsgType:34],@"m_dtVoice",@"@",@[]));
    TestUnrelatedForwarder *unrelated=[TestUnrelatedForwarder new]; unrelated.m_extendInfoWithMsgType=[TestPayloadExtension new];
    CHECK(!CSMessageNativeSupports(unrelated,@"m_dtVoice",@"@",@[]));
    forwarded.m_extendInfoWithMsgType=(TestPayloadExtension *)[TestWrongPayloadExtension new];
    CHECK(!CSMessageNativeSupports(forwarded,@"m_uiVoiceTime",@"I",@[])); CHECK(!CSMessageNativeUnsigned(forwarded,@"m_uiVoiceTime"));
    CSMessageNativeActionAdapter *adapter=[CSMessageNativeActionAdapter new]; __block BOOL valid=YES; __block NSInteger state=-99;
    [adapter performAction:CSMessageActionDelete context:context valid:^BOOL{ return valid; } completion:^(CSMessageActionSubmissionState result){ state=result; }];
    CHECK(controller.confirmation); valid=NO; controller.confirmation(); CHECK(state==CSMessageActionSubmissionStateCancelled); CHECK(controller.calls.count==1);
    TestCell *outgoing=Cell(1); outgoing.wrap.m_nsFromUsr=@"me"; outgoing.wrap.m_nsToUsr=@"chat"; outgoing.revokeAllowed=YES; CSMessageActionContext *sent=Context(outgoing,controller); CHECK([adapter canPerformAction:CSMessageActionRevoke context:sent]);
    valid=YES; [adapter performAction:CSMessageActionRevoke context:sent valid:^BOOL{ return valid; } completion:^(CSMessageActionSubmissionState result){state=result;}];
    outgoing.revokeAllowed=NO; controller.confirmation(); CHECK(controller.calls.count==1); CHECK(state==CSMessageActionSubmissionStateCancelled);
}
static void TestSendRoutes(void) {
    TestEnvironment *env=[TestEnvironment new]; TestController *controller=[TestController new]; env.controller=controller; TestCell *cell=Cell(1); CSMessageSendAdapter *sender=[[CSMessageSendAdapter alloc] initWithEnvironment:env];
    controller.textThrows=YES; CSMessagePreparedSend *text=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(text); CHECK([text submit]==CSMessageActionSubmissionStateUnknown); CHECK(controller.calls.count==1); CHECK([text submit]==CSMessageActionSubmissionStateUnknown); CHECK(controller.calls.count==1); CHECK([controller.calls[0][0] isEqual:@"text"]);
    TestManager *manager=[TestManager new]; TestUploader *uploader=[TestUploader new]; TestAudio *audio=[TestAudio new]; audio.uploader=uploader; env.services[@"CMessageMgr"]=manager; env.services[@"AudioSender"]=audio;
    cell=Cell(34); CSMessageActionContext *context=Context(cell,controller); CSMessageVoiceResource *voice=[[CSMessageVoiceResource alloc] initWithData:[@"audio" dataUsingEncoding:NSUTF8StringEncoding] durationMilliseconds:1234 format:0];
    CSMessagePreparedSend *a=[sender prepareContext:context targetID:@"A" voice:voice], *b=[sender prepareContext:context targetID:@"B" voice:voice]; CHECK(a && b); CHECK(a.outputWrap!=b.outputWrap && a.outputWrap!=cell.wrap); CHECK(CSMessageNativeUnsigned(a.outputWrap,@"m_uiVoiceTime")==1234); CHECK(CSMessageNativeUnsigned(a.outputWrap,@"m_uiVoiceFormat")==0);
    CHECK([a submit]==CSMessageActionSubmissionStateUnknown); CHECK([b submit]==CSMessageActionSubmissionStateUnknown); CHECK(manager.calls.count==2 && uploader.calls.count==2 && !audio.unsafeCalls); CHECK(cell.wrap.m_uiMesLocalID==42 && cell.wrap.m_n64MesSvrID==900 && [cell.wrap.m_nsFromUsr isEqual:@"chat"] && [cell.wrap.m_nsToUsr isEqual:@"me"]);
    manager.insertThrows=YES; CSMessagePreparedSend *c=[sender prepareContext:context targetID:@"C" voice:voice]; CHECK([c submit]==CSMessageActionSubmissionStateUnknown); CHECK(manager.calls.count==3 && uploader.calls.count==2 && !audio.unsafeCalls);
    manager.insertThrows=NO; uploader.throws=YES; CSMessagePreparedSend *d=[sender prepareContext:context targetID:@"D" voice:voice]; CHECK([d submit]==CSMessageActionSubmissionStateUnknown); CHECK(manager.calls.count==4 && uploader.calls.count==3);
    cell=Cell(48); CSMessagePreparedSend *location=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(location); [location submit]; CHECK([manager.calls.lastObject[0] isEqual:@"add"]); CHECK(cell.wrap.m_uiMesLocalID==42);
    cell=Cell(47); cell.wrap.m_nsContent=@"<emoji md5=\"0123456789abcdef0123456789abcdef\"/>"; CSMessagePreparedSend *emoji=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(emoji); [emoji submit]; CHECK([manager.calls.lastObject[0] isEqual:@"emoji"]); CHECK([[[(CMessageWrap *)emoji.outputWrap m_nsEmoticonMD5] description] isEqual:@"0123456789abcdef0123456789abcdef"]);
}
static void TestOrdinaryPayloadRoutes(void) {
    factoryInputs=[NSMutableArray array]; TestEnvironment *env=[TestEnvironment new]; TestManager *manager=[TestManager new]; env.services[@"CMessageMgr"]=manager; TestController *controller=[TestController new]; env.controller=controller;
    CSMessageSendAdapter *sender=[[CSMessageSendAdapter alloc] initWithEnvironment:env];
    TestCell *cell=Cell(3); TestImageInfo *info=[TestImageInfo new]; info.assetId=@"historical-asset"; cell.wrap.m_oImageInfo=info;
    CSMessagePreparedSend *image=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil];
    CHECK(image && factoryInputs.lastObject!=cell.wrap); CHECK([info.assetId isEqual:@"historical-asset"]); CHECK(image.outputWrap!=cell.wrap); CHECK(CSMessageNativeUnsigned(image.outputWrap,@"m_uiMesLocalID")==0 && CSMessageNativeUnsigned(image.outputWrap,@"m_n64MesSvrID")==0); [image submit]; CHECK([manager.calls.lastObject[0] isEqual:@"add"]); CHECK(cell.wrap.m_uiMesLocalID==42 && [info.assetId isEqual:@"historical-asset"]);
    cell=Cell(42); CSMessagePreparedSend *card=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(card && card.outputWrap!=cell.wrap); [card submit]; CHECK([manager.calls.lastObject[0] isEqual:@"add"]);
    cell=Cell(43); CaptureVideoInfo *cached=[CaptureVideoInfo new]; cached.m_nsSpecifiedChatName=@"historical-target"; cell.wrap.m_dicForwardParas=[@{@"CaptureVideoInfo":cached} mutableCopy];
    CSMessagePreparedSend *video=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(video); CHECK(cell.wrap.m_dicForwardParas[@"CaptureVideoInfo"]==cached && [cached.m_nsSpecifiedChatName isEqual:@"historical-target"] && !cached.m_bForward); [video submit]; CHECK([manager.calls.lastObject[0] isEqual:@"video"]); CHECK(video.outputWrap && video.outputWrap!=cell.wrap); CHECK([CSMessageActionObjectGetter(video.outputWrap,NSSelectorFromString(@"m_nsToUsr")) isEqual:@"chat"]);
    cell=Cell(49); cell.wrap.record=YES; CSMessagePreparedSend *record=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(record); [record submit]; CHECK([manager.calls.lastObject[0] isEqual:@"record"]);
    NSString *path=[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]; NSData *data=[@"attachment-data" dataUsingEncoding:NSUTF8StringEncoding]; CHECK([data writeToFile:path atomically:YES]); cell=Cell(49); cell.wrap.file=YES; cell.wrap.path=path; CSMessageActionContext *fileContext=Context(cell,controller);
    __block NSUInteger reads=0; CSMessageMediaProvider *provider=[[CSMessageMediaProvider alloc] initWithReader:^NSData *(NSString *file){ CHECK(!NSThread.isMainThread); reads++; return [NSData dataWithContentsOfFile:file]; }];
    __block BOOL fileReady=NO; __block NSString *preparedPath=nil;
    [provider prepareAppDataForContext:fileContext operationID:@"file" completion:^(NSData *bytes,NSString *resolved){ CHECK(!bytes && [resolved isEqual:path]); preparedPath=resolved; fileReady=YES; }]; CHECK(!fileReady); CHECK(Wait(^BOOL{ return fileReady; })); CHECK(!reads);
    CSMessagePreparedSend *file=[sender prepareContext:fileContext targetID:@"chat" voice:nil appData:nil appDataPath:preparedPath]; CHECK(file); [file submit]; CHECK([manager.calls.lastObject[0] isEqual:@"app-path"] && [manager.calls.lastObject[3] isEqual:path]); CHECK([NSFileManager.defaultManager fileExistsAtPath:path] && cell.wrap.m_uiMesLocalID==42);
    cell.wrap.file=NO; cell.wrap.m_uiAppDataSize=(unsigned)data.length; __block NSData *preparedData=nil; __block BOOL dataReady=NO;
    [provider prepareAppDataForContext:fileContext operationID:@"data" completion:^(NSData *bytes,NSString *resolved){ CHECK([resolved isEqual:path]); preparedData=bytes; dataReady=YES; }]; CHECK(Wait(^BOOL{ return dataReady; })); CHECK(reads==1 && [preparedData isEqual:data]);
    CSMessagePreparedSend *app=[sender prepareContext:fileContext targetID:@"chat" voice:nil appData:preparedData appDataPath:path]; CHECK(app); [app submit]; CHECK([manager.calls.lastObject[0] isEqual:@"app-data"] && [manager.calls.lastObject[3] isEqual:data]); CHECK(cell.wrap.m_uiMesLocalID==42);
    cell.wrap.m_uiAppDataSize=99; CHECK(![sender prepareContext:fileContext targetID:@"chat" voice:nil appData:nil appDataPath:nil]);
    cell.wrap.m_nsAppAttachID=@"remote-attachment"; CHECK([sender prepareContext:fileContext targetID:@"chat" voice:nil appData:nil appDataPath:nil]);
    cell=Cell(987); CSMessagePreparedSend *generic=[sender prepareContext:Context(cell,controller) targetID:@"chat" voice:nil]; CHECK(generic && generic.outputWrap!=cell.wrap); CHECK([CSMessageActionObjectGetter(generic.outputWrap,NSSelectorFromString(@"m_nsContent")) isEqual:cell.wrap.m_nsContent]); [generic submit]; CHECK([manager.calls.lastObject[0] isEqual:@"add"] && cell.wrap.m_uiMesLocalID==42);
    [NSFileManager.defaultManager removeItemAtPath:path error:nil]; factoryInputs=nil;
}
// Reproduce the native numeric dedup followed by only-delete filtering. Hook bodies
// are extracted from production; unhooked independent builders return native items only.
static NSArray *NativeMenuPipeline(NSArray *items, BOOL onlyDelete) {
    NSMutableIndexSet *seen=[NSMutableIndexSet indexSet]; NSMutableArray *result=[NSMutableArray array];
    for (MMMenuItem *item in items) { if ([seen containsIndex:item.menuType]) continue; [seen addIndex:item.menuType]; if (!onlyDelete || item.menuType==8 || item.menuType==4 || item.menuType==5) [result addObject:item]; }
    return result;
}
static NSArray<NSDictionary *> *DiagnosticEvents(void) {
    NSData *data=[[CSMessageActionDiagnostics report] dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *report=[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    CHECK([report[@"schema"] isEqual:@1]);
    CHECK([report[@"events"] isKindOfClass:NSArray.class]);
    return report[@"events"];
}
static void TestDiagnostics(void) {
    CHECK(!CSMessageActionDiagnostics.isEnabled);
    [CSMessageActionDiagnostics record:@"ignored" fields:@{@"count":@1}]; CHECK(DiagnosticEvents().count==0);
    [CSMessageActionDiagnostics setEnabled:YES];
    [CSMessageActionDiagnostics record:@"schema" fields:@{@"cell":@"TestCell",@"count":@2,@"fromSelf":@YES,
        @"account":@"private-account",@"content":@"private-message",@"path":@"/private/media",@"md5":@"private-md5",@"localID":@42,@"serverID":@900,@"bytes":[NSData data]}];
    NSDictionary *event=DiagnosticEvents().lastObject;
    CHECK(event.count==5 && [event[@"cell"] isEqual:@"TestCell"] && [event[@"count"] isEqual:@2] && [event[@"fromSelf"] boolValue]);
    CHECK(![[CSMessageActionDiagnostics report] containsString:@"private-"]);
    for (NSUInteger index=0;index<200;index++) [CSMessageActionDiagnostics record:@"bounded" fields:@{@"count":@(index)}];
    NSArray *events=DiagnosticEvents(); CHECK(events.count==160);
    CHECK([events.firstObject[@"count"] isEqual:@40] && [events.lastObject[@"count"] isEqual:@199]);
    [CSMessageActionDiagnostics setEnabled:NO]; NSString *frozen=[CSMessageActionDiagnostics report];
    [CSMessageActionDiagnostics record:@"ignored" fields:@{@"count":@999}]; CHECK([[CSMessageActionDiagnostics report] isEqual:frozen]);
    [CSMessageActionDiagnostics setEnabled:YES]; CHECK(DiagnosticEvents().count==0);
    [CSMessageActionDiagnostics record:@"reset" fields:@{}]; CHECK([DiagnosticEvents().lastObject[@"sequence"] isEqual:@1]);
    [CSMessageActionDiagnostics setEnabled:NO];
}
static void TestMenuObservation(void) {
    // Execute the actual production hook bodies extracted by the build script.
    // Native results are controlled inputs here; this does not simulate phone menu rendering.
    TestMenuObservationCell *cell=[TestMenuObservationCell new]; cell.wrap=Cell(47).wrap;
    MMMenuItem *native=[[MMMenuItem alloc] initWithTitle:@"原生" target:nil action:NULL];
    MMMenuItem *repeat=[[MMMenuItem alloc] initWithTitle:@"复读" target:nil action:NSSelectorFromString(@"cs_handleRepeatMenuItem:")];
    NSArray *withRepeat=@[native,repeat], *restricted=@[native];
    for (NSNumber *enabled in @[@NO,@YES]) {
        [CSMessageActionDiagnostics setEnabled:enabled.boolValue];
        NSString *before=[CSMessageActionDiagnostics report];
        cell.generatedItems=withRepeat; CHECK([cell generateOperationMenu]==withRepeat);
        cell.nativeOutput=withRepeat; CHECK([cell uniqMenuItems:withRepeat]==withRepeat && cell.observedInput==withRepeat);
        cell.nativeOutput=restricted; CHECK([cell filteredMenuItems:withRepeat]==restricted && cell.observedInput==withRepeat);
        if (enabled.boolValue) {
            NSArray *events=DiagnosticEvents(); CHECK(events.count==5);
            CHECK([events[0][@"stage"] isEqual:@"menu.generate"] && [events[0][@"repeat"] isEqual:@1]);
            CHECK([events[3][@"stage"] isEqual:@"menu.filter.in"] && [events[3][@"repeat"] isEqual:@1]);
            CHECK([events[4][@"stage"] isEqual:@"menu.filter.out"] && [events[4][@"repeat"] isEqual:@0]);
        } else CHECK([[CSMessageActionDiagnostics report] isEqual:before]);
        cell.generatedItems=nil; CHECK([cell generateOperationMenu]==nil);
        cell.nativeOutput=nil; CHECK([cell uniqMenuItems:nil]==nil && [cell filteredMenuItems:nil]==nil);
    }
    [CSMessageActionDiagnostics setEnabled:NO];
}
static void TestNativeStickerMenu(NSUserDefaults *defaults) {
    CContactMgr *contacts=[CContactMgr new]; contacts.contact=Contact(@"me");
    CMessageMgr *manager=[CMessageMgr new];
    nativeServices=[@{@"CContactMgr":WrappedService(contacts),@"CMessageMgr":WrappedService(manager)} mutableCopy];
    CSMessageNativeEnvironment *environment=[CSMessageNativeEnvironment new];
    BaseMsgContentViewController *page=[BaseMsgContentViewController new];
    TestMessageCellDelegate *delegate=[TestMessageCellDelegate new]; delegate.controller=page;
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:environment preferences:Preferences(defaults) mediaProvider:[CSMessageMediaProvider new]];
    coordinator.feedbackHandler=^(__unused NSString *message){};
    menuHookAdapter=[[CSMessageActionMenuAdapter alloc] initWithCoordinator:coordinator];
    for (NSString *name in @[@"EmoticonMessageCellView",@"AppEmoticonMessageCellView"]) {
        TestCell *cell=[NSClassFromString(name) new];
        TestMessageViewModel *model=[TestMessageViewModel new]; model.messageWrap=Cell(47).wrap;
        model.messageWrap.m_nsEmoticonMD5=@"0123456789abcdef0123456789abcdef";
        cell.viewModel=model; // Native source is viewModel.messageWrap; no synthetic current-wrap getter result.
        NSObject *responder=[NSObject new]; cell.nextResponder=responder; // Native page is reached through the cell's delegate, not the responder chain.
        [cell setValue:delegate forKey:@"nativeDelegate"];
        MMMenuItem *native=[[MMMenuItem alloc] initWithTitle:@"原生表情菜单" target:nil action:NULL]; native.menuType=1;
        [cell setValue:@[native] forKey:@"nativeItems"];
        CHECK([environment controllerForCell:cell]==page);
        NSArray *items=NativeMenuPipeline(CSMessageActionObjectGetter(cell,@selector(operationMenuItems)),NO);
        CHECK(items.count==2 && items[0]==native);
        MMMenuItem *repeat=items.lastObject; CHECK([repeat.title isEqual:@"复读"]);
        NSUInteger calls=manager.calls.count;
        CSMessageNativeInvoke(repeat.target,NSStringFromSelector(repeat.action),@[NSNull.null]);
        CHECK(Wait(^BOOL{ return manager.calls.count==calls+1; }));
        CHECK([manager.calls.lastObject[0] isEqual:@"emoji"]);
        CHECK(manager.calls.lastObject[2]!=model.messageWrap && model.messageWrap.m_uiMesLocalID==42);
        NSObject *unrelated=[NSObject new]; delegate.controller=unrelated; CHECK(![environment controllerForCell:cell]);
        cell.nextResponder=page; CHECK([environment controllerForCell:cell]==page);
        delegate.controller=nil; CHECK([environment controllerForCell:cell]==page);
        delegate.controller=page;
    }
    for (Class cellClass in @[TestWrongControllerCell.class,TestThrowingControllerCell.class]) {
        TestCell *cell=[cellClass new]; CHECK(![environment controllerForCell:cell]);
        cell.nextResponder=page; CHECK([environment controllerForCell:cell]==page);
    }
    menuHookAdapter=nil; nativeServices=nil;
}
static void TestGameMenu(NSUserDefaults *defaults) {
    TestEnvironment *environment=[TestEnvironment new]; TestController *page=[TestController new]; environment.controller=page;
    TestManager *manager=[TestManager new]; environment.services[@"CMessageMgr"]=manager;
    CSMessageActionPreferences *preferences=Preferences(defaults);
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:environment preferences:preferences mediaProvider:[CSMessageMediaProvider new]];
    coordinator.feedbackHandler=^(__unused NSString *message){};
    menuHookAdapter=[[CSMessageActionMenuAdapter alloc] initWithCoordinator:coordinator];
    for (unsigned int gameType=1;gameType<=2;gameType++) {
        GameMessageCellView *cell=[GameMessageCellView new];
        TestMessageViewModel *model=[TestMessageViewModel new]; model.messageWrap=Cell(47).wrap; cell.viewModel=model;
        CMessageWrap *source=model.messageWrap; source.m_uiGameType=gameType; source.m_uiGameContent=gameType==1 ? 3 : 6;
        source.m_nsEmoticonMD5=@"0123456789abcdef0123456789abcdef";
        MMMenuItem *forward=[[MMMenuItem alloc] initWithTitle:@"转发" target:nil action:NULL]; forward.menuType=1;
        MMMenuItem *delete=[[MMMenuItem alloc] initWithTitle:@"删除" target:nil action:NULL]; delete.menuType=8;
        cell.nativeItems=@[forward,delete];
        NSArray *items=NativeMenuPipeline([cell operationMenuItems],NO);
        CHECK(items.count==3 && items[0]==forward && items[1]==delete);
        CHECK([menuHookAdapter itemsByAddingActionsForCell:cell items:items]==items);
        CHECK([NativeMenuPipeline(items,YES) isEqual:@[delete]]);
        MMMenuItem *repeat=items.lastObject; CHECK([repeat.title isEqual:@"复读"]);
        NSUInteger count=manager.calls.count;
        CSMessageNativeInvoke(repeat.target,NSStringFromSelector(repeat.action),@[NSNull.null]);
        CHECK(Wait(^BOOL{ return manager.calls.count==count+1; }));
        CMessageWrap *sent=manager.calls.lastObject[2];
        CHECK([manager.calls.lastObject[0] isEqual:@"emoji"] && sent!=source);
        CHECK(sent.m_uiGameType==source.m_uiGameType && sent.m_uiGameContent==source.m_uiGameContent);
        CHECK([sent.m_nsEmoticonMD5 isEqual:source.m_nsEmoticonMD5]);
        CHECK(source.m_uiMesLocalID==42 && source.m_n64MesSvrID==900 && [source.m_nsFromUsr isEqual:@"chat"]);
        model.messageWrap=Cell(47).wrap; model.messageWrap.m_uiMesLocalID=123; model.messageWrap.m_n64MesSvrID=901;
        CSMessageNativeInvoke(repeat.target,NSStringFromSelector(repeat.action),@[NSNull.null]); Drain(); CHECK(manager.calls.count==count+1);
    }
    [defaults setBool:NO forKey:CSMessageActionRepeatEnabledKey]; [preferences requestRefresh]; CHECK(Wait(^BOOL{ return !preferences.snapshot.repeatEnabled; }));
    GameMessageCellView *disabled=[GameMessageCellView new]; disabled.wrap=Cell(47).wrap; disabled.nativeItems=@[];
    CHECK([disabled operationMenuItems]==disabled.nativeItems);
    menuHookAdapter=nil;
}
static void TestNativeActionFastPath(NSUserDefaults *defaults) {
    TestEnvironment *environment=[TestEnvironment new]; TestController *controller=[TestController new]; environment.controller=controller;
    HeldMedia *media=[HeldMedia new]; CSMessageActionPreferences *preferences=Preferences(defaults);
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:environment preferences:preferences mediaProvider:media];
    NSMutableArray *feedback=[NSMutableArray array]; coordinator.feedbackHandler=^(NSString *message){ [feedback addObject:message]; };
    TestCell *voice=Cell(34); CSMessageActionContext *voiceContext=Context(voice,controller);
    for (NSUInteger i=0;i<32;i++) CHECK([coordinator executeContext:voiceContext action:CSMessageActionRepeat entry:CSMessageActionEntryGesture]);
    TestCell *cell=Cell(1); CSMessageActionContext *context=Context(cell,controller);
    [coordinator executeContext:context action:CSMessageActionQuote entry:CSMessageActionEntryGesture];
    CHECK(controller.calls.count==1 && [controller.calls[0][0] isEqual:@"quote"]);
    [coordinator executeContext:context action:CSMessageActionFavorite entry:CSMessageActionEntryGesture]; CHECK(cell.favoriteCalls==1);
    __block NSUInteger forwards=0; TestLogic *logic=[TestLogic new];
    __weak CSMessageActionCoordinator *weakCoordinator=coordinator; __weak TestCell *weakCell=cell;
    cell.forwardHandler=^{ forwards++; [weakCoordinator bindForwardLogic:logic source:weakCell.wrap]; };
    [coordinator executeContext:context action:CSMessageActionForward entry:CSMessageActionEntryGesture];
    CHECK(forwards==1 && ![[CSVoiceForwardAdapter new] bindingForLogic:logic]);
    CHECK(media.callbacks.count==32 && feedback.count==0);
    [coordinator withForwardContext:context entry:CSMessageActionEntryNativeForward perform:^{ forwards++; }];
    CHECK(forwards==2 && feedback.count==0);
    [defaults setBool:NO forKey:CSMessageActionVoiceForwardEnabledKey]; [preferences requestRefresh]; CHECK(Wait(^BOOL{ return !preferences.snapshot.voiceForwardEnabled; }));
    voice.forwardHandler=^{ forwards++; };
    [coordinator executeContext:voiceContext action:CSMessageActionForward entry:CSMessageActionEntryGesture];
    [coordinator withForwardContext:voiceContext entry:CSMessageActionEntryNativeForward perform:^{ forwards++; }];
    CHECK(forwards==4 && media.callbacks.count==32 && feedback.count==0);
    [coordinator executeContext:context action:CSMessageActionDelete entry:CSMessageActionEntryGesture]; CHECK(controller.confirmation);
    controller.confirmation(); controller.confirmation(); CHECK(controller.calls.count==2);
    [coordinator executeContext:context action:CSMessageActionDelete entry:CSMessageActionEntryGesture];
    [coordinator cancelOperationsForCell:cell]; controller.confirmation(); CHECK(controller.calls.count==2);
    [coordinator executeContext:context action:CSMessageActionDelete entry:CSMessageActionEntryGesture];
    [defaults setBool:NO forKey:CSMessageActionGestureEnabledKey]; [preferences requestRefresh]; CHECK(Wait(^BOOL{ return !preferences.snapshot.gestureEnabled; }));
    [defaults setBool:YES forKey:CSMessageActionGestureEnabledKey]; [preferences requestRefresh]; CHECK(Wait(^BOOL{ return preferences.snapshot.gestureEnabled; }));
    controller.confirmation(); CHECK(controller.calls.count==2); // Disable then re-enable never revives an old confirmation.
    [coordinator executeContext:context action:CSMessageActionDelete entry:CSMessageActionEntryGesture];
    CMessageWrap *original=cell.wrap; cell.wrap=Cell(1).wrap; cell.wrap.m_uiMesLocalID=123; cell.wrap.m_n64MesSvrID=456;
    controller.confirmation(); CHECK(controller.calls.count==2); cell.wrap=original;
    cell.wrap.m_nsFromUsr=@"me"; cell.wrap.m_nsToUsr=@"chat"; cell.revokeAllowed=YES;
    CSMessageActionContext *outgoing=Context(cell,controller);
    [coordinator executeContext:outgoing action:CSMessageActionRevoke entry:CSMessageActionEntryGesture];
    cell.revokeAllowed=NO; controller.confirmation(); CHECK(controller.calls.count==2);
    cell.wrap.m_nsFromUsr=@"chat"; cell.wrap.m_nsToUsr=@"me";
    [coordinator executeContext:context action:CSMessageActionDelete entry:CSMessageActionEntryGesture];
    [coordinator accountWillChange]; [coordinator accountDidChange]; controller.confirmation(); CHECK(controller.calls.count==2);
    NSString *noOperation=nil; CHECK(![coordinator resultsForOperationID:noOperation].count); [coordinator cancelOperationID:noOperation];
    controller.confirmation=nil; [coordinator cancelAllUnsubmittedOperations];
}
static void TestMenuNoOp(NSUserDefaults *defaults) {
    TestEnvironment *environment=[TestEnvironment new]; TestController *controller=[TestController new]; environment.controller=controller;
    CSMessageActionPreferences *preferences=Preferences(defaults);
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:environment preferences:preferences mediaProvider:[CSMessageMediaProvider new]];
    CSMessageActionMenuAdapter *menu=[[CSMessageActionMenuAdapter alloc] initWithCoordinator:coordinator];
    TestCell *cell=Cell(1); MMMenuItem *native=[[MMMenuItem alloc] initWithTitle:@"native" target:nil action:NULL];
    NSArray *original=@[native], *withRepeat=[menu itemsByAddingActionsForCell:cell items:original]; CHECK(withRepeat.count==2);
    CHECK([menu itemsByAddingActionsForCell:cell items:withRepeat]==withRepeat);
    [defaults setBool:NO forKey:CSMessageActionRepeatEnabledKey]; [defaults setBool:NO forKey:CSMessageActionVoiceForwardEnabledKey];
    [preferences requestRefresh]; CHECK(Wait(^BOOL{ return !preferences.snapshot.repeatEnabled && !preferences.snapshot.voiceForwardEnabled; }));
    NSUInteger reads=environment.accountReads, lookups=environment.controllerLookups;
    CHECK([menu itemsByAddingActionsForCell:cell items:original]==original);
    NSArray *removed=[menu itemsByAddingActionsForCell:cell items:withRepeat]; CHECK(removed.count==1 && removed[0]==native);
    CHECK(environment.accountReads==reads && environment.controllerLookups==lookups);
    [defaults setBool:YES forKey:CSMessageActionVoiceForwardEnabledKey]; [preferences requestRefresh]; CHECK(Wait(^BOOL{ return preferences.snapshot.voiceForwardEnabled; }));
    CHECK([menu itemsByAddingActionsForCell:cell items:original]==original);
    CHECK(environment.accountReads==reads && environment.controllerLookups==lookups);
}
static void TestNativeMenuPipeline(NSUserDefaults *defaults) {
    TestEnvironment *env=[TestEnvironment new]; TestController *controller=[TestController new]; env.controller=controller;
    CSMessageActionPreferences *preferences=Preferences(defaults);
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:env preferences:preferences mediaProvider:[CSMessageMediaProvider new]];
    menuHookAdapter=[[CSMessageActionMenuAdapter alloc] initWithCoordinator:coordinator];
    NSArray *classes=@[@"EmoticonMessageCellView",@"AppEmoticonMessageCellView",@"VoiceMessageCellView",@"AppFileMessageCellView",@"ShareCardMessageCellView"];
    NSArray *types=@[@47,@47,@34,@49,@42];
    for (NSUInteger i=0;i<classes.count;i++) {
        TestCell *cell=[NSClassFromString(classes[i]) new]; cell.wrap=Cell([types[i] unsignedIntValue]).wrap;
        MMMenuItem *host=[[MMMenuItem alloc] initWithTitle:@"native" target:nil action:NULL]; host.menuType=0;
        MMMenuItem *other=[[MMMenuItem alloc] initWithTitle:@"other-plugin" target:nil action:NULL]; other.menuType=0x43535001;
        [cell setValue:@[host,other] forKey:@"nativeItems"];
        NSArray *items=CSMessageActionObjectGetter(cell,@selector(operationMenuItems)); NSArray *shown=NativeMenuPipeline(items,NO);
        CHECK(shown.count==(i==2 ? 4 : 3)); CHECK(shown[0]==host && shown[1]==other);
        CHECK(NativeMenuPipeline(items,YES).count==0); // Respect native restricted menus.
        CHECK([menuHookAdapter itemsByAddingActionsForCell:cell items:items].count==items.count);
    }
    [defaults setBool:NO forKey:CSMessageActionRepeatEnabledKey]; [preferences requestRefresh]; CHECK(Wait(^BOOL{ return !preferences.snapshot.repeatEnabled; }));
    VoiceMessageCellView *voice=[VoiceMessageCellView new]; voice.wrap=Cell(34).wrap; voice.nativeItems=@[];
    NSArray *shown=NativeMenuPipeline([voice operationMenuItems],NO); CHECK(shown.count==1 && [((MMMenuItem *)shown[0]).title isEqual:@"语音转发"]);
    menuHookAdapter=nil;
}
static void TestMenuSnapshots(NSUserDefaults *defaults) {
    TestEnvironment *env=[TestEnvironment new]; TestController *controller=[TestController new]; env.controller=controller;
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:env preferences:Preferences(defaults) mediaProvider:[CSMessageMediaProvider new]];
    coordinator.feedbackHandler=^(__unused NSString *message){};
    CSMessageActionMenuAdapter *menu=[[CSMessageActionMenuAdapter alloc] initWithCoordinator:coordinator]; TestCell *cell=Cell(1);
    NSObject *hostItem=[NSObject new]; NSArray *items=[menu itemsByAddingActionsForCell:cell items:@[hostItem]]; CHECK(items.count==2 && items[0]==hostItem); MMMenuItem *repeat=items.lastObject; CHECK([repeat.title isEqual:@"复读"]); CHECK([menu canPerformSelector:repeat.action cell:cell]); CHECK([menu itemsByAddingActionsForCell:cell items:items].count==2);
    // Retain old item, rebuild a menu on a reused cell, then click OLD target. The production target
    // owns its original snapshot and must not send either the replacement or historical message.
    cell.wrap=Cell(1).wrap; cell.wrap.m_uiMesLocalID=123; cell.wrap.m_n64MesSvrID=456; [menu itemsByAddingActionsForCell:cell items:@[]];
    CSMessageNativeInvoke(repeat.target,NSStringFromSelector(repeat.action),@[NSNull.null]); Drain(); CHECK(!controller.calls.count);
    TestCell *voice=Cell(34); NSArray *voiceItems=[menu itemsByAddingActionsForCell:voice items:@[]]; CHECK(voiceItems.count==2); CHECK([((MMMenuItem *)voiceItems[0]).title isEqual:@"语音转发"] && [((MMMenuItem *)voiceItems[1]).title isEqual:@"复读"]);
    TestCell *card=Cell(42); CHECK([menu itemsByAddingActionsForCell:card items:@[]].count==1); CHECK([coordinator canExecuteContext:[coordinator captureContextForCell:card controller:controller bindingGeneration:1] action:CSMessageActionRepeat entry:CSMessageActionEntryGesture]);
}
static void TestCoordinator(NSUserDefaults *defaults) {
    TestEnvironment *env=[TestEnvironment new]; TestController *controller=[TestController new]; env.controller=controller;
    HeldMedia *media=[HeldMedia new]; RecordingSender *sender=[[RecordingSender alloc] initWithEnvironment:env]; CSMessageActionPreferences *preferences=Preferences(defaults);
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:env preferences:preferences mediaProvider:media sendAdapter:sender nativeAdapter:[CSMessageNativeActionAdapter new]];
    NSMutableArray *feedback=[NSMutableArray array]; coordinator.feedbackHandler=^(NSString *message){ [feedback addObject:message]; };
    TestCell *cell=Cell(34); CSMessageActionContext *context=[coordinator captureContextForCell:cell controller:controller bindingGeneration:7]; CHECK(context);
    TestLogic *logicA=[TestLogic new],*logicB=[TestLogic new]; logicA.targets=@[Contact(@"A"),Contact(@"B"),Contact(@"A")]; logicB.targets=@[Contact(@"Z")];
    [coordinator withForwardContext:context entry:CSMessageActionEntryNativeForward perform:^{ [coordinator bindForwardLogic:logicA source:cell.wrap]; }];
    CSMessageForwardBinding *binding=[[CSVoiceForwardAdapter new] bindingForLogic:logicA]; NSString *identifier=binding.operationID; CHECK(identifier.length);
    [coordinator confirmForwardLogic:logicA]; CHECK([coordinator resultsForOperationID:identifier].count==2);
    CHECK(![coordinator handleForwardLogic:logicB source:cell.wrap target:logicB.targets[0]]); CHECK(!sender.calls.count);
    CHECK([coordinator handleForwardLogic:logicA source:cell.wrap target:Contact(@"Z")]); CHECK(!sender.calls.count);
    CHECK([coordinator handleForwardLogic:logicA source:cell.wrap target:Contact(@"A")]); CHECK([coordinator handleForwardLogic:logicA source:cell.wrap target:Contact(@"B")]);
    [media finish:identifier]; CHECK(sender.calls.count==2); NSDictionary *results=[coordinator resultsForOperationID:identifier]; CHECK([results[@"A"] integerValue]==CSMessageActionSubmissionStateAccepted && [results[@"B"] integerValue]==CSMessageActionSubmissionStateFailedBeforeAcceptance);
    CHECK([coordinator handleForwardLogic:logicA source:cell.wrap target:Contact(@"A")]); [media finish:identifier]; CHECK(sender.calls.count==2); CHECK(feedback.count==1); [coordinator finishForwardLogic:logicA cancelled:NO]; CHECK([[CSVoiceForwardAdapter new] bindingForLogic:logicA].closed); CHECK(![[CSVoiceForwardAdapter new] bindingForLogic:logicA].context); CHECK([coordinator handleForwardLogic:logicA source:cell.wrap target:Contact(@"A")]); CHECK(sender.calls.count==2); CHECK([coordinator resultsForOperationID:identifier].count==2);
    // Opening through the public facade and binding native logic share one operation ID.
    TestLogic *facadeLogic=[TestLogic new]; facadeLogic.targets=@[Contact(@"A")];
    __weak TestCell *weakCell=cell; __weak CSMessageActionCoordinator *weakCoordinator=coordinator;
    cell.forwardHandler=^{ [weakCoordinator bindForwardLogic:facadeLogic source:weakCell.wrap]; };
    NSString *facadeID=[coordinator executeContext:context action:CSMessageActionForward entry:CSMessageActionEntryGesture];
    CHECK([facadeID isEqual:[[CSVoiceForwardAdapter new] bindingForLogic:facadeLogic].operationID]);
    [coordinator finishForwardLogic:facadeLogic cancelled:YES]; [media finish:facadeID]; CHECK(sender.calls.count==2); cell.forwardHandler=nil;
    TestCell *different=Cell(34); different.wrap.m_uiMesLocalID=555; different.wrap.m_n64MesSvrID=9999;
    CHECK(![coordinator handleForwardLogic:logicA source:different.wrap target:Contact(@"A")]);
    // Cancel before media readiness, then inject the retained late callback. No submit.
    NSString *cancelled=[coordinator executeContext:context action:CSMessageActionRepeat entry:CSMessageActionEntryGesture]; CHECK(cancelled); [coordinator cancelOperationID:cancelled]; [media finish:cancelled]; CHECK(sender.calls.count==2); CHECK([[coordinator resultsForOperationID:cancelled][@"chat"] integerValue]==CSMessageActionSubmissionStateCancelled);
    NSString *oldAccount=[coordinator executeContext:context action:CSMessageActionRepeat entry:CSMessageActionEntryGesture]; CHECK(oldAccount); env.account=@"other"; [coordinator accountDidChange]; [media finish:oldAccount]; CHECK(sender.calls.count==2); CHECK(![coordinator validateContext:context]); env.account=@"me"; [coordinator accountDidChange]; CHECK(![coordinator validateContext:context]);
    [coordinator accountWillChange]; CHECK(![coordinator captureContextForCell:cell controller:controller bindingGeneration:8]); CHECK(![coordinator validateContext:context]);
    [coordinator accountDidChange];
    context=[coordinator captureContextForCell:cell controller:controller bindingGeneration:8]; TestLogic *disabled=[TestLogic new]; disabled.targets=@[Contact(@"A")];
    [coordinator withForwardContext:context entry:CSMessageActionEntryNativeForward perform:^{ [coordinator bindForwardLogic:disabled source:cell.wrap]; }];
    NSString *disabledID=[[CSVoiceForwardAdapter new] bindingForLogic:disabled].operationID; [coordinator confirmForwardLogic:disabled]; [defaults setBool:NO forKey:CSMessageActionVoiceForwardEnabledKey]; [preferences requestRefresh]; CHECK(Wait(^BOOL{ return !coordinator.settings.voiceForwardEnabled; }));
    [media finish:disabledID]; CHECK(sender.calls.count==2); CHECK([coordinator handleForwardLogic:disabled source:cell.wrap target:Contact(@"A")]); [coordinator finishForwardLogic:disabled cancelled:YES]; CHECK([[CSVoiceForwardAdapter new] bindingForLogic:disabled].closed); CHECK(![[CSVoiceForwardAdapter new] bindingForLogic:disabled].context);
    // Weak page lifetime is not extended by a captured source context.
    __weak TestController *weakController=nil; CSMessageActionContext *weakContext=nil;
    @autoreleasepool { TestController *temporary=[TestController new]; weakController=temporary; weakContext=[coordinator captureContextForCell:cell controller:temporary bindingGeneration:9]; }
    CHECK(!weakController && !weakContext.controller); CHECK(![coordinator validateContext:weakContext]);
    // A stale cell binding is rejected before native confirmation.
    cell.wrap=Cell(34).wrap; cell.wrap.m_uiMesLocalID=99; cell.wrap.m_n64MesSvrID=999; CHECK(![coordinator validateContext:context]);
}
static void TestForwardCleanupWhileWaiting(NSUserDefaults *defaults) {
    TestEnvironment *env=[TestEnvironment new]; TestController *controller=[TestController new]; env.controller=controller;
    HeldMedia *media=[HeldMedia new]; RecordingSender *sender=[[RecordingSender alloc] initWithEnvironment:env];
    CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:env preferences:Preferences(defaults) mediaProvider:media sendAdapter:sender nativeAdapter:[CSMessageNativeActionAdapter new]];
    coordinator.feedbackHandler=^(__unused NSString *message){};
    TestCell *cell=Cell(34); CSMessageActionContext *context=[coordinator captureContextForCell:cell controller:nil bindingGeneration:1];
    TestLogic *logic=[TestLogic new]; logic.targets=@[Contact(@"A")];
    [coordinator withForwardContext:context entry:CSMessageActionEntryNativeForward perform:^{ [coordinator bindForwardLogic:logic source:cell.wrap]; }];
    NSString *identifier=[[CSVoiceForwardAdapter new] bindingForLogic:logic].operationID;
    [coordinator confirmForwardLogic:logic]; CHECK([coordinator handleForwardLogic:logic source:cell.wrap target:logic.targets[0]]);
    CHECK(!sender.calls.count);
    forwardHookCoordinator=coordinator; forwardNativeClearCalls=0;
    CHECK(![logic bShowSendSuccessView] && [logic bHiddenSendSuccessToastView]);
    TestLogic *unbound=[TestLogic new]; CHECK([unbound bShowSendSuccessView] && ![unbound bHiddenSendSuccessToastView]);
    TestForwardManager *manager=[TestForwardManager new]; manager.originalCalls=[NSMutableArray array];
    [manager OnForwardMessageSend:logic]; // Extracted hook %orig synchronously invokes extracted clearData.
    CHECK(manager.originalCalls.count==1 && forwardNativeClearCalls==1);
    CHECK(![logic bShowSendSuccessView] && [logic bHiddenSendSuccessToastView]);
    [media finish:identifier];
    CHECK(sender.calls.count==1);
    CHECK([[coordinator resultsForOperationID:identifier][@"A"] integerValue]==CSMessageActionSubmissionStateAccepted);
    CHECK([coordinator handleForwardLogic:logic source:cell.wrap target:Contact(@"A")]);
    [media finish:identifier]; CHECK(sender.calls.count==1);
    // A genuine picker cancellation still wins, even if late completion arrives.
    TestLogic *cancelled=[TestLogic new]; cancelled.targets=@[Contact(@"A")];
    [coordinator withForwardContext:context entry:CSMessageActionEntryNativeForward perform:^{ [coordinator bindForwardLogic:cancelled source:cell.wrap]; }];
    NSString *cancelID=[[CSVoiceForwardAdapter new] bindingForLogic:cancelled].operationID;
    [coordinator confirmForwardLogic:cancelled]; CHECK([coordinator handleForwardLogic:cancelled source:cell.wrap target:cancelled.targets[0]]);
    [manager OnForwardMessageCancel:cancelled]; [manager OnForwardMessageSend:cancelled];
    CHECK(manager.originalCalls.count==3 && forwardNativeClearCalls==3);
    [media finish:cancelID]; CHECK(sender.calls.count==1);
    CHECK([[coordinator resultsForOperationID:cancelID][@"A"] integerValue]==CSMessageActionSubmissionStateCancelled);
    [coordinator bindForwardLogic:logic source:Cell(3).wrap]; // Native logic reused by unrelated forwarding.
    CHECK([logic bShowSendSuccessView] && ![logic bHiddenSendSuccessToastView]);
    forwardHookCoordinator=nil;
}
// Synthetic bytes and calculator doubles test routing/ABI, not real codec decoding.
static NSData *expectedCodecBytes;
static unsigned int codecMilliseconds=1000;
static NSUInteger silkCalculatorCalls,opusCalculatorCalls,lengthCalculatorCalls;
@interface AudioUtil : NSObject
@end
@implementation AudioUtil
+ (unsigned int)calcVoiceTime:(unsigned int)length VoiceFormat:(unsigned int)format { CHECK(!NSThread.isMainThread); lengthCalculatorCalls++; return format==0 ? ((length/2)/7)*20 : 0; }
+ (unsigned int)calcSilkVoiceTime:(NSData *)data { CHECK(!NSThread.isMainThread && [data isEqual:expectedCodecBytes]); silkCalculatorCalls++; return codecMilliseconds; }
@end
@interface OpusAudioPlayer : NSObject
@end
@implementation OpusAudioPlayer
+ (unsigned int)calculateVoiceTime:(NSData *)data { CHECK(!NSThread.isMainThread && [data isEqual:expectedCodecBytes]); opusCalculatorCalls++; return codecMilliseconds; }
@end
static NSData *CodecBytes(unsigned int format) {
    NSMutableData *data=[NSMutableData data];
    if (format==4) { unsigned char prefix=2; [data appendBytes:&prefix length:1]; [data appendData:[@"#!SILK_V3" dataUsingEncoding:NSUTF8StringEncoding]]; }
    else [data appendData:[@"#!OPUS_RAW_V1" dataUsingEncoding:NSUTF8StringEncoding]];
    [data increaseLengthBy:32]; return data;
}
static void TestVoiceNativeConstructorFlows(NSUserDefaults *defaults) {
    for (NSNumber *outgoing in @[@NO,@YES]) for (NSNumber *forward in @[@NO,@YES]) for (NSUInteger formatCase=0;formatCase<4;formatCase++) {
        unsigned int codec=formatCase%2==0 ? 4 : 7,declared=formatCase<2 ? codec : UINT_MAX;
        silkCalculatorCalls=opusCalculatorCalls=lengthCalculatorCalls=0; codecMilliseconds=1000; expectedCodecBytes=CodecBytes(codec);
        TestEnvironment *env=[TestEnvironment new]; TestController *page=[TestController new]; env.controller=page;
        TestManager *manager=[TestManager new]; TestAudio *audio=[TestAudio new]; audio.uploader=[TestUploader new];
        env.services[@"CMessageMgr"]=manager; env.services[@"AudioSender"]=audio;
        TestCell *cell=Cell(34); cell.wrap.m_uiVoiceTime=1000; cell.wrap.m_uiVoiceFormat=declared;
        cell.wrap.m_dtVoice=expectedCodecBytes; cell.wrap.m_uiDownloadStatus=outgoing.boolValue ? 9 : 1;
        if (outgoing.boolValue) { cell.wrap.m_nsFromUsr=@"me"; cell.wrap.m_nsToUsr=@"chat"; }
        NSString *content=[NSString stringWithFormat:@"<voicemsg voicelength='1000' length='%lu' endflag='1'/>",(unsigned long)expectedCodecBytes.length]; cell.wrap.m_nsContent=content;
        CHECK(CSMessageNativeSupports(cell.wrap,@"initWithMsgType:",@"@",@[@"q"]));
        CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:env preferences:Preferences(defaults) mediaProvider:[CSMessageMediaProvider new]];
        coordinator.feedbackHandler=^(__unused NSString *message){};
        CSMessageActionContext *context=[coordinator captureContextForCell:cell controller:page bindingGeneration:1]; CHECK(context && context.outgoing==outgoing.boolValue);
        NSString *operation=nil; TestLogic *logic=[TestLogic new]; logic.targets=@[Contact(@"A"),Contact(@"B"),Contact(@"A")];
        if (forward.boolValue) {
            [coordinator withForwardContext:context entry:CSMessageActionEntryMenuVoiceForward perform:^{ [coordinator bindForwardLogic:logic source:cell.wrap]; }];
            operation=[[CSVoiceForwardAdapter new] bindingForLogic:logic].operationID;
            [coordinator confirmForwardLogic:logic];
            for (TestContact *target in logic.targets) CHECK([coordinator handleForwardLogic:logic source:cell.wrap target:target]);
        } else operation=[coordinator executeContext:context action:CSMessageActionRepeat entry:CSMessageActionEntryMenuRepeat];
        NSUInteger expected=forward.boolValue ? 2 : 1; CHECK(operation.length);
        CHECK(Wait(^BOOL{ return audio.uploader.calls.count==expected; })); CHECK(manager.calls.count==expected && audio.unsafeCalls==0);
        CHECK(silkCalculatorCalls==(codec==4 ? 1 : 0) && opusCalculatorCalls==(codec==7 ? 1 : 0) && lengthCalculatorCalls==0);
        NSMutableSet *recipients=[NSMutableSet set];
        for (NSUInteger index=0;index<expected;index++) {
            CMessageWrap *sent=manager.calls[index][2]; CHECK(sent!=cell.wrap && sent==audio.uploader.calls[index][1]);
            CHECK(sent.m_uiVoiceTime==1000 && sent.m_uiVoiceFormat==codec && [sent.m_dtVoice isEqual:expectedCodecBytes]);
            CHECK(sent.m_uiMesLocalID!=0 && sent.m_n64MesSvrID==0 && [sent.m_nsFromUsr isEqual:@"me"]);
            CHECK([manager.calls[index][1] isEqual:sent.m_nsToUsr]); [recipients addObject:sent.m_nsToUsr];
            CHECK([[coordinator resultsForOperationID:operation][sent.m_nsToUsr] integerValue]==CSMessageActionSubmissionStateUnknown);
        }
        CHECK(([recipients isEqual:[NSSet setWithArray:forward.boolValue ? @[@"A",@"B"] : @[@"chat"]]]));
        if (forward.boolValue) {
            CHECK(manager.calls[0][2]!=manager.calls[1][2]);
            CHECK([coordinator handleForwardLogic:logic source:cell.wrap target:Contact(@"A")]);
            [coordinator finishForwardLogic:logic cancelled:NO]; CHECK(audio.uploader.calls.count==2);
        }
        CHECK(cell.wrap.m_uiMesLocalID==42 && cell.wrap.m_n64MesSvrID==900 && [cell.wrap.m_nsContent isEqual:content]);
        CHECK(cell.wrap.m_uiVoiceFormat==declared && [cell.wrap.m_dtVoice isEqual:expectedCodecBytes]);
        CHECK([cell.wrap.m_nsFromUsr isEqual:outgoing.boolValue ? @"me" : @"chat"] && [cell.wrap.m_nsToUsr isEqual:outgoing.boolValue ? @"chat" : @"me"]);
    }
    expectedCodecBytes=nil;
}
static void TestVoiceFailureFeedback(NSUserDefaults *defaults) {
    for (NSUInteger scenario=0;scenario<3;scenario++) {
        TestEnvironment *env=[TestEnvironment new]; TestController *page=[TestController new]; env.controller=page;
        TestManager *manager=[TestManager new]; TestAudio *audio=[TestAudio new]; audio.uploader=scenario==2 ? nil : [TestUploader new];
        env.services[@"CMessageMgr"]=manager; env.services[@"AudioSender"]=audio;
        TestCell *cell=Cell(34); cell.wrap.m_uiVoiceTime=1000; cell.wrap.m_uiVoiceFormat=scenario==0 ? 4 : 0; cell.wrap.m_uiDownloadStatus=1;
        expectedCodecBytes=CodecBytes(4); codecMilliseconds=900;
        cell.wrap.m_dtVoice=scenario==0 ? expectedCodecBytes : [NSMutableData dataWithLength:scenario==1 ? 14 : 700];
        CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:env preferences:Preferences(defaults) mediaProvider:[CSMessageMediaProvider new]];
        __block NSString *feedback=nil; coordinator.feedbackHandler=^(NSString *message){ feedback=message; };
        NSString *operation=[coordinator executeContext:[coordinator captureContextForCell:cell controller:page bindingGeneration:1] action:CSMessageActionRepeat entry:CSMessageActionEntryMenuRepeat]; CHECK(operation);
        CHECK(Wait(^BOOL{ return feedback!=nil; }));
        CHECK([feedback containsString:scenario==2 ? @"语音发送准备失败" : @"语音读取或校验失败"]);
        CHECK([[coordinator resultsForOperationID:operation][@"chat"] integerValue]==CSMessageActionSubmissionStateFailedBeforeAcceptance);
        CHECK(manager.calls.count==0 && audio.uploader.calls.count==0);
    }
    expectedCodecBytes=nil; codecMilliseconds=1000;
}
static void TestNativeVoiceStatuses(void) {
    TestController *controller=[TestController new];
    for (NSNumber *outgoing in @[@NO,@YES]) for (NSNumber *status in outgoing.boolValue ? @[@9,@13,@25,@29] : @[@1,@5,@17,@21]) {
        TestCell *cell=Cell(34); if (outgoing.boolValue) { cell.wrap.m_nsFromUsr=@"me"; cell.wrap.m_nsToUsr=@"chat"; }
        cell.wrap.m_uiDownloadStatus=status.unsignedIntValue; cell.wrap.m_uiVoiceTime=1000; cell.wrap.m_uiVoiceFormat=0; cell.wrap.m_dtVoice=[NSMutableData dataWithLength:700];
        cell.wrap.m_nsContent=@"<msg><voicemsg voicelength='1000' voiceformat='0' forwardflag='0' /></msg>";
        CSMessageMediaProvider *provider=[CSMessageMediaProvider new]; __block NSUInteger downloads=0; __block BOOL done=NO,accepted=NO;
        provider.requestDownload=^(__unused CSMessageActionContext *context){ downloads++; return YES; };
        [provider prepareVoiceForContext:Context(cell,controller) operationID:@"native-local" completion:^(CSMessageVoiceResource *resource){ done=YES; accepted=resource!=nil; }];
        CHECK(Wait(^BOOL{ return done; })); CHECK(accepted && downloads==0);
    }
    for (NSNumber *status in @[@1,@5,@17,@9,@13]) {
        TestCell *cell=Cell(34); cell.wrap.m_nsFromUsr=@"me"; cell.wrap.m_nsToUsr=@"chat"; cell.wrap.m_uiDownloadStatus=status.unsignedIntValue;
        cell.wrap.m_uiVoiceTime=1000; cell.wrap.m_uiVoiceFormat=0; cell.wrap.m_dtVoice=[NSMutableData dataWithLength:14]; cell.wrap.m_nsContent=@"<voicemsg voicelength='1000' voiceformat='0'/>";
        CSMessageMediaProvider *provider=[CSMessageMediaProvider new]; __block BOOL done=NO; __block NSUInteger downloads=0;
        provider.requestDownload=^(__unused CSMessageActionContext *context){ downloads++; return YES; };
        [provider prepareVoiceForContext:Context(cell,controller) operationID:@"invalid-local" completion:^(CSMessageVoiceResource *resource){ CHECK(!resource); done=YES; }];
        CHECK(Wait(^BOOL{ return done; })); CHECK(downloads==0);
    }
}
static void TestVoiceInvalidBytes(void) {
    TestController *controller=[TestController new];
    for (NSUInteger scenario=0;scenario<6;scenario++) {
        TestCell *cell=Cell(34); cell.wrap.m_uiDownloadStatus=5; cell.wrap.m_uiVoiceTime=1000; cell.wrap.m_uiVoiceFormat=scenario==0 ? 999 : 0;
        cell.wrap.m_dtVoice=scenario==1 ? nil : [NSMutableData dataWithLength:700];
        cell.wrap.m_uiVoiceCancelFlag=scenario==5 ? 1 : 0;
        cell.wrap.m_nsContent=scenario==2 ? @"<voicemsg length='701'/>" : @"<voicemsg length='700'/>";
        NSString *path=[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString];
        if (scenario>=3) { [cell.wrap.m_dtVoice writeToFile:path atomically:YES]; cell.wrap.path=path; cell.wrap.m_dtVoice=nil; }
        CSMessageMediaProvider *provider=[[CSMessageMediaProvider alloc] initWithReader:^NSData *(NSString *file){
            NSData *data=[NSData dataWithContentsOfFile:file];
            if (scenario==3) [[NSMutableData dataWithLength:701] writeToFile:file atomically:YES];
            return scenario==4 ? [data subdataWithRange:NSMakeRange(0,699)] : data;
        }];
        __block NSUInteger downloads=0; __block BOOL done=NO;
        provider.requestDownload=^(__unused CSMessageActionContext *context){ downloads++; return YES; };
        [provider prepareVoiceForContext:Context(cell,controller) operationID:@"invalid-bytes" completion:^(CSMessageVoiceResource *resource){ CHECK(!resource); done=YES; }];
        CHECK(Wait(^BOOL{ return done; })); CHECK(!downloads);
        [NSFileManager.defaultManager removeItemAtPath:path error:nil];
    }
}
static void TestVoiceCallbackIntegration(NSUserDefaults *defaults) {
    for (NSUInteger scenario=0;scenario<4;scenario++) {
        TestEnvironment *env=[TestEnvironment new]; TestController *controller=[TestController new]; env.controller=controller;
        TestManager *manager=[TestManager new]; TestAudio *audio=[TestAudio new]; audio.uploader=[TestUploader new];
        VoiceMsgDownloader *downloader=[VoiceMsgDownloader new]; env.services[@"CMessageMgr"]=manager; env.services[@"AudioSender"]=audio;
        if (scenario!=3) env.services[@"VoiceMsgDownloader"]=downloader;
        TestCell *cell=Cell(34); cell.wrap.m_uiVoiceTime=1000; cell.wrap.m_uiVoiceFormat=0;
        cell.wrap.m_nsContent=@"<voicemsg voicelength='1000' voiceformat='0' length='700' endflag='0'/>";
        manager.storedWrap=[cell.wrap copy]; manager.storedWrap.m_dtVoice=[NSMutableData dataWithLength:700]; manager.storedWrap.m_uiDownloadStatus=5;
        manager.storedWrap.m_nsContent=@"<voicemsg voicelength='1000' voiceformat='0' length='700' endflag='1'/>";
        if (scenario==1) manager.storedWrap.m_n64MesSvrID=901;
        CSMessageActionCoordinator *coordinator=[[CSMessageActionCoordinator alloc] initWithEnvironment:env preferences:Preferences(defaults) mediaProvider:[CSMessageMediaProvider new]];
        coordinator.feedbackHandler=^(__unused NSString *message){};
        CSMessageActionContext *context=[coordinator captureContextForCell:cell controller:controller bindingGeneration:1];
        NSString *operation=[coordinator executeContext:context action:CSMessageActionRepeat entry:CSMessageActionEntryMenuRepeat]; CHECK(operation);
        [coordinator voiceDownloadCompletedForChat:@"chat" localID:42 serverID:900 endFlag:0 error:0]; CHECK(!manager.calls.count);
        if (scenario!=3) CHECK(downloader.downloads==1);
        [coordinator voiceDownloadCompletedForChat:@"chat" localID:42 serverID:900 endFlag:1 error:scenario==2 ? 0 : 3];
        CHECK(Wait(^BOOL{ NSInteger state=[[coordinator resultsForOperationID:operation][@"chat"] integerValue]; return state==CSMessageActionSubmissionStateUnknown || state==CSMessageActionSubmissionStateFailedBeforeAcceptance; }));
        CHECK(manager.calls.count==(scenario==0 ? 1 : 0)); CHECK(audio.uploader.calls.count==(scenario==0 ? 1 : 0));
        CHECK(cell.wrap.m_dtVoice==nil && cell.wrap.m_uiDownloadStatus==0 && [cell.wrap.m_nsContent containsString:@"endflag='0'"]);
        [coordinator voiceDownloadCompletedForChat:@"chat" localID:42 serverID:900 endFlag:1 error:3]; Drain(); CHECK(audio.uploader.calls.count==(scenario==0 ? 1 : 0));
    }
}
static void TestMedia(void) {
    TestCell *cell=Cell(34); TestController *controller=[TestController new]; cell.wrap.m_uiVoiceTime=1000; cell.wrap.m_uiVoiceFormat=0; cell.wrap.m_uiDownloadStatus=0;
    NSString *path=[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]; NSData *audio=[NSMutableData dataWithLength:700]; CHECK([audio writeToFile:path atomically:YES]); cell.wrap.path=path; cell.wrap.m_nsContent=@"<voicemsg voicelength=\"1000\" voiceformat=\"0\" length=\"700\"/>";
    __block NSUInteger reads=0,downloads=0,callbacks=0; CSMessageMediaProvider *provider=[[CSMessageMediaProvider alloc] initWithReader:^NSData *(NSString *file){ CHECK(!NSThread.isMainThread); reads++; return [NSData dataWithContentsOfFile:file]; }];
    provider.requestDownload=^(CSMessageActionContext *context){ CHECK(context.sourceWrap==cell.wrap); downloads++; return YES; };
    CSMessageActionContext *context=Context(cell,controller);
    [provider prepareVoiceForContext:context operationID:@"one" completion:^(CSMessageVoiceResource *resource){ CHECK(resource.durationMilliseconds==1000 && resource.format==0 && resource.data.length==700); callbacks++; }];
    [provider prepareVoiceForContext:context operationID:@"two" completion:^(__unused CSMessageVoiceResource *resource){ callbacks++; }]; CHECK(downloads==1 && reads==0);
    [provider cancelOperationID:@"two"];
    [provider downloadCompletedForAccount:@"other" epoch:1 chat:@"chat" localID:42 serverID:900]; Drain(); CHECK(!callbacks);
    [provider downloadCompletedForAccount:@"me" epoch:1 chat:@"wrong" localID:42 serverID:900]; Drain(); CHECK(!callbacks);
    [provider downloadCompletedForAccount:@"me" epoch:1 chat:@"chat" localID:42 serverID:900]; CHECK(Wait(^BOOL{ return callbacks==1; })); CHECK(reads==1);
    [provider downloadCompletedForAccount:@"me" epoch:1 chat:@"chat" localID:42 serverID:900]; Drain(); CHECK(callbacks==1);
    // Native status without full byte evidence does not accept a partial file.
    cell.wrap.m_uiDownloadStatus=1; cell.wrap.m_nsContent=@"<voicemsg voicelength=\"1000\" voiceformat=\"0\" length=\"500\"/>"; __block BOOL partialAccepted=NO;
    [provider prepareVoiceForContext:context operationID:@"partial" completion:^(CSMessageVoiceResource *resource){ partialAccepted=resource!=nil; }]; Drain(); CHECK(downloads==1); CHECK(!partialAccepted); [provider cancelOperationID:@"partial"];
    // Cancel during an actual off-main read: released operation receives no late completion.
    dispatch_semaphore_t entered=dispatch_semaphore_create(0), release=dispatch_semaphore_create(0);
    CSMessageMediaProvider *racing=[[CSMessageMediaProvider alloc] initWithReader:^NSData *(NSString *file){ dispatch_semaphore_signal(entered); dispatch_semaphore_wait(release,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC)); return [NSData dataWithContentsOfFile:file]; }];
    cell.wrap.m_uiDownloadStatus=1; cell.wrap.m_nsContent=@"<voicemsg voicelength=\"1000\" voiceformat=\"0\" length=\"700\"/>";
    __block NSUInteger cancelledCallbacks=0;
    [racing prepareVoiceForContext:context operationID:@"racing" completion:^(__unused CSMessageVoiceResource *resource){ cancelledCallbacks++; }];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0); [racing cancelOperationID:@"racing"]; dispatch_semaphore_signal(release); Drain(); Drain(); CHECK(!cancelledCallbacks);
    // Checked native out-object ABI resolves the historical app path before identity reset.
    CHECK([CSMessageNativeAppDataPath(context) isEqual:path]);
    [NSFileManager.defaultManager removeItemAtPath:path error:nil];
}
static void TestVoiceFlags(void) {
    TestCell *cell=Cell(34); TestController *controller=[TestController new]; CSMessageActionContext *context=Context(cell,controller);
    cell.wrap.m_uiDownloadStatus=1; cell.wrap.m_uiVoiceTime=1000; cell.wrap.m_uiVoiceFormat=0; cell.wrap.m_dtVoice=[NSMutableData dataWithLength:700];
    NSString *path=[NSTemporaryDirectory() stringByAppendingPathComponent:NSUUID.UUID.UUIDString]; CHECK([cell.wrap.m_dtVoice writeToFile:path atomically:YES]); cell.wrap.path=path;
    for (NSUInteger scenario=0;scenario<3;scenario++) {
        // Otherwise complete bytes must not defeat endflag0 or cancelflag1.
        cell.wrap.m_uiDownloadStatus=scenario==1 ? 1 : 0;
        cell.wrap.m_nsContent=scenario!=1 ? @"<voicemsg voicelength='1000' voiceformat='0' length='700' endflag='0' cancelflag='0'/>" : @"<voicemsg voicelength='1000' voiceformat='0' length='700' endflag='1' cancelflag='1'/>";
        CSMessageMediaProvider *provider=[CSMessageMediaProvider new]; __block NSUInteger downloads=0,callbacks=0; __block BOOL accepted=NO;
        provider.requestDownload=^(__unused CSMessageActionContext *source){ downloads++; return YES; };
        [provider prepareVoiceForContext:context operationID:@"flags" completion:^(CSMessageVoiceResource *resource){ callbacks++; accepted=resource!=nil; }];
        CHECK(Wait(^BOOL{ return callbacks || downloads; })); CHECK(!accepted);
        if (scenario==0) { CHECK(downloads==1 && !callbacks); [provider downloadCompletedForAccount:@"me" epoch:1 chat:@"chat" localID:42 serverID:900]; CHECK(Wait(^BOOL{ return callbacks==1; })); CHECK(accepted); }
        else { if (scenario==2) cell.wrap.m_nsContent=@"<voicemsg voicelength='1000' voiceformat='0' length='700' endflag='0' cancelflag='1'/>"; [provider downloadCompletedForAccount:@"me" epoch:1 chat:@"chat" localID:42 serverID:900]; Drain(); CHECK(callbacks==1 && !accepted); CHECK(downloads==(scenario==2 ? 1 : 0)); }
    }
    // Flags can change while bytes are being read; acceptance must use fresh metadata.
    cell.wrap.m_dtVoice=nil; cell.wrap.m_uiDownloadStatus=1;
    dispatch_semaphore_t entered=dispatch_semaphore_create(0),release=dispatch_semaphore_create(0);
    CSMessageMediaProvider *racing=[[CSMessageMediaProvider alloc] initWithReader:^NSData *(NSString *file){ dispatch_semaphore_signal(entered); dispatch_semaphore_wait(release,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC)); return [NSData dataWithContentsOfFile:file]; }];
    cell.wrap.m_nsContent=@"<voicemsg voicelength='1000' voiceformat='0' length='700' endflag='1'/>"; __block NSUInteger callbacks=0; __block BOOL accepted=NO;
    [racing prepareVoiceForContext:context operationID:@"metadata-race" completion:^(CSMessageVoiceResource *resource){ callbacks++; accepted=resource!=nil; }];
    CHECK(dispatch_semaphore_wait(entered,dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC))==0);
    cell.wrap.m_nsContent=@"<voicemsg voicelength='1000' voiceformat='0' length='700' endflag='1' cancelflag='1'/>"; dispatch_semaphore_signal(release);
    CHECK(Wait(^BOOL{ return callbacks==1; })); CHECK(!accepted); [NSFileManager.defaultManager removeItemAtPath:path error:nil];
}
int main(void) { @autoreleasepool { NSString *suite=[@"CSMessageActionExecutionTests." stringByAppendingString:NSUUID.UUID.UUIDString]; NSUserDefaults *defaults=[[NSUserDefaults alloc] initWithSuiteName:suite]; if (getenv("CS_TEST_FIRST_BATCH_CASE")) {
    NSString *test=[NSString stringWithUTF8String:getenv("CS_TEST_FIRST_BATCH_CASE")];
    if ([test isEqual:@"native-actions"]) TestNativeActionFastPath(defaults);
    else if ([test isEqual:@"menu"]) TestMenuNoOp(defaults);
    else if ([test isEqual:@"stickers"]) TestNativeStickerMenu(defaults);
    else if ([test isEqual:@"games"]) TestGameMenu(defaults);
    else return 2;
    [defaults removePersistentDomainForName:suite]; printf("PASS: %lu focused checks\n",(unsigned long)checks); return 0;
} if (getenv("CS_TEST_VOICE_FLAGS_ONLY")) { TestVoiceFlags(); return 0; } TestDiagnostics(); TestMenuObservation(); TestVoiceNativeConstructorFlows(defaults); TestVoiceFailureFeedback(defaults); TestNativeActionFastPath(defaults); TestMenuNoOp(defaults); TestNativeStickerMenu(defaults); TestGameMenu(defaults); TestVoiceInvalidBytes(); TestVoiceCallbackIntegration(defaults); TestNativeMenuPipeline(defaults); TestNativeVoiceStatuses(); TestNativeTextAndFeedback(defaults); TestProductionAdmission(defaults); TestNativeBoundary(); TestSendRoutes(); TestOrdinaryPayloadRoutes(); TestMenuSnapshots(defaults); TestCoordinator(defaults); TestForwardCleanupWhileWaiting(defaults); TestMedia(); TestVoiceFlags(); [defaults removePersistentDomainForName:suite]; printf("PASS: %lu production action/coordinator/native/media checks (host doubles, no native sends)\n",(unsigned long)checks); } return 0; }
