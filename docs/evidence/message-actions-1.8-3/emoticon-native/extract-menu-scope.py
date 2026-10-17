"""Read-only extraction of Objective-C metadata and bounded native disassembly."""
import mmap,struct,json
from pathlib import Path
f=open('/tmp/wechat-8.0.78-inset-analysis/WeChat','rb');b=mmap.mmap(f.fileno(),0,access=mmap.ACCESS_READ)
u32=lambda o:struct.unpack_from('<I',b,o)[0]
u64=lambda o:struct.unpack_from('<Q',b,o)[0]
i32=lambda o:struct.unpack_from('<i',b,o)[0]
segs=[];sections={};off=32
for _ in range(u32(16)):
 cmd,size=struct.unpack_from('<II',b,off)
 if cmd==0x19:
  name=b[off+8:off+24].split(b'\0')[0].decode();va,vs,fo,fs=struct.unpack_from('<QQQQ',b,off+24);segs.append((va,vs,fo,fs))
  for j in range(u32(off+64)):
   so=off+72+80*j;sn=b[so:so+16].split(b'\0')[0].decode();sections[(name,sn)]=struct.unpack_from('<QQI',b,so+32)
 if cmd==0x2c:print('encryption',struct.unpack_from('<III',b,off+8))
 off+=size
def pos(addr):
 for va,vs,fo,fs in segs:
  if va<=addr<va+fs:return fo+addr-va
 raise ValueError(hex(addr))
def string(addr):
 p=pos(addr);return b[p:b.find(b'\0',p)].decode(errors='replace')
def ptr(offset):
 v=u64(offset)
 if v>>63:raise ValueError('bind')
 return 0x100000000+(v&0xfffffffff)


