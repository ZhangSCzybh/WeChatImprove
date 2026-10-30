import asyncio,json
from pathlib import Path
from datetime import datetime,timezone
from pymobiledevice3.remote.native_tunnel import NativeRemotedTunnel
from pymobiledevice3.services.dvt.instruments.device_info import DeviceInfo
from pymobiledevice3.services.dvt.instruments.dvt_provider import DvtProvider
from pymobiledevice3.services.dvt.instruments.core_profile_session_tap import CoreProfileSessionTap
ROOT=Path(__file__).parent
async def main():
 pid=json.loads((ROOT/'process-identity.json').read_text())['pid']
 async with asyncio.timeout(55):
  async with NativeRemotedTunnel(serial='00008120-001064E10E70201E') as rsd:
   for i in range(4):
    async with DvtProvider(rsd) as dvt:
     async with DeviceInfo(dvt) as info:
      proc=next((p for p in await info.proclist() if p.get('pid')==pid),None)
      if not proc or not proc.get('foregroundRunning'):raise RuntimeError('Foreground process changed; no app control attempted')
      if i==0:
       extras={str(p):await info.execname_for_pid(p) for p in [66998,67509] if await info.is_running_pid(p)}
       (ROOT/'system-process-paths.json').write_text(json.dumps(extras,indent=2))
     async with CoreProfileSessionTap(dvt,{},filters={0xFEFF0000},sample_callstacks=False) as tap:
      data=await tap.get_stackshot(timeout=10)
      tasks={k:v for k,v in data['task_snapshots'].items() if v.get('task_snapshot',{}).get('ts_pid')==pid}
      if len(tasks)!=1:raise RuntimeError('Target process exited')
      out={k:v for k,v in data.items() if k!='task_snapshots'};out['task_snapshots']=tasks
      out['host_timestamp']=datetime.now(timezone.utc).isoformat();out['scene_process']=proc
      (ROOT/f'foreground-stack-{i+1:02d}.json').write_text(json.dumps(out,default=str))
      task=next(iter(tasks.values()));main=next(v for v in task['thread_snapshots'].values() if v.get('dispatch_queue_label')=='com.apple.main-thread')
      print(json.dumps({'snapshot':i+1,'mach_absolute_time':data['mach_absolute_time'],'main_cpu':main.get('cpu_times'),'main_state':main['thread_snapshot'].get('ths_state')}),flush=True)
    if i<3:await asyncio.sleep(3)
asyncio.run(main())
