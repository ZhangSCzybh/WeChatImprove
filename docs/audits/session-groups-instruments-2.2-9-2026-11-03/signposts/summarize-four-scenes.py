#!/usr/bin/env python3
"""Summarize four existing measured signpost analyses. No device access."""
import hashlib
import json
from pathlib import Path

BASE=Path(__file__).resolve().parent
SCENES=[('idle-confirmed','静置',25,65),('messages','连续收消息',25,70),
        ('scroll','滚动',25,65),('switch','切组',25,70)]

def sha(path):return hashlib.sha256(path.read_bytes()).hexdigest()
def metric(value):
    if value is None:return '未观察到'
    return f'{value:.6f}'

records=[]
for name,title,begin,end in SCENES:
    path=BASE/f'{name}-summary.json';d=json.loads(path.read_text());s=d['summary']
    assert d['target_pid']==40208
    assert d['recording_status_verified_externally']=='complete'
    assert d['window_seconds']['begin']==begin and d['window_seconds']['end']==end
    validity_path=BASE.parent/name/'scenario-validity.json';validity=json.loads(validity_path.read_text())
    assert validity['eligible_for_final_comparison'] is True
    issues={key:d[key] for key in ('pairing_issues','whole_export_unpaired_events') if d[key]}
    if d['input']['issues']:issues['xml']=d['input']['issues']
    if d['input']['arguments'] and d['input']['arguments']['issues']:issues['args_xml']=d['input']['arguments']['issues']
    native_names=('ModelFull','ModelDelta','ModelSelection','CoordinatorApply','AdapterRefreshAttempt','AdapterPublication','MainTableReloadData','MainTableReloadRows')
    native_observed={key:s['operations'][key] for key in native_names if s['operations'][key]['complete_interval_count']}
    records.append({'scenario':name,'title':title,'window_seconds':d['window_seconds'],
                    'analysis_path':str(path),'analysis_sha256':sha(path),
                    'validity_path':str(validity_path),'validity_sha256':sha(validity_path),
                    'scenario_limitations':validity['limitations'],'parser_issues':issues,
                    'unique_probe_events_in_window':s['selected_unique_raw_events'],
                    'native_observed_complete_intervals':native_observed,
                    'native_measurement_status':'unavailable' if not native_observed else 'inspect_native_chain_coverage',
                    'target_coverage':s['publication_target_validation'],'main_table_coverage':s['main_table_reload_coverage'],
                    'class_scope_update_tabs':s['operations']['TabRecordsUpdateAttempt'],
                    'class_scope_layout':s['operations']['TabLayout'],
                    'class_scope_records_rebuilt_events':s['events']['TabRecordsRebuilt'],
                    'known_change_hint':s['events']['KnownChangeHint'],'unknown_change_hint':s['events']['UnknownChangeHint'],
                    'whole_export_probe_time_seconds':d['whole_export_probe_time_seconds']})

assert all(not r['native_observed_complete_intervals'] for r in records), 'New native coverage needs review before drafting text'
assert all(not r['parser_issues'] for r in records), 'Parser/boundary issues need review before drafting text'
assert all(r['class_scope_update_tabs']['outcomes'].get('unchanged',0)==r['class_scope_update_tabs']['complete_interval_count'] for r in records), 'New Tab outcomes need review'

out={'target_pid':40208,'build':'2.2-9+observe','scenes':records,
     'limits':['Model timing and actual verified main-table reload counts were not obtained if native chain and target validation are absent. Missing records must not be interpreted as zero computation or zero refresh.',
               'Tab probes cover WESessionTabContainerView methods across the target process, without owner/window identity; not exclusively the visible main-list container.',
               'Timing is synchronous observation-build wall time, includes probe overhead and is not CPU time or click-to-display latency. Nested timings cannot be added.',
               'Known/Unknown hint counts and change-kind bitmasks are not message counts or confirmed model fallback counts.',
               '2.2-8 did not have matching probes, so no before/after per-round or actual reload-count comparison exists.',
               'The messages25-55s sensitivity window was selected after inspecting activity; it does not replace the retained25-70s main window. Exact input arrival rates and manual action intensity were not independently counted.'],
     'source_diagnosis':'native-probe-coverage-diagnosis.md'}
