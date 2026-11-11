#!/usr/bin/env python3
"""Read-only comparison against the captured 2.4-7 editor source."""
from pathlib import Path
import hashlib
import json
import re

BASE = Path(__file__).resolve().parent
ROOT = BASE.parents[2]
source = ROOT / 'Controllers/CSGroupChatSettingsViewController.m'
b = (BASE / 'baseline-CSGroupChatSettingsViewController.m').read_text()
c = source.read_text()
parts = json.loads((BASE / 'behavior-method-baseline.json').read_text())
checks = []


def part(s, start, end):
    a = s.index(start)
    return s[a:s.index(end, a)]


def check(name, result, detail):
    checks.append({'name': name, 'pass': bool(result), 'detail': detail})


for key, start, end in [
    ('editor-save', '- (void)save {', '\n@end'),
    ('editor-cancel', '- (void)cancel {', '\n- (void)insertVariable'),
    ('editor-restoreDefault', '- (void)restoreDefault {', '\n- (void)save'),
    ('homepage-reload-and-rows', '- (void)reloadSettings {', '\n- (void)saveChanges:'),
]:
    check(key, part(c, start, end) == parts[key], '完整方法段与基线逐字比较。')

old = parts['homepage-editTemplate']
new = part(c, '- (void)editTemplate:(NSString *)key {', '\n- (void)editDelay')
normalized = new.replace('[[CSGroupChatTemplateEditor alloc] initWithStyle:UITableViewStyleInsetGrouped]', '[CSGroupChatTemplateEditor new]')
check('homepage-editTemplate-only-table-style', normalized == old, '唯一差异为 new → initWithStyle:UITableViewStyleInsetGrouped。')

bi = part(b, '- (void)insertVariable {', '\n- (void)restoreDefault')
ci = part(c, '- (void)insertVariable {', '\n- (void)restoreDefault')
old_anchor = '    sheet.popoverPresentationController.sourceView=self.view; sheet.popoverPresentationController.sourceRect=CGRectMake(CGRectGetMidX(self.view.bounds),180,1,1);'
anchor_start = ci.index('    UIView *anchor=')
anchor_end = ci.index('    [self presentViewController:sheet', anchor_start)
normalized = ci[:anchor_start] + old_anchor + '\n' + ci[anchor_end:]
check('insertVariable-only-popover-anchor', normalized == bi, 'sheet 名称、选项内容/顺序、上下文检查、dismiss 后 becomeFirstResponder+insertText 和调用顺序均逐字不变，仅锚点替换。')

bs = part(b, '- (void)stateChanged:(NSNotification *)note {', '\n- (void)textViewDidChange:')
cs = part(c, '- (void)stateChanged:(NSNotification *)note {', '\n- (void)textViewDidChange:')
normalized = cs.replace('self.stateText=', 'self.stateLabel.text=').replace('    [self.tableView footerViewForSection:2].textLabel.text=self.stateText;\n', '')
check('stateChanged-only-footer-storage', normalized == bs, 'valid/saving 规则、保存标题、editable 和完整原提示字串不变，仅存储到 footer 文本并更新当前 section。')

bp = part(b, '- (void)updatePreview {', '\n- (void)cancel')
cp = part(c, '- (void)updatePreview {', '\n- (void)updateContentHeights')
normalized = cp.replace('self.counterText=', 'self.counterLabel.text=')
normalized = normalized.replace('    UILabel *counter=[self.tableView footerViewForSection:0].textLabel;\n', '').replace('    counter.text=self.counterText;\n', '')
normalized = normalized.replace('counter.textColor=', 'self.counterLabel.textColor=').replace('    [self updateContentHeights];\n', '')
check('updatePreview-only-footer-and-height', normalized == bp, '原 %lu / 4,000 计数、红色条件、全部示例值、欢迎 U+2005 与 CSGroupChatRenderTemplate 逐字不变。')

