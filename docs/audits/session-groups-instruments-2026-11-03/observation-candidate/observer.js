/* OFFLINE CANDIDATE. Never attached or executed against the device.
 * Frida 17 core API only; deliberately does not depend on global ObjC.
 * Counts/timings describe an instrumented run, never the unobserved baseline.
 * No message text, names, group identifiers, or unread values are emitted.
 */
'use strict';

const EXPECTED_UUIDS = new Set([
  '45BD5B83-2727-3243-B023-946D8F99D149', '9A79A63A-FD75-3E01-B60D-B1EDE7F5C64D',
  'DC3D6FF4-3E03-3578-B866-C1977E293AD0', 'D495EF9A-1354-323E-98C4-65CCCD1B5CDE'
]);
const MAX_SAMPLES = 65536;
const nf = (name, result, args) => new NativeFunction(Module.getGlobalExportByName(name), result, args);
const getClass = nf('objc_getClass', 'pointer', ['pointer']);
const getObjectClass = nf('object_getClass', 'pointer', ['pointer']);
const getSuperclass = nf('class_getSuperclass', 'pointer', ['pointer']);
const getName = nf('class_getName', 'pointer', ['pointer']);
const getInstanceMethod = nf('class_getInstanceMethod', 'pointer', ['pointer', 'pointer']);
const getClassMethod = nf('class_getClassMethod', 'pointer', ['pointer', 'pointer']);
const getImp = nf('method_getImplementation', 'pointer', ['pointer']);
const registerSelector = nf('sel_registerName', 'pointer', ['pointer']);
const msgObject = nf('objc_msgSend', 'pointer', ['pointer', 'pointer']);
const msgInteger = nf('objc_msgSend', 'long', ['pointer', 'pointer']);
const ticks = nf('mach_absolute_time', 'uint64', []);
const timebase = Memory.alloc(8);
if (nf('mach_timebase_info', 'int', ['pointer'])(timebase) !== 0) throw new Error('mach_timebase_info failed');
const ticksToUs = timebase.readU32() / timebase.add(4).readU32() / 1000;
const selectors = new Map(), listeners = [], installed = new Set(), metrics = new Map();
const scopes = new Map(), targetTables = new Set(), targetChrome = new Set(), tableDepths = new Map();
let active = false, started = null, stopped = null;
const sel = name => {
  if (!selectors.has(name)) selectors.set(name, registerSelector(Memory.allocUtf8String(name)));
  return selectors.get(name);
};
const object = (self, name) => msgObject(self, sel(name));
const integer = (self, name) => {
  const value = msgInteger(self, sel(name));
  return typeof value === 'number' ? value : value.toNumber();
};
const elapsedUs = begin => ticks().sub(begin).toNumber() * ticksToUs;
const tidScopes = tid => {
  if (!scopes.has(tid)) scopes.set(tid, []);
  return scopes.get(tid);
};
function count(name, us) {
  if (!metrics.has(name)) metrics.set(name, {entries: 0, normalReturns: 0, totalUs: 0, minUs: null, maxUs: null, samplesUs: [], samplesTruncated: false});
  const m = metrics.get(name);
  if (us === undefined) { m.entries++; return; }
  m.normalReturns++; m.totalUs += us;
  m.minUs = m.minUs === null ? us : Math.min(m.minUs, us);
  m.maxUs = m.maxUs === null ? us : Math.max(m.maxUs, us);
  if (m.samplesUs.length < MAX_SAMPLES) m.samplesUs.push(us); else m.samplesTruncated = true;
}
function uuidForModule(module) {
  const base = module.base;
  if (base.readU32() !== 0xfeedfacf) throw new Error('Expected 64-bit Mach-O');
  const ncmds = base.add(16).readU32(), bytes = base.add(20).readU32();
  if (ncmds > 4096 || bytes > module.size) throw new Error('Invalid Mach-O commands');
  let p = base.add(32), consumed = 0;
  for (let i = 0; i < ncmds; i++) {
    const cmd = p.readU32(), size = p.add(4).readU32();
    if (size < 8 || consumed + size > bytes) throw new Error('Invalid Mach-O command size');
    if (cmd === 0x1b && size >= 24) {
      const a = new Uint8Array(p.add(8).readByteArray(16));
      const h = Array.from(a, b => b.toString(16).padStart(2, '0')).join('').toUpperCase();
      return `${h.slice(0, 8)}-${h.slice(8, 12)}-${h.slice(12, 16)}-${h.slice(16, 20)}-${h.slice(20)}`;
    }
    p = p.add(size); consumed += size;
  }
  throw new Error('No LC_UUID');
}
function method(className, selector, isClass) {
  const c = getClass(Memory.allocUtf8String(className));
  if (c.isNull()) throw new Error(`Missing class ${className}`);
  const m = (isClass ? getClassMethod : getInstanceMethod)(c, sel(selector));
  if (m.isNull()) throw new Error(`Missing method ${className} ${selector}`);
  return getImp(m).strip();
}
function mainAdapter(self) {
  const controller = object(self, 'controller');
  if (controller.isNull()) return false;
  let c = getObjectClass(controller);
  while (!c.isNull()) {
    if (getName(c).readUtf8String() === 'NewMainFrameViewController') return true;
    c = getSuperclass(c);
  }
  return false;
}
function installAt(imp, selector, name, callbacks) {
  const key = `${imp}:${selector}:${name}`;
  if (installed.has(key)) return;
  installed.add(key);
  listeners.push(Interceptor.attach(imp, {
    onEnter(args) {
      this.observing = false;
      if (!args[1].equals(sel(selector))) return;
      this.observing = callbacks.enter.call(this, args) !== false;
    },
    onLeave(retval) {
      if (this.observing && callbacks.leave) callbacks.leave.call(this, retval);
    }
  }));
}
function discoverTable(adapter) {
  const table = object(adapter, 'table'), chrome = object(adapter, 'chrome');
  if (!chrome.isNull()) targetChrome.add(chrome.toString());
  if (table.isNull() || targetTables.has(table.toString())) return;
  targetTables.add(table.toString());
  const c = getObjectClass(table);
  for (const [selector, kind] of [['reloadData', 'reloadData'], ['reloadRowsAtIndexPaths:withRowAnimation:', 'reloadRows']]) {
    const m = getInstanceMethod(c, sel(selector));
    if (m.isNull()) throw new Error(`Target table missing ${selector}`);
    installAt(getImp(m).strip(), selector, `table.${kind}`, {
      enter(args) {
        if (!active || !targetTables.has(args[0].toString())) return false;
        this.depthKey = `${this.threadId}:${args[0]}:${kind}`;
        const depth = tableDepths.get(this.depthKey) || 0;
        tableDepths.set(this.depthKey, depth + 1);
        this.outer = depth === 0;
        if (this.outer) {
          const inPublication = tidScopes(this.threadId).some(x => x.indexOf('publication.') === 0);
          this.metric = `table.${kind}.${inPublication ? 'in_plugin_publication' : 'outside_plugin_publication'}`;
          count(this.metric); this.begin = ticks();
        }
      },
      leave() {
        tableDepths.set(this.depthKey, tableDepths.get(this.depthKey) - 1);
        if (this.outer) count(this.metric, elapsedUs(this.begin));
      }
    });
  }
}
function observe(className, selector, name, options = {}) {
  installAt(method(className, selector, !!options.classMethod), selector, name, {
    enter(args) {
      if (options.adapter) {
        if (!mainAdapter(args[0])) return false;
        discoverTable(args[0]);
      }
      if (options.chrome && !targetChrome.has(args[0].toString())) return false;
      if (!active) return false;
      this.name = name;
      if (options.model) this.name += tidScopes(this.threadId).includes('coordinator.apply') ? '.main_apply' : '.other_context';
      this.before = options.before ? options.before(args[0]) : null;
      this.self = args[0];
      if (options.scope) tidScopes(this.threadId).push(options.scope);
      count(this.name); this.begin = ticks();
    },
    leave(retval) {
      const us = elapsedUs(this.begin);
      if (options.scope) {
        const stack = tidScopes(this.threadId);
        if (stack.pop() !== options.scope) throw new Error('Observer scope mismatch');
      }
      count(this.name, us);
      if (options.returnNil) count(`${this.name}.${retval.isNull() ? 'nil' : 'non_nil'}`);
      if (options.changed && options.changed(this.self, this.before)) count(`${this.name}.state_changed`);
    }
  });
}
const full = 'buildWithTopSessions:normalSessions:allTopSessions:allSessions:tabs:selectedTabID:groupingEnabled:filterDuplicates:accountID:hiddenUserNames:privacyRevision:scopeFoldedEntry:foldedRows:rowProvider:';
const image = Process.findModuleByAddress(method('CSGroupNativeModel', full, true));
if (image === null) throw new Error('Model IMP has no loaded image');
const uuid = uuidForModule(image);
if (!EXPECTED_UUIDS.has(uuid)) throw new Error(`Loaded model image UUID is not known 2.2-8: ${uuid}`);

