import collections,json,statistics,sys,math
from pathlib import Path
path=Path(sys.argv[1]);rows=[json.loads(x) for x in path.read_text().splitlines() if x.strip()]
meta=next(x for x in rows if x['kind']=='metadata');pid=meta['pid'];groups=collections.defaultdict(list)
for row in rows:
 if row['kind']!='processes' or row.get('initial_sample'):continue
 for p in row['processes']:groups[(p['pid'],p.get('startAbsTime'))].append({**p,'timestamp':row['timestamp'],'host_monotonic':row['host_monotonic']})
result=[]
for key,values in groups.items():
 if len(values)<2:continue
 intervals=[]
 for a,b in zip(values,values[1:]):
  dt=(b['procAge']-a['procAge'])/1e9;dc=(b['cpuTotalUser']+b['cpuTotalSystem']-a['cpuTotalUser']-a['cpuTotalSystem'])/1e9
  if dt>0 and dc>=0:intervals.append({'span_s':dt,'cpu_s':dc,'pct':100*dc/dt,'timestamp':b['timestamp'],'device_s':(b['procAge']-values[0]['procAge'])/1e9})
 if not intervals:continue
 seconds=sum(x['span_s'] for x in intervals);cpu=sum(x['cpu_s'] for x in intervals);pcts=sorted(x['pct'] for x in intervals)
 row={'pid':key[0],'startAbsTime':key[1],'name':values[0].get('name',values[0].get('comm')),'samples':len(values),'device_span_s':seconds,'cpu_s':cpu,'avg_cpu_pct_one_core':cpu/seconds*100,'median_interval_cpu_pct':statistics.median(pcts),'p90_interval_cpu_pct':pcts[math.ceil(.9*len(pcts))-1],'max_interval_cpu_pct':max(pcts),'first_timestamp':values[0]['timestamp'],'last_timestamp':values[-1]['timestamp'],'proc_age_start_s':values[0]['procAge']/1e9,'footprint_start_mib':values[0]['physFootprint']/1048576,'footprint_end_mib':values[-1]['physFootprint']/1048576}
 for k in ('diskBytesRead','diskBytesWritten','intWakeups','ctxSwitch'):
  if isinstance(values[0].get(k),int) and isinstance(values[-1].get(k),int):row[k+'_delta']=values[-1][k]-values[0][k];row[k+'_per_s']=row[k+'_delta']/seconds
 if key[0]==pid:
  row['intervals']=intervals;row['blocks']=[]
  for i in range(0,math.ceil(seconds),10):
   chunk=[x for x in intervals if i<x['device_s']<=i+10]
   if chunk:row['blocks'].append({'block_s':[i,i+10],'avg_cpu_pct':100*sum(x['cpu_s'] for x in chunk)/sum(x['span_s'] for x in chunk)})
 result.append(row)
result.sort(key=lambda x:x['cpu_s'],reverse=True)
out={'source':str(path),'metadata':meta,'complete':any(x['kind']=='complete' for x in rows),'scenes':[x for x in rows if x['kind']=='scene'],'processes':result}
path.with_suffix('.summary.json').write_text(json.dumps(out,ensure_ascii=False,indent=2))
for x in result[:10]:print(json.dumps({k:v for k,v in x.items() if k!='intervals'},ensure_ascii=False))
