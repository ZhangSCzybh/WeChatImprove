/* Optional Frida observation only. NOT RUN ON A DEVICE in this audit.
 * No replacement, args/retval writes, forced layout/reload, timers, policy calls,
 * account/name/message output, settings/database writes, or automatic attachment.
 * start() performs one main-thread heap scan and reads existing view/adapter
 * properties. These reads and Interceptor callbacks have timing overhead.
 * Object IDs are local pointer aliases, not persistent identities. Only current
 * method IMPs are observed; later swizzles, early calls, or failed hooks can miss
 * events. Unknown is never zero. Native exception unwinds may omit onLeave.
 */
'use strict';
if (typeof ObjC === 'undefined' || !ObjC.available)
  throw new Error('Objective-C bridge unavailable; no observations installed.');

const LIMIT = 10000;
const SPAN_MS = 60000;
let enabled = false, started = 0, sequence = 0, calls = 0, objectSequence = 0;
let returnSequence = 0, currentReturn = null, chatObserved = false, stoppedReason = null;
const ids = new Map(), counts = {}, selectorEntries = {}, selectorCompletions = {}, roleEntries = {};
const coverage = [], listeners = [], dynamicHooks = new Set();
const sampling = new Set(), stacks = new Map(), tables = new Set(), banners = new Map();
const bannerParents = new Set(), headerViews = new Map();
const windowBannerOperations = new Map();
const unknown = reason => ({status:'unknown', reason});
const isUnknown = value => value && value.status === 'unknown';
const nil = value => value === null || value === undefined ||
  (typeof value.isNull === 'function' && value.isNull());