observe('CSGroupNativeSessionCoordinator', 'applyBaselineCandidate', 'coordinator.apply_candidate', {scope: 'coordinator.apply'});
observe('CSGroupNativeModel', full, 'model.full', {classMethod: true, model: true});
observe('CSGroupNativeModel', 'modelByUpdatingResult:changedUserNames:rowProvider:', 'model.delta', {classMethod: true, model: true, returnNil: true});
observe('CSGroupListAdapter', 'refresh', 'adapter.refresh_attempt', {adapter: true});
observe('CSGroupListAdapter', 'refreshNativeSessionModel', 'adapter.native_refresh_attempt', {adapter: true});
observe('CSGroupListAdapter', 'publishNativeProjection:previous:changes:changedUserNames:previouslyProjecting:', 'adapter.native_publication', {adapter: true, scope: 'publication.native'});
observe('CSGroupListAdapter', 'publishProjection:previous:changes:previouslyProjecting:', 'adapter.compatibility_publication', {adapter: true, scope: 'publication.compatibility'});
observe('CSGroupListAdapter', 'selectIndex:', 'group.selection_request', {adapter: true});
observe('WESessionTabContainerView', 'updateTabs:', 'chrome.update_tabs_attempt', {
  chrome: true, before: self => object(self, 'renderedTabRecords'),
  changed: (self, before) => !object(self, 'renderedTabRecords').equals(before)
});
observe('WESessionTabContainerView', 'selectTabAtIndex:animated:', 'chrome.selection_attempt', {
  chrome: true, before: self => integer(self, 'selectedIndex'),
  changed: (self, before) => integer(self, 'selectedIndex') !== before
});
observe('WESessionTabContainerView', 'updateUnreadCount:hasRedDot:forTabIndex:', 'chrome.badge_update_attempt', {chrome: true});