import hashlib
out=Path(__file__).parent
selected={'AppNoteMessageCellView', 'AppLinkTextMessageViewModel', 'VideoMessageCellView', 'LiveLuckyBagTextMessageViewModel', 'CBTCoopV2EmoticonViewModel', 'EmoticonBoardCrossCollectionStoreSyncingCell', 'LiveLotteryTextMessageCellView', 'AppRecordMessageCellView', 'TemplateReaderMessageFolderViewModel', 'StreamMDMessageCellView', 'AppDefaultMessageCellView', 'AppNoteMessageViewModel', 'AppLinkTextMessageCellView', 'MMMenuItem', 'AppTingListMessageCellView', 'GCMessageViewModel', 'AppChatBotShareMessageCellView', 'AppLimitedModeAccessMessageViewModel', 'AppProductMessageViewModel', 'AppWeChatIntroductionMessageViewModel', 'AppStandardTextContentMessageViewModel', 'AppChatBotShareMessageViewModel', 'AppTingListMessageViewModel', 'AppStandardContentBaseMessageCellView', 'AppUrlMessageViewModel', 'CommonMessageViewModel', 'RelatedEmoticonCollectionExceptionCell', 'MessageTipsCellView', 'AppLimitedModeAccessMessageCellView', 'WCPayRecepictReaderMessageViewModel', 'MMQuickSendEmoticonCell', 'BaseMsgContentLogicController', 'AppFileMessageCellView', 'EmoticonBoardCrossCollectionStoreGridCellModel', 'WASubscriptionMessagePageSheetViewModel', 'EmoticonBoardDynamicTabBarCollectionCell', 'ServiceNotifyMessageViewModel', 'WAAppMessageCellView', 'EmoticonBoardCrossCollectionAsyncUploadCell', 'AppMMScheduleMessageCellView', 'WeClawQuickMessageCell', 'EmoticonLensCollectionCell', 'EmoticonSearchViewModel', 'WCPayThirdC2CMessageCellViewV3', 'BizAppImageContentMessageCellView', 'SearchEmoticonExceptionCell', '_TtC6WeChat31EmoticonStoreDesginerIPPackCell', 'AppScanCodeRetryMessageViewModel', 'MassSendMessageViewModel', 'AppWxGameCardMessageCellView', 'AppVideoMessageCellView', 'BizAppBaseMessageViewModel', 'EmoticonBoardCrossCollectionIPSetPageCell', 'AttributedReaderMessageCellView', 'ChatBotCardMessageCellView', 'WeiShiReaderMessageViewModel', 'GCMultiMessageViewModel', 'BrandFinderLiveMessageCellView', 'EmoticonBoardCrossCollectionQQEmojiCell', 'CommonMessageViewModelExtTarget', 'EmoticonBoardCrossCollectionRecommendCell', 'FavPhotoAccountNameCardMessageViewModel', 'MultiTalkMessageCellView', 'BaseMessageCellView', 'AppLimitedModeGuardianMessageViewModel', 'MultiColumnReaderMessageViewModel', 'AppHardWareNotifyMessageCellView', 'AppProductMessageCellView', 'WCPayThirdC2CMessageViewModelV3', 'GCEmoticonCellModel', 'GCMessageViewModelConfig', 'VoiceReaderMessageCellView', 'MultiColumnReaderMessageCellMainContentView', 'VoiceTransTextMessageCellViewV2', 'CMessageWrap', 'BizAppImageContentMessageViewModel', 'AppWCCardMessageCellView', 'AppDefaultMessageViewModel', 'BizAppImageContentMessageRecordViewModel', 'AppFileMessageViewModel', 'GCEmoticonCell', 'WASubscriptionMessageSettingsViewModel', 'AppGameShareMessageViewModel', 'EmoticonBoardCrossCollectionBasePageCell', 'AppTingChatRoomMessageCellView', 'AppStandardImageContentMessageCellView', 'EmoticonFinderDesignerUGCEmojiCell', 'GameChatMessageCellModel', 'ReaderMessageViewModel', 'SessionMenuAdjuester', 'EcsKFCardMessageViewModel', 'AppPatMessageViewModel', 'AppGameShareMessageCellView', 'EmoticonStoreDesingerIPViewCell', 'AppWCCardMessageViewModel', 'WCBizAppReaderMessageBigPicViewModel', 'AppLimitedModeGuardianMessageCellView', 'AppGameLifeUnsupportedMessageCellView', 'EcsGiftNewChatroomMessageCellView', 'NotifyLiveImageMessageCellView', 'AppGiftCardMessageViewModel', 'VoIPSignalMessageCellView', 'FinderLiveServiceNotifyMessageCellView', 'EmoticonBoardCrossCollectionEmoticonCell', 'WCPayThirdC2CMessageCellView', 'EmoticonBoardCrossCollectionStoreGridCell', 'EcsKFCardMessageCellView', 'AppHardWareRankMessageViewModel', 'ilinkMultiTalkMessageViewModel', 'AppStandardContentBaseMessageViewModel', 'MessageTipsViewModel', 'BaseChatViewModel', 'AppEmoticonMessageCellView', 'VideoMessageViewModel', 'WCPayTransferMessageCellView', 'AppGameRecordVideoMessageViewModel', 'EmoticonDesignerRichPortfolioCell', 'AppVideoMessageViewModel', 'EmoticonBoardCrossCollectionEmoticonPageCell', 'MultiTalkMessageViewModel', 'GCMultiMessageViewModelConfig', 'ilinkMultiTalkMessageCellView', 'RevokeMessageCellView', 'WCCommentBigEmoticonViewModel', 'EmoticonBoardXiaoweiRecentSearchCell', 'BaseMsgContentViewController', 'EcsKfProductCardMessageViewModel', 'ChatBotHistoryMessageCell', 'AppTingLandingMessageViewModel', 'AppRecordMessageViewModel', 'BizAppMessageCellBaseHandler', 'EcsKfProductCardMessageCellView', 'GroupNoticeMessageViewModel', 'MailMessageViewModel', 'AppPatMessageCellView', 'EmoticonBoardCrossCollectionIPPackMergeTipCell', 'GameShareNameCardMessageViewModel', 'AppUrlMessageCellView', 'ImageTextReaderMessageViewModel', 'MailMessageCellView', 'VoIPBubbleMessageCellView', 'RevokeMessageViewModel', 'TemplateReaderMessageFolderCellView', 'WAAppMessageBaseCellView', 'TextMessageCellView', 'ChatBotCardMessageViewModel', 'ImageMessageCellView', 'EcsGiftChatroomMessageCellView', 'EcsGiftChatroomMessageViewModel', 'VideoReaderMessageCellView', 'AppOpenSDKAppBrandMessageViewModel', 'ImageMessageViewModel', 'PocketMoneyMessageCellView', 'TextStateMessageBoxCollectionViewCell', 'VoiceTransTextMessageViewModelV2', 'CExtendInfoOfEmoticonMsg', 'LiveLuckyBagTextMessageCellView', 'AppGameLifeUnsupportedMessageViewModel', 'CommonMessageCellViewExtTarget', 'EmoticonBoardCrossCollectionRecommendPageCell', 'AppOpenSDKAppBrandMessageCellView', 'AppGiftCardMessageCellView', 'AppTingStandardListMessageViewModel', 'BizAppTextContentMessageCellView', 'EmoticonMessageViewModel', 'AppTrackRoomMessageCellView', 'BizAppImageContentMessageCellCoverView', 'EmoticonBoardCrossCollectionRecommendEmoticonHeaderViewModel', 'MassSendMessageCellView', 'WCFinderMessageCellViewModel', 'GameChatMessageCell', 'MMStoreEmoticonPreviewCell', 'EmoticonBoradCrossCollectionRecommendAndAIEmptyCell', 'AppUrlImageMessageCellView', 'AppTingMusicSpaceMessageCellView', 'EcsGiftMessageCellView', 'EmoticonBoardCrossCollectionQQEmojiPageCell', 'EmoticonMixedPreviewCell', 'FinderLiveMessageCellMainContentView', 'EcsGiftMessageViewModel', 'StreamMDMessageViewModel', 'TemplateNotifyMessageCellView', 'WAAppMessageBaseViewModel', 'WCPayBaseMessageViewModel', 'BizAppTextContentMessageViewModel', 'MMMenuController', 'AppTingLandingMessageCellView', 'BizAppTextContentMessageRecordViewModel', 'SystemMessageCellView', 'TemplateTwoNotifyMessageCellView', 'ImageTextReaderMessageCellView', 'AppWxGameCardMessageViewModel', 'BizAppReaderMessageBigPicViewModel', 'VoiceTransTextMessageViewModel', 'WCPayTransferMessageViewModel', 'WeiShiReaderMessageCellView', 'EmoticonBoardCrossCollectionCameraEmoticonEntryPageCell', 'AppStandardTextContentMessageCellView', 'EmoticonBoardCrossCollectionEmoticonButtonCell', 'AppUrlImageMessageViewModel', 'MMFinderLiveTableStyleBigEmoticonCommentPubbleUserCell', 'MultiImageReaderMessageCellView', 'AppStandardImageContentMessageViewModel', 'ReaderMessageTemplateMsgFolderCellView', 'MessageRingCellHandler', 'VoiceTransTextMessageCellView', 'EmoticonCellLikeButton', 'TextReaderMessageViewModel', 'AppTingMessageViewModel', 'WCPayC2CMessageViewModel', 'BizAppBaseMessageCellView', 'MMQuickSendEmoticonSearchCellView', 'AppTrackRoomMessageViewModel', 'WCPayBaseMessageCellView', 'PhotoAccountNameCardMessageViewModel', 'LocationMessageCellView', 'EmoticonBoardCrossCollectionRecommendAndAIPageCell', 'ReaderMessageFolderCellView', 'VoiceMessageViewModel', 'AttributedReaderMessageViewModel', 'WCPayThirdC2CMessageViewModel', 'BaseChatCellView', 'EmoticonCustomManageCell', 'AppStandardAccountContentMessageCellView', 'EmoticonManageCell', 'EmoticonBoardCrossCollectionCameraEmoticonEntryCell', 'AppRingBackMessageViewModel', 'PhotoAccountNameCardMessageCellView', 'EmoticonMessageCellView', 'SystemMessageViewModel', 'AppRingBackMessageCellView', 'VoiceNodataMessageViewModel', 'WAAppMessageViewModel', 'TextMessageViewModel', 'LocationMessageViewModel', 'EmoticonBoradCrossCollectionRecommendAndAICell', 'VoiceNodataMessageCellView', 'FavPhotoAccountNameCardMessageCellView', 'AppTingChatRoomMessageViewModel', 'AppUrlMessageCellViewBase', 'SearchEmoticonCollectionCell', 'TextMessageSubViewModel', 'WCPayC2CMessageCellView', 'BaseMessageViewModel', 'AppStandardAccountContentMessageViewModel', 'ShareCardMessageCellView', 'TextReaderMessageCellView', 'AppImageMessageViewModel', 'CBTCoopV2EmoticonCellView', 'EmoticonCustomManageCellLayoutAttributes', 'ReaderMessageCellView', 'BrandFinderLiveMessageViewModel', 'VideoReaderMessageViewModel', 'LiveLotteryTextMessageViewModel', 'AppGameRecordVideoMessageCellView', 'AppEmoticonMessageViewModel', 'MultiReaderMessageViewModel', 'WCPayRecepictReaderMessageCellView', 'MultiColumnReaderMessageCellView', 'PocketMoneyMessageViewModel', 'ShareCardMessageViewModel', 'VoIPBubbleMessageViewModel', 'VoiceReaderMessageViewModel', 'AppWeChatIntroductionMessageCellView', 'AppFileMessageCellContentView', 'EmoticonCustomManageMultiImagePreviewCell', 'GameMessageViewModel', 'NotifyMessageViewModel', 'AppTingMusicSpaceMessageViewModel', 'EmoticonBoardCrossCollectionIPTipPageCell', 'AppHardWareNotifyMessageViewModel', 'AppMMScheduleMessageViewModel', 'CommonMessageCellView', 'RelatedEmoticonCollectionCell', 'ReaderMessageTemplateMsgFolderViewModel', 'VoiceMessageCellView', 'MultiReaderMessageCellView', 'GameMessageCellView', 'VoIPSignalMessageViewModel', 'RelatedEmoticonActivityCell', 'EcsGiftNewChatroomMessageViewModel', 'ReaderMessageFolderViewModel', 'AppImageMessageCellView', 'AppTingStandardListMessageCellView', 'AppHardWareRankMessageCellView', 'ImageReaderMessageViewModel', 'ImageReaderMessageCellView', 'AppTingMessageCellView', 'EmoticonBoardCrossCollectionSystemEmojiPageCell', 'EmoticonWeAppCellView'}
records={};byaddr={};allmethods=[];cats=[]
imports=[];off=32
for _ in range(u32(16)):
 cmd,size=struct.unpack_from('<II',b,off)
 if cmd==0x80000034:
  fixoff,fixsize=struct.unpack_from('<II',b,off+8);version,starts,impo,symo,num,fmt,symfmt=struct.unpack_from('<7I',b,fixoff)
  assert fmt==1 and symfmt==0
  for i in range(num):
   v=u32(fixoff+impo+4*i);p=fixoff+symo+(v>>9);imports.append(b[p:b.find(b'\0',p)].decode())
 off+=size