json_path=BASE/'four-scenes-observation.json';md_path=BASE/'four-scenes-observation.md'
if json_path.exists() or md_path.exists():raise SystemExit('Refusing to overwrite final summary evidence')
json_path.write_text(json.dumps(out,ensure_ascii=False,indent=2)+'\n')
lines=['# 四场景原生 signpost 观测汇总','',
       '四份正式 trace 均成功完成，目标 PID 为 40208，构建为 2.2-9+observe。用户已确认静置重采未触屏、消息约持续 60 秒但尾段有短暂停发、滚动与切组按提示进行且切组界面和列表生效。',
       '',
       '**四景均未取得原生模型链路和主表目标验证。因此每轮原生计算耗时、原生发布次数、已验证主表 reload 次数须报告“未取得”；不能报告为 0，也不能用下面的 Tab 类方法耗时替代。**',
       '',
       '| 场景 | 主分析窗口 | Tab 更新完整调用 | 更新结果 Unchanged | Tab 布局完整调用 | Known / Unknown 提示 | 原生模型与主表覆盖 |',
       '| --- | --- | ---: | ---: | ---: | ---: | --- |']
for r in records:
    tab=r['class_scope_update_tabs'];layout=r['class_scope_layout']
    lines.append(f"| {r['title']} | [{r['window_seconds']['begin']:g}, {r['window_seconds']['end']:g}) 秒 | {tab['complete_interval_count']} | {tab['outcomes'].get('unchanged',0)} | {layout['complete_interval_count']} | {r['known_change_hint']['count']} / {r['unknown_change_hint']['count']} | 未取得 |")
lines+=['','表中的 Tab 指进程内 `WESessionTabContainerView` 类方法，未携带 owner/window 标识，不能逐次归属为当前可见主列表。Tab 更新不等于有效切组、模型重算、表格发布或按钮重建；所有观察到的完整 updateTabs 调用均为 Unchanged，表明这些调用的记录对象未替换。布局计数 0 仅表示本窗口未观察到该类 layoutSubviews 区间，不能推广到宿主所有布局。','',
        '| 场景 | Tab 更新 P50 / P95 / 最大值 (ms) | Tab 布局 P50 / P95 / 最大值 (ms) |',
        '| --- | --- | --- |']
for r in records:
    cells=[]
    for key in ('class_scope_update_tabs','class_scope_layout'):
        durations=r[key]['duration_ms']
        cells.append(' / '.join(metric(durations[k]) for k in ('p50','p95_nearest_rank','max')))
    lines.append(f"| {r['title']} | {cells[0]} | {cells[1]} |")
lines+=['','这些是观测构建中的同步墙钟耗时，包含探针开销，尤其微秒量级的 Tab 更新不能当作纯计算成本。没有执行正式包/关闭观测/开启观测的同设备开销对照。','',
        '所有正式窗口 XML ref、参数载荷和 begin/end 配对检查均无异常。导出中的同名表可能重复包含事件，统计已按精确事件身份跨表去重；原始 XML 保留。成功配对与可读 XML 本身不证明系统没有丢记录。','',
        '消息主窗口保留 [25,70) 秒。自有探针最后在 t55.0975495 出现，窗口尾部约 14.9 秒没有自有探针；用户确认只在最后几秒未继续发送，实际到达速率/条数没有独立计量，不能把这 14.9 秒都判成停发。[25,55) 秒辅助结果另存 messages-active-sensitivity-summary.json，为事后活跃段敏感性分析，不能替换主窗。','',
        '2.2-8 没有对应探针，因此无法直接比较两版每轮计算时间或实际主表刷新次数。CPU、帧和 CA 提交比较由主审计另行记录，CA 提交不能替代分组刷新次数。','',
        '源码能解释现象的一个候选是录制前已经安全切换到兼容投影路径，但本包没有输出实际路由状态，当前不能确认为真机原因。详见 native-probe-coverage-diagnosis.md；本轮未修改生产代码或设备。','']
md_path.write_text('\n'.join(lines))
print(json.dumps({'json':str(json_path),'markdown':str(md_path),'scenes':len(records),'parser_issues':[r['parser_issues'] for r in records]},ensure_ascii=False))