rpc.exports = {
  status() { return {candidate: true, pid: Process.id, image: image.name, uuid, active, discoveredMainTables: targetTables.size, discoveredMainChrome: targetChrome.size, installedHooks: listeners.length}; },
  arm() {
    if (active) throw new Error('Already armed');
    if (!targetTables.size || !targetChrome.size) throw new Error('Wait for a natural main-list refresh before arming; discovery is incomplete');
    metrics.clear(); scopes.clear(); tableDepths.clear(); started = ticks(); stopped = null; active = true;
    return {active, pid: Process.id, discoveredMainTables: targetTables.size, discoveredMainChrome: targetChrome.size};
  },
  stop() {
    active = false; stopped = ticks();
    const result = {};
    for (const [name, value] of metrics) {
      const sorted = value.samplesUs.slice().sort((a, b) => a - b);
      result[name] = {...value, samplesUs: undefined,
        meanUs: value.normalReturns ? value.totalUs / value.normalReturns : null,
        p95Us: !value.samplesTruncated && sorted.length ? sorted[Math.ceil(sorted.length * 0.95) - 1] : null};
    }
    return {instrumentedRun: true, durationSeconds: started === null ? null : stopped.sub(started).toNumber() * ticksToUs / 1e6,
      cpuAndFramesAreNotMeasuredHere: true, timingsIncludeObserverOverhead: true, metrics: result,
      inFlightScopesAtStop: Array.from(scopes.values()).reduce((n, a) => n + a.length, 0)};
  },
  detach() { active = false; for (const listener of listeners) listener.detach(); return {detached: listeners.length}; }
};
send({type: 'offline-candidate-loaded', pid: Process.id, image: image.name, uuid, active: false, requiresDiscoveryBeforeArm: true});
