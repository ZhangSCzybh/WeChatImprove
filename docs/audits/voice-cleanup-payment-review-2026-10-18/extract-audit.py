from pathlib import Path
import sys
root,out=map(Path,sys.argv[1:]);transfer=(root/'Hooks/ReceiveTransferHooks.xm').read_text();envelope=(root/'Hooks/RedEnvelopHooks.xm').read_text()
def method(source,marker):
    start=source.index(marker);brace=source.index('{',start);depth=0
    for end in range(brace,len(source)):
        if source[end]=='{': depth+=1
        elif source[end]=='}':
            depth-=1
            if not depth: return source[start:end+1]
    raise ValueError(marker)
markers=['static BOOL CSIsTransferCandidate(',
 'static void cs_handleTransferMessage(CMessageWrap *msgWrap) {',
 'static void cs_confirmTransfer(CMessageWrap *msgWrap, BOOL isGroup, NSString *fromUsr, NSString *toUsr) {']
(out/'TransferAuditBody.h').write_text('\n'.join(method(transfer,m) for m in markers))
hook=transfer.split('%hook CMessageMgr',1)[1].split('%end',1)[0].replace('%orig;','nativeMessageCalls++;')
manual=transfer.split('%hook WCPayReveiverControlTransferControlLogic',1)[1].split('%end',1)[0].replace('%orig;','nativeStartCalls++;')
(out/'TransferAuditHooks.h').write_text('@implementation TransferMessageManager\n'+hook+'\n@end\n@implementation WCPayReveiverControlTransferControlLogic\n'+manual+'\n- (void)OnWCPayTransferMoneyStatusViewControllerConfirmTransfer { manualConfirms++; }\n@end\n')
helpers=['static NSDictionary *CSParseBufferToDict(', 'static unsigned int CSGetRedEnvelopCommandId(', 'static BOOL CSRedEnvelopUserNameInList(']
methods=['- (void)cs_handleRedEnvelopReceiverQueryResponse:', '- (BOOL)cs_shouldReceiveRedEnvelop:', '- (void)cs_handleRedEnvelopOpenResponse:']
# Method declarations occur before definitions; take the implementation section.
impl=envelope.split('%hook WCRedEnvelopesLogicMgr',1)[1]
(out/'EnvelopeAuditBody.h').write_text('\n'.join(method(envelope,m) for m in helpers)+'\n@implementation WCRedEnvelopesLogicMgr\n'+
 '\n'.join(method(impl,m) for m in methods)+'\n'+'''
- (void)OpenRedEnvelopesRequest:(id)params { (void)params; envelopeOpens++; }
- (BOOL)cs_sendTextMessage:(NSString *)content toSession:(NSString *)session { return CSSendTextMessage(content,session); }
- (void)cs_sendRedEnvelopNotify:(NSString *)session amount:(NSInteger)amount totalAmount:(NSInteger)total isGroup:(BOOL)isGroup { (void)session;(void)amount;(void)total;(void)isGroup; envelopeNotifies++; }
@end
''')