def boundclass(off):
 v=u64(off)
 if v>>63:
  sym=imports[v&0xffffff];return sym.removeprefix('_OBJC_CLASS_$_')
 return byaddr.get(ptr(off))

def methods(addr):
 if not addr:return []
 mp=pos(addr);flags,count=struct.unpack_from('<II',b,mp);rows=[]
 for n in range(count):
  step=flags&0xffff;entry=mp+8+n*step;ev=addr+8+n*step
  if flags&0x80000000:
   seladdr=ev+i32(entry)
   if not flags&0x40000000:seladdr=ptr(pos(seladdr))
   sel=string(seladdr);imp=ev+8+i32(entry+8);types=string(ev+4+i32(entry+4))
  else:sel=string(ptr(entry));imp=ptr(entry+16);types=string(ptr(entry+8))
  rows.append({'selector':sel,'address':hex(imp),'types':types});allmethods.append(imp)
 return rows
for (seg,sec),(addr,size,offset) in sections.items():
 if sec!='__objc_classlist':continue
 for off in range(offset,offset+size,8):
  cls=ptr(off)
  try:rp=pos(ptr(pos(cls)+32)&~7);name=string(ptr(rp+24))
  except ValueError:continue
  byaddr[cls]=name
  if name not in selected:continue
  cp=pos(cls);sup=u64(cp+8)
  row={'address':hex(cls),'super_raw':hex(sup),'super_addr':hex(ptr(cp+8)) if sup and sup>>63==0 else None,'methods':methods(ptr(rp+32)) if u64(rp+32) else [],'ivars':[]}
  try:
   ip=pos(ptr(rp+48));iz,ic=struct.unpack_from('<II',b,ip)
   for k in range(ic):
    en=ip+8+k*iz;oa=ptr(en);row['ivars'].append({'name':string(ptr(en+8)),'offset':u32(pos(oa)),'type':string(ptr(en+16))})
  except ValueError:pass
  meta=ptr(pos(cls));mr=pos(ptr(pos(meta)+32)&~7)
  row['class_methods']=methods(ptr(mr+32)) if u64(mr+32) else []
  records[name]=row