function wrap(value) { try { return nil(value) || isUnknown(value) ? null : new ObjC.Object(value); } catch (_) { return null; } }
function key(value) { try { return isUnknown(value) ? null : value && value.handle ? value.handle.toString() : nil(value) ? null : value.toString(); } catch (_) { return null; } }
function id(value) {
  if (isUnknown(value)) return value;
  const pointer = key(value); if (!pointer || pointer === '0x0') return null;
  if (!ids.has(pointer)) ids.set(pointer, 'O' + (++objectSequence));
  return ids.get(pointer);
}
function get(owner, selector) {
  if (isUnknown(owner)) return owner;
  if (!owner) return unknown('nil-or-unreadable-owner');
  try { return typeof owner[selector] === 'function' ? owner[selector]() : unknown('getter-unavailable'); }
  catch (_) { return unknown('getter-read-error'); }
}
function ivar(owner, name) {
  if (isUnknown(owner)) return owner;
  try { return owner && owner.$ivars && name in owner.$ivars ? owner.$ivars[name] : unknown('ivar-unavailable'); }
  catch (_) { return unknown('ivar-read-error'); }
}
function number(value) {
  if (isUnknown(value)) return value;
  if (typeof value === 'boolean') return value ? 1 : 0;
  try { const parsed = Number(value); return Number.isSafeInteger(parsed) ? parsed : unknown('non-integer-or-unsafe'); }
  catch (_) { return unknown('numeric-read-error'); }
}
function real(value) {
  if (isUnknown(value)) return value;
  try { const parsed=Number(value);return Number.isFinite(parsed)?parsed:unknown('nonfinite-number'); }
  catch (_) {return unknown('numeric-read-error');}
}
function arg(value) { try { return number(BigInt(value.toString())); } catch (_) { return unknown('argument-read-error'); } }
function bool(value) {
  const n = number(value); return n === 0 ? false : n === 1 ? true : unknown('boolean-unavailable');
}
function count(owner) { return owner ? number(get(owner, 'count')) : null; }
function main() { try { return !!ObjC.classes.NSThread.isMainThread(); } catch (_) { return false; } }
function struct(value) {
  if (isUnknown(value)) return value;
  if (Array.isArray(value)) return value.map(struct);
  return typeof value === 'number' && Number.isFinite(value) ? value : unknown('unsupported-struct');
}
function path(owner) {
  if (!owner) return null;
  const length = number(get(owner, 'length'));
  if (length !== 2) return unknown('not-a-two-index-path');
  return {section:number(get(owner, 'section')), row:number(get(owner, 'row'))};
}
function paths(owner) {
  const n = count(owner); if (!Number.isSafeInteger(n)) return unknown('paths-unreadable');
  const result = []; for (let i=0;i<Math.min(n,64);i++) {
    try { result.push(path(owner.objectAtIndex_(i))); } catch (_) { result.push(unknown('path-read-error')); }
  }
  return {count:n, paths:result, truncated:n>64};
}
function view(owner) {
  if (isUnknown(owner)) return owner;
  if (!owner) return null;
  if (!main()) return {id:id(owner), properties:unknown('off-main-ui-read-refused')};
  const parent = get(owner, 'superview');
  return {id:id(owner), parent:parent && parent.status ? parent : id(parent),
    frame:struct(get(owner,'frame')), bounds:struct(get(owner,'bounds')),
    hidden:bool(get(owner,'isHidden')), alpha:real(get(owner,'alpha'))};
}
function rememberTable(table) { const pointer=key(table); if (pointer) tables.add(pointer); }
function rememberHeader(header, role) {
  const pointer=key(header); if (!pointer) return;
  headerViews.set(pointer,role || headerViews.get(pointer) || 'observed-header');
  observeViewClass(header);
}
function tableState(table) {
  if (isUnknown(table)) return table;
  if (!table) return unknown('table-unavailable'); rememberTable(table);
  if (!main()) return {id:id(table), properties:unknown('off-main-ui-read-refused')};
  return {id:id(table), offset:struct(get(table,'contentOffset')), contentSize:struct(get(table,'contentSize')),
    adjustedInset:struct(get(table,'adjustedContentInset')), bounds:struct(get(table,'bounds')),
    // The plugin intentionally transforms this getter in native/header scope.
    effectiveScopedHeader:id(get(table,'tableHeaderView'))};
}
function adapterState(owner) {
  if (!main()) return {id:id(owner), properties:unknown('off-main-state-read-refused')};
  const table=get(owner,'table'), header=get(owner,'headerContainer'), native=get(owner,'nativeHeader');
  rememberHeader(header,'wrapper'); rememberHeader(native,'native-header');
  return {id:id(owner), table:tableState(table), projecting:bool(get(owner,'isActive')),
    publishing:bool(get(owner,'publishing')), dirty:bool(get(owner,'dirty')),
    suspended:bool(get(owner,'presentationSuspended')), depth:number(get(owner,'changeDepth')),
    changes:number(get(owner,'pendingChanges')), unattributed:bool(get(owner,'pendingContentUnattributed')),
    pendingNameCount:count(get(owner,'pendingContentUserNames')), revision:number(get(owner,'modelRevision')),
    headerUpdating:bool(get(owner,'updatingHeader')), wrapper:view(header), nativeHeader:view(native)};
}
function sample(thread, body) {
  sampling.add(thread); try { return body(); } finally { sampling.delete(thread); }
}
function output(event, fields, force=false) {
  if (!force && !enabled) return;
  if (!force && (sequence>=LIMIT || Date.now()-started>SPAN_MS)) {
    stoppedReason=sequence>=LIMIT?'event-limit':'time-limit'; enabled=false;
    console.log('[top-transition-30] '+JSON.stringify({event:'capture-limit', reason:stoppedReason, count:sequence})); return;
  }
  const thread=Process.getCurrentThreadId();
  counts[event]=(counts[event]||0)+1;
  const stack=stacks.get(thread)||[];
  console.log('[top-transition-30] '+JSON.stringify(Object.assign({sequence:++sequence,
    elapsedMs:started ? Date.now()-started : null, thread, event,
    returnWindow:currentReturn, currentCall:stack.slice(-1)[0]||null,
    parentCall:stack.slice(-2,-1)[0]||null}, fields)));
}
// Parse Objective-C encodings before accepting an observation boundary. No
// hardcoded IMP addresses or assumptions that a selector's spelling proves ABI.
function typeTokens(encoding) {
  // Pointer targets can themselves be nested structures (e.g. CGColorRef).
  function endOf(i) {
    while(i<encoding.length && /[rnNoORV]/.test(encoding[i]))i++;
    const c=encoding[i++];
    if(c==='^')return endOf(i);
    if(c==='@' && encoding[i]==='?')return i+1;
    if(c==='@' && encoding[i]==='"'){i++;while(i<encoding.length && encoding[i]!=='"')i++;return i+1;}
    if(c==='{' || c==='[' || c==='('){
      const close=c==='{'?'}':c==='['?']':')';let depth=1;
      while(i<encoding.length && depth){if(encoding[i]===c)depth++;if(encoding[i]===close)depth--;i++;}
    }
    return i;
  }
  const result=[];let i=0;
  while(i<encoding.length){
    if(/[\s0-9+\-rnNoORV]/.test(encoding[i])){i++;continue;}
    const begin=i;i=endOf(i);result.push(encoding.slice(begin,i));
  }
  return result;
}
function match(tokens, expected) {
  if(tokens.length!==expected.length)return false;
  return tokens.every((token,i)=>expected[i]==='int' ? /^[QqIiLlSsCcB]$/.test(token) :
    expected[i]==='bool' ? /^[BcC]$/.test(token) : expected[i]==='double' ? token==='d' :
    expected[i]==='pointer' ? /^\^/.test(token) : expected[i]==='point' ? /^\{CGPoint=/.test(token) :
    expected[i]==='rect' ? /^\{CGRect=/.test(token) : token===expected[i]);
}
function observe(cls, selector, expected, enter, leave, filter) {
  let method;
  try { method=ObjC.classes[cls] && ObjC.classes[cls][selector]; } catch (_) {}
  if(!method) {coverage.push({className:cls,selector,status:'unavailable-selector'});return;}
  const types=method.types;
  if(typeof types!=='string' || !match(typeTokens(types), expected)) {
    coverage.push({className:cls,selector,status:'unverified-signature',encoding:typeof types==='string'?types:null});return;
  }
  try {
    const listener=Interceptor.attach(method.implementation,{
      onEnter(args) {
        this.thread=Process.getCurrentThreadId();this.active=false;
        if(!enabled || sampling.has(this.thread))return;
        this.owner=wrap(args[0]);if(!this.owner)return;
        if(filter && !sample(this.thread,()=>filter.call(this,args)))return;
        this.active=true;this.callId=++calls;this.selector=cls+'.'+selector;
        selectorEntries[this.selector]=(selectorEntries[this.selector]||0)+1;
        const stack=stacks.get(this.thread)||[];
        this.parent=stack.slice(-1)[0]||null;stack.push({callId:this.callId,selector:this.selector});stacks.set(this.thread,stack);
        sample(this.thread,()=>{
          try {if(enter)enter.call(this,args);else output('selector-enter',{callId:this.callId,selector:this.selector,object:id(this.owner)});}
          catch(_){output('probe-read-error',{callId:this.callId,selector:this.selector,stage:'enter'});}
        });
      },
      onLeave(ret) {
        if(!this.active)return;
        selectorCompletions[this.selector]=(selectorCompletions[this.selector]||0)+1;
        sample(this.thread,()=>{
          try {if(leave)leave.call(this,ret);else output('selector-leave',{callId:this.callId,selector:this.selector});}
          catch(_){output('probe-read-error',{callId:this.callId,selector:this.selector,stage:'leave'});}
        });
        const stack=stacks.get(this.thread)||[];const index=stack.findIndex(value=>value.callId===this.callId);
        if(index>=0)stack.splice(index,1);if(!stack.length)stacks.delete(this.thread);
        this.owner=null;
      }
    });
    listeners.push(listener);coverage.push({className:cls,selector,status:'installed',encoding:types});
  } catch (_) {coverage.push({className:cls,selector,status:'install-error'});}
}
const V=['v','@',':'], O=['@','@',':'];
function trackedView(owner) {return banners.has(key(owner)) || headerViews.has(key(owner)) || cards.has(key(owner));}
function viewRole(owner) {const banner=banners.get(key(owner));return banner ? banner.label : headerViews.get(key(owner)) || (cards.has(key(owner))?'existing-business-card':unknown('view-unclassified'));}
function recordBannerOperation(kind) {
  if(!currentReturn)return;
  const result=windowBannerOperations.get(currentReturn.id)||{adds:0,removes:0};
  result[kind]++;windowBannerOperations.set(currentReturn.id,result);
}
function observeViewClass(owner) {
  // Observe the concrete override as well as UIView. A subclass that calls its
  // superclass can produce two boundaries, identified by distinct selectors.
  let cls;try {cls=owner.$className;}catch(_){return;}
  if(typeof cls!=='string' || dynamicHooks.has(cls))return;
  dynamicHooks.add(cls);
  for(const [selector,expected] of [['- layoutSubviews',V],['- setFrame:',V.concat('rect')],['- setBackgroundColor:',V.concat('@')],['- drawRect:',V.concat('rect')],['- setNeedsDisplay',V]])
    observe(cls,selector,expected,function(){
      const metric=viewRole(this.owner)+'|'+this.selector;
      roleEntries[metric]=(roleEntries[metric]||0)+1;
      output('tracked-view-operation-enter',{callId:this.callId,selector:this.selector,role:viewRole(this.owner),view:view(this.owner),
        requestedRect:selector==='- setFrame:'?unknown('struct-register-argument-not-decoded'):null});
    },function(){output('tracked-view-operation-leave',{callId:this.callId,selector:this.selector,role:viewRole(this.owner),view:view(this.owner)});},
    function(){return trackedView(this.owner);});
}
function adapterEnter() {output('adapter-enter',{callId:this.callId,selector:this.selector,state:adapterState(this.owner)});}
function adapterLeave() {output('adapter-leave',{callId:this.callId,selector:this.selector,state:adapterState(this.owner)});}
for(const selector of ['- viewWillAppear:','- viewDidAppear:','- viewWillDisappear:','- viewDidDisappear:']) {
  observe('NewMainFrameViewController',selector,V.concat('bool'),function(){
    if(selector==='- viewWillAppear:') {currentReturn={id:++returnSequence,afterObservedChat:chatObserved,startSequence:sequence+1};chatObserved=false;}
    output('list-lifecycle-enter',{callId:this.callId,selector:this.selector,owner:id(this.owner)});
  },function(){output('list-lifecycle-leave',{callId:this.callId,selector:this.selector});});
}
observe('BaseMsgContentViewController','- viewDidAppear:',V.concat('bool'),function(){
  chatObserved=true;output('chat-did-appear',{callId:this.callId,owner:id(this.owner)});
});
for(const selector of ['- viewDidLayoutSubviews','- initTableHeaderView','- setSearchBarToTableHeaderView'])
  observe('NewMainFrameViewController',selector,V,null,null);
for(const [selector,types] of [
  ['- onActiveUsrNameChange:curUsrName:',V.concat('@','@')],
  ['- onSessionTotalUnreadCountChange:',V.concat('int')],
  ['- onSessionChanged:',V.concat('@')],['- onMainSessionReload',V],
  ['- onSessionRebuildBegin',V],['- onSessionRebuildEnd',V]])
  observe('MainFrameLogicController',selector,types,null,null);
for(const [selector,types] of [['- updateSession:',V.concat('@')],['- updateItem:',V.concat('@')],
  ['- logicUpdateSession:',V.concat('@')],['- reloadSessions',V]])
  observe('NewMainFrameViewController',selector,types,null,null);
for(const selector of ['- checkAutoClearUnreadForSession:','- recountUnReadCountAndFireExtension'])
  observe('MMNewSessionMgr',selector,selector.endsWith(':')?V.concat('@'):V,null,null);
for(const selector of ['- refresh','- requestRefresh','- requestRecovery','- layout','- restoreAnchor'])
  observe('CSGroupListAdapter',selector,V,adapterEnter,adapterLeave);
for(const [selector,types] of [['- setNativeTableHeaderView:',V.concat('@')],['- publishHeader:',V.concat('@')],
  ['- performVisibleLayout:',V.concat('@?')],['- restoreScrollHeight:',V.concat('double')],
  ['- restoreViewportFromTab:scrollHeight:',V.concat('@','double')]])
  observe('CSGroupListAdapter',selector,types,adapterEnter,adapterLeave);
observe('CSGroupListAdapter','- beginNativeChangeOfKind:sessionUserNames:',V.concat('int','@'),function(args){
  output('event-attribution',{callId:this.callId,changes:arg(args[2]),namesNil:nil(args[3]),
    namesCount:count(wrap(args[3])),state:adapterState(this.owner)});
},adapterLeave);
observe('CSGroupListAdapter','- publishProjection:previous:changes:contentUserNames:contentIdentityKnown:previouslyProjecting:',
  V.concat('@','@','int','@','bool','bool'),function(args){
    output('publication-enter',{callId:this.callId,projection:id(args[2]),previous:id(args[3]),
      changes:arg(args[4]),namesNil:nil(args[5]),namesCount:count(wrap(args[5])),
      identityKnown:bool(arg(args[6])),previouslyProjecting:bool(arg(args[7])),state:adapterState(this.owner)});
  },adapterLeave);
observe('CSGroupProjection','- publicationPlanFrom:changes:contentUserNames:contentIdentityKnown:visiblePaths:',
  O.concat('@','int','@','bool','@'),function(args){
    output('plan-enter',{callId:this.callId,projection:id(this.owner),previous:id(args[2]),changes:arg(args[3]),
      namesNil:nil(args[4]),namesCount:count(wrap(args[4])),identityKnown:bool(arg(args[5])),visible:paths(wrap(args[6]))});
  },function(ret){const plan=wrap(ret);output('plan-result',{callId:this.callId,plan:id(plan),
    fullReload:bool(get(plan,'fullReload')),geometryChanged:bool(get(plan,'geometryChanged')),
    reload:paths(get(plan,'reloadPaths'))});});
observe('CSGroupListAdapter','- cellForDisplayPath:target:',O.concat('@','@'),function(args){
  this.path=path(wrap(args[2]));this.isBusiness=unknown('row-not-observed');
  // Read immutable sections directly; do not call rowAtDisplayPath:, a native
  // model accessor, a policy getter, or any rendering/filtering method.
  if(main() && this.path && Number.isSafeInteger(this.path.section) && Number.isSafeInteger(this.path.row)) {
    try {const sections=get(get(this.owner,'projection'),'sections');
      if(this.path.section>=0 && this.path.section<number(get(sections,'count'))) {
        const section=sections.objectAtIndex_(this.path.section);
        if(this.path.row>=0 && this.path.row<number(get(section,'count'))) {
          const row=section.objectAtIndex_(this.path.row),kind=number(get(row,'kind'));
          this.isBusiness=Number.isSafeInteger(kind)?kind===2:unknown('row-kind-unreadable');
        }
      }
    } catch (_) {this.isBusiness=unknown('immutable-row-read-error');}
  }
},function(ret){if(this.isBusiness===true)output('business-cell-delivered',{callId:this.callId,adapter:id(this.owner),
  displayPath:this.path,cell:view(wrap(ret)),businessClassification:'immutable-row-kind=2'});
  else if(isUnknown(this.isBusiness))output('cell-classification-unknown',{callId:this.callId,reason:this.isBusiness});});
observe('MainFrameHeaderLogic','- getBanner:',O.concat('int'),function(args){this.index=arg(args[2]);},function(ret){
  const banner=wrap(ret), pointer=key(banner);let label='unclassified-banner';
  // Classify only a naturally returned banner. Never call getBanner: or a
  // setter to seed observations, and never inspect a banner's text/subviews.
  if(pointer) {
    if(key(ivar(this.owner,'m_MFFavDetailBtn'))===pointer)label='favorite-banner';
    else if(key(ivar(this.owner,'m_webMMBtn'))===pointer)label='login-banner';
    if(!banners.has(pointer))banners.set(pointer,{label,discoveryKind:'natural-return',discoveredSequence:sequence+1,discoveredReturn:currentReturn?currentReturn.id:null});
    rememberBusinessCell(banner);observeViewClass(banner);
  }
  if(main() && banner){const parent=get(banner,'superview');const p=key(parent);if(p)bannerParents.add(p);}
  output('native-get-banner',{callId:this.callId,index:this.index,label,banner:view(banner),discovery:banners.get(pointer)||unknown('nil-banner')});
});
for(const [selector,types,childSlot] of [
  ['- addSubview:',V.concat('@'),2],['- insertSubview:atIndex:',V.concat('@','int'),2],
  ['- insertSubview:belowSubview:',V.concat('@','@'),2],['- insertSubview:aboveSubview:',V.concat('@','@'),2]])
  observe('UIView',selector,types,function(args){this.child=wrap(args[childSlot]);
    const sharedBanner=banners.has(key(this.child));
    if(sharedBanner){bannerParents.add(key(this.owner));recordBannerOperation('adds');}
    output('view-attachment-enter',{callId:this.callId,selector:this.selector,parent:id(this.owner),sharedBanner,child:view(this.child)});
  },function(){output('view-attachment-leave',{callId:this.callId,parent:id(this.owner),child:view(this.child)});this.child=null;},
  function(args){return banners.has(key(args[childSlot]))||headerViews.has(key(args[childSlot]))||cards.has(key(args[childSlot]));});
observe('UIView','- removeFromSuperview',V,function(){
  const sharedBanner=banners.has(key(this.owner));if(sharedBanner)recordBannerOperation('removes');
  output('view-removal-enter',{callId:this.callId,sharedBanner,view:view(this.owner)});
},function(){output('view-removal-leave',{callId:this.callId,view:view(this.owner)});},
function(){return trackedView(this.owner);});
observe('UIView','- removeAllSubViews',V,function(){
  output('banner-container-clear-enter',{callId:this.callId,container:view(this.owner)});
},function(){output('banner-container-clear-leave',{callId:this.callId,container:view(this.owner)});},
function(){return bannerParents.has(key(this.owner));});
for(const selector of ['- reloadData','- layoutSubviews'])
  observe('UITableView',selector,V,function(){output('table-operation-enter',{callId:this.callId,selector:this.selector,table:tableState(this.owner)});},
    function(){output('table-operation-leave',{callId:this.callId,selector:this.selector,table:tableState(this.owner)});},
    function(){return tables.has(key(this.owner));});
observe('MainFrameTableView','- layoutSubviews',V,function(){output('main-table-layout-enter',{callId:this.callId,table:tableState(this.owner)});},
  function(){output('main-table-layout-leave',{callId:this.callId,table:tableState(this.owner)});},
  function(){return tables.has(key(this.owner));});
observe('UITableView','- reloadRowsAtIndexPaths:withRowAnimation:',V.concat('@','int'),function(args){
  output('table-reload-rows',{callId:this.callId,paths:paths(wrap(args[2])),animation:arg(args[3]),table:tableState(this.owner)});
},null,function(){return tables.has(key(this.owner));});
observe('UITableView','- setTableHeaderView:',V.concat('@'),function(args){
  rememberHeader(wrap(args[2]));output('header-setter-enter',{callId:this.callId,requestedHeader:view(wrap(args[2])),table:tableState(this.owner)});
},function(){output('header-setter-leave',{callId:this.callId,table:tableState(this.owner)});},
function(){return tables.has(key(this.owner));});
for(const [selector,types] of [['- setContentOffset:',V.concat('point')],['- setContentOffset:animated:',V.concat('point','bool')]])
  observe('UIScrollView',selector,types,function(){output('offset-setter-enter',{callId:this.callId,selector:this.selector,table:tableState(this.owner),
    requestedPoint:unknown('struct-register-argument-not-decoded')});},
    function(){output('offset-setter-leave',{callId:this.callId,table:tableState(this.owner)});},
    function(){return tables.has(key(this.owner));});

// Additional geometry/drawing boundary observations. C ABIs below are verified
// against source declarations only, not a connected runtime or device bridge.
const businessCells=new Set(), cards=new Map(), cardLayers=new Map(), cCoverage=[];
function nearestCell(owner) {
  if(!main())return null;
  for(let i=0;owner && i<16;i++,owner=get(owner,'superview')){
    if(isUnknown(owner))return null;
    try {if(owner.isKindOfClass_(ObjC.classes.UITableViewCell))return owner;}catch(_){return null;}
  }
  return null;
}
function rememberBusinessCell(banner) {
  const cell=nearestCell(banner),pointer=key(cell);if(pointer)businessCells.add(pointer);
}
function rememberCard(card) {
  const pointer=key(card),cell=nearestCell(card);
  if(!pointer || (!cards.has(pointer) && !businessCells.has(key(cell))))return false;
  if(!cards.has(pointer))cards.set(pointer,{discoveredSequence:sequence+1,
    discoveredReturn:currentReturn?currentReturn.id:null,cell:id(cell),identitySource:'natural production renderer argument0'});
  const layer=get(card,'layer');if(key(layer))cardLayers.set(key(layer),'business-card-layer');
  const mask=get(layer,'mask');if(key(mask))cardLayers.set(key(mask),'business-card-mask');
  observeViewClass(card);return true;
}
function cardState(card) {
  if(!main())return {id:id(card),properties:unknown('off-main-ui-read-refused')};
  const layer=get(card,'layer'),mask=get(layer,'mask');
  if(key(layer))cardLayers.set(key(layer),'business-card-layer');
  if(key(mask))cardLayers.set(key(mask),'business-card-mask');
  return {view:view(card),backgroundColor:id(get(card,'backgroundColor')),layer:id(layer),
    layerFrame:struct(get(layer,'frame')),mask:id(mask),maskFrame:struct(get(mask,'frame')),
    layerBackground:id(get(layer,'backgroundColor')),discovery:cards.get(key(card))||unknown('card-not-discovered')};
}
function cardForCell(cell) {
  const entries=[];
  for(const [pointer,record] of cards)if(record.cell===id(cell))entries.push(cardState(wrap(ptr(pointer))));
  return entries.length?entries:unknown('no-naturally-observed-renderer-card-for-cell');
}
function cObserve(name,kind) {
  // Only the tweak module is considered; no hardcoded native addresses.
  let symbols=[];
  try {for(const module of Process.enumerateModules())if(/^WeChatImprove(?:\.|$)/.test(module.name))
    symbols.push(...module.enumerateSymbols().filter(symbol=>symbol.type==='function' && symbol.name.replace(/^_/,'')===name));}
  catch(_){cCoverage.push({name,status:'symbol-enumeration-unavailable'});return;}
  const unique=Array.from(new Map(symbols.map(symbol=>[symbol.address.toString(),symbol])).values());
  if(unique.length!==1){cCoverage.push({name,status:unique.length?'ambiguous-symbol':'unavailable-symbol'});return;}
  try {listeners.push(Interceptor.attach(unique[0].address,{
    onEnter(args){
      this.active=false;const thread=Process.getCurrentThreadId();if(!enabled || sampling.has(thread))return;
      this.object=wrap(args[0]);if(!this.object)return;
      if(kind==='card'){if(!sample(thread,()=>rememberCard(this.object)))return;}
      else if(!businessCells.has(key(this.object)))return;
      this.active=true;this.callId=++calls;
      sample(thread,()=>output('corner-function-enter',{callId:this.callId,function:name,
        boundary:'source-declared C ABI; runtime bridge not device validated',
        state:kind==='card'?cardState(this.object):{cell:view(this.object),cards:cardForCell(this.object)}}));
    },
    onLeave(){if(!this.active)return;sample(Process.getCurrentThreadId(),()=>output('corner-function-leave',{
      callId:this.callId,function:name,state:kind==='card'?cardState(this.object):{cell:view(this.object),cards:cardForCell(this.object)}}));this.object=null;}
  }));cCoverage.push({name,status:'installed-source-ABI-only'});}
  catch(_){cCoverage.push({name,status:'attach-error'});}
}
for(const name of ['CSListApplyCardBackground','CSListRefreshCardBackground'])cObserve(name,'card');
for(const name of ['CSListCornerRefreshSessionGeometry','CSListCornerSessionDecorate'])cObserve(name,'cell');
for(const cls of ['MMTableViewCell','MMBaseMultiMenuTableViewCell','NewMainFrameCell','FakeMainFrameCell'])
  observe(cls,'- layoutSubviews',V,function(){output('business-cell-layout-enter',{callId:this.callId,selector:this.selector,
    cell:view(this.owner),content:view(get(this.owner,'contentView')),cards:cardForCell(this.owner)});},
  function(){output('business-cell-layout-leave',{callId:this.callId,selector:this.selector,
    cell:view(this.owner),content:view(get(this.owner,'contentView')),cards:cardForCell(this.owner)});},
  function(){return businessCells.has(key(this.owner));});
for(const [selector,types] of [['- setBackgroundColor:',V.concat('@')],['- setFrame:',V.concat('rect')],
  ['- layoutSubviews',V],['- drawRect:',V.concat('rect')],['- setNeedsDisplay',V]])
  observe('UIView',selector,types,function(){output('card-view-operation-enter',{callId:this.callId,selector:this.selector,state:cardState(this.owner)});},
    function(){output('card-view-operation-leave',{callId:this.callId,selector:this.selector,state:cardState(this.owner)});},
    function(){return cards.has(key(this.owner));});
for(const [selector,types] of [['- setBackgroundColor:',V.concat('pointer')],['- setMask:',V.concat('@')],
  ['- setFrame:',V.concat('rect')],['- display',V],['- displayIfNeeded',V],['- setNeedsDisplay',V],['- layoutSublayers',V]])
  observe('CALayer',selector,types,function(){output('card-layer-operation-enter',{callId:this.callId,selector:this.selector,
    layer:id(this.owner),role:cardLayers.get(key(this.owner)),frame:struct(get(this.owner,'frame')),mask:id(get(this.owner,'mask'))});},
    function(){output('card-layer-operation-leave',{callId:this.callId,selector:this.selector,layer:id(this.owner),
      frame:struct(get(this.owner,'frame')),mask:id(get(this.owner,'mask'))});},function(){return cardLayers.has(key(this.owner));});
observe('UINavigationController','- popViewControllerAnimated:',O.concat('bool'),function(){
  output('navigation-pop-enter',{callId:this.callId,owner:id(this.owner),completion:unknown('method boundary is not transition/compositor completion')});
},function(){output('navigation-pop-leave',{callId:this.callId,owner:id(this.owner)});});
for(const selector of ['- viewWillLayoutSubviews','- viewDidLayoutSubviews'])
  observe('UINavigationController',selector,V,null,null);
function cardMetrics(){
  return {knownBusinessCells:businessCells.size,knownCards:cards.size,
    discovered:Array.from(cards,([pointer,record])=>({id:id(pointer),...record,
      knownBeforeCurrentReturn:currentReturn?record.discoveredSequence<currentReturn.startSequence:unknown('no-return-boundary')})),
    cCoverage,drawRectInterpretation:'observed method boundaries only; no call can still mean layer/compositor painting',
    deviceCACommits:unknown('CA transaction/compositor commits are not observed'),
    identityLimits:'no view-tree guessing; card identity only comes from naturally called production renderer, missing baseline remains unknown'};
}
function seed() {
  if(typeof ObjC.chooseSync!=='function')return unknown('heap-scan-unavailable');
  try {return ObjC.chooseSync(ObjC.classes.CSGroupListAdapter).map(adapter=>{
    const controller=get(adapter,'controller'),logic=ivar(controller,'m_headerLogic'),seeded=[];
    // Existing displayed banners need not be returned by getBanner: again.
    // Read only the already held view ivars; this supplies identity/geometry,
    // never historical cell deliveries or getBanner call counts.
    for(const [name,label] of [['m_MFFavDetailBtn','favorite-banner'],['m_webMMBtn','login-banner']]) {
      const banner=ivar(logic,name),pointer=key(banner);if(!pointer)continue;
      if(!banners.has(pointer))banners.set(pointer,{label,discoveryKind:'existing-ivar',discoveredSequence:sequence,discoveredReturn:currentReturn?currentReturn.id:null});
      const parent=get(banner,'superview'),parentPointer=key(parent);if(parentPointer)bannerParents.add(parentPointer);
      rememberBusinessCell(banner);observeViewClass(banner);seeded.push({label,view:view(banner),discovery:banners.get(pointer)});
    }
    return {state:adapterState(adapter),seeded};
  });} catch (_) {return unknown('heap-scan-or-ivar-read-error');}
}
function observedCount(cls,selector,requireTable=false) {
  if(!coverage.some(entry=>entry.className===cls && entry.selector===selector && entry.status==='installed'))
    return unknown('selector-not-observed');
  if(requireTable && !tables.size)return unknown('target-table-not-discovered');
  return selectorEntries[cls+'.'+selector]||0;
}
function metrics() {
  const discovered=Array.from(banners,([pointer,record])=>({id:id(pointer),...record,
    knownBeforeCurrentReturn:currentReturn ? record.discoveredSequence<currentReturn.startSequence : unknown('no-list-appearance-boundary')}));
  const required=['favorite-banner','login-banner'];
  const baselineCovered=!!currentReturn && currentReturn.afterObservedChat && required.every(label=>discovered.some(record=>record.label===label && record.knownBeforeCurrentReturn===true));
  const operationHooksCovered=['- addSubview:','- insertSubview:atIndex:','- insertSubview:belowSubview:',
    '- insertSubview:aboveSubview:','- removeFromSuperview'].every(selector=>coverage.some(entry=>entry.className==='UIView' && entry.selector===selector && entry.status==='installed'));
  const bannerMetric=kind=>baselineCovered && operationHooksCovered ? (windowBannerOperations.get(currentReturn.id)||{adds:0,removes:0})[kind] : unknown('banner-baseline-or-operation-hooks-incomplete');
  const cellCoverage=observedCount('CSGroupListAdapter','- cellForDisplayPath:target:',true);
  return {selectorEntries:{...selectorEntries},selectorCompletions:{...selectorCompletions},
    trackedRoleEntries:{...roleEntries},adapterLayoutEntries:observedCount('CSGroupListAdapter','- layout'),
    publishHeaderEntries:observedCount('CSGroupListAdapter','- publishHeader:'),
    tableHeaderSetterEntries:observedCount('UITableView','- setTableHeaderView:',true),
    cellDeliveryEntries:cellCoverage,
    // Entry count is all cell deliveries; business-only emitted event count is
    // separate and incomplete classification is explicitly reported below.
    classifiedBusinessCellDeliveries:isUnknown(cellCoverage) ? cellCoverage :
      counts['cell-classification-unknown'] ? unknown('incomplete-business-row-classification') : counts['business-cell-delivered']||0,
    businessClassificationLimits:'unknown rows are not counted as business; inspect cell-classification-unknown',
    sharedBannerTracking:{baselineCovered,operationHooksCovered,discovered,
      currentReturnObservedAttachmentEntries:bannerMetric('adds'),
      currentReturnObservedRemovalEntries:bannerMetric('removes'),
      note:'method boundaries can nest; zero excludes only covered entry points, not every UIKit internal move'},
    nativeHeaderTracking:headerViews.size ? Array.from(headerViews,([pointer,role])=>({id:id(pointer),role})) : unknown('headers-not-discovered'),
    coverage,cardMetrics:cardMetrics()};
}
function start(label) {
  const allowed=['chat-return','tab-return','cold-control','real-banner-update'];
  const safeLabel=allowed.includes(label)?label:'custom-label-redacted';
  ObjC.schedule(ObjC.mainQueue,()=>sample(Process.getCurrentThreadId(),()=>{
    enabled=false;sequence=0;calls=0;started=Date.now();stoppedReason=null;currentReturn=null;chatObserved=false;
    for(const target of [counts,selectorEntries,selectorCompletions,roleEntries])for(const k of Object.keys(target))delete target[k];
    stacks.clear();tables.clear();banners.clear();bannerParents.clear();headerViews.clear();windowBannerOperations.clear();businessCells.clear();cards.clear();cardLayers.clear();
    const state=seed();enabled=true;
    output('capture-start',{label:safeLabel,status:'observer-only',state,coverage,cCoverage});
  }));
}
function stop() {
  output('capture-stop',{counts:Object.assign({},counts),stoppedReason,metrics:metrics()},true);enabled=false;
}
function snapshot() {
  ObjC.schedule(ObjC.mainQueue,()=>sample(Process.getCurrentThreadId(),()=>{
    output('manual-snapshot',{state:seed(),counts:Object.assign({},counts),metrics:metrics()},true);
  }));
}
globalThis.topTransition30={start,stop,snapshot,coverage:()=>({objc:coverage.slice(),c:cCoverage.slice()})};
console.log('[top-transition-30] '+JSON.stringify({event:'observer-ready',notDeviceValidated:true,enabled:false,coverage}));
