#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-payment-core.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -framework Foundation -I"$project_dir/Controllers" "$project_dir/Tests/PaymentCoreTests.m" "$project_dir/Controllers/CSPaymentCore.m" "$project_dir/Controllers/CSPaymentLedger.m" -o "$test_dir/core"
"$test_dir/core"

python3 - "$project_dir" "$test_dir" <<'PYTEST'
from pathlib import Path
import sys
root,out=map(Path,sys.argv[1:])
s=(root/'Controllers/CSPaymentAutomation.m').read_text().replace('#import <UIKit/UIKit.h>','').replace('NSUserDefaults.standardUserDefaults','paymentDefaults')
(out/'PaymentAutomationUnderTest.h').write_text(s)
hooks=(root/'Hooks/ReceiveTransferHooks.xm').read_text()
logic=hooks.split('%hook WCPayReveiverControlTransferControlLogic',1)[1].split('%end',1)[0]
logic=logic.replace('id result=%orig;','id result=[super init]; self.data=data;')
start=logic.index('- (void)startLogic');confirm=logic.index('- (void)OnWCPayTransferMoneyStatusViewControllerConfirmTransfer')
tail=logic[confirm:]
stop=tail.index('// This callback')
tail=tail[:stop].replace('%orig;','[self nativeConfirm];')+tail[stop:].replace('%orig;','originalCallbacks++;')
logic=logic[:start]+logic[start:confirm].replace('%orig;','nativeStarts++;')+tail
(out/'PaymentLogicHooksUnderTest.h').write_text(logic)
network=hooks.split('%hook WCPayNetworkHelper',1)[1].split('%end',1)[0].replace('%orig;','nativeNetworkSubmissions++;')
(out/'TransferNetworkHooksUnderTest.h').write_text(network)
response=hooks.split('%hook WCPayLogicMgr',1)[1].split('%end',1)[0].replace('%orig;','originalCallbacks++;').replace('%orig(scene,guarded,deny,start,stop);','[self nativeLicense:guarded];')
(out/'PaymentResponseHooksUnderTest.h').write_text(response)
hooks=(root/'Hooks/RedEnvelopHooks.xm').read_text()
network=hooks.split('%hook WCRedEnvelopesNetworkHelper',1)[1].split('%end',1)[0].replace('%orig;','nativeNetworkSubmissions++;')
(out/'EnvelopeNetworkHooksUnderTest.h').write_text(network)
response=hooks.split('%hook WCRedEnvelopesLogicMgr',1)[1].split('%end',1)[0].replace('%orig;','originalCallbacks++;')
(out/'EnvelopeResponseHooksUnderTest.h').write_text(response)
PYTEST
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-nullability-completeness -framework Foundation -I"$project_dir/Controllers" -I"$test_dir" "$project_dir/Tests/PaymentAutomationTests.m" "$project_dir/Controllers/CSPaymentCore.m" "$project_dir/Controllers/CSPaymentLedger.m" -o "$test_dir/automation"
"$test_dir/automation"
