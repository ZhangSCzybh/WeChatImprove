# Selection follow-up: frozen source references

Every complete source snapshot below matches the historical 2.1-6 authorization-cleanup after SHA. Lines are one-based and excerpts preserve source text.

## Controllers/CSNativeContactPicker.m

SHA-256: `2d7c6070247818648ae43639d51282b664965c656a3fd99b6c56a0dcde7bd003`

35–94: selection validates and commits only after Done/dismiss completion

```objc
35: static CSNativePickerState *State(id picker) { return objc_getAssociatedObject(picker,&PickerStateKey); }
36: static id CurrentSelection(id picker) {
37:     // Native friend Done reads ContactSelectView's live result, not the
38:     // controller's initial seed (search/tag selection may replace that result).
39:     id owner=State(picker).groups ? picker : CSGroupReadObject(picker,@"m_selectView");
40:     return Get(owner,@"m_dicMultiSelect");
41: }
42: 
43: @implementation CSNativePickerState
44: - (BOOL)valid {
45:     return !self.finished && !self.revoked && [self.account isEqual:CSGroupCurrentAccountID()] && (!self.isValid || self.isValid());
46: }
47: - (BOOL)acceptsContact:(id)contact {
48:     NSString *name=Get(contact,@"m_nsUsrName");
49:     return [self valid] && IsName(name,self.groups) && ![name isEqual:self.account] &&
50:         (self.groups || CSGroupCategoryForContact(contact)==CSGroupRowCategoryPrivate);
51: }
52: - (BOOL)onShouldSelectContact:(id)contact {
53:     if(![self acceptsContact:contact])return NO;
54:     if(!self.singleSelection)return YES;
55:     id selection=CurrentSelection(self.picker);
56:     if(![selection isKindOfClass:NSDictionary.class])return NO;
57:     NSString *name=Get(contact,@"m_nsUsrName");
58:     return [selection count]==0 || selection[name]!=nil;
59: }
60: - (BOOL)canFinish {
61:     if(![self valid])return NO;
62:     if(!self.singleSelection)return YES;
63:     id selection=CurrentSelection(self.picker);
64:     return [selection isKindOfClass:NSDictionary.class] && [selection count]==1 && [self acceptsContact:[selection allValues].firstObject];
65: }
66: - (void)finish:(BOOL)save {
67:     if(self.finished)return;
68:     BOOL allowed=[self valid];
69:     // Search/tag bulk selection can bypass a per-contact delegate. Never pick
70:     // an arbitrary first target, and keep the page open so the user can correct it.
71:     if(save && allowed && self.singleSelection && ![self canFinish])return;
72:     id selection=CurrentSelection(self.picker);
73:     // A missing native result is not an intentional empty selection.
74:     save=save && allowed && [selection isKindOfClass:NSDictionary.class];
75:     NSMutableSet *names=[self.unavailableNames mutableCopy];
76:     if(save)for(id contact in [selection allValues]) {
77:         NSString *name=Get(contact,@"m_nsUsrName");
78:         if([self acceptsContact:contact])[names addObject:name];
79:     }
80:     NSArray *result=[names.allObjects sortedArrayUsingSelector:@selector(compare:)];
81:     self.finished=YES;
82:     void (^completion)(NSArray *)=self.completion; self.completion=nil;
83:     // Keep state alive through dismissal; account/token changes during animation
84:     // invalidate the write just as changes while the list is open do.
85:     [self.picker.navigationController dismissViewControllerAnimated:YES completion:^{
86:         if(save && [self.account isEqual:CSGroupCurrentAccountID()] && (!self.isValid || self.isValid()))completion(result);
87:     }];
88: }
89: @end
90: 
91: static void PickerDone(id picker, SEL command) { [State(picker) finish:YES]; }
92: static void PickerDoneWithSender(id picker, SEL command, id sender) { PickerDone(picker,command); }
93: static void PickerCancel(id picker, SEL command) { [State(picker) finish:NO]; }
94: static void PickerCancelWithSender(id picker, SEL command, id sender) { PickerCancel(picker,command); }
```

## Controllers/CSCloseFriendSettingsViewController.m

SHA-256: `85a37d369779ec50c3b999198f10e9fb56966426478a391d4dca17146e27cb3b`

185–219: selection result replaces friends/groups and saves profile

```objc
185: }
186: - (void)showError:(NSError *)error {
187:     UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"未保存" message:error.localizedDescription?:@"操作已失效，请重新验证。" preferredStyle:UIAlertControllerStyleAlert];
188:     [alert addAction:[UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleDefault handler:nil]]; [self presentViewController:alert animated:YES completion:nil];
189: }
190: - (void)save:(NSDictionary *)profile { NSError *error=nil; if(!CSCloseFriendUpdateCurrentProfile(profile,&error))[self showError:error]; [self.tableView reloadData]; }
191: - (void)toggle:(UISwitch *)toggle {
192:     if(![self authorized]) { [self.tableView reloadData]; return; }
193:     NSMutableDictionary *profile=[CSCloseFriendCurrentProfile() mutableCopy];
194:     if(toggle.tag==100)profile[@"enabled"]=@(toggle.on);
195:     else { NSMutableDictionary *options=[profile[@"options"] mutableCopy]; options[self.keys[toggle.tag]]=@(toggle.on); profile[@"options"]=options; }
196:     [self save:profile];
197: }
198: - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
199:     [tableView deselectRowAtIndexPath:indexPath animated:YES]; if(![self authorized])return;
200:     if(indexPath.section==2) { [self resetCloseFriends]; return; }
201:     NSDictionary *token=CSCloseFriendManager.sharedManager.runtime.authenticationToken;
202:     NSString *optionKey=[self optionKeyForIndexPath:indexPath];
203:     if(indexPath.section==0 && (indexPath.row==1 || indexPath.row==2)) {
204:         NSString *key=indexPath.row==1?@"friends":@"groups";
205:         __weak typeof(self) weakSelf=self;
206:         NSError *error=nil;
207:         BOOL shown=CSNativeContactPickerPresent(self,indexPath.row==1?@"选择密友":@"选择密友群聊",indexPath.row==2,
208:           CSCloseFriendCurrentProfile()[key],^BOOL{
209:             return weakSelf && [weakSelf authorized] && [CSCloseFriendManager.sharedManager.runtime isTokenCurrent:token];
210:           },^(NSArray<NSString *> *names){
211:             [CSCloseFriendManager.sharedManager refreshAccount];
212:             if(![weakSelf authorized] || ![CSCloseFriendManager.sharedManager.runtime isTokenCurrent:token])return;
213:             NSMutableDictionary *profile=[CSCloseFriendCurrentProfile() mutableCopy]; profile[key]=names; [weakSelf save:profile];
214:           },&error);
215:         if(!shown)[self showError:error];
216:     } else if(indexPath.section==0 && indexPath.row==3)[CSCloseFriendManager.sharedManager changePasswordFrom:self];
217:     else if(indexPath.section==0 && indexPath.row==4)CSCloseFriendLock();
218:     else if([optionKey isEqual:@"callReplyText"]) {
219:         UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"挂断回复内容" message:@"输入 1–200 字的单行回复。自动拒接单人语音／视频来电后发送，同一人 5 分钟内最多一次。" preferredStyle:UIAlertControllerStyleAlert];
```

## Controllers/CSCloseFriendBridge.m

SHA-256: `777e5ae8938bd2c32a685933a2b6532bf1418e758f3702b6c42438cc88bb7ef8`

7–26: snapshot bridge and ABI-checked object read

```objc
7: NSString *const CSCloseFriendPolicyDidChangeNotification=@"CSCloseFriendPolicyDidChange";
8: CSCloseFriendSnapshot *CSCloseFriendCurrentSnapshot(void) {
9:     return [CSCloseFriendManager.sharedManager.runtime snapshotForEpoch:CSBackupAccountEpoch() suspended:CSBackupAccountIsSuspended()];
10: }
11: NSUInteger CSCloseFriendAccountEpoch(void) { return CSBackupAccountEpoch(); }
12: BOOL CSCloseFriendShouldHideUserName(NSString *name, CSCloseFriendSurface surface) { return [CSCloseFriendCurrentSnapshot() hidesUserName:name surface:surface]; }
13: BOOL CSCloseFriendShouldSilence(NSString *session, NSString *sender) { return [CSCloseFriendCurrentSnapshot() silencesSession:session sender:sender]; }
14: BOOL CSCloseFriendShouldRejectCall(NSString *caller, NSString *room, BOOL video) { return [CSCloseFriendCurrentSnapshot() rejectsCaller:caller chatRoom:room video:video]; }
15: BOOL CSCloseFriendHidesPrivacyIcons(void) { CSCloseFriendSnapshot *s=CSCloseFriendCurrentSnapshot(); return s.blocked || (s.enabled && [s.options[@"hidePrivacyIcons"] boolValue]); }
16: BOOL CSCloseFriendPluginEntryHidden(void) { CSCloseFriendSnapshot *s=CSCloseFriendCurrentSnapshot(); return s.enabled && [s.options[@"hidePluginEntry"] boolValue] && !s.revealed; }
17: id CSCloseFriendRead(id object, NSString *key) {
18:     if(!object || ![key isKindOfClass:NSString.class] || !key.length)return nil;
19:     @try {
20:         if([object isKindOfClass:NSDictionary.class])return object[key];
21:         SEL sel=NSSelectorFromString(key); Method method=class_getInstanceMethod([object class],sel);
22:         if(CSCloseFriendMethodMatches(method,"@@:"))return ((id(*)(id,SEL))objc_msgSend)(object,sel);
23:         Ivar ivar=class_getInstanceVariable([object class],key.UTF8String);
24:         if(ivar && ivar_getTypeEncoding(ivar)[0]=='@')return object_getIvar(object,ivar);
25:     } @catch(__unused NSException *exception) {}
26:     return nil;
```

44–65: epoch-guarded profile mutation and hook installation

```objc
44: NSDictionary *CSCloseFriendCurrentProfile(void) { CSCloseFriendSnapshot *s=CSCloseFriendCurrentSnapshot(); return s.blocked?nil:CSCloseFriendManager.sharedManager.runtime.currentProfile; }
45: static BOOL CSBridgeMutation(NSString *account, NSUInteger epoch, BOOL (^mutation)(NSError **), NSError **error) {
46:     if(!NSThread.isMainThread) { if(error)*error=[NSError errorWithDomain:@"CSCloseFriendRuntime" code:2 userInfo:@{NSLocalizedDescriptionKey:@"必须在主线程修改密友配置。"}]; return NO; }
47:     __block BOOL ok=NO; __block NSError *localError=nil;
48:     CSBackupPerformAtAccountEpoch(epoch,^{
49:         if(CSBackupAccountIsSuspended())return;
50:         [CSCloseFriendManager.sharedManager refreshAccount];
51:         CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
52:         if(snapshot.blocked || (account && ![snapshot.accountID isEqual:account]))return;
53:         ok=mutation(&localError);
54:     });
55:     if(!ok && error)*error=localError?:[NSError errorWithDomain:@"CSCloseFriendRuntime" code:3 userInfo:@{NSLocalizedDescriptionKey:@"当前账号不可用或操作已失效。"}];
56:     return ok;
57: }
58: BOOL CSCloseFriendUpdateCurrentProfile(NSDictionary *profile, NSError **error) { return CSBridgeMutation(nil,CSBackupAccountEpoch(),^BOOL(NSError **e){ return [CSCloseFriendManager.sharedManager.runtime updateProfile:profile error:e]; },error); }
59: BOOL CSCloseFriendInstallHook(NSString *className, NSString *selector, IMP replacement, IMP *original, const char *encoding) {
60:     Class cls=NSClassFromString(className); SEL sel=NSSelectorFromString(selector);
61:     BOOL available=cls && replacement && original && CSCloseFriendMethodMatches(class_getInstanceMethod(cls,sel),encoding);
62:     if(available) { MSHookMessageEx(cls,sel,replacement,original); available=*original!=NULL; }
63:     CSCloseFriendRecordCapability([NSString stringWithFormat:@"%@.%@",className,selector],available);
64:     return available;
65: }
```

## Controllers/CSCloseFriendManager.m

SHA-256: `32029613b26321429e662eccfb778e4ff90532618b4605e00cc17256dd2e8548`

70–115: runtime didChange schedules main policy publication

