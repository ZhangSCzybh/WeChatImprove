/* Optional Frida observer, outside production and formal Tests.
 * Attach only after 2.1-6 initialization, in a Frida environment providing ObjC.
 * No args/retval/IMP replacement, setter, timer, unread recomputation, network or
 * persistent write. Property reads and heap enumeration still add execution time.
 * Native owners are local to callbacks/capture, never cached or retained by us.
 * Policy associations are same-thread observed calls, not a claim of current state.
 * Missing/nil/error/false/zero are distinct. Unknown never implies false or zero.
 * Fixed labels: style-on-cold / style-on-message / style-off-cold / style-off-message.
 * No account/name/message values or exception reasons are emitted. Account fields
 * are explicitly unavailable when a safe same-callback comparison is unavailable.
 * capture runs on main; UIKit properties are not sampled from background callbacks.
 * No device run in this audit. node --check verifies syntax only, not Frida APIs,
 * hook installation, object lifetime during heap scans, clipping, z-order or cause.
 * A native exception/unwind may omit onLeave; do not trust unpaired call IDs.
 */
'use strict';
if (typeof ObjC === 'undefined' || !ObjC.available) {
  throw new Error('Objective-C bridge unavailable; use a Frida environment providing ObjC.');
}
let sequence = 0;
let callSequence = 0;
const samplingByThread = new Map();
const suppressedByThread = new Map();
const filtersByThread = new Map();
const lastPolicyByThread = new Map(); // Sanitized values only; no ObjC wrappers.
const installed = new Set();
const unavailable = reason => ({ status: 'unavailable', reason });
const ok = value => ({ status: 'ok', value });
function nil(value) {
  if (value === null) return true;
  try { return value !== undefined && typeof value.isNull === 'function' && value.isNull(); }
  catch (_) { return false; }
}
function valid(value) {
  try { return !!(value && value.handle && !value.handle.isNull()); } catch (_) { return false; }
}
function object(value) {
  if (nil(value)) return { status: 'nil' };
  if (value === undefined) return unavailable('missing-object-pointer');
  try { return ok(new ObjC.Object(value)); } catch (_) { return { status: 'read-error', stage: 'object-wrap' }; }
}
function raw(result) { return result && result.status === 'ok' ? result.value : undefined; }
function read(receiver, method, args = []) {
  if (!valid(receiver)) return unavailable('receiver-missing-or-nil');
  try {
    const fn = receiver[method];
    if (typeof fn !== 'function') return unavailable('selector-missing');
    return ok(fn.apply(receiver, args));
  } catch (_) { return { status: 'read-error', stage: 'objc-getter' }; }
}
function readFrom(receiver, method, args = []) {
  if (!receiver || receiver.status !== 'ok') return unavailable('upstream-' + (receiver ? receiver.status : 'missing'));
  if (nil(receiver.value)) return unavailable('upstream-nil');
  return read(receiver.value, method, args);
}
function convert(result, transform) {
  if (result.status !== 'ok') return result;
  if (result.value === undefined) return unavailable('undefined-return');
  if (nil(result.value)) return { status: 'nil' };
  try { return transform(result.value); } catch (_) { return { status: 'read-error', stage: 'value-conversion' }; }
}
function numeric(result) {
  return convert(result, value => {
    if (typeof value === 'number') return Number.isFinite(value) ? ok(value) : unavailable('non-finite-number');
    if (typeof value === 'boolean' || valid(value)) return unavailable('unexpected-numeric-type');
    // Frida Int64/UInt64 values are objects. Keep large integers exact as strings.
    const text = value.toString();
    if (!/^-?[0-9]+$/.test(text)) return unavailable('unexpected-numeric-type');
    const parsed = Number(text);
    return Number.isSafeInteger(parsed) ? ok(parsed) : { status: 'ok', value: text, encoding: 'decimal-integer' };
  });
}
function boolean(result) {
  return convert(result, value => {
    if (typeof value === 'boolean') return ok(value);
    if (value === 0 || value === 1) return ok(value === 1);
    return unavailable('unexpected-boolean-type');
  });
}
function presence(result) {
  return convert(result, value => valid(value) ? ok(true) : unavailable('unexpected-object-type'));
}
function summary(result) {
  return convert(result, value => valid(value)
    ? { status: 'ok', object: value.handle.toString(), className: value.$className }
    : unavailable('unexpected-object-type'));
}
function integerArgument(value) {
  try { return { status: 'ok', hex: value.toString(), encoding: 'raw-uintptr' }; }
  catch (_) { return unavailable('argument-unreadable'); }
}
function argumentNumber(value) {
  try {
    const parsed = Number(BigInt(value.toString()));
    return Number.isSafeInteger(parsed) ? ok(parsed) : unavailable('integer-exceeds-js-safe-range');
  } catch (_) { return unavailable('argument-unreadable'); }
}
function nsString(value) {
  return ObjC.classes.NSString.stringWithUTF8String_(Memory.allocUtf8String(value));
}
function badgeText(result) {
  return convert(result, value => {
    const isString = boolean(read(value, 'isKindOfClass_', [ObjC.classes.NSString]));
    if (isString.status !== 'ok' || !isString.value) return unavailable('badge-string-type-unverified');
    const text = value.toString(); // Only NSString badge content; non-numeric text is never emitted.
    return /^[0-9]+\+?$/.test(text) || text === '' ? ok(text)
      : { status: 'redacted', reason: 'non-numeric-badge-string', length: text.length };
  });
}
function rect(result) {
  return convert(result, value => {
    if (!Array.isArray(value) || value.length !== 2 || !value.every(pair =>
      Array.isArray(pair) && pair.length === 2 && pair.every(n => typeof n === 'number' && Number.isFinite(n)))) {
      return unavailable('unsupported-struct-representation');
    }
    return ok(value);
  });
}
function mainThread() { return boolean(read(ObjC.classes.NSThread, 'isMainThread')); }
function onMain() { const result = mainThread(); return result.status === 'ok' && result.value; }
function withSampling(thread, body) {
  samplingByThread.set(thread, (samplingByThread.get(thread) || 0) + 1);
  try { return body(); } finally {
    const depth = samplingByThread.get(thread) - 1;
    if (depth) samplingByThread.set(thread, depth); else samplingByThread.delete(thread);
  }
}
function log(event, fields) {
  const thread = Process.getCurrentThreadId();
  const id = ++sequence;
  console.log('[badge-audit] ' + JSON.stringify(Object.assign({
    sequence: id, wallClockMs: Date.now(), thread, mainThread: mainThread(), event,
    diagnosticReentrantCallbacksSuppressedOnThread: suppressedByThread.get(thread) || 0
  }, fields)));
  return id;
}
function styleConfiguration() {
  const defaults = read(ObjC.classes.NSUserDefaults, 'standardUserDefaults');
  const key = name => {
    try { return boolean(readFrom(defaults, 'boolForKey_', [nsString(name)])); }
    catch (_) { return { status: 'read-error', stage: 'style-key-read' }; }
  };
  return {
    source: 'effective-NSUserDefaults-boolForKey',
    enabled: key('com.wechat.enhance.tabbar_style.enabled'),
    groupsEnabled: key('com.wechat.enhance.chat_group.enabled')
  };
}
let associated = null;
let itemStateKey = null;
try {
  const address = typeof Module.findGlobalExportByName === 'function'
    ? Module.findGlobalExportByName('objc_getAssociatedObject')
    : Module.findExportByName(null, 'objc_getAssociatedObject');
  if (address) associated = new NativeFunction(address, 'pointer', ['pointer', 'pointer']);
  const module = Process.enumerateModules().find(m => /WeChatImprove/.test(m.name));
  if (module) {
    const symbol = module.enumerateSymbols().find(s => /^_?CSItemStateKey$/.test(s.name));
    if (symbol) itemStateKey = symbol.address;
  }
} catch (_) { /* A stripped/missing symbol is reported as unavailable, never false. */ }
function styleState(item) {
  if (!associated || !itemStateKey) return unavailable('private-key-or-associated-api-unavailable');
  if (!valid(item)) return unavailable('item-unavailable');
  try {
    const state = object(associated(item.handle, itemStateKey));
    return { association: summary(state), applied: boolean(readFrom(state, 'applied')), depth: numeric(readFrom(state, 'depth')) };
  } catch (_) { return { status: 'read-error', stage: 'associated-style-state' }; }
}
function viewState(result) {
  const base = summary(result);
  if (base.status !== 'ok') return base;
  if (!onMain()) return Object.assign(base, { properties: unavailable('ui-read-off-main') });
  const view = raw(result);
  return Object.assign(base, {
    frame: rect(read(view, 'frame')), bounds: rect(read(view, 'bounds')),
    hidden: boolean(read(view, 'isHidden')), alpha: numeric(read(view, 'alpha')),
    parent: summary(read(view, 'superview')), clipsToBounds: boolean(read(view, 'clipsToBounds'))
  });
}
function itemState(item) {
  if (!onMain()) return { item: summary(ok(item)), properties: unavailable('ui-read-off-main') };
  const badge = read(item, 'badgeView');
  const ancestors = [];
  let parent = readFrom(badge, 'superview');
  while (parent.status === 'ok' && valid(parent.value) && ancestors.length < 10) {
    const layer = readFrom(parent, 'layer');
    ancestors.push({ view: viewState(parent), masksToBounds: boolean(readFrom(layer, 'masksToBounds')),
      zPosition: numeric(readFrom(layer, 'zPosition')), mask: summary(readFrom(layer, 'mask')) });
    parent = readFrom(parent, 'superview');
  }
  return {
    item: viewState(ok(item)), unreadCount: numeric(read(item, 'unreadCount')),
    badgeString: badgeText(read(item, 'badgeString')), badge: viewState(badge),
    image: viewState(read(item, 'imageView')), style: styleConfiguration(),
    styleOwnership: styleState(item), modelIndex: numeric(readFrom(read(item, 'item'), 'index')),
    ancestors, ancestorWalkEnd: ancestors.length === 10 ? unavailable('depth-limit') : summary(parent)
  };
}
function currentFilter(thread) {
  const stack = filtersByThread.get(thread);
  return stack && stack.length ? stack[stack.length - 1] : null;
}
function adapterState(adapter) {
  const fields = { adapter: summary(ok(adapter)) };
  if (!onMain()) return Object.assign(fields, { properties: unavailable('non-atomic-adapter-read-off-main') });
  for (const name of ['changeDepth', 'modelRevision', 'snapshotRevision', 'snapshotEpoch']) fields[name] = numeric(read(adapter, name));
  for (const name of ['dirty', 'presentationSuspended', 'searching', 'publishing']) fields[name] = boolean(read(adapter, name));
  fields.cachePresent = presence(read(adapter, 'cachedNativeSections'));
  const badge = read(adapter, 'alertBadge');
  fields.alertBadge = badge.status === 'ok' && nil(badge.value) ? { status: 'nil' }
    : numeric(readFrom(badge, 'unsignedLongLongValue'));
  fields.controller = summary(read(adapter, 'controller'));
  fields.snapshotAccountMatchesObservedPolicy = unavailable('account-comparison-not-sampled');
  fields.snapshotEpochMatchesObservedEpoch = unavailable('no-snapshot-argument-in-this-adapter-callback');
  fields.currentAccountMatchesPolicy = unavailable('current-account-getter-not-observed');
  return fields; // Only equality booleans; no accounts, row contents or names.
}
function choose(className, body) {
  const cls = ObjC.classes[className];
  if (!cls) return unavailable('class-missing');
  if (typeof ObjC.chooseSync !== 'function') return unavailable('heap-enumeration-api-missing');
  try { return ok(ObjC.chooseSync(cls).map(body)); }
  catch (_) { return { status: 'read-error', stage: 'live-object-enumeration' }; }
}
function rootState(owner, index) {
  if (!onMain()) return unavailable('ui-read-off-main');
  if (index.status !== 'ok' || !Number.isSafeInteger(index.value) || index.value < 0) return unavailable('index-not-safe-integer');
  const controllers = read(owner, 'viewControllers');
  const count = numeric(readFrom(controllers, 'count'));
  if (count.status !== 'ok' || typeof count.value !== 'number') return unavailable('controller-count-unavailable');
  if (index.value >= count.value) return { status: 'out-of-range', controllerCount: count.value };
  const root = readFrom(controllers, 'objectAtIndex_', [index.value]);
  const navigation = boolean(readFrom(root, 'isKindOfClass_', [ObjC.classes.UINavigationController]));
  if (navigation.status !== 'ok') return { root: summary(root), isNavigation: navigation, chatTabMatch: unavailable('root-type-unavailable') };
  const content = navigation.value ? readFrom(readFrom(root, 'viewControllers'), 'firstObject') : root;
  const chatClass = ObjC.classes.NewMainFrameViewController;
  return { root: summary(root), isNavigation: navigation, contentRoot: summary(content),
    chatTabMatch: chatClass ? boolean(readFrom(content, 'isKindOfClass_', [chatClass])) : unavailable('chat-class-missing') };
}
function items(owner) {
  if (!onMain()) return { controller: summary(ok(owner)), properties: unavailable('ui-read-off-main') };
  const bar = read(owner, 'tabBar');
  const views = readFrom(bar, 'tabBarItemViews');
  const count = numeric(readFrom(views, 'count'));
  const entries = [];
  if (count.status === 'ok' && typeof count.value === 'number' && Number.isInteger(count.value) && count.value >= 0) {
    for (let index = 0; index < Math.min(count.value, 64); index++) {
      const item = readFrom(views, 'objectAtIndex_', [index]);
      entries.push({ index, root: rootState(owner, ok(index)), state: item.status === 'ok' && valid(item.value) ? itemState(item.value) : summary(item) });
    }
  }
  return { controller: summary(ok(owner)), bar: viewState(bar), itemViews: summary(views), count,
    entries, truncated: count.status === 'ok' && typeof count.value === 'number' ? ok(count.value > 64) : unavailable('count-unavailable') };
}
function observe(className, selector, enter, leave) {
  const cls = ObjC.classes[className];
  const method = cls && cls[selector];
  if (!method) { log('unavailable-selector', { className, selector }); return; }
  const key = className + selector;
  if (installed.has(key)) return;
  try {
    Interceptor.attach(method.implementation, {
      onEnter(args) {
        this.thread = Process.getCurrentThreadId();
        this.active = !(samplingByThread.get(this.thread) || 0);
        if (!this.active) {
          suppressedByThread.set(this.thread, (suppressedByThread.get(this.thread) || 0) + 1);
          return;
        }
        this.callId = ++callSequence;
        withSampling(this.thread, () => {
          try { this.owner = raw(object(args[0])); if (enter) enter.call(this, args); }
          catch (_) { log('probe-error', { className, selector, callId: this.callId, phase: 'enter', errorCategory: 'native-or-probe-error' }); }
        });
      },
      onLeave(retval) {
        if (!this.active) return;
        withSampling(this.thread, () => {
          try { if (leave) leave.call(this, retval); }
          catch (_) { log('probe-error', { className, selector, callId: this.callId, phase: 'leave', errorCategory: 'native-or-probe-error' }); }
          finally { this.owner = undefined; }
        });
      }
    });
    installed.add(key);
    log('observer-installed', { className, selector, implementation: method.implementation.toString() });
  } catch (_) { log('observer-install-failed', { className, selector, errorCategory: 'native-or-probe-error' }); }
}
observe('CSCloseFriendRuntime', '- snapshotForEpoch:suspended:', function (args) {
  this.epochRaw = integerArgument(args[2]); this.epoch = argumentNumber(args[2]);
  const suspended = argumentNumber(args[3]); this.suspended = boolean(suspended);
  const filter = currentFilter(this.thread); this.filterId = filter ? filter.callId : null;
}, function (ret) {
  const policy = object(ret);
  const options = readFrom(policy, 'options');
  const option = key => {
    try { return boolean(readFrom(readFrom(options, 'objectForKey_', [nsString(key)]), 'boolValue')); }
    catch (_) { return { status: 'read-error', stage: 'policy-option' }; }
  };
  const observation = {
    snapshotCallId: this.callId, filterCallId: this.filterId, thread: this.thread,
    epochArgument: this.epochRaw, epoch: this.epoch, suspendedArgument: this.suspended,
    policyObject: summary(policy), enabled: boolean(readFrom(policy, 'enabled')),
    revealed: boolean(readFrom(policy, 'revealed')), blocked: boolean(readFrom(policy, 'blocked')),
    revision: numeric(readFrom(policy, 'revision')),
    protectedCount: numeric(readFrom(readFrom(policy, 'protectedUserNames'), 'count')),
    hideSessions: option('hideSessions'), silenceMessages: option('silenceMessages')
  };
  const filter = currentFilter(this.thread);
  // No heap enumeration or account reads in the filter hot path. Adapter snapshots
  // are collected only by explicit capture or naturally invoked adapter callbacks.
  observation.adaptersAtSnapshotReturn = unavailable('not-enumerated-in-hot-path');
  observation.observedSequence = log('policy-observed-return', observation);
  lastPolicyByThread.set(this.thread, observation);
  if (filter && filter.callId === this.filterId) filter.snapshots.push(observation);
});
observe('CSGroupListAdapter', '+ closeFriendAlertBadgeCount', function () {
  this.filter = { callId: this.callId, snapshots: [] };
  const stack = filtersByThread.get(this.thread) || [];
  stack.push(this.filter); filtersByThread.set(this.thread, stack);
  log('filter-enter', { callId: this.callId, style: styleConfiguration(),
    previouslyObservedPolicyOnThisThread: lastPolicyByThread.get(this.thread) || unavailable('no-prior-observation'),
    policyAtEntry: unavailable('not-yet-observed-in-this-call') });
}, function (ret) {
  try {
    const value = object(ret);
    log('filter-return', { callId: this.callId, value: value.status === 'nil' ? value : numeric(readFrom(value, 'unsignedLongLongValue')),
      snapshotsObservedInThisCall: this.filter ? this.filter.snapshots : [],
      policyAssociation: this.filter && this.filter.snapshots.length ? 'same-thread-nested-observation' : 'unavailable-no-nested-observation' });
  } finally {
    const stack = filtersByThread.get(this.thread) || [];
    const index = stack.indexOf(this.filter);
    if (index >= 0) stack.splice(index, 1);
    if (!stack.length) filtersByThread.delete(this.thread);
    this.filter = undefined;
  }
});
for (const selector of ['- beginNativeChangeOfKind:', '- endNativeChangeCoalesced:', '- refresh']) {
  observe('CSGroupListAdapter', selector, function () {
    log('adapter-enter', { selector, callId: this.callId, state: adapterState(this.owner) });
  }, function () { log('adapter-leave', { selector, callId: this.callId, state: adapterState(this.owner) }); });
}
for (const selector of ['- setTabBarBadgeValue:forIndex:', '- setTabBarBadgeString:forIndex:',
  '- showRedDotOnTabBarItemAtIndex:', '- removeRedDotOnTabBarItemAtIndex:']) {
  observe('MMTabBarController', selector, function (args) {
    const isString = selector.includes('String'); const isValue = selector.includes('Value');
    const index = (isString || isValue) ? args[3] : args[2];
    this.indexRaw = integerArgument(index); this.index = argumentNumber(index);
    log('controller-input', { selector, callId: this.callId, index: this.indexRaw,
      requested: isString ? badgeText(object(args[2])) : isValue ? integerArgument(args[2]) : { status: 'not-applicable' },
      controller: summary(ok(this.owner)), root: rootState(this.owner, this.index), style: styleConfiguration() });
  }, function () { log('controller-result', { selector, callId: this.callId, index: this.indexRaw, state: items(this.owner) }); });
}
for (const selector of ['- setTabBarBadgeValue:', '- setTabBarBadgeString:', '- setBadgeViewHidden:',
  '- showSmallRedDot', '- removeSmallRedDot', '- layoutBadgeView']) {
  observe('MMTabBarItemView', selector, function (args) {
    log('item-input', { selector, callId: this.callId, item: summary(ok(this.owner)),
      actualArgument: selector.includes('String:') ? badgeText(object(args[2]))
        : selector.endsWith(':') ? integerArgument(args[2]) : { status: 'not-applicable' }, state: itemState(this.owner) });
  }, function () { log('item-result', { selector, callId: this.callId, state: itemState(this.owner) }); });
}
for (const [className, selector] of [
  ['CMessageMgr', '- AsyncOnAddMsg:MsgWrap:'],
  ['MainFrameLogicController', '- onSessionTotalUnreadCountChange:'],
  ['NewMainFrameViewController', '- updateUnReadCount']
]) {
  observe(className, selector, function () { log('message-chain-enter', { className, selector, callId: this.callId }); },
    function () { log('message-chain-leave', { className, selector, callId: this.callId }); });
}
observe('MainFrameLogicController', '- getTotalUnreadCount', null, function (ret) {
  log('native-unread-return', { callId: this.callId, count: ok(ret.toUInt32()),
    source: 'naturally-invoked-original-return-unsigned-int' });
});
function capture(label) {
  const allowed = ['style-on-cold', 'style-on-message', 'style-off-cold', 'style-off-message'];
  const safeLabel = allowed.includes(label) ? label : '<custom-label-redacted>';
  ObjC.schedule(ObjC.mainQueue, function () {
    const thread = Process.getCurrentThreadId();
    withSampling(thread, () => {
      try {
        log('quadrant-snapshot', { label: safeLabel,
          controllers: choose('MMTabBarController', owner => items(owner)),
          adapters: choose('CSGroupListAdapter', adapter => adapterState(adapter)),
          previouslyObservedPolicyOnThisThread: lastPolicyByThread.get(thread) || unavailable('no-prior-observation'),
          policyNow: unavailable('not-invoked-by-capture') });
        log('bar-style-state', { label: safeLabel, states: choose('CSTabBarState', state => ({
          bar: summary(read(state, 'bar')), applied: boolean(read(state, 'applied')),
          geometryApplied: boolean(read(state, 'geometryApplied')), depth: numeric(read(state, 'depth'))
        })) });
      } catch (_) { log('probe-error', { phase: 'capture', errorCategory: 'native-or-probe-error' }); }
    });
  });
}
globalThis.badgeAudit = { capture };
rpc.exports = { capture(label) { capture(label); return 'snapshot queued on main thread'; } };
log('probe-ready', { privateItemStateKeyAvailable: !!itemStateKey,
  note: 'Observers only; attach after initialization. Labels: style-on-cold, style-on-message, style-off-cold, style-off-message. Syntax checked only; no device execution.' });
