import asyncio, json, importlib.metadata
from pathlib import Path
from datetime import datetime, timezone
from pymobiledevice3.remote.native_tunnel import NativeRemotedTunnel
from pymobiledevice3.services.dvt.instruments.device_info import DeviceInfo
from pymobiledevice3.services.dvt.instruments.dvt_provider import DvtProvider
from pymobiledevice3.services.dvt.instruments.core_profile_session_tap import CoreProfileSessionTap
ROOT=Path(__file__).parent
UDID='00008120-001064E10E70201E'
async def main():
 async with asyncio.timeout(55):
  async with NativeRemotedTunnel(serial=UDID) as rsd:
   if rsd.udid!=UDID: raise RuntimeError('Unexpected device')
   async with DvtProvider(rsd) as dvt:
    async with DeviceInfo(dvt) as info:
     processes=await info.proclist()
     targets=[p for p in processes if p.get('bundleIdentifier')=='com.tencent.xin' and p.get('name')=='WeChat']
     if len(targets)!=1: raise RuntimeError('Expected one running WeChat: '+str(targets))
     process=targets[0];pid=int(process['pid'])
     executable=await info.execname_for_pid(pid)
     if '/WeChat.app/WeChat' not in executable: raise RuntimeError('Unexpected target executable')
     meta={'timestamp':datetime.now(timezone.utc).isoformat(),'pymobiledevice3':importlib.metadata.version('pymobiledevice3'),'process':process,'executable':executable,'pid':pid}
     (ROOT/'process-identity.json').write_text(json.dumps(meta,default=str,indent=2))
     print(json.dumps(meta,default=str),flush=True)
    async with CoreProfileSessionTap(dvt,{},filters={0xFEFF0000},sample_callstacks=False) as tap:
     data=await tap.get_stackshot(timeout=15)
     tasks={k:v for k,v in data['task_snapshots'].items() if v.get('task_snapshot',{}).get('ts_pid')==pid}
     if len(tasks)!=1: raise RuntimeError('WeChat exited before stackshot')
     out={k:v for k,v in data.items() if k!='task_snapshots'};out['task_snapshots']=tasks
     out['host_timestamp']=datetime.now(timezone.utc).isoformat()
     (ROOT/'preflight-stack.json').write_text(json.dumps(out,default=str))
     task=next(iter(tasks.values()))
     print('TASK',json.dumps(task.get('task_snapshot',{})),flush=True)
     print('IMAGES',json.dumps(task.get('dyld_load_info',[]),default=str),flush=True)
asyncio.run(main())
