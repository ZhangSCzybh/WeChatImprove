import extract as e
import re,subprocess,json
selected={'WCPayControlLogic':['startLogic','stopLogic'], 'WCBaseControlMgr':['startLogic:'], 'WCBizControlLogic':['startLogic'],'WCPayReveiverControlTransferControlLogic': ['initWithData:', 'stopLogic', 'startLogic', 'OnConfirmTransferMoney:Error:', 'onWCPayUnionTransferConfirmCgiResponseOK:', 'OnWCPayTransferMoneyStatusViewControllerConfirmTransfer', 'OnWCPayTransferMoneyStatusViewControllerConfirmTransfer:againCtx:'], 'WCPayLogicMgr': ['GetWCPayBusinessRequest:WXInnerUseDic:CMDID:OutputType:retryCount:routeInfo:', 'OnWCToTenpayCommonResponse:Request:', 'ConfirmTransferMoney:', 'insideCallBackOnConfirmTransferMoneyResponse:OnRequest:'], 'WCPayControlMgr': ['startReceiverConfirmTransferMoneyLogic:Data:', 'startLogic:', 'stopLogic:'], 'WCPayUnionTransferConfirmCgi': ['startWithRequest:', 'didGetResponse:'], 'WCRedEnvelopesLogicMgr': ['ReceiverQueryRedEnvelopesRequest:', 'OpenRedEnvelopesRequest:', 'OnWCToHongbaoCommonResponse:Request:','GetHongbaoBusinessRequest:CMDID:OutputType:']}
alladdresses=sorted(set(int(row['address'],16) for rows in e.results.values() for row in rows))
for name,sels in selected.items():
 rows=e.results.get(name,[])
 for row in rows:
  if row['selector'] not in sels:continue
  start=int(row['address'],16);end=min((v for v in alladdresses if v>start),default=start+0x4000);end=min(end,start+0x9000)
  result=subprocess.check_output(['xcrun','llvm-objdump','-d','--start-address='+hex(start),'--stop-address='+hex(end),'/tmp/wechat-8.0.78-inset-analysis/WeChat'],text=True)
  regs={};lines=[]
  for line in result.splitlines():
   m=re.search(r'adrp\s+(x\d+), (0x[0-9a-f]+)',line)
   if m:regs[m[1]]=int(m[2],16)
   m=re.search(r'add\s+x\d+, (x\d+), #(0x[0-9a-f]+)',line)
   if m and m[1] in regs:
    try:
     a=regs[m[1]]+int(m[2],16); s=e.string(e.ptr(e.pos(a)+16))
     if s and len(s)<220 and all(c.isprintable() and c!='�' for c in s):line+=' ; CFSTR '+s
    except (ValueError,e.struct.error):pass
   m=re.search(r'ldr\s+x\d+, \[(x\d+), #(0x[0-9a-f]+)\]',line)
   if m and m[1] in regs:
    try:
     s=e.string(e.ptr(e.pos(regs[m[1]]+int(m[2],16))))
     if s and len(s)<180 and all(c.isprintable() for c in s):line+=' ; '+s
    except (ValueError,e.struct.error):pass
   lines.append(line)
  file=e.out/(name+'--'+row['selector'].replace(':','_')+'.asm')
  file.write_text('\n'.join(lines))
  print(file.name,row['address'],hex(end),len(lines))