original_help = re.findall(r'help.text=(@"[^\n]*");', b)
check('all-three-original-help-strings', len(original_help) == 3 and all(x in c for x in original_help), '三套原始说明逐字保留并追加 @群昵称/@群人数/@时间 含义。')
check('all-other-production-source-outside-editor', b[b.index('@interface CSGroupChatQuitResultsViewController'):].replace('[CSGroupChatTemplateEditor new]', '[[CSGroupChatTemplateEditor alloc] initWithStyle:UITableViewStyleInsetGrouped]') == c[c.index('@interface CSGroupChatQuitResultsViewController'):], '编辑器之后所有代码仅入口初始化样式变化。')
check('shared-helper-and-cell-source-unchanged', b[:b.index('@interface CSGroupChatTemplateEditor')].strip() == c[:c.index('// Only this editor adapts')].replace('#import <math.h>\n', '').strip(), 'CSGCContextValid/CSGCRequireAuthorization/CSGCRow/CSGroupChatSettingsCell/CSGCConfigureTable 均逐字不变；仅增加 math.h import。')
editor = part(c, '@interface CSGroupChatTemplateEditor', '\n@interface CSGroupChatQuitResultsViewController')
check('no-editor-reload', not re.search(r'reloadData|reloadRows', editor), '编辑器内没有 reloadData/reloadRows。稳定 editorCell/textView 通过 beginUpdates/endUpdates 更新高度。')
check('navigation-and-accessibility', all(x in editor for x in [
    '- (BOOL)hidesBottomBarWhenPushed { return YES; }',
    'text.accessibilityLabel=self.title;',
    'initWithTitle:@"取消" style:UIBarButtonItemStylePlain',
    'initWithTitle:@"保存" style:UIBarButtonItemStyleDone',
    'text.adjustsFontForContentSizeCategory=YES;',
]), '标题继续由未变的 editTemplate 设置；取消/保存文案与 style、accessibilityLabel、hidesBottomBarWhenPushed 保留。')

hashes = json.loads((BASE / 'behavior-baseline-hashes.json').read_text())
for path, sha in hashes.items():
    if path == 'Controllers/CSGroupChatSettingsViewController.m':
        continue
    check('unchanged-file-' + path, hashlib.sha256((ROOT / path).read_bytes()).hexdigest() == sha, '文件 SHA-256 与改造前相同。')

report = {
    'source': str(source),
    'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
    'checks': checks,
    'all_behavior_checks_pass': all(x['pass'] for x in checks),
    'device_validation': '未执行真机运行验证；只读源码比较不能证明键盘、SE/横屏/iPad 与动态字体显示结果。',
    'layout_review_notes': [
        '已修正：footer 更新直接取 footerViewForSection，避免离屏 footer 复用写错 section。',
        '已修正：footer 高度测量额外扣除 32pt，给系统 footer 内边距预留空间。',
        '已修正：编辑区 height constraint priority 为 999，避免 separator 厚度与 required 上下约束冲突。',
        '已修正：浮动 iPad 键盘遮挡 caret 且现有滚动空间不足时，以 floatingKeyboardInset 记录缺少的滚动空间，通过原键盘 delta 叠加；键盘移动或隐藏时清零撤回。真实设备表现尚未验证。',
    ],
}
(BASE / 'behavior-comparison.json').write_text(json.dumps(report, ensure_ascii=False, indent=2) + '\n')
lines = [
    '# 2.4-8 行为源码独立对照', '',
    f"行为比较：{'全部通过' if report['all_behavior_checks_pass'] else '存在失败'}。这是源码级证据，不代表真机运行验证。", '',
    '| 检查 | 结果 | 证据与范围 |', '|---|---|---|',
]
for item in checks:
    lines.append(f"| {item['name']} | {'PASS' if item['pass'] else 'FAIL'} | {item['detail']} |")
lines += ['', '## 布局审查记录', '']
lines += ['- ' + x for x in report['layout_review_notes']]
lines += ['', report['device_validation'], '']
(BASE / 'behavior-comparison.md').write_text('\n'.join(lines))
print(json.dumps({'all_behavior_checks_pass': report['all_behavior_checks_pass'], 'checks': len(checks), 'failed': [x['name'] for x in checks if not x['pass']]}, ensure_ascii=False))
raise SystemExit(0 if report['all_behavior_checks_pass'] else 1)