```objc
70: @implementation CSCloseFriendManager
71: + (instancetype)sharedManager { static CSCloseFriendManager *instance; static dispatch_once_t once; dispatch_once(&once,^{ instance=[self new]; }); return instance; }
72: - (instancetype)init {
73:     if((self=[super init])) {
74:         _capabilityMap=[NSMutableDictionary new]; _covers=[NSMutableArray new];
75:         _entryState=[[CSCloseFriendEntryState alloc] initWithDefaults:[[NSUserDefaults alloc] initWithSuiteName:@"com.wechatimprove.closefriends.entry-discovery"]];
76:         CSPluginDirectoryMigration *migration=CSPluginStorageMigration(@"CloseFriends");
77:         CSCloseFriendStore *store=[[CSCloseFriendStore alloc] initWithMigration:migration keyProvider:^NSData *(NSString *account,NSError **error){
78:             NSData *key=CSKeychainRead(account,@"policy",error); if(key || (error && *error))return key;
79:             if(!CSCanCreatePolicyKey(migration,account)) { CSKeychainError(error,errSecItemNotFound); return nil; }
80:             key=CSCloseFriendRandomBytes(64,error); if(!key || !CSKeychainWrite(account,@"policy",key,NO,error))return nil; return key;
81:         }];
82:         store.readKeyProvider=^NSData *(NSString *account,NSError **error){
83:             NSData *key=CSKeychainRead(account,@"policy",error);
84:             if(!key && (!error || !*error))CSKeychainError(error,errSecItemNotFound);
85:             return key;
86:         };
87:         _runtime=[[CSCloseFriendRuntime alloc] initWithStore:store wallClock:^NSTimeInterval{ return NSDate.date.timeIntervalSince1970; } elapsedClock:^NSTimeInterval{ return NSProcessInfo.processInfo.systemUptime; } credentialReader:^NSDictionary *(NSString *account,NSError **error){
88:             NSData *data=CSKeychainRead(account,@"auth",error); if(!data)return nil;
89:             id value=[NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:NULL error:error];
90:             if(![value isKindOfClass:NSDictionary.class]) { CSKeychainError(error,errSecDecode); return nil; } return value;
91:         } credentialWriter:^BOOL(NSString *account,NSDictionary *credential,NSError **error){
92:             NSData *data=[NSPropertyListSerialization dataWithPropertyList:credential format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
93:             return data && CSKeychainWrite(account,@"auth",data,YES,error);
94:         }];
95:         CSCloseFriendReset *reset=[[CSCloseFriendReset alloc] initWithStore:store entryState:_entryState
96:             reader:^NSData *(NSString *account,NSString *kind,NSError **error){ return CSKeychainRead(account,kind,error); }
97:             writer:^BOOL(NSString *account,NSString *kind,NSData *data,NSError **error){ return CSKeychainWrite(account,kind,data,NO,error); }
98:             remover:^BOOL(NSString *account,NSString *kind,NSError **error){ return CSKeychainRemove(account,kind,error); }];
99:         _runtime.resetStorage=^BOOL(NSString *account,BOOL begin,NSError **error){
100:             return begin ? [reset beginResetForAccountID:account error:error] : [reset resumeResetForAccountID:account error:error];
101:         };
102:         __weak typeof(self) weakSelf=self;
103:         _runtime.didChange=^{ [weakSelf schedulePolicyRefresh]; };
104:     } return self;
105: }
106: - (void)schedulePolicyRefresh {
107:     @synchronized(self) { if(self.policyRefreshScheduled)return; self.policyRefreshScheduled=YES; }
108:     dispatch_async(dispatch_get_main_queue(),^{ [self flushPolicyRefresh]; });
109: }
110: - (void)flushPolicyRefresh {
111:     NSAssert(NSThread.isMainThread,@"Policy publication on main");
112:     @synchronized(self) { if(!self.policyRefreshScheduled)return; self.policyRefreshScheduled=NO; }
113:     [self refreshShakeMonitoring]; [self refreshRecoveryGesture]; [self startExpiryTimer];
114:     [NSNotificationCenter.defaultCenter postNotificationName:CSCloseFriendPolicyDidChangeNotification object:nil];
115: }
```

162–176: start refreshes account synchronously

```objc
162: - (void)start {
163:     NSAssert(NSThread.isMainThread,@"UI on main"); if(self.started)return; self.started=YES;
164:     NSNotificationCenter *center=NSNotificationCenter.defaultCenter;
165:     [center addObserver:self selector:@selector(resign:) name:UIApplicationWillResignActiveNotification object:nil];
166:     [center addObserver:self selector:@selector(suspend:) name:UIApplicationDidEnterBackgroundNotification object:nil];
167:     [center addObserver:self selector:@selector(active:) name:UIApplicationDidBecomeActiveNotification object:nil];
168:     [center addObserver:self selector:@selector(accountChanged:) name:@"CSBackupAccountChanged" object:nil];
169:     [center addObserver:self selector:@selector(suspend:) name:UIApplicationProtectedDataWillBecomeUnavailable object:nil];
170:     for(NSString *name in @[CSBackgroundBlurSettingsChangedNotification,@"com.wechat.tweak.settings_changed",@"com.wechat.tweak.local_settings_changed"])
171:         [center addObserver:self selector:@selector(backgroundPrivacySettingsChanged:) name:name object:nil];
172:     [self.runtime setActive:UIApplication.sharedApplication.applicationState==UIApplicationStateActive];
173:     [self refreshAccount];
174:     [self refreshShakeMonitoring];
175:     [self startExpiryTimer];
176: }
```

232–249: account synchronization

```objc
232:     [self uncover];
233: }
234: - (void)accountChanged:(NSNotification *)note { [self lockAndReturnToSafePage]; [self refreshAccount]; }
235: - (void)refreshAccount {
236:     NSAssert(NSThread.isMainThread,@"Account service on main");
237:     NSUInteger epoch=CSBackupAccountEpoch(); BOOL suspended=CSBackupAccountIsSuspended(); NSString *account=@"";
238:     if(!suspended) {
239:         account=CSCloseFriendResolveAccount(^Class(NSString *name){ return NSClassFromString(name); })?:@"";
240:         [self recordCapability:@"当前账号读取" available:account.length>0];
241:     }
242:     if(epoch!=CSBackupAccountEpoch() || CSBackupAccountIsSuspended()) { suspended=YES; account=@""; }
243:     // Recovery can finish a confirmed reset, so loading shares the account mutation lock.
244:     BOOL ran=CSBackupPerformAtAccountEpoch(epoch,^{
245:         BOOL unavailable=suspended || CSBackupAccountIsSuspended();
246:         [self.runtime synchronizeAccount:unavailable?@"":account epoch:epoch suspended:unavailable];
247:     });
248:     if(!ran)[self.runtime synchronizeAccount:@"" epoch:CSBackupAccountEpoch() suspended:YES];
249: }
```

## Controllers/CSCloseFriendRuntime.m

SHA-256: `b08edf89b04a94306f5dc8d8766224b4d182fddbd5964286d30c69813b650829`

28–42: initial blocked state and changed invalidation

```objc
28: @end
29: @implementation CSCloseFriendRuntime
30: - (instancetype)initWithStore:(CSCloseFriendStore *)store clock:(NSTimeInterval (^)(void))clock credentialReader:(CSCloseFriendCredentialReader)reader credentialWriter:(CSCloseFriendCredentialWriter)writer {
31:     return [self initWithStore:store wallClock:clock elapsedClock:^NSTimeInterval{ return NSProcessInfo.processInfo.systemUptime; } credentialReader:reader credentialWriter:writer];
32: }
33: - (instancetype)initWithStore:(CSCloseFriendStore *)store wallClock:(NSTimeInterval (^)(void))wallClock elapsedClock:(NSTimeInterval (^)(void))elapsedClock credentialReader:(CSCloseFriendCredentialReader)reader credentialWriter:(CSCloseFriendCredentialWriter)writer {
34:     if((self=[super init])) { _store=store; _wallClock=[wallClock copy]; _elapsedClock=[elapsedClock copy]; _reader=[reader copy]; _writer=[writer copy]; _account=@""; _blocked=YES; _active=YES; }
35:     return self;
36: }
37: - (void)invalidateSearchVerification {
38:     self.resetToken=nil;
39:     self.searchCredentialVersion++; self.searchRequest++;
40:     self.searchCache=nil; self.searchCacheKey=nil;
41: }
42: - (void)changed { self.revision++; self.publishedSnapshot=nil; self.boundarySnapshot=nil; if(self.didChange)self.didChange(); }
```

51–90: account load and fail-closed snapshot

```objc
51:     if([value[@"failures"] unsignedIntegerValue]>10)return NO;
52:     return [value[@"salt"] isKindOfClass:NSData.class] && [value[@"salt"] length]==32 && [value[@"verifier"] isKindOfClass:NSData.class] && [value[@"verifier"] length]==32 && [value[@"iterations"] isKindOfClass:NSNumber.class] && [value[@"iterations"] unsignedIntegerValue]>=210000 && [value[@"iterations"] unsignedIntegerValue]<=2000000 && [value[@"failures"] isKindOfClass:NSNumber.class] && [value[@"cooldown"] isKindOfClass:NSNumber.class];
53: }
54: - (void)synchronizeAccount:(NSString *)account epoch:(NSUInteger)epoch suspended:(BOOL)suspended {
55:     NSAssert(NSThread.isMainThread,@"Main-thread mutation required");
56:     @synchronized(self) {
57:         if([self.account isEqual:account] && self.epoch==epoch && self.suspended==suspended && !self.blocked)return;
58:         [self invalidateSearchVerification];
59:         self.account=[account copy]?:@""; self.epoch=epoch; self.suspended=suspended; self.generation++; self.revealUntil=0; self.state=nil; self.credential=nil; self.blocked=YES;
60:         if(account.length && !suspended && (!self.resetStorage || self.resetStorage(account,NO,NULL))) {
61:             NSError *error=nil;
62:             NSDictionary *state=[self.store loadStateForAccountID:account error:&error];
63:             BOOL missing=[error.domain isEqual:CSCloseFriendStoreErrorDomain] && error.code==CSCloseFriendStoreErrorMissing;
64:             if(state || missing) {
65:                 error=nil; NSDictionary *credential=self.reader(account,&error);
66:                 if(!error && (!credential || [self validCredential:credential])) {
67:                     self.credential=credential;
68:                     self.state=state?:@{@"profile":CSEmptyProfile(),@"muteRecords":@{}};
69:                     // Any persisted policy without its verifier is a security failure, never a new setup.
70:                     self.blocked=state!=nil && !credential;
71:                 }
72:             }
73:         }
74:         [self changed];
75:     }
76: }
77: - (CSCloseFriendSnapshot *)snapshotForEpoch:(NSUInteger)epoch suspended:(BOOL)suspended {
78:     @synchronized(self) {
79:         // A boundary must not apply the old account's notification/call membership.
80:         if(self.suspended || suspended || epoch!=self.epoch) {
81:             if(!self.boundarySnapshot)self.boundarySnapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:@"" profile:CSEmptyProfile() revealed:NO revision:self.revision blocked:YES];
82:             return self.boundarySnapshot;
83:         }
84:         BOOL revealed=!self.blocked && self.active && self.revealUntil>self.elapsedClock();
85:         if(self.publishedSnapshot && self.publishedSnapshot.revealed!=revealed)[self changed];
86:         if(!self.publishedSnapshot) {
87:             self.publishedSnapshot=[[CSCloseFriendSnapshot alloc] initWithAccountID:self.account profile:self.state[@"profile"]?:CSEmptyProfile() revealed:revealed revision:self.revision blocked:self.blocked];
88:         }
89:         return self.publishedSnapshot;
90:     }
```

203–222: save readback then changed; authorization gate

```objc
203:         if(![self isTokenCurrent:token] || !self.credential || ![self.state[@"profile"][@"options"][@"biometric"] boolValue] || [self.credential[@"cooldown"] doubleValue]>self.wallClock())return NO;
204:         self.revealUntil=self.elapsedClock()+[self.state[@"profile"][@"options"][@"unlockSeconds"] doubleValue]; self.generation++; [self changed]; return YES;
205:     }
206: }
207: - (NSDictionary *)currentProfile { @synchronized(self) { return self.blocked?nil:self.state[@"profile"]; } }
208: - (BOOL)saveState:(NSDictionary *)state error:(NSError **)error {
209:     if(![self.store saveState:state forAccountID:self.account error:error]) { self.blocked=YES; [self lock]; return NO; }
210:     // Read back immutable normalized data. A failure holds protection without replacing bytes.
211:     self.state=[self.store loadStateForAccountID:self.account error:error];
212:     if(!self.state) { self.blocked=YES; [self lock]; return NO; }
213:     [self changed]; return YES;
214: }
215: - (BOOL)updateProfile:(NSDictionary *)profile error:(NSError **)error {
216:     NSAssert(NSThread.isMainThread,@"Main-thread mutation required");
217:     @synchronized(self) {
218:         if(![self isAuthorized] || !self.credential)return CSRuntimeFail(error,@"请先设置密码并验证当前账号。");
219:         NSDictionary *normalized=CSCloseFriendNormalizeProfile(profile,error); if(!normalized)return NO;
220:         return [self saveState:@{@"profile":normalized,@"muteRecords":self.state[@"muteRecords"]?:@{}} error:error];
221:     }
222: }
```

## Controllers/CSCloseFriendStore.m

SHA-256: `eaaf39fe06c2a365971502015ac0cd1fc5a932a1eecbea1e6f5530fa12e8bf8b`

99–134: validated encrypted staged save and atomic rename