for row in records.values():row['superclass']=boundclass(pos(int(row['address'],16))+8)
for (seg,sec),(addr,size,offset) in sections.items():
 if sec not in ('__objc_catlist','__objc_nlcatlist'):continue
 for off in range(offset,offset+size,8):
  try:
   ca=ptr(off);cp=pos(ca);name=string(ptr(cp));cn=boundclass(cp+8)
   if cn not in selected:continue
   cats.append({'category':name,'class':cn,'instance':methods(ptr(cp+16)) if u64(cp+16) else [],'class_methods':methods(ptr(cp+24)) if u64(cp+24) else []})
  except ValueError:continue
metadata={'binary':'/tmp/wechat-8.0.78-inset-analysis/WeChat','sha256':hashlib.sha256(b).hexdigest(),'classes':records,'categories':cats}
inventory={'binary':metadata['binary'],'sha256':metadata['sha256'],'selection':'Classes containing Cell or ViewModel, and Message or Emoticon; plus named base/menu classes. No runtime class selection is observed.','classes':{n:{'superclass':c['superclass'],'menu_methods':[m for m in c['methods'] if 'Menu' in m['selector'] or m['selector'] in ['onLongTouch','getViewController']]} for n,c in records.items()}}
out.joinpath('class-menu-inventory.json').write_text(json.dumps(inventory,indent=2))
keep={'BaseMessageCellView', 'AppEmoticonMessageCellView', 'CommonMessageCellView', 'BaseMsgContentViewController', 'BaseChatCellView', 'EmoticonMessageCellView', 'GameMessageCellView', 'BaseMessageViewModel', 'BaseChatViewModel', 'CommonMessageViewModel', 'EmoticonMessageViewModel', 'AppEmoticonMessageViewModel'}
metadata['classes']={n:c for n,c in records.items() if n in keep}
out.joinpath('metadata.json').write_text(json.dumps(metadata,indent=2))
