#!/usr/bin/env python3
"""Create a source route inventory; this is not UI automation."""
import hashlib,json,pathlib,re
root=pathlib.Path(__file__).resolve().parents[4];out=pathlib.Path(__file__).resolve().parent
coverage=json.loads((out.parent/'tabbar-navigation-validation/red-runtime-2.2-18/route-coverage.json').read_text());byclass={r['class']:r for r in coverage['classes'] if 'parent' in r}
custom=(root/'Controllers/CSCustomViewController.m').read_text();start=custom.index('- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:');text=custom[start:]
matches=list(re.finditer(r'if \(\[item.title isEqualToString:@"([^"]+)"\]\)',text));rows=[]
for index,match in enumerate(matches):
 label=match[1];body=text[match.end():matches[index+1].start() if index+1<len(matches) else len(text)]
 cls_match=re.search(r'\[\[(CS\w+)\s+alloc\]',body)
 if label=='捉迷藏呀':cls='CSCloseFriendSettingsViewController'
 elif not cls_match:continue
 else:cls=cls_match[1]
 row={'path':label,'class':cls,'source':'Controllers/CSCustomViewController.m','line':custom.count('\n',0,start+match.start())+1,'verification':'source-derived runtime class declaration; production shared base executes; child body/navigation NOT executed','device':'未验证'}
 if label=='顶栏信息':row['page_title']='顶栏头像设置'
 rows.append(row)
rows.append({'path':'密友设置（头像五击）','class':'CSCloseFriendSettingsViewController','source':'Controllers/CSCustomViewController.m','line':654,'verification':'source-derived class; shared base getter; quick-entry authentication tests remain separate','device':'未验证'})
extra=[('备份 → 恢复预览','CSBackupPreviewViewController'),('重置设置 → 预览重置','CSBackupPreviewViewController'),('备份 → 配置修复','CSBackupRepairViewController'),('配置修复 → 导航栏分隔图片','CSNavigationTitleSettingsViewController'),('配置修复 → 底栏图标','CSTabBarStyleSettingsViewController'),('配置修复 → 触摸轨迹图片','CSTouchTrailViewController'),('配置修复 → 联系人分隔图片','CSContactSeparatorSettingsViewController'),('AI → 选择预设/能力选项','CSAIOptionsPage'),('AI → 管理预设','CSAIPresetsPage'),('AI → 已开启的会话','CSAIConversationsPage'),('AI → 会话详情','CSAIConversationPage'),('AI → 回复记录','CSAIHistoryPage'),('AI → 模型连接','CSAIConnectionEditor'),('AI → 新增/编辑预设','CSAIPresetEditor'),('定时任务 → 新建/编辑任务','CSScheduledTaskEditor'),('定时任务 → 消息内容','CSScheduledTaskTextEditor'),('定时任务 → 时间选择','CSScheduledTaskTimeEditor')]
for label,cls in extra:
 record=byclass[cls];rows.append({'path':label,'class':cls,'source':record['source'],'line':None,'verification':record['implementation_executed']+'; child body/navigation NOT executed','device':'未验证'})
rows.append({'path':'配置修复 → 其他插件设置（再次打开根宿主）','class':'CSNativeSettingsHostController','source':'Controllers/CSBackupSettingsViewController.m','line':67,'verification':'source inspection + native MMUIViewController init YES disassembly; host root stand-in only','device':'未验证'})
for row in rows:row['parent']=byclass.get(row['class'],{}).get('parent','MMUIViewController (dynamic)')
(out/'route-coverage.json').write_text(json.dumps({'routes':rows,'all_source_derived_classes':coverage['classes'],'push_calls':coverage['push_calls'],'scope':'Source inventory plus source-bound host class stubs. No UI page bodies, callbacks or UIKit native transitions executed. Not device validation.'},ensure_ascii=False,indent=2)+'\n')
lines=['# 2.2-19 路径覆盖说明','', '每行的“主机验证”均指**按生产 interface 链生成类声明，执行完整生产共享基类及四个纯编辑器抽取 getter**；不执行子页自身业务实现、不执行实际菜单点击或 UIKit 导航。具体每类样本在 tabbar-navigation-validation 的 samples.json。所有真机栏明确未验证；不能将“共用基类”记作各页面已上真机通过。','', '| 页面/路径 | 目标类型 | 继承/声明 | 源入口 | 主机验证 | 真机 |','| --- | --- | --- | --- | --- | --- |']
for r in rows:
 parent=byclass.get(r['class'],{}).get('parent','MMUIViewController (dynamic)')
 where=r['source']+((':'+str(r['line'])) if r['line'] else '')
 check='原生init YES静态证据 + 根页替身' if r['class']=='CSNativeSettingsHostController' else ('只执行生产抽取getter' if r['class'] in ['CSAIConnectionEditor','CSAIPresetEditor','CSScheduledTaskTextEditor','CSScheduledTaskTimeEditor'] else '生产共享基类执行；子页实现未执行')
 lines.append('| '+r['path']+' | `'+r['class']+'` | `'+parent+'` | `'+where+'` | '+check+' | 未验证 |')
lines+=['','源声明共派生 44 个共享基类后代、4 个 plain editor；增加密友两个入口标签后主机模型 50 条 route。子页请求包含的所有类型逐行列出，也保留根列表其余真实功能目的页。','', '反向模型覆盖子页→根列表→插件列表→微信主界面、四 tab 轮换、两次重复进入退出、modal 独立入口、底栏样式开/关。模型只验证导航政策不粘滞、非插件页面仍默认 NO；它没有运行样式 adapter，因此不能证明实际圆角、描边、缩放、图标、文字、未读角标或点击区域的视觉/事件行为。样式生产实现由既有 tabbar suite 回归，真机完整外观/点击仍未验证。','', '`WEContactSelectViewController` 虽由 Makefile wildcard 编译，当前 Controllers/Hooks 中没有 alloc/new/push 使用。CSChatGroupSettingsViewController 仅使用其 enum，实际联系人流程走 CSNativeContactPickerPresent/PresentTags 的原生 modal；本轮不改它。系统图片/颜色/文件选择器、原生联系人 modal 也不被全局改写；真机 modal 表现未验证。']
(out/'route-coverage.md').write_text('\n'.join(lines)+'\n');print(len(rows),'documented paths')