```objc
99: - (BOOL)saveState:(NSDictionary *)state forAccountID:(NSString *)account error:(NSError **)error {
100:     @synchronized(CSCloseFriendStore.class) {
101:         if(!CSAccount(account) || !self.root.isFileURL || !self.keyProvider)return CSStoreFail(error,CSCloseFriendStoreErrorInvalid);
102:         NSError *migrationError=nil;
103:         if(self.migration && ![self.migration migrate:&migrationError]) {
104:             if(error)*error=migrationError;
105:             if(!migrationError)CSStoreFail(error,CSCloseFriendStoreErrorIO);
106:             return NO;
107:         }
108:         NSDictionary *valid=CSState(state,error); if(!valid)return NO;
109:         NSError *keyError=nil; NSData *key=self.keyProvider(account,&keyError); if(!key && keyError) { if(error)*error=keyError; return NO; } if(![key isKindOfClass:NSData.class] || key.length!=64)return CSStoreFail(error,CSCloseFriendStoreErrorInvalid);
110:         NSURL *destination=[self URLForAccount:account]; BOOL missing=NO; NSError *readError=nil;
111:         NSData *existing=[self readURL:destination missing:&missing error:&readError];
112:         if(existing) { if(![self decode:existing key:key account:account error:error])return NO; }
113:         else if(!missing) { if(error)*error=readError; return NO; }
114:         NSFileManager *fm=NSFileManager.defaultManager;
115:         if(![fm createDirectoryAtURL:self.root withIntermediateDirectories:YES attributes:@{NSFilePosixPermissions:@0700} error:error])return NO;
116:         struct stat rootStat; if(lstat(self.root.path.fileSystemRepresentation,&rootStat) || !S_ISDIR(rootStat.st_mode))return CSStoreFail(error,CSCloseFriendStoreErrorIO);
117:         if(chmod(self.root.path.fileSystemRepresentation,0700))return CSStoreFail(error,CSCloseFriendStoreErrorIO);
118:         NSURL *rootURL=self.root;
119:         if(![rootURL setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:error])return NO;
120: #if TARGET_OS_IPHONE
121:         if(![fm setAttributes:@{NSFileProtectionKey:NSFileProtectionComplete} ofItemAtPath:rootURL.path error:error])return NO;
122: #endif
123:         NSData *plain=[NSPropertyListSerialization dataWithPropertyList:@{@"schema":@1,@"accountID":account,@"state":valid} format:NSPropertyListBinaryFormat_v1_0 options:0 error:error];
124:         NSData *encrypted=plain?CSCloseFriendEncrypt(plain,key,error):nil; if(!encrypted)return NO;
125:         NSURL *stage=[self.root URLByAppendingPathComponent:[@".pending-" stringByAppendingString:NSUUID.UUID.UUIDString]];
126:         BOOL ok=[self writeStagedData:encrypted URL:stage error:error];
127:         if(ok) { NSData *readback=[self readURL:stage missing:NULL error:error]; if(!readback)ok=NO; else if(!CSCloseFriendConstantTimeEqual(readback,encrypted))ok=CSStoreFail(error,CSCloseFriendStoreErrorIO); else ok=[self decode:readback key:key account:account error:error]!=nil; }
128:         if(ok && rename(stage.path.fileSystemRepresentation,destination.path.fileSystemRepresentation))ok=CSStoreFail(error,CSCloseFriendStoreErrorIO);
129:         if(!ok) { [fm removeItemAtURL:stage error:NULL]; return NO; }
130:         // The file was flushed before atomic rename; flush directory metadata for crash durability.
131:         int dir=open(self.root.path.fileSystemRepresentation,O_RDONLY|O_DIRECTORY); if(dir>=0) { fsync(dir); close(dir); }
132:         return YES;
133:     }
134: }
```

## Controllers/CSCloseFriendPolicy.m

SHA-256: `270695d97b73bf4d3298b8e9546a4ba35c5d16777c21cefd5ce8d52e0ee9a174`

7–9: default options include silenceMessages YES

```objc
7: NSDictionary *CSCloseFriendDefaultOptions(void) {
8:     return @{@"hideSessions":@YES,@"hideContacts":@YES,@"hideForwarding":@YES,@"hideTags":@YES,@"hideSearch":@YES,@"hideTimeline":@YES,@"hideInteractions":@YES,@"hideStatus":@YES,@"maskProfiles":@YES,@"hideScheduledTasks":@NO,@"hideAIReply":@NO,@"silenceMessages":@YES,@"rejectVoice":@YES,@"rejectVideo":@YES,@"callReplyEnabled":@NO,@"callReplyText":@"现在不方便接听，请留言。",@"hidePrivacyIcons":@YES,@"showBadges":@NO,@"hideSettingsEntry":@NO,@"hidePluginEntry":@NO,@"biometric":@NO,@"shakeToLock":@NO,@"longPressUnlockEnabled":@YES,@"longPressUnlockDuration":@1.0,@"unlockSeconds":@300};
9: }
```

48–64: protected union and conceal semantics

```objc
48: - (instancetype)initWithAccountID:(NSString *)accountID profile:(NSDictionary *)profile revealed:(BOOL)revealed revision:(NSUInteger)revision blocked:(BOOL)blocked {
49:     if((self=[super init])) {
50:         NSDictionary *valid=CSCloseFriendNormalizeProfile(profile,NULL);
51:         _accountID=CSName(accountID)?[accountID copy]:@"";
52:         _revision=revision; _blocked=blocked || !valid || !_accountID.length;
53:         _enabled=[valid[@"enabled"] boolValue]; _revealed=revealed && !_blocked;
54:         NSMutableSet *names=[NSMutableSet setWithArray:valid[@"friends"]?:@[]]; [names addObjectsFromArray:valid[@"groups"]?:@[]];
55:         _protectedUserNames=[names copy]; _options=valid[@"options"]?:CSCloseFriendDefaultOptions();
56:     } return self;
57: }
58: - (BOOL)containsUserName:(NSString *)name { return CSName(name) && [self.protectedUserNames containsObject:name]; }
59: - (BOOL)concealsSurface:(CSCloseFriendSurface)surface {
60:     if(self.blocked)return YES;
61:     if(!self.enabled || self.revealed || !self.protectedUserNames.count)return NO;
62:     static NSString *const keys[]={@"hideSessions",@"hideContacts",@"hideForwarding",@"hideTags",@"hideSearch",@"hideTimeline",@"hideInteractions",@"hideStatus",@"maskProfiles",@"hideScheduledTasks",@"hideAIReply"};
63:     return surface<sizeof(keys)/sizeof(*keys) && [self.options[keys[surface]] boolValue];
64: }
```

## Controllers/CSGroupListAdapter.m

SHA-256: `dcea1b1e1f4b0eb7cc2f2ef4cd0af301527789bf79c9804455a852e601fbc811`

13–23: privacy predicate excludes silence-only filtering

```objc
13: 
14: static BOOL CSGroupAppInactive;
15: static BOOL CSGroupApplicationActive(void) { return !CSGroupAppInactive && UIApplication.sharedApplication.applicationState==UIApplicationStateActive; }
16: 
17: static BOOL CSGroupPrivacyActive(void) {
18:     CSCloseFriendSnapshot *snapshot=CSCloseFriendCurrentSnapshot();
19:     return snapshot.blocked || (snapshot.enabled && !snapshot.revealed && [snapshot.options[@"hideSessions"] boolValue]);
20: }
21: static char AdapterKey, CellRowKey, TitleContextKey, PresentationSuspendedKey;
22: static NSHashTable<CSGroupListAdapter *> *Adapters(void) {
23:     static NSHashTable *adapters; static dispatch_once_t once;
```

130–169: attachment regardless group option and suspension clears cache

```objc
130:     // Attachment is authorized by its actual chat table, not an assumed superclass.
131:     if (!NSThread.isMainThread || !controller) return;
132:     id table=CSGroupReadObject(controller,CSGroupIsFoldedController(controller) ? @"tableView" : @"m_tableView");
133:     if (![table isKindOfClass:UITableView.class]) return;
134:     CSGroupListAdapter *adapter=[self adapterForController:controller];
135:     if (adapter.table!=table) {
136:         if (adapter) [adapter detach];
137:         adapter=[self new]; adapter.controller=controller; adapter.table=table;
138:         adapter.presentationSuspended=[objc_getAssociatedObject(controller,&PresentationSuspendedKey) boolValue];
139:         adapter.proxies=[NSMutableDictionary dictionary]; adapter.anchors=[NSMutableDictionary dictionary]; adapter.completions=[NSMutableArray array]; adapter.prefetchedPaths=[NSMutableSet set]; adapter.nativeActions=[NSMutableArray array];
140:         adapter.nativeHeader=[table tableHeaderView]; adapter.baselineDeceleration=[table decelerationRate];
141:         objc_setAssociatedObject(controller,&AdapterKey,adapter,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
142:         objc_setAssociatedObject(table,&AdapterKey,adapter,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
143:         [Adapters() addObject:adapter];
144:     }
145:     if (adapter.presentationSuspended || !CSGroupApplicationActive()) { adapter.dirty=YES; return; }
146:     // Appearance is not a data change. Repeated reload/anchor restoration here
147:     // competes with WeChat's own search/task-bar inset and offset restoration.
148:     NSString *account=CSGroupCurrentAccountID();
149:     BOOL sameAccount=adapter.preferences.accountID==account || [adapter.preferences.accountID isEqualToString:account];
150:     BOOL searching=CSGroupReadInteger(controller,@"isSearching",0)!=0;
151:     if (!adapter.preferences || adapter.dirty || !sameAccount ||
152:         adapter.publishedEnabled!=Option(@"enabled") || adapter.searching!=searching) [adapter refresh];
153:     [adapter layout];
154: }
155: // Visibility belongs to the native owner lifecycle, not table.window: a covered
156: // main list can remain attached while chat scrolling and keyboard layout run.
157: + (void)setPresentationSuspended:(BOOL)suspended forController:(id)controller {
158:     if (!NSThread.isMainThread || !controller) return;
159:     objc_setAssociatedObject(controller,&PresentationSuspendedKey,@(suspended),OBJC_ASSOCIATION_RETAIN_NONATOMIC);
160:     CSGroupListAdapter *adapter=[self adapterForController:controller];
161:     adapter.presentationSuspended=suspended;
162:     if (suspended) {
163:         adapter.dirty=YES; [adapter invalidateNativeSnapshot]; adapter.cachedNativeSections=nil;
164:         [adapter.projection discardComputationCache]; [adapter cancelScheduledRefresh];
165:         adapter.snapshotRetryAttempted=NO; adapter.snapshotRetryGeneration++;
166:         [adapter finishSuspendedBatches];
167:     }
168: }
169: - (void)finishSuspendedBatches {
```

183–228: badge getter and grouping policy observer

```objc
183: + (NSNumber *)closeFriendAlertBadgeCount {
184:     CSCloseFriendSnapshot *policy=CSCloseFriendCurrentSnapshot();
185:     BOOL filtering=[policy concealsSurface:CSCloseFriendSurfaceSession] || (policy.enabled && [policy.options[@"silenceMessages"] boolValue]);
186:     if(!policy.blocked && (!filtering || !policy.protectedUserNames.count))return nil;
187:     NSMutableSet *hidden=[policy.protectedUserNames mutableCopy];
188:     if(!NSThread.isMainThread || policy.blocked)return @0;
189:     NSUInteger epoch=CSCloseFriendAccountEpoch();
190:     for(CSGroupListAdapter *adapter in Adapters().allObjects) {
191:         if(CSGroupIsFoldedController(adapter.controller) || !adapter.cachedNativeSections || adapter.changeDepth || adapter.dirty ||
192:            adapter.snapshotRevision!=adapter.modelRevision || adapter.snapshotEpoch!=epoch || ![adapter.snapshotAccount isEqual:policy.accountID] ||
193:            ![policy.accountID isEqual:CSGroupCurrentAccountID()])continue;
194:         NSUInteger revision=adapter.modelRevision;
195:         NSArray *foldedNames=CSGroupCopyFoldedUserNames();
196:         NSArray *cacheKey=@[policy.accountID,@(epoch),@(revision),@(policy.revision),foldedNames ?: NSNull.null];
197:         if(adapter.alertBadge && [adapter.alertBadgeKey isEqual:cacheKey])return adapter.alertBadge;
198:         NSMutableSet *unmasked=[NSMutableSet set];
199:         CSGroupFoldedPrivacyState folded=CSGroupAssessFoldedUserNames(foldedNames,hidden);
200:         if(folded==CSGroupFoldedPrivacyAllHidden)[hidden addObject:@"chatroom_session_box"];
201:         else if(folded==CSGroupFoldedPrivacyNoHidden)[unmasked addObject:@"chatroom_session_box"];
202:         WESessionTabItem *all=[WESessionTabItem tabWithType:WETabTypeAll];
203:         CSGroupProjection *projection=[[CSGroupProjection alloc] initWithSections:adapter.cachedNativeSections tabs:@[all] selectedTabID:all.tabId
204:             filterDuplicates:NO accountID:policy.accountID hiddenUserNames:hidden unmaskedAggregateUserNames:unmasked privacyRevision:policy.revision previousProjection:nil];
205:         if(!projection.isValid || revision!=adapter.modelRevision || epoch!=CSCloseFriendAccountEpoch() || policy.revision!=CSCloseFriendCurrentSnapshot().revision)return @0;
206:         adapter.alertBadgeKey=cacheKey; adapter.alertBadge=@([projection badgeForTabID:all.tabId].count);
207:         return adapter.alertBadge;
208:     }
209:     return @0;
210: }
211: + (void)settingsChanged {
212:     dispatch_async(dispatch_get_main_queue(), ^{ for (CSGroupListAdapter *adapter in Adapters().allObjects) { @synchronized (adapter) { adapter.pendingChanges|=CSGroupChangeUnknown; } [adapter invalidateNativeSnapshot]; adapter.appearanceDirty=YES; [adapter refresh]; [adapter layout]; } });
213: }
214: + (void)closeFriendPolicyChanged:(NSNotification *)notification {
215:     (void)notification;
216:     if (!NSThread.isMainThread) {
217:         dispatch_async(dispatch_get_main_queue(), ^{ [self closeFriendPolicyChanged:notification]; }); return;
218:     }
219:     for (CSGroupListAdapter *adapter in Adapters().allObjects) {
220:         // Preserve the header and ordinary rows even if the native model is in a
221:         // transaction. Redact sensitive rows before attempting the safe publication.
222:         adapter.privacyRefreshPending=YES; adapter.dirty=YES;
223:         [adapter shieldVisiblePrivateRows];
224:         [adapter cancelScheduledRefresh]; [adapter invalidateNativeSnapshot];
225:         @synchronized (adapter) { adapter.pendingChanges|=CSGroupChangeUnknown; }
226:         [adapter refresh];
227:     }
228: }
```

