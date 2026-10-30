import asyncio,json,sys,time,importlib.metadata
from datetime import datetime,timezone
from pathlib import Path
from pymobiledevice3.remote.native_tunnel import NativeRemotedTunnel
from pymobiledevice3.services.dvt.instruments.device_info import DeviceInfo
from pymobiledevice3.services.dvt.instruments.dvt_provider import DvtProvider
from pymobiledevice3.services.dvt.instruments.sysmontap import Sysmontap
ROOT=Path(__file__).parent
UDID='00008120-001064E10E70201E'
async def main():
 label=sys.argv[1] if len(sys.argv)>1 else 'foreground-static';duration=float(sys.argv[2]) if len(sys.argv)>2 else 60
 identity=json.loads((ROOT/'process-identity.json').read_text());pid=identity['pid']
 with (ROOT/(label+'-lowrate.jsonl')).open('x') as out:
  def emit(kind,**values):
   out.write(json.dumps({'kind':kind,'label':label,'timestamp':datetime.now(timezone.utc).isoformat(),'host_monotonic':time.monotonic(),**values},default=str)+'\n');out.flush()
  async with asyncio.timeout(duration+50):
   async with NativeRemotedTunnel(serial=UDID) as rsd:
    if rsd.udid!=UDID:raise RuntimeError('Unexpected device')
    async with DvtProvider(rsd) as dvt:
     async with DeviceInfo(dvt) as info:
      async def scene():
       proc=next((p for p in await info.proclist() if p.get('pid')==pid and p.get('bundleIdentifier')=='com.tencent.xin'),None)
       emit('scene',process=proc)
       if not proc:raise RuntimeError('Target stopped; no automatic launch')
       return proc
      proc=await scene()
      if not proc.get('foregroundRunning'):raise RuntimeError('WeChat is not in foreground')
      emit('metadata',pid=pid,interval_ms=1000,attributes=await info.sysmon_process_attributes(),duration_requested_s=duration,energy_gauge=False,package_version='2.1-21',pymobiledevice3=importlib.metadata.version('pymobiledevice3'),scene_user_confirmed='groups_on_privacy_locked_original_styles_static_list')
      sysmon=await Sysmontap.create(dvt,interval=1000)
      async with sysmon:
       started=time.monotonic();count=0
       async for processes in sysmon.iter_processes():
        count+=1;emit('processes',initial_sample=count==1,processes=processes)
        target=next((p for p in processes if p.get('pid')==pid),None)
        if count==2 or count%10==0:
         print(json.dumps({'sample':count,'elapsed_s':round(time.monotonic()-started,2),'wechat_cpu_raw_pct':target.get('cpuUsage') if target else None}),flush=True)
        if count%15==0:await scene()
        if time.monotonic()-started>=duration:break
      await scene();emit('complete',duration_host_s=time.monotonic()-started)
      print(label+': capture complete',flush=True)
asyncio.run(main())
