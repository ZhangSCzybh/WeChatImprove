import extract as e
import re,subprocess,json
selected={
'VoiceMsgDownloader':['downloadMsg:','OnRecvData:MesLocalID:n64MesSvrID:CreateTime:VoiceTime:Offset:Len:Data:EndFlag:ErrNo:'],
'CMessageMgr':['AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:Unique:','AddLocalMsg:MsgWrap:','AddLocalMsg:MsgWrap:fixTime:NewMsgArriveNotify:','SaveMesVoice:MsgWrap:'],
'ForwardMsgUtil':['GenForwardMsgFromMsgWrap:ToContact:','SendMsgWithOriMsg:Contact:ForwardType:EditImageAttr:','ForwardMsg:ToContact:Scene:forwardType:uiIDKeyScene:editImageAttr:roomTodoFlag:inputText:searchScene:'],
'BaseMessageCellView':['canPerformAction:withSender:','canShowRevokeMsgMenuItemForMessage:','canShowRevokeMsgMenuItem','canPerformAction:withSender:withUnhandledCheck:','onRevokeMsg:','onForward:','onForwardMsg:','doForward'],
'CDownloadVoiceMgr':['MessageReturn:Event:','HandleDownloadError:'],
'BaseMsgContentLogicController':['isMsgCanRevoke:','RevokeMsg:'],
'ForwardMessageLogicController':['onForwardMessageSend','OnSharePreConfirmViewSend:','OnSharePreConfirmSheetViewSend:','OnSharePreConfirmSheetViewCancel:','OnSelectSessionCancel:','OnSelectSessions:SessionSelectController:','ForwardMsg:ToContact:','ForwardMsgList:ToContact:','ForwardMsgList:ToContact:WithRevokeBatchId:','getMessages','getToContacts','clearData','forwardMsgList:msgOriginList:toContacts:ignoreTips:showConfirmView:'],
'ForwardMessageMgr':['forwardMessage:fromViewController:toContact:forwardType:','forwardMessageList:fromViewController:toContact:forwardType:multiForwardType:','OnForwardMessageSend:','ForwardMsg:ToContact:','ForwardMessage:ToContact:','ForwardVoiceMsg:ToContact:'],
'BaseMsgContentViewController':['isMsgCanRevoke:','revokeMsgByNodeView:','batchRevokeMsgByNodeView:withReportInterval:'],
'SendMessageMgr':['AddMsgToSendTable:MsgWrap:'],
'AudioSender':['ResendVoiceMsg:MsgWrap:','prepareSend:','uploaderForMsgWrap:','addMessageToDB:'],
'MMNewUploadVoiceMgr':['ResendVoiceMsg:MsgWrap:'],
'UploadVoiceCDNMgr':['ResendVoiceMsg:MsgWrap:'],
'DownloadVoiceCDNMgr':['handleDownloadCDNSuccess:','handleDownloadCDNFail:'],
'UnusedCMessageMgr':['StartDownloadVoice:MsgWrap:','OnVoiceMsgDownloadEnd:MsgWrap:','OnMsgDownloadVoiceOK:MsgWrap:','OnMsgDownloadVoiceFail:MsgWrap:'],
}
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