263–275: native table proxies

```objc
263: - (id)nativeSource { return self.proxies[@0].target; }
264: - (void)installProxies {
265:     UITableView *table=self.table; if (!table) return;
266:     table.dataSource=[self proxyForTarget:table.dataSource role:0];
267:     table.delegate=[self proxyForTarget:table.delegate role:1];
268:     table.prefetchDataSource=[self proxyForTarget:table.prefetchDataSource role:2];
269: }
270: - (id)proxyForTarget:(id)target role:(NSUInteger)role {
271:     if ([target isKindOfClass:CSGroupTableProxy.class]) return target;
272:     CSGroupTableProxy *proxy=self.proxies[@(role)];
273:     if (!target) { proxy.target=nil; return nil; }
274:     if (!proxy) { proxy=[CSGroupTableProxy new]; proxy.adapter=self; self.proxies[@(role)]=proxy; }
275:     proxy.target=target; return proxy;
```

345–394: header and table layout boundary

```objc
345:     if (!self.table) return;
346:     self.updatingHeader=YES;
347:     @try { CSGroupWithDisplayIndices(self.table, ^{ self.table.tableHeaderView=header; }); }
348:     @finally { self.updatingHeader=NO; }
349: }
350: - (void)layout {
351:     UITableView *table=self.table; if (self.presentationSuspended || !CSGroupApplicationActive() || !table || self.updatingHeader) return;
352:     __block UIView *installed=nil;
353:     CSGroupWithDisplayIndices(table, ^{ installed=table.tableHeaderView; });
354:     // Search changes data/index ownership, not the header seen behind the
355:     // transition. Do not mount, hide or resize the native search view here: the
356:     // host may already have moved it into its search controller.
357:     if ([self keepsGroupHeaderDuringSearch]) {
358:         self.chrome.hidden=NO; self.chrome.userInteractionEnabled=NO;
359:         self.pan.enabled=NO; self.listPan.enabled=NO;
360:         if (installed!=self.headerContainer) [self publishHeader:self.headerContainer];
361:         table.decelerationRate=self.baselineDeceleration;
362:         return;
363:     }
364:     BOOL visible=self.chromeVisible && !self.searching;
365:     if (!visible) {
366:         self.chrome.hidden=YES;
367:         self.pan.enabled=NO; self.listPan.enabled=NO;
368:         if (installed!=self.nativeHeader) [self publishHeader:self.nativeHeader];
369:         table.decelerationRate=self.baselineDeceleration; return;
370:     }
371:     [self ensureChrome];
372:     self.chrome.userInteractionEnabled=YES;
373:     NSUserDefaults *defaults=NSUserDefaults.standardUserDefaults;
374:     [self.chrome applyAppearanceWithFontSize:CSGroupTabFontSize(defaults) showsSearchButton:CSGroupSearchButtonVisible(defaults)];
375:     if (!self.headerContainer) self.headerContainer=[UIView new];
376:     CGFloat width=CGRectGetWidth(table.bounds);
377:     CGFloat nativeHeight=MAX(0,CGRectGetHeight(self.nativeHeader.frame));
378:     CGFloat height=self.chrome.intrinsicContentSize.height;
379:     BOOL replacesNativeHeader=CSGroupSearchButtonVisible(defaults);
380:     CGFloat displayedNativeHeight=replacesNativeHeader ? 0 : nativeHeight;
381:     // The shortcut replaces the entire native search header, including decoration,
382:     // wrappers and padding. Keep its object and full height for native search/restore.
383:     if (replacesNativeHeader) [self.nativeHeader removeFromSuperview];
384:     else if (self.nativeHeader && self.nativeHeader.superview!=self.headerContainer) [self.headerContainer addSubview:self.nativeHeader];
385:     if (self.chrome.superview!=self.headerContainer) [self.headerContainer addSubview:self.chrome];
386:     self.nativeHeader.frame=CGRectMake(0,0,width,nativeHeight);
387:     self.chrome.frame=CGRectMake(0,displayedNativeHeight,width,height); self.chrome.hidden=NO;
388:     CGRect headerFrame=CGRectMake(0,0,width,displayedNativeHeight+height);
389:     BOOL resized=!CGRectEqualToRect(self.headerContainer.frame,headerFrame);
390:     self.headerContainer.frame=headerFrame;
391:     if (installed!=self.headerContainer || resized) [self publishHeader:self.headerContainer];
392:     NSInteger sensitivity=[NSUserDefaults.standardUserDefaults integerForKey:@"com.wechat.enhance.scroll_sensitivity"];
393:     table.decelerationRate=sensitivity==1 ? 0.998 : sensitivity==2 ? 0.9998 : sensitivity==3 ? 0.999 : self.baselineDeceleration;
394:     [self updateGroupGestureAvailability];
```

465–476: snapshot revision and cache rebuild

```objc
465: - (void)invalidateNativeSnapshot {
466:     @synchronized (self) { self.modelRevision++; }
467: }
468: - (NSArray *)nativeSectionsForAccount:(NSString *)account {
469:     NSUInteger revision=self.modelRevision, epoch=CSCloseFriendAccountEpoch();
470:     if (self.cachedNativeSections && self.snapshotRevision==revision && self.snapshotEpoch==epoch && [self.snapshotAccount isEqual:account]) return self.cachedNativeSections;
471:     __block NSArray *sections=nil;
472:     NSArray *previous=self.snapshotEpoch==epoch && [self.snapshotAccount isEqual:account] ? self.cachedNativeSections : nil;
473:     CSGroupWithNativeIndices(self.table, ^{ sections=CSGroupBuildNativeSectionsReusing(self.controller,self.table,[self nativeSource],previous); });
474:     // Only immutable row values are cached; never hold private sessions/contacts.
475:     if (revision!=self.modelRevision || epoch!=CSCloseFriendAccountEpoch() || ![account isEqual:CSGroupCurrentAccountID()]) { self.cachedNativeSections=nil; return nil; }
476:     self.cachedNativeSections=sections; self.snapshotAccount=account; self.snapshotRevision=revision; self.snapshotEpoch=epoch;
```

486–545: refresh guards; dirty cleared before native work; no-privacy branch

```objc
486: - (void)refresh {
487:     if (!NSThread.isMainThread) { [self requestRefresh]; return; }
488:     if (self.publishing) return;
489:     [self pruneNativeActions];
490:     // Explicit native navigation is the only offscreen publication exception.
491:     // Ordinary message/unread/draft updates merely invalidate the cached list.
492:     if ((!CSGroupApplicationActive() && !(self.privacyRefreshPending && CSGroupPrivacyActive())) || (self.presentationSuspended && !self.nativeActions.count)) {
493:         self.dirty=YES; [self finishSuspendedBatches]; return;
494:     }
495:     // A horizontal row swipe starts tracking before UIKit reports editing or
496:     // dragging. Reloading in that window replaces the cell under the finger.
497:     if (!self.privacyRefreshPending && !self.presentationSuspended && (self.table.tracking || [self groupPanMoving])) { self.dirty=YES; [self scheduleRefresh]; return; }
498:     NSUInteger menuState=(self.privacyRefreshPending || self.presentationSuspended) ? 0 : [self nativeMenuState];
499:     if (menuState) {
500:         self.dirty=YES;
501:         if (menuState&2) [self scheduleRefresh];
502:         return;
503:     }
504:     if (!self.presentationSuspended) [self reconcileDeletedSwipeRow];
505:     if (self.changeDepth || (!self.privacyRefreshPending && !self.presentationSuspended && (self.table.dragging || self.table.decelerating || self.table.editing || self.swipeActive))) { self.dirty=YES; return; }
506:     self.interactionDeadline=0; self.interactionAttempts=0;
507:     self.publishing=YES; self.dirty=NO;
508:     CSGroupChangeKind changes;
509:     @synchronized (self) { changes=self.pendingChanges; self.pendingChanges=0; }
510:     self.recoveryPending=NO;
511:     BOOL finished=NO;
512:     @try {
513:         [self saveAnchor];
514:         [self installProxies];
515:         NSString *account=CSGroupCurrentAccountID();
516:         BOOL changed= ![self.preferences.accountID isEqualToString:account];
517:         if (changed) { self.anchors=[NSMutableDictionary dictionary]; self.nativePresentation=self.nativeActions.count>0; self.projection=nil; self.snapshotRetryAttempted=NO; self.searchChromeVisible=NO; }
518:         self.searching=CSGroupReadInteger(self.controller,@"isSearching",0)!=0;
519:         if (!self.searching) self.searchChromeVisible=NO;
520:         BOOL enabled=Option(@"enabled");
521:         BOOL privacy=CSGroupPrivacyActive();
522:         // Search owns a separate page. Preserve the selected list behind its
523:         // transition instead of publishing unfiltered rows underneath group tabs.
524:         // Explicit result navigation may still require native coordinates.
525:         BOOL keepsSearchGroup=enabled && self.searching && self.searchChromeVisible && account.length && !changed &&
526:             !self.nativePresentation && !self.nativeActions.count;
527:         if (keepsSearchGroup && !self.privacyRefreshPending && self.projecting) {
528:             @synchronized (self) { self.pendingChanges|=changes|CSGroupChangeUnknown; }
529:             self.cachedNativeSections=nil; [self.projection discardComputationCache];
530:             [self layout]; finished=YES; return;
531:         }
532:         if ((!privacy && (!enabled || (self.searching && !keepsSearchGroup))) || !account.length) {
533:             BOOL needsReload=self.projecting || self.nativeActions.count>0;
534:             BOOL hadChrome=self.chromeVisible;
535:             self.projecting=NO; self.chromeVisible=NO; self.publishedEnabled=enabled;
536:             self.projection=nil; self.identityDisplayPaths=nil; self.cachedNativeSections=nil;
537:             [self layout];
538:             if (needsReload) CSGroupWithDisplayIndices(self.table, ^{
539:                 [self.privacyShield prepareForPublication];
540:                 [self.table reloadData]; [self.table layoutIfNeeded];
541:             });
542:             if (hadChrome) [self refreshNavigationTitle];
543:             finished=YES; return;
544:         }
545:         if (!self.preferences || changed) self.preferences=[[CSGroupPreferences alloc] initWithDefaults:NSUserDefaults.standardUserDefaults accountID:account];
```

547–638: cache/projection publication and native table callbacks

```objc
547:         [self ensureChrome];
548:         NSArray *tabs=self.preferences.tabs; NSString *selected=self.preferences.selectedTabID;
549:         // A privacy change during search must rebuild this same group. It must
550:         // neither retain newly hidden rows nor replace the transition with All.
551:         if (self.nativePresentation || !enabled || (self.searching && !keepsSearchGroup)) {
552:             selected=@"preset_0";
553:             if (![tabs filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(WESessionTabItem *tab, NSDictionary *bindings) { (void)bindings; return [tab.tabId isEqual:selected]; }]].count)
554:                 tabs=[@[[WESessionTabItem tabWithType:WETabTypeAll]] arrayByAddingObjectsFromArray:tabs];
555:         }
556:         CSGroupProjection *previous=self.projection;
557:         BOOL previouslyProjecting=self.projecting;
558:         NSArray *sections=(self.nativePresentation && !privacy) ? nil : [self nativeSectionsForAccount:account];
559:         CSGroupProjection *projection=(self.nativePresentation && !privacy) ? nil : [self projectionForSections:sections tabs:tabs selectedTabID:selected accountID:account];
560:         self.projection=projection;
561:         if (![projection hasSameDisplayStructureAs:previous]) {
562:             NSMutableDictionary *identities=[NSMutableDictionary dictionary];
563:             [self.projection.sections enumerateObjectsUsingBlock:^(NSArray *rows, NSUInteger s, BOOL *stop) {
564:                 (void)stop; [rows enumerateObjectsUsingBlock:^(CSGroupRow *row, NSUInteger r, BOOL *end) {
565:                     (void)end; if (row.userName.length) identities[row.userName]=identities[row.userName] ? (id)NSNull.null : [NSIndexPath indexPathForRow:(NSInteger)r inSection:(NSInteger)s];
566:                 }];
567:             }]; self.identityDisplayPaths=identities;
568:         }
569:         self.displayedTabs=tabs;
570:         BOOL projecting=(privacy || (enabled && (!self.searching || keepsSearchGroup) && !self.nativePresentation)) && self.projection.isValid && account.length>0;
571:         if (projecting && self.prefetchedPaths.count) {
572:             id prefetch=self.proxies[@2].target;
573:             NSArray *paths=self.prefetchedPaths.allObjects;
574:             CSGroupWithNativeIndices(self.table, ^{ if ([prefetch respondsToSelector:@selector(tableView:cancelPrefetchingForRowsAtIndexPaths:)]) [prefetch tableView:self.table cancelPrefetchingForRowsAtIndexPaths:paths]; });
575:             [self.prefetchedPaths removeAllObjects];
576:         }
577:         self.projecting=projecting;
578:         self.chromeVisible=enabled && !CSGroupIsFoldedController(self.controller) && (!self.searching || keepsSearchGroup) && account.length>0;
579:         self.publishedEnabled=Option(@"enabled");
580:         self.publishedTabID=selected;
581:         if (self.appearanceDirty) { [self.chrome refreshAppearance]; self.appearanceDirty=NO; }
582:         self.chrome.selectedTabID=selected; [self.chrome updateTabs:tabs]; self.chrome.selectedTabID=selected;
583:         id logic=CSGroupReadObject(self.controller,@"m_mainFrameLogicController");
584:         [tabs enumerateObjectsUsingBlock:^(WESessionTabItem *tab, NSUInteger index, BOOL *stop) {
585:             (void)stop; if (!projection && tab.type!=WETabTypeAll) return;
586:             CSGroupBadge *badge=[projection badgeForTabID:tab.tabId];
587:             NSInteger count=tab.type==WETabTypeAll && !privacy ? (NSInteger)MAX(0,CSGroupReadInteger(logic,@"getTotalUnreadCount",(long long)badge.count)) : (NSInteger)MIN(badge.count,(NSUInteger)NSIntegerMax);
588:             BOOL hidden=Option(tab.type==WETabTypeAll ? @"hide_all_badge" : @"hide_group_badge");
589:             [self.chrome updateUnreadCount:hidden ? 0 : count hasRedDot:!hidden && badge.redDot forTabIndex:(NSInteger)index];
590:         }];
591:         [self layout];
592:         [self.privacyShield prepareForPublication];
593:         [self publishProjection:projection previous:previous changes:changes previouslyProjecting:previouslyProjecting];
594:         [self restoreAnchor];
595:         [self refreshNavigationTitle];
596:         finished=YES;
597:     } @finally {
598:         self.publishing=NO;
599:         if (!finished && self.privacyRefreshPending) [self shieldVisiblePrivateRows];
600:         if (finished) {
601:             self.privacyRefreshPending=NO;
602:             if (CSCloseFriendCurrentSnapshot().blocked && !CSGroupCurrentAccountID().length)
603:                 [self shieldVisiblePrivateRows];
604:             else
605:                 [self.privacyShield prepareForPublication];
606:         }
607:         if (finished) [self applyPendingScrollToTop];
608:         NSArray *callbacks=[self.completions copy]; [self.completions removeAllObjects];
609:         for (void (^completion)(BOOL) in callbacks) completion(finished);
610:         if (finished && CSGroupApplicationActive() && (!self.isActive || CSGroupPrivacyActive()) && !self.changeDepth) {
611:             NSArray *actions=[self.nativeActions copy]; [self.nativeActions removeAllObjects];
612:             for (void (^action)(void) in actions) CSGroupWithNativeIndices(self.table,action);
613:         }
614:         if (self.dirty) [self scheduleRefresh];
615:     }
616: }
617: - (void)publishProjection:(CSGroupProjection *)projection previous:(CSGroupProjection *)previous
618:                   changes:(CSGroupChangeKind)changes previouslyProjecting:(BOOL)previouslyProjecting {
619:     BOOL incremental=previouslyProjecting && self.projecting && !self.pendingScrollToTop &&
620:         !(changes&CSGroupChangeUnknown) && [projection hasSameDisplayStructureAs:previous];
621:     // Anonymous banners can change intrinsic geometry without a session event.
622:     if (incremental) for (NSArray *section in projection.sections) for (CSGroupRow *row in section)
623:         if (!row.userName.length || row.kind==CSGroupRowKindBusiness || row.kind==CSGroupRowKindAggregate) incremental=NO;
624:     CSGroupWithDisplayIndices(self.table, ^{
625:         if (!incremental) [self.table reloadData];
626:         else {
627:             NSArray *visible=self.table.indexPathsForVisibleRows ?: @[];
628:             NSArray *changed=[projection changedUnreadPathsFrom:previous];
629:             NSMutableArray *reload=[NSMutableArray array];
630:             for (NSIndexPath *path in visible) {
631:                 if (![projection rowAtDisplayPath:path]) continue;
632:                 if ((changes&(CSGroupChangeContent|CSGroupChangeStructure)) || [changed containsObject:path]) [reload addObject:path];
633:             }
634:             if (reload.count) [self.table reloadRowsAtIndexPaths:reload withRowAnimation:UITableViewRowAnimationNone];
635:         }
636:         [self.table layoutIfNeeded];
637:     });
638: }
```

695–777: refresh scheduling and native mutation depth

```objc
695:     // Do not invent a model revision for a failed rendering attempt. All failures
696:     // of the same account/revision share one finite retry budget.
697:     self.cachedNativeSections=nil;
698:     [self scheduleRefresh];
699: }
700: - (void)requestRefresh {
701:     if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self requestRefresh]; }); return; }
702:     if (self.publishing && !self.changeDepth && !self.nativeActions.count) { [self requestRecovery]; return; }
703:     self.dirty=YES;
704:     if (!self.changeDepth) { self.recoveryPending=NO; @synchronized (self) { self.pendingChanges|=CSGroupChangeUnknown; } [self invalidateNativeSnapshot]; }
705:     [self scheduleRefresh];
706: }
707: - (void)scheduleRefresh {
708:     if (!NSThread.isMainThread) { dispatch_async(dispatch_get_main_queue(), ^{ [self scheduleRefresh]; }); return; }
709:     self.dirty=YES;
710:     [self pruneNativeActions];
711:     if ((!CSGroupApplicationActive() && !(self.privacyRefreshPending && CSGroupPrivacyActive())) || (self.presentationSuspended && !self.nativeActions.count)) { [self finishSuspendedBatches]; return; }
712:     if (self.changeDepth || self.publishing) return;
713:     BOOL coalesced=!self.privacyRefreshPending && self.coalescingNotification && !self.nativeActions.count;
714:     BOOL waiting=!self.privacyRefreshPending && !self.presentationSuspended && (self.table.tracking || [self groupPanMoving] || ([self nativeMenuState]&2));
715:     BOOL releasedWait=self.scheduledInteraction && !waiting;
716:     BOOL freshEvent=self.scheduledRecovery && !self.recoveryPending;
717:     if (self.scheduled && !releasedWait && !freshEvent && (!self.scheduledCoalesced || coalesced)) return;
718:     NSTimeInterval delay=coalesced ? 0.08 : 0;
719:     if (waiting) {
720:         NSTimeInterval now=NSProcessInfo.processInfo.systemUptime;
721:         if (!self.interactionDeadline) self.interactionDeadline=now+2.0;
722:         if (now>=self.interactionDeadline) return; // Keep dirty; actual end/lifecycle events wake it.
723:         delay=MIN(self.interactionDeadline-now,MIN(0.4,0.05*(1UL<<MIN(self.interactionAttempts++,3UL))));
724:     } else { self.interactionDeadline=0; self.interactionAttempts=0; }
725:     if (self.recoveryPending && !waiting) {
726:         NSString *account=CSGroupCurrentAccountID();
727:         BOOL sameAccount=self.recoveryAccount==account || [self.recoveryAccount isEqual:account];
728:         if (self.recoveryRevision!=self.modelRevision || !sameAccount) {
729:             self.recoveryRevision=self.modelRevision; self.recoveryAccount=account; self.recoveryAttempts=0;
730:         }
731:         if (self.recoveryAttempts>=3) return;
732:         static const NSTimeInterval delays[]={0.1,0.25,0.5};
733:         delay=MAX(delay,delays[self.recoveryAttempts++]);
734:     }
735:     self.scheduled=YES; self.scheduledCoalesced=coalesced; self.scheduledInteraction=waiting; self.scheduledRecovery=self.recoveryPending && !waiting;
736:     NSUInteger generation=++self.refreshGeneration;
737:     __weak typeof(self) weakSelf=self;
738:     void (^publish)(void)=^{
739:         CSGroupListAdapter *self=weakSelf;
740:         if (!self || generation!=self.refreshGeneration) return;
741:         self.scheduled=NO;
742:         if (self.dirty) [self refresh];
743:     };
744:     if (delay>0) dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(delay*NSEC_PER_SEC)),dispatch_get_main_queue(),publish);
745:     else dispatch_async(dispatch_get_main_queue(),publish);
746: }
747: - (void)requestCoalescedRefresh {
748:     if (!NSThread.isMainThread) {
749:         @synchronized (self) { if (self.coalescedDispatchPending) return; self.coalescedDispatchPending=YES; }
750:         dispatch_async(dispatch_get_main_queue(), ^{
751:             @synchronized (self) { self.coalescedDispatchPending=NO; }
752:             [self requestCoalescedRefresh];
753:         });
754:         return;
755:     }
756:     self.dirty=YES;
757:     self.coalescingNotification=YES;
758:     @try { [self scheduleRefresh]; } @finally { self.coalescingNotification=NO; }
759: }
760: 
761: - (void)beginNativeChange { [self beginNativeChangeOfKind:CSGroupChangeStructure|CSGroupChangeContent]; }
762: - (void)beginNativeChangeOfKind:(CSGroupChangeKind)kind {
763:     [self invalidateNativeSnapshot];
764:     BOOL captureAnchor=NO;
765:     @synchronized (self) {
766:         self.recoveryPending=NO; self.pendingChanges|=kind;
767:         captureAnchor=!self.changeDepth && NSThread.isMainThread && !self.presentationSuspended && !(self.dirty && self.scheduledCoalesced);
768:         self.changeDepth++;
769:     }
770:     // Native/UI reads must not hold the lock used by background notifications.
771:     if (captureAnchor) [self saveAnchor];
772: }
773: - (void)endNativeChange { [self endNativeChangeCoalesced:NO]; }
774: - (void)endNativeChangeCoalesced:(BOOL)coalesced {
775:     BOOL outer=NO; @synchronized (self) { if (self.changeDepth) self.changeDepth--; outer=self.changeDepth==0; }
776:     if (outer) { if (coalesced) [self requestCoalescedRefresh]; else [self scheduleRefresh]; }
777: }
```

789–819: pending native navigation actions

```objc
789:     if (!self.isActive || self.swipeActive || self.table.editing || [self nativeMenuState]) return;
790:     [self saveAnchor]; self.nativePresentation=YES; [self.table setEditing:NO animated:NO]; [self refresh];
791: }
792: - (void)performInNativePresentation:(void (^)(void))action {
793:     NSString *account=CSGroupCurrentAccountID(); if (!account.length) return;
794:     NSUInteger epoch=CSCloseFriendAccountEpoch();
795:     void (^guarded)(void)=^{ if (epoch==CSCloseFriendAccountEpoch() && CSGroupApplicationActive() && [account isEqualToString:CSGroupCurrentAccountID()]) action(); };
796:     if (CSGroupApplicationActive() && !self.isActive && !self.publishing && !self.changeDepth) { CSGroupWithNativeIndices(self.table,guarded); return; }
797:     [self pruneNativeActions];
798:     self.nativeActionsAccount=account;
799:     [self.nativeActions addObject:[guarded copy]];
800:     if (!CSGroupApplicationActive()) { self.nativePresentation=YES; self.dirty=YES; return; }
801:     if (self.publishing) {
802:         self.nativePresentation=YES; [self requestRefresh]; return;
803:     }
804:     if (self.presentationSuspended) {
805:         // Search/next-chat navigation can target the main list from another page.
806:         // Publish native coordinates once for that action, then remain suspended.
807:         self.nativePresentation=YES; [self refresh]; return;
808:     }
809:     if (self.swipeActive || self.table.editing || [self nativeMenuState]) {
810:         // Native navigation waits for the menu to close; do not discard its queued action.
811:         self.nativePresentation=YES; [self requestRefresh]; return;
812:     }
813:     [self useNativePresentation];
814: }
815: - (BOOL)navigatePrivateSessionsForward:(BOOL)forward unreadOnly:(BOOL)unreadOnly {
816:     if (!CSGroupPrivacyActive()) return NO;
817:     if (!NSThread.isMainThread || !CSGroupApplicationActive() || self.changeDepth || self.publishing) return YES;
818:     NSUInteger epoch=CSCloseFriendAccountEpoch();
819:     NSString *account=CSGroupCurrentAccountID();
```

972–982: native cell callback

```objc
972: }
973: - (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target {
974:     BOOL projected=self.isActive && !CSGroupUsesNativeIndices(self.table);
975:     CSGroupRow *row=projected ? [self.projection rowAtDisplayPath:path] : nil;
976:     NSIndexPath *native=projected ? [self currentPathForRow:row] : path;
977:     __block UITableViewCell *cell=nil;
978:     if (native && [target respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)])
979:         CSGroupWithNativeIndices(self.table, ^{ cell=[target tableView:self.table cellForRowAtIndexPath:native]; });
980:     if (!cell) {
981:         // Required data-source callbacks must return a cell even while an old identity disappears.
982:         cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
```

1002–1052: native callback forwarding

```objc
1002:         NSDictionary *delivery=objc_getAssociatedObject(cell,&CellRowKey);
1003:         if (delivery) {
1004:             if (![delivery[@"account"] isEqual:CSGroupCurrentAccountID()]) return;
1005:             cellRow=delivery[@"row"];
1006:             if (!self.isActive || CSGroupUsesNativeIndices(self.table)) {
1007:                 if (!CSGroupMapInvocationPaths(inv, ^NSIndexPath *(NSIndexPath *path) { (void)path; return [self currentPathForRow:cellRow]; })) return;
1008:                 CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; }); CSCloseFriendRefreshSessionCover(cell); return;
1009:             }
1010:         } else if (self.publishing && [name isEqual:@"tableView:didEndDisplayingCell:forRowAtIndexPath:"]) {
1011:             // Cells delivered before activation were native and never carried projected coordinates.
1012:             CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; }); CSCloseFriendRefreshSessionCover(cell); return;
1013:         }
1014:     }
1015:     BOOL prefetch=[name isEqual:@"tableView:prefetchRowsAtIndexPaths:"];
1016:     BOOL cancelPrefetch=[name isEqual:@"tableView:cancelPrefetchingForRowsAtIndexPaths:"];
1017:     if (prefetch || cancelPrefetch) {
1018:         // Native prefetch cancellation captures positions. It stays disabled in projected lists.
1019:         if (self.isActive) return;
1020:         __unsafe_unretained NSArray *paths=nil; [inv getArgument:&paths atIndex:3];
1021:         if (prefetch) [self.prefetchedPaths addObjectsFromArray:paths]; else [self.prefetchedPaths minusSet:[NSSet setWithArray:paths]];
1022:     }
1023:     if (!self.isActive || CSGroupUsesNativeIndices(self.table)) {
1024:         CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; });
1025:         if (cellLifecycle) CSCloseFriendRefreshSessionCover(cell);
1026:         if ((self.dirty || self.pendingScrollToTop) && ([name isEqual:@"scrollViewDidEndDecelerating:"] || [name isEqual:@"scrollViewDidEndDragging:willDecelerate:"] || [name isEqual:@"tableView:didEndEditingRowAtIndexPath:"])) [self scheduleRefresh];
1027:         return;
1028:     }
1029:     if ([name isEqual:@"numberOfSectionsInTableView:"]) { NSInteger count=(NSInteger)self.projection.sections.count; [inv setReturnValue:&count]; return; }
1030:     if ([name isEqual:@"tableView:numberOfRowsInSection:"]) {
1031:         NSInteger section=0; [inv getArgument:&section atIndex:3];
1032:         NSInteger count=section>=0 && section<(NSInteger)self.projection.sections.count ? (NSInteger)self.projection.sections[(NSUInteger)section].count : 0;
1033:         [inv setReturnValue:&count]; return;
1034:     }
1035:     // Optional queries and unsupported coordinate/block callbacks do not express
1036:     // a request to select All. Keep the initialized neutral return and selection.
1037:     if (!CSGroupInvocationIsSupported(inv.selector) || [@[@"tableView:shouldShowMenuForRowAtIndexPath:",@"tableView:moveRowAtIndexPath:toIndexPath:",@"tableView:performAction:forRowAtIndexPath:withSender:"] containsObject:name]) return;
1038:     __block CSGroupRow *deliveredRow=nil;
1039:     BOOL mapped=CSGroupMapInvocationPaths(inv, ^NSIndexPath *(NSIndexPath *path) {
1040:         deliveredRow=cellRow ?: [self.projection rowAtDisplayPath:path];
1041:         BOOL action=[name containsString:@"didSelectRow"] || [name containsString:@"commitEditingStyle"] || [name containsString:@"moveRowAt"] || [name containsString:@"performAction:"];
1042:         if (action && !deliveredRow.userName.length) return nil;
1043:         return [self currentPathForRow:deliveredRow];
1044:     });
1045:     if (!mapped) {
1046:         if ([name isEqual:@"tableView:heightForRowAtIndexPath:"] || [name isEqual:@"tableView:estimatedHeightForRowAtIndexPath:"]) {
1047:             CGFloat height=44; [inv setReturnValue:&height]; [self requestRecovery];
1048:         } else if (!cellLifecycle) [self requestRecovery];
1049:         return;
1050:     }
1051:     CSGroupWithNativeIndices(self.table, ^{ [inv invokeWithTarget:target]; });
1052:     if (cellLifecycle) CSCloseFriendRefreshSessionCover(cell);
```

1173–1190: native title callback

```objc
1173: - (void)refreshNavigationTitle {
1174:     if (self.presentationSuspended || !CSGroupApplicationActive()) return;
1175:     id titleView=CSGroupReadObject(self.controller,@"m_titleView");
1176:     NSDictionary *before=objc_getAssociatedObject(titleView,&TitleContextKey);
1177:     SEL selector=NSSelectorFromString(@"updateTitleView");
1178:     if ([self.controller respondsToSelector:selector]) ((void(*)(id,SEL))objc_msgSend)(self.controller,selector);
1179:     // Native updateTitleView may skip an unchanged "WeChat" title. Replaying its
1180:     // last input still updates the group name, without changing its cached title
1181:     // or inventing a status flag. The hook resolves the new group at render time.
1182:     if (before && before==objc_getAssociatedObject(titleView,&TitleContextKey)) {
1183:         SEL render=NSSelectorFromString(@"updateTitleView:title:");
1184:         NSString *title=before[@"title"]==NSNull.null ? nil : before[@"title"];
1185:         if ([titleView respondsToSelector:render])
1186:             ((void(*)(id,SEL,unsigned int,id))objc_msgSend)(titleView,render,[before[@"status"] unsignedIntValue],title);
1187:     }
1188: }
1189: - (BOOL)groupSwipesAvailable {
1190:     return self.table && Option(@"enabled") && Option(@"swipe_gesture_enabled") && self.chromeVisible && !self.searching;
```

## Controllers/CSGroupIndexScope.m

SHA-256: `ea8ef3cd22b8632bca9999bee45250672ba1b4b5d6a4e41e6fff8051c1ffb780`

1–17: index domain is a scope, not a native-call suppression barrier

```objc
1: #import "CSGroupIndexScope.h"
2: static NSString *const ScopeKey=@"CSGroupIndexScope.stack";
3: BOOL CSGroupUsesNativeIndices(id table) {
4:     for (NSArray *entry in [NSThread.currentThread.threadDictionary[ScopeKey] reverseObjectEnumerator])
5:         if (entry[0]==table) return [entry[1] boolValue];
6:     return NO;
7: }
8: static void WithDomain(id table, BOOL native, void (^block)(void)) {
9:     NSMutableDictionary *dictionary=NSThread.currentThread.threadDictionary;
10:     NSMutableArray *stack=dictionary[ScopeKey];
11:     if (!stack) dictionary[ScopeKey]=stack=[NSMutableArray array];
12:     [stack addObject:@[table,@(native)]];
13:     @try { block(); }
14:     @finally { [stack removeLastObject]; if (!stack.count) [dictionary removeObjectForKey:ScopeKey]; }
15: }
16: void CSGroupWithNativeIndices(id table, void (^block)(void)) { WithDomain(table,YES,block); }
17: void CSGroupWithDisplayIndices(id table, void (^block)(void)) { WithDomain(table,NO,block); }
```

## Controllers/CSGroupNativeBridge.m

SHA-256: `aa352dd26bbb41b0446994689e91d7ed8427e2ff81ddb0f8a51e69664e618475`

204–218: current-account service reads

```objc
204: NSString *CSGroupCurrentAccountID(void) {
205:     for (NSArray *entry in @[@[@"MMContext",@"currentUserName"],@[@"SettingUtil",@"getCurUsrName"]]) {
206:         id provider=NSClassFromString(entry[0]);
207:         NSMethodSignature *signature=Signature(provider,NSSelectorFromString(entry[1]),2);
208:         if (signature && ObjectType(signature.methodReturnType)) {
209:             id value=CSGroupReadObject(provider,entry[1]);
210:             // An available authoritative accessor returning nil means logged out.
211:             return [value isKindOfClass:NSString.class] && [value length]>0 ? [value copy] : nil;
212:         }
213:     }
214:     id contact=CSGroupReadObject(CSGetService(NSClassFromString(@"CContactMgr")),@"getSelfContact");
215:     id value=CSGroupReadObject(contact,@"m_nsUsrName");
216:     return [value isKindOfClass:NSString.class] && [value length]>0 ? [value copy] : nil;
217: }
218: static BOOL ServiceName(NSString *name) {
```

## Hooks/SessionGroupHooks.xm

SHA-256: `5716f9e7dc6158c13162bcad8e7ee45f7099901f61e3d0fde970f7bbf7888a46`

33–56: native notification mutation transaction and publishing predicate

```objc
33: 
34: static CSGroupListAdapter *Adapter(id owner) {
35:     CSGroupListAdapter *a=[CSGroupListAdapter adapterForController:owner];
36:     if (!a) a=[CSGroupListAdapter adapterForController:CSGroupReadObject(owner,@"m_delegate")];
37:     return a;
38: }
39: static void Native(id owner, BOOL change, void (^body)(void)) {
40:     CSGroupListAdapter *a=Adapter(owner);
41:     if (!a.table) { body(); return; }
42:     if (change) [a beginNativeChange];
43:     @try { CSGroupWithNativeIndices(a.table,body); }
44:     @finally { if (change) [a endNativeChange]; }
45: }
46: static void NativeNotification(id owner, CSGroupChangeKind kind, void (^body)(void)) {
47:     CSGroupListAdapter *a=Adapter(owner);
48:     if (!a.table) { body(); return; }
49:     [a beginNativeChangeOfKind:kind];
50:     @try { CSGroupWithNativeIndices(a.table,body); }
51:     @finally { [a endNativeChangeCoalesced:YES]; }
52: }
53: static BOOL Projected(CSGroupListAdapter *a) { return a.isActive && !a.publishing; }
54: static void SettingsChanged(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef info) {
55:     (void)center; (void)observer; (void)name; (void)object; (void)info;
56:     [CSGroupListAdapter settingsChanged];
```

59–101: main-list appear/disappear and message callbacks

```objc
59: %hook NewMainFrameViewController
60: - (void)viewDidLoad { %orig; [CSGroupListAdapter attachToController:self]; }
61: - (void)initView { %orig; [CSGroupListAdapter attachToController:self]; }
62: - (void)viewWillAppear:(BOOL)animated {
63:     [CSGroupListAdapter setPresentationSuspended:NO forController:self];
64:     Native(self,NO,^{ %orig; });
65:     [CSGroupListAdapter attachToController:self];
66: }
67: - (void)viewDidAppear:(BOOL)animated {
68:     [CSGroupListAdapter setPresentationSuspended:NO forController:self];
69:     Native(self,NO,^{ %orig; });
70:     [CSGroupListAdapter attachToController:self];
71:     [Adapter(self) returnToGroupTop];
72: }
73: - (void)viewWillDisappear:(BOOL)animated {
74:     [CSGroupListAdapter setPresentationSuspended:YES forController:self];
75:     Native(self,NO,^{ %orig; });
76: }
77: - (void)viewDidDisappear:(BOOL)animated {
78:     [CSGroupListAdapter setPresentationSuspended:YES forController:self];
79:     Native(self,NO,^{ %orig; });
80: }
81: - (void)viewDidLayoutSubviews { Native(self,NO,^{ %orig; }); [CSGroupListAdapter layoutForController:self]; }
82: - (void)initTableHeaderView { Native(self,NO,^{ %orig; }); [CSGroupListAdapter layoutForController:self]; }
83: - (void)setSearchBarToTableHeaderView { Native(self,NO,^{ %orig; }); [CSGroupListAdapter layoutForController:self]; }
84: - (void)onSearch { [Adapter(self) prepareForNativeSearch]; Native(self,NO,^{ %orig; }); [Adapter(self) requestRefresh]; }
85: - (void)setSearchBarActive:(BOOL)active { if (active) [Adapter(self) prepareForNativeSearch]; Native(self,NO,^{ %orig; }); [Adapter(self) refresh]; }
86: - (void)onFTSSearchEnd { Native(self,NO,^{ %orig; }); [Adapter(self) refresh]; }
87: - (void)cancelSearch { Native(self,NO,^{ %orig; }); [Adapter(self) refresh]; }
88: - (id)previewingContext:(id)context viewControllerForLocation:(CGPoint)point {
89:     CSGroupListAdapter *a=Adapter(self);
90:     if (a.isActive) return nil; // An incidental preview must not change the selected group.
91:     __block id result=nil; Native(self,NO,^{ result=%orig; }); return result;
92: }
93: - (void)newMessageByContact:(id)contact msgWrapToAdd:(id)wrap { NativeNotification(self,CSGroupChangeContent|CSGroupChangeStructure,^{ %orig; }); }
94: - (void)updateSession:(id)session { NativeNotification(self,CSGroupChangeContent|CSGroupChangeStructure,^{ %orig; }); }
95: - (void)reloadSessions { Native(self,YES,^{ %orig; }); }
96: - (void)updateItem:(id)item { Native(self,YES,^{ %orig; }); }
97: - (void)insertSessionCellAtIndexes:(id)paths { Native(self,YES,^{ %orig; }); }
98: - (void)deleteSessionCellAtIndexes:(id)paths { Native(self,YES,^{ %orig; }); }
99: - (void)onLogicDeleteSessionByUsername:(id)name { Native(self,YES,^{ %orig; }); }
100: - (void)logicUpdateSession:(id)session { NativeNotification(self,CSGroupChangeContent|CSGroupChangeStructure,^{ %orig; }); }
101: - (void)onAuthOK { Native(self,YES,^{ %orig; }); }
```

196–204: unread-count and session notifications

```objc
196: %hook MainFrameLogicController
197: - (void)onSessionRebuildBegin { [Adapter(self) beginNativeChange]; Native(self,NO,^{ %orig; }); }
198: - (void)onSessionRebuildEnd { @try { Native(self,NO,^{ %orig; }); } @finally { [Adapter(self) endNativeChange]; } }
199: - (void)onActiveUsrNameChange:(id)oldName curUsrName:(id)newName { Native(self,YES,^{ %orig; }); }
200: - (void)onSessionTotalUnreadCountChange:(unsigned int)count { NativeNotification(self,CSGroupChangeUnread,^{ %orig; }); }
201: - (void)onSessionChanged:(id)session { NativeNotification(self,CSGroupChangeContent|CSGroupChangeStructure,^{ %orig; }); }
202: - (void)onSessionTopStatusChanged:(id)session bTop:(BOOL)top { Native(self,YES,^{ %orig; }); }
203: - (void)onMainSessionReload { Native(self,YES,^{ %orig; }); }
204: %end
```

312–338: table reload falls through original while publishing

```objc
312: - (void)reloadData {
313:     CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
314:     if (!a) { %orig; return; } // Chat and other tables need no grouping index scope.
315:     if (Projected(a)) { [a requestRefresh]; return; }
316:     CSGroupWithDisplayIndices(self, ^{ %orig; });
317: }
318: - (void)beginUpdates {
319:     CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
320:     if (Projected(a)) { [a beginNativeChange]; return; } %orig;
321: }
322: - (void)endUpdates {
323:     CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
324:     if (a.changeDepth && !a.publishing) { [a endNativeChange]; return; } %orig;
325: }
326: - (void)performBatchUpdates:(void (^)(void))updates completion:(void (^)(BOOL))completion {
327:     CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
328:     if (Projected(a)) { [a performNativeBatch:updates completion:completion]; return; } %orig;
329: }
330: - (void)insertRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(UITableViewRowAnimation)animation {
331:     CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
332:     if (Projected(a)) { [a requestRefresh]; return; } %orig;
333: }
334: - (void)deleteRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(UITableViewRowAnimation)animation {
335:     CSGroupListAdapter *a=[CSGroupListAdapter adapterForTable:self];
336:     if (Projected(a)) { [a requestRefresh]; return; } %orig;
337: }
338: - (void)reloadRowsAtIndexPaths:(NSArray *)paths withRowAnimation:(UITableViewRowAnimation)animation {
```

499–510: group observer registered behind readiness gate

```objc
499: %ctor {
500:     CSBackupWhenReady(^{
501:         InstallMenuTouchGate();
502:         InstallFoldedSessionHooks();
503:         [NSNotificationCenter.defaultCenter addObserver:CSGroupListAdapter.class selector:@selector(closeFriendPolicyChanged:) name:CSCloseFriendPolicyDidChangeNotification object:nil];
504:         for (NSString *name in @[UIApplicationWillResignActiveNotification,UIApplicationDidEnterBackgroundNotification,UIApplicationDidBecomeActiveNotification])
505:             [NSNotificationCenter.defaultCenter addObserver:CSGroupListAdapter.class selector:@selector(applicationActivityChanged:) name:name object:nil];
506:         CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,SettingsChanged,
507:             CFSTR("com.wechat.enhance.chat_group.settings_changed"),NULL,CFNotificationSuspensionBehaviorDeliverImmediately);
508:         %init;
509:     });
510: }
```

## Hooks/CloseFriendNotificationHooks.xm

SHA-256: `00c1236f230dd2ffd36ce1d0a8852046aa8bda72325ca508bbd6e0171aa0aef3`

27–35: ChatTab predicate and deferred constructor

```objc
27: static BOOL ChatTab(id controller,NSUInteger index) {
28:     id views=CSCloseFriendRead(controller,@"viewControllers");if(![views isKindOfClass:NSArray.class] || index>=[views count])return NO;
29:     id root=views[index];if([root isKindOfClass:UINavigationController.class])root=[root viewControllers].firstObject;
30:     Class cls=NSClassFromString(@"NewMainFrameViewController");BOOL matches=cls && [root isKindOfClass:cls];
31:     if(matches && NSThread.isMainThread)[TabOwners addObject:controller];return matches;
32: }
33: %ctor { dispatch_async(dispatch_get_main_queue(),^{
34:     Requests=[NSMutableDictionary dictionary]; TabOwners=[NSHashTable weakObjectsHashTable];
35:     for(NSString *name in @[@"showQuickReplyItem:",@"showQuickReplyItem:timeout:"]) {
```

101–127: content hooks and policy observer force-write path

```objc
101:     __block IMP badge=NULL;
102:     imp=imp_implementationWithBlock(^(id app,NSInteger count){NSNumber *value=[CSGroupListAdapter closeFriendAlertBadgeCount];((void(*)(id,SEL,NSInteger))badge)(app,@selector(setApplicationIconBadgeNumber:),value?value.integerValue:count);});
103:     if(!CSCloseFriendInstallHook(@"UIApplication",@"setApplicationIconBadgeNumber:",imp,&badge,"v@:q"))imp_removeBlock(imp);
104:     __block IMP tab=NULL;
105:     imp=imp_implementationWithBlock(^(id owner,unsigned long long count,unsigned long long index){NSNumber *value=ChatTab(owner,(NSUInteger)index)?[CSGroupListAdapter closeFriendAlertBadgeCount]:nil;((void(*)(id,SEL,unsigned long long,unsigned long long))tab)(owner,NSSelectorFromString(@"setTabBarBadgeValue:forIndex:"),value?value.unsignedLongLongValue:count,index);});
106:     if(!CSCloseFriendInstallHook(@"MMTabBarController",@"setTabBarBadgeValue:forIndex:",imp,&tab,"v@:QQ"))imp_removeBlock(imp);
107:     __block IMP tabString=NULL;
108:     imp=imp_implementationWithBlock(^(id owner,id string,unsigned long long index){NSNumber *value=ChatTab(owner,(NSUInteger)index)?[CSGroupListAdapter closeFriendAlertBadgeCount]:nil;((void(*)(id,SEL,id,unsigned long long))tabString)(owner,NSSelectorFromString(@"setTabBarBadgeString:forIndex:"),value?(value.unsignedLongLongValue?value.stringValue:nil):string,index);});
109:     if(!CSCloseFriendInstallHook(@"MMTabBarController",@"setTabBarBadgeString:forIndex:",imp,&tabString,"v@:@Q"))imp_removeBlock(imp);
110:     __block IMP dot=NULL;
111:     imp=imp_implementationWithBlock(^(id owner,unsigned long long index){NSNumber *value=ChatTab(owner,(NSUInteger)index)?[CSGroupListAdapter closeFriendAlertBadgeCount]:nil;if(value && !value.unsignedLongLongValue)return;((void(*)(id,SEL,unsigned long long))dot)(owner,NSSelectorFromString(@"showRedDotOnTabBarItemAtIndex:"),index);});
112:     if(!CSCloseFriendInstallHook(@"MMTabBarController",@"showRedDotOnTabBarItemAtIndex:",imp,&dot,"v@:Q"))imp_removeBlock(imp);
113:     [NSNotificationCenter.defaultCenter addObserverForName:CSCloseFriendPolicyDidChangeNotification object:nil queue:NSOperationQueue.mainQueue usingBlock:^(__unused NSNotification *note){
114:         [UNUserNotificationCenter.currentNotificationCenter getPendingNotificationRequestsWithCompletionHandler:^(NSArray *requests){dispatch_async(dispatch_get_main_queue(),^{RemoveKnown(requests,NO);});}];
115:         [UNUserNotificationCenter.currentNotificationCenter getDeliveredNotificationsWithCompletionHandler:^(NSArray *notifications){NSMutableArray *requests=[NSMutableArray array];for(UNNotification *n in notifications)[requests addObject:n.request];dispatch_async(dispatch_get_main_queue(),^{RemoveKnown(requests,YES);});}];
116:         NSNumber *value=[CSGroupListAdapter closeFriendAlertBadgeCount];if(value)UIApplication.sharedApplication.applicationIconBadgeNumber=value.integerValue;
117:         if(value)for(id owner in TabOwners.allObjects) {
118:             NSArray *views=CSCloseFriendRead(owner,@"viewControllers");if(![views isKindOfClass:NSArray.class])continue;
119:             for(NSUInteger index=0;index<views.count;index++)if(ChatTab(owner,index)) {
120:                 SEL set=NSSelectorFromString(@"setTabBarBadgeValue:forIndex:");
121:                 if(CSCloseFriendMethodMatches(class_getInstanceMethod([owner class],set),"v@:QQ"))((void(*)(id,SEL,unsigned long long,unsigned long long))objc_msgSend)(owner,set,value.unsignedLongLongValue,(unsigned long long)index);
122:                 SEL remove=NSSelectorFromString(@"removeRedDotOnTabBarItemAtIndex:");
123:                 if(!value.unsignedLongLongValue && CSCloseFriendMethodMatches(class_getInstanceMethod([owner class],remove),"v@:Q"))((void(*)(id,SEL,unsigned long long))objc_msgSend)(owner,remove,(unsigned long long)index);
124:             }
125:         }
126:     }];
127: }); }
```

## Hooks/CloseFriendLifecycleHooks.xm

SHA-256: `92ab6300d49c7e981d901db8ecab1febbf66fa5218bac5bee10b55ed0299681e`

1–9: home appear first calls original then starts manager

```objc
1: #import "../Controllers/CSCloseFriendBridge.h"
2: #import "../Controllers/CSCloseFriendManager.h"
3: static void (*CSHomeDidAppearOriginal)(id,SEL,BOOL);
4: static void CSHomeDidAppear(id self, SEL command, BOOL animated) {
5:     CSHomeDidAppearOriginal(self,command,animated);
6:     [CSCloseFriendManager.sharedManager start];
7:     [CSCloseFriendManager.sharedManager refreshAccount];
8:     [CSCloseFriendManager.sharedManager attachRecoveryGestureTo:self];
9: }
```

25–35: deferred lifecycle install then start

```objc
25: }
26: %ctor {
27:     // Only register deferred bootstrap. No service lookup, Keychain access, file read or class scan here.
28:     dispatch_async(dispatch_get_main_queue(),^{
29:         CSCloseFriendInstallHook(@"NewMainFrameViewController",@"viewDidAppear:",(IMP)CSHomeDidAppear,(IMP *)&CSHomeDidAppearOriginal,"v@:B");
30:         CSCloseFriendInstallHook(@"UIWindow",@"motionBegan:withEvent:",(IMP)CSMotionBegan,(IMP *)&CSMotionBeganOriginal,"v@:q@");
31:         CSCloseFriendInstallHook(@"UIWindow",@"motionEnded:withEvent:",(IMP)CSMotionEnded,(IMP *)&CSMotionEndedOriginal,"v@:q@");
32:         CSCloseFriendInstallHook(@"BaseMsgContentViewController",@"viewDidAppear:",(IMP)CSChatDidAppear,(IMP *)&CSChatDidAppearOriginal,"v@:B");
33:         [CSCloseFriendManager.sharedManager start];
34:     });
35: }
```

## Hooks/TabBarStyleHooks.xm

SHA-256: `a30fdb29e98707a944f2bdb2f020fdee7e8ecdcd29bc863a580140a85f7a5617`

1–92: complete restored 2.1-6 style hook surface

```objc
1: #import "../Controllers/CSBackupBootstrap.h"
2: #import "CSTabBarNativeAdapter.h"
3: 
4: // Keep native navigation, badge content, keyboard handling and visibility decisions intact.
5: %hook MMTabBar
6: - (void)layoutSubviews {
7:     CSTabBarBeginLayout(self);
8:     %orig;
9:     CSTabBarEndLayout(self);
10: }
11: - (void)relayoutTabBarItems {
12:     CSTabBarBeginLayout(self);
13:     %orig;
14:     CSTabBarEndLayout(self);
15: }
16: - (void)setHidden:(BOOL)hidden {
17:     CSTabBarUpdate(self);
18:     %orig(hidden);
19:     CSTabBarUpdate(self);
20: }
21: - (void)setAlpha:(CGFloat)alpha {
22:     CSTabBarUpdate(self);
23:     %orig(alpha);
24:     CSTabBarUpdate(self);
25: }
26: - (UIView *)snapshotViewAfterScreenUpdates:(BOOL)afterUpdates {
27:     CSTabBarUpdate(self);
28:     UIView *snapshot=%orig(afterUpdates);
29:     return CSTabBarStyleSnapshot(self,snapshot);
30: }
31: - (void)didMoveToWindow {
32:     %orig;
33:     CSTabBarUpdate(self);
34: }
35: - (void)traitCollectionDidChange:(UITraitCollection *)previous {
36:     %orig(previous);
37:     CSTabBarUpdate(self);
38: }
39: - (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
40:     BOOL handled=NO;
41:     BOOL inside=CSTabBarContainsPoint(self,point,&handled);
42:     return handled ? inside : %orig(point,event);
43: }
44: - (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
45:     BOOL handled=NO;
46:     UIView *hit=CSTabBarHitTest(self,point,event,&handled);
47:     return handled ? hit : %orig(point,event);
48: }
49: %end
50: 
51: %hook MMTabBarController
52: - (void)viewWillLayoutSubviews {
53:     MMTabBar *bar=[self.tabBar isKindOfClass:NSClassFromString(@"MMTabBar")] ? (MMTabBar *)self.tabBar : nil;
54:     if (bar) CSTabBarBeginLayout(bar);
55:     %orig;
56:     if (bar) CSTabBarEndLayout(bar);
57: }
58: - (void)viewDidLayoutSubviews {
59:     MMTabBar *bar=[self.tabBar isKindOfClass:NSClassFromString(@"MMTabBar")] ? (MMTabBar *)self.tabBar : nil;
60:     if (bar) CSTabBarBeginLayout(bar);
61:     %orig;
62:     if (bar) CSTabBarEndLayout(bar);
63: }
64: %end
65: 
66: %hook MMTabBarItemView
67: - (void)layoutSubviews {
68:     CSTabBarBeginItemUpdate(self); %orig; CSTabBarEndItemUpdate(self);
69: }
70: - (void)layoutIcon {
71:     CSTabBarBeginItemUpdate(self); %orig; CSTabBarEndItemUpdate(self);
72: }
73: - (void)layoutBadgeView {
74:     CSTabBarBeginItemUpdate(self); %orig; CSTabBarEndItemUpdate(self);
75: }
76: - (void)reloadIconImage {
77:     CSTabBarBeginItemUpdate(self); %orig; CSTabBarEndItemUpdate(self);
78: }
79: - (void)setSelected:(BOOL)selected {
80:     CSTabBarBeginItemUpdate(self); %orig(selected); CSTabBarEndItemUpdate(self);
81: }
82: - (void)setTitle:(NSString *)title {
83:     CSTabBarBeginItemUpdate(self); %orig(title); CSTabBarEndItemUpdate(self);
84: }
85: %end
86: 
87: %ctor {
88:     CSBackupWhenReady(^{
89:         CSTabBarInstallObservers();
90:         %init;
91:     });
92: }
```

## Controllers/CSTabBarNativeAdapter.m

SHA-256: `7eeac3627d62361d93a6bcdb8c3c00dc236286fb355c51455eaae4a71659374c`

74–93: owner and item reads

```objc
74: static MMTabBarController *CSOwner(MMTabBar *bar) {
75:     id owner=bar.customDelegate;
76:     Class main=NSClassFromString(@"MainTabBarViewController");
77:     return main && [owner isKindOfClass:main] && [owner isKindOfClass:UITabBarController.class] ? owner : nil;
78: }
79: static CSTabBarState *CSState(MMTabBar *bar, BOOL create) {
80:     CSTabBarState *s=objc_getAssociatedObject(bar,&CSBarStateKey);
81:     if (!s && create && CSOwner(bar)) {
82:         s=[CSTabBarState new]; s.bar=bar; s.controller=CSOwner(bar);
83:         s.backgroundHidden=[NSMapTable weakToStrongObjectsMapTable];
84:         s.observedButtons=[NSHashTable weakObjectsHashTable];
85:         objc_setAssociatedObject(bar,&CSBarStateKey,s,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
86:         if (!CSBars) CSBars=[NSHashTable weakObjectsHashTable];
87:         [CSBars addObject:bar];
88:     }
89:     return s;
90: }
91: static NSArray<MMTabBarItemView *> *CSItems(MMTabBar *bar) {
92:     return [bar.tabBarItemViews isKindOfClass:NSArray.class] ? [bar.tabBarItemViews copy] : @[];
93: }
```

169–215: item style applies original badge object geometry

```objc
169:     CSTabBarState *host=CSState(bar,NO);
170:     if (!host.applied || host.depth || !CSTabBarPreferences.current.enabled) return;
171:     NSUInteger index=[bar.items indexOfObjectIdenticalTo:item.item];
172:     if (index==NSNotFound || index>=4) return;
173:     CSTabBarItemState *s=objc_getAssociatedObject(item,&CSItemStateKey);
174:     if (!s) {
175:         s=[CSTabBarItemState new];
176:         objc_setAssociatedObject(item,&CSItemStateKey,s,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
177:     }
178:     if (s.depth) return;
179:     CSRestoreItem(item);
180:     s.bar=bar; s.image=item.imageView.image; s.imageMode=item.imageView.contentMode;
181:     s.imageFrame=item.imageView.frame; s.textFrame=item.textLabel.frame; s.badgeFrame=item.badgeView.frame;
182:     s.textHidden=item.textLabel.hidden; s.imageHidden=item.imageView.hidden; s.text=item.textLabel.text;
183:     s.customIcon=CSCustomIcon(item); s.customHidden=s.customIcon.hidden; s.customFrame=s.customIcon.frame;
184:     s.applied=YES;
185:     CSTabBarPreferences *p=CSTabBarPreferences.current;
186:     UIImage *custom=[p iconAtIndex:index selected:item.isSelected];
187:     if (custom) {
188:         item.imageView.image=custom; item.imageView.contentMode=UIViewContentModeScaleAspectFit;
189:         item.imageView.hidden=NO; s.customIcon.hidden=YES;
190:     }
191:     NSString *title=[p titleAtIndex:index];
192:     if (title) item.textLabel.text=title;
193:     item.textLabel.hidden=p.hideText || s.textHidden;
194:     CGFloat height=CGRectGetHeight(item.bounds), width=CGRectGetWidth(item.bounds);
195:     CGFloat labelHeight=p.hideText ? 0 : MIN(20,MAX(12,item.textLabel.font.lineHeight));
196:     CGFloat iconHeight=MIN(28,MAX(20,height-labelHeight-12));
197:     CGSize nativeSize=custom ? CGSizeMake(25,25) : s.imageFrame.size;
198:     if (nativeSize.width<=0 || nativeSize.height<=0) nativeSize=CGSizeMake(25,25);
199:     CGFloat factor=MIN(iconHeight/MAX(1,nativeSize.height),MIN(32,width-12)/MAX(1,nativeSize.width));
200:     CGSize size=CGSizeMake(nativeSize.width*factor,nativeSize.height*factor);
201:     CGFloat gap=p.hideText ? 0 : 3;
202:     CGFloat top=(height-size.height-labelHeight-gap)/2;
203:     CGRect imageFrame=CGRectMake((width-size.width)/2,top,size.width,size.height);
204:     CSSetFrame(item.imageView,imageFrame);
205:     if (s.customIcon && !custom) CSSetFrame(s.customIcon,imageFrame);
206:     if (!p.hideText) CSSetFrame(item.textLabel,CGRectMake(2,CGRectGetMaxY(imageFrame)+gap,width-4,labelHeight));
207:     // Keep the original badge object, value, shape and visibility. Move its native anchor.
208:     CGRect badge=s.badgeFrame;
209:     badge.origin.x+=CGRectGetMaxX(imageFrame)-CGRectGetMaxX(s.imageFrame);
210:     badge.origin.y+=CGRectGetMinY(imageFrame)-CGRectGetMinY(s.imageFrame);
211:     s.badgeOffset=CGPointMake(badge.origin.x-s.badgeFrame.origin.x,badge.origin.y-s.badgeFrame.origin.y);
212:     CSSetFrame(item.badgeView,badge);
213:     CSReconcileClickEffect(host);
214: }
215: 
```

235–257: navigation only read for inset choice

```objc
235:     return best;
236: }
237: static void CSUpdateInset(CSTabBarState *s) {
238:     UIViewController *selected=s.controller.selectedViewController;
239:     if ([selected isKindOfClass:UINavigationController.class]) {
240:         UINavigationController *nav=(id)selected;
241:         if (nav.viewControllers.count!=1) { CSRestoreInset(s); return; }
242:         selected=nav.topViewController;
243:     }
244:     UITableView *table=CSMainTable(selected.viewIfLoaded);
245:     if (!table || table.window!=s.bar.window) { CSRestoreInset(s); return; }
246:     if (s.scrollView!=table) { CSRestoreInset(s); s.scrollView=table; }
247:     UIEdgeInsets inset=table.contentInset, indicator=table.verticalScrollIndicatorInsets;
248:     if (!s.insetApplied || fabs(inset.bottom-s.appliedInset)>.01) s.nativeInset=inset.bottom;
249:     if (!s.insetApplied || fabs(indicator.bottom-s.appliedIndicatorInset)>.01) s.nativeIndicatorInset=indicator.bottom;
250:     CGRect viewport=[table convertRect:table.bounds toView:s.bar];
251:     CGFloat system=table.adjustedContentInset.bottom-inset.bottom;
252:     CGFloat desired=CSTabBarRequiredBottomInset(CGRectGetMaxY(viewport),CGRectGetMinY(s.floatingRect),s.nativeInset,system);
253:     s.appliedInset=desired;
254:     s.appliedIndicatorInset=s.nativeIndicatorInset+MAX(0,desired-s.nativeInset);
255:     s.insetApplied=YES;
256:     if (fabs(inset.bottom-desired)>.01) { inset.bottom=desired; table.contentInset=inset; }
257:     if (fabs(indicator.bottom-s.appliedIndicatorInset)>.01) { indicator.bottom=s.appliedIndicatorInset; table.verticalScrollIndicatorInsets=indicator; }
```

## Controllers/CSBackupBootstrap.m

SHA-256: `0f5916558fb31b9935838c380dfcce26778d7a60c0dea4c5eff4c428c5c35e03`

51–61: ready callback may run immediately

```objc
51:     BOOL start = !ready && !self.attempted;
52:     if (!ready) [self.callbacks addObject:[callback copy]];
53:     if (start) { self.resolving = YES; self.attempted = YES; }
54:     [self.lock unlock];
55:     if (ready) callback();
56:     else if (start) [self startResolution];
57: }
58: - (void)retry:(CSBackupStartupCompletion)completion {
59:     [self.lock lock];
60:     BOOL ready = self.resolved;
61:     BOOL start = !ready && !self.resolving;
```

137–148: atomic account epoch and suspension boundary

```objc
137: static void CSBackupMarkAccountBoundary(BOOL suspended) {
138:     NSRecursiveLock *lock=CSBackupAccountLock();[lock lock];
139:     uint_fast64_t old = atomic_load_explicit(&CSBackupAccountBoundary, memory_order_acquire), next;
140:     do { next = ((old + 2) & ~(uint_fast64_t)1) | (suspended ? 1 : 0); }
141:     while (!atomic_compare_exchange_weak_explicit(&CSBackupAccountBoundary, &old, next, memory_order_acq_rel, memory_order_acquire));
142:     [lock unlock];
143: }
144: void CSBackupAccountWillChangeAtNativeBoundary(void) { CSBackupMarkAccountBoundary(YES); }
145: void CSBackupAccountDidChangeAtNativeBoundary(void) {
146:     CSBackupMarkAccountBoundary(NO);
147:     dispatch_async(dispatch_get_main_queue(), ^{ [NSNotificationCenter.defaultCenter postNotificationName:@"CSBackupAccountChanged" object:nil]; CSBackupResumeAfterRecovery(); });
148: }
```
