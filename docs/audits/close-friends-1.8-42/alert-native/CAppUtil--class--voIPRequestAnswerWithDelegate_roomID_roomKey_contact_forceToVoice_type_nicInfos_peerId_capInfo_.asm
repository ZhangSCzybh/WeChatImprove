
/tmp/wechat-8.0.78-inset-analysis/WeChat:	file format mach-o arm64

Disassembly of section __TEXT,__text:

0000000100008000 <__text>:
100138a24: d107c3ff    	sub	sp, sp, #0x1f0
100138a28: a9196ffc    	stp	x28, x27, [sp, #0x190]
100138a2c: a91a67fa    	stp	x26, x25, [sp, #0x1a0]
100138a30: a91b5ff8    	stp	x24, x23, [sp, #0x1b0]
100138a34: a91c57f6    	stp	x22, x21, [sp, #0x1c0]
100138a38: a91d4ff4    	stp	x20, x19, [sp, #0x1d0]
100138a3c: a91e7bfd    	stp	x29, x30, [sp, #0x1e0]
100138a40: 910783fd    	add	x29, sp, #0x1e0
100138a44: aa0703f8    	mov	x24, x7
100138a48: aa0603f7    	mov	x23, x6
100138a4c: aa0503f4    	mov	x20, x5
100138a50: aa0403fb    	mov	x27, x4
100138a54: aa0303f9    	mov	x25, x3
100138a58: aa0203fc    	mov	x28, x2
100138a5c: a941ebb6    	ldp	x22, x26, [x29, #0x18]
100138a60: f9400bb5    	ldr	x21, [x29, #0x10]
100138a64: f00ea5a8    	adrp	x8, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
100138a68: f9405908    	ldr	x8, [x8, #0xb0]
100138a6c: f9400108    	ldr	x8, [x8]
100138a70: f81a03a8    	stur	x8, [x29, #-0x60]
100138a74: b01057a8    	adrp	x8, 0x120c2d000 <dyld_stub_binder+0x120c2d000>
100138a78: 52800029    	mov	w9, #0x1                ; =1
100138a7c: 391b6109    	strb	w9, [x8, #0x6d8]
100138a80: aa0203e0    	mov	x0, x2
100138a84: 95ebb9ad    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100138a88: aa1403e0    	mov	x0, x20
100138a8c: 95ebb9ab    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100138a90: aa1503e0    	mov	x0, x21
100138a94: 95ebb9a9    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100138a98: aa1603e0    	mov	x0, x22
100138a9c: 95ebb9a7    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100138aa0: aa1a03e0    	mov	x0, x26
100138aa4: 95ebb9a5    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100138aa8: b4002099    	cbz	x25, 0x100138eb8 <__text+0x130eb8>
100138aac: b4002d1b    	cbz	x27, 0x10013904c <__text+0x13104c>
100138ab0: f90057f9    	str	x25, [sp, #0xa8]
100138ab4: b4003874    	cbz	x20, 0x1001391c0 <__text+0x1311c0>
100138ab8: b9008bf7    	str	w23, [sp, #0x88]
100138abc: a909ebf4    	stp	x20, x26, [sp, #0x98]
100138ac0: a90b5bfc    	stp	x28, x22, [sp, #0xb0]
100138ac4: 901001e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100138ac8: f947f100    	ldr	x0, [x8, #0xfe0] ; class=VoipAnswerReq
100138acc: 95ebb9a3    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
100138ad0: aa0003f9    	mov	x25, x0
100138ad4: f01001c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100138ad8: f9471100    	ldr	x0, [x8, #0xe20] ; class=SettingUtil
100138adc: b00fe828    	adrp	x8, 0x11fe3d000 <dyld_stub_binder+0x11fe3d000>
100138ae0: f9459901    	ldr	x1, [x8, #0xb30] ; selector=getCurUsrName
100138ae4: 95ebb996    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138ae8: aa1d03fd    	mov	x29, x29
100138aec: 95ebb997    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138af0: aa0003f3    	mov	x19, x0
100138af4: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138af8: f946a101    	ldr	x1, [x8, #0xd40] ; selector=setFromUsername:
100138afc: aa1903e0    	mov	x0, x25
100138b00: aa1303e2    	mov	x2, x19
100138b04: 95ebb98e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138b08: aa1303e0    	mov	x0, x19
100138b0c: 95ebb992    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100138b10: 901001e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100138b14: f947f500    	ldr	x0, [x8, #0xfe8] ; class=VOIPHelper
100138b18: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138b1c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=checkIfUInt64RoomIDOutOfInt32:
100138b20: f94057f3    	ldr	x19, [sp, #0xa8]
100138b24: aa1303e2    	mov	x2, x19
100138b28: 95ebb985    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138b2c: 900fe828    	adrp	x8, 0x11fe3c000 <dyld_stub_binder+0x11fe3c000>
100138b30: f945dd01    	ldr	x1, [x8, #0xbb8] ; selector=setRoomId:
100138b34: aa1903e0    	mov	x0, x25
100138b38: aa1303e2    	mov	x2, x19
100138b3c: 95ebb980    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138b40: d00fe808    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100138b44: f9414901    	ldr	x1, [x8, #0x290] ; selector=setRoomKey:
100138b48: aa1903e0    	mov	x0, x25
100138b4c: f90037fb    	str	x27, [sp, #0x68]
100138b50: aa1b03e2    	mov	x2, x27
100138b54: 95ebb97a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138b58: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138b5c: f946a901    	ldr	x1, [x8, #0xd50] ; selector=setAnswer:
100138b60: aa1903e0    	mov	x0, x25
100138b64: b90093f8    	str	w24, [sp, #0x90]
100138b68: aa1803e2    	mov	x2, x24
100138b6c: 95ebb974    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138b70: f01001d7    	adrp	x23, 0x120173000 <dyld_stub_binder+0x120173000>
100138b74: f945eae0    	ldr	x0, [x23, #0xbd0] ; class=MMContext
100138b78: 900ffe48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100138b7c: f944e914    	ldr	x20, [x8, #0x9d0] ; selector=currentContext
100138b80: aa1403e1    	mov	x1, x20
100138b84: 95ebb96e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138b88: aa1d03fd    	mov	x29, x29
100138b8c: 95ebb96f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138b90: aa0003f3    	mov	x19, x0
100138b94: 901001e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100138b98: f9420900    	ldr	x0, [x8, #0x410] ; class=CNetworkStatus
100138b9c: f00ffe28    	adrp	x8, 0x1200ff000 <dyld_stub_binder+0x1200ff000>
100138ba0: f947ad18    	ldr	x24, [x8, #0xf58] ; selector=class
100138ba4: aa1803e1    	mov	x1, x24
100138ba8: 95ebb965    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138bac: aa0003e2    	mov	x2, x0
100138bb0: b00fe808    	adrp	x8, 0x11fe39000 <dyld_stub_binder+0x11fe39000>
100138bb4: f946411a    	ldr	x26, [x8, #0xc80] ; selector=getService:
100138bb8: aa1303e0    	mov	x0, x19
100138bbc: aa1a03e1    	mov	x1, x26
100138bc0: 95ebb95f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138bc4: aa1d03fd    	mov	x29, x29
100138bc8: 95ebb960    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138bcc: aa0003f6    	mov	x22, x0
100138bd0: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138bd4: f946ad01    	ldr	x1, [x8, #0xd58] ; selector=voIPNetState
100138bd8: 95ebb959    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138bdc: aa0003e2    	mov	x2, x0
100138be0: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138be4: f946b101    	ldr	x1, [x8, #0xd60] ; selector=setNetType:
100138be8: aa1903e0    	mov	x0, x25
100138bec: 95ebb954    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138bf0: aa1603e0    	mov	x0, x22
100138bf4: 95ebb958    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100138bf8: aa1303e0    	mov	x0, x19
100138bfc: 95ebb956    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100138c00: f01001c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100138c04: f9467900    	ldr	x0, [x8, #0xcf0] ; class=CUtility
100138c08: 900fe848    	adrp	x8, 0x11fe40000 <dyld_stub_binder+0x11fe40000>
100138c0c: f942c501    	ldr	x1, [x8, #0x588] ; selector=genCurrentTimeInMsFrom1970
100138c10: 95ebb94b    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138c14: aa0003e2    	mov	x2, x0
100138c18: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138c1c: f946b501    	ldr	x1, [x8, #0xd68] ; selector=setTimestamp64:
100138c20: aa1903e0    	mov	x0, x25
100138c24: 95ebb946    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138c28: f945eae0    	ldr	x0, [x23, #0xbd0] ; class=MMContext
100138c2c: f90043f4    	str	x20, [sp, #0x80]
100138c30: aa1403e1    	mov	x1, x20
100138c34: 95ebb942    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138c38: aa1d03fd    	mov	x29, x29
100138c3c: 95ebb943    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138c40: aa0003f3    	mov	x19, x0
100138c44: 901001e8    	adrp	x8, 0x120174000 <dyld_stub_binder+0x120174000>
100138c48: f947f900    	ldr	x0, [x8, #0xff0] ; class=CheckMobileSIMType
100138c4c: f9003ff8    	str	x24, [sp, #0x78]
100138c50: aa1803e1    	mov	x1, x24
100138c54: 95ebb93a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138c58: aa0003e2    	mov	x2, x0
100138c5c: aa1303e0    	mov	x0, x19
100138c60: f9003bfa    	str	x26, [sp, #0x70]
100138c64: aa1a03e1    	mov	x1, x26
100138c68: 95ebb935    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138c6c: aa1d03fd    	mov	x29, x29
100138c70: 95ebb936    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138c74: aa0003f6    	mov	x22, x0
100138c78: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138c7c: f946b901    	ldr	x1, [x8, #0xd70] ; selector=voIPMobileSIMType
100138c80: 95ebb92f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138c84: aa0003f8    	mov	x24, x0
100138c88: aa1603e0    	mov	x0, x22
100138c8c: 95ebb932    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100138c90: aa1303e0    	mov	x0, x19
100138c94: 95ebb930    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100138c98: 52800040    	mov	w0, #0x2                ; =2
100138c9c: 95eb5169    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
100138ca0: 34000560    	cbz	w0, 0x100138d4c <__text+0x130d4c>
100138ca4: 95ebb93f    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
100138ca8: aa0003fa    	mov	x26, x0
100138cac: f01001d4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
100138cb0: f9454680    	ldr	x0, [x20, #0xa88]
100138cb4: 95ebb92b    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100138cb8: aa0003f3    	mov	x19, x0
100138cbc: f9454680    	ldr	x0, [x20, #0xa88]
100138cc0: d00ffe88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100138cc4: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
100138cc8: a9007ff8    	stp	x24, xzr, [sp]
100138ccc: d00f1b82    	adrp	x2, 0x11e4aa000 <dyld_stub_binder+0x11e4aa000>
100138cd0: 91182042    	add	x2, x2, #0x608 ; cfstring='sendAnswerRequest, isWKSimCard = %u'
100138cd4: 95ebb91a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138cd8: aa1d03fd    	mov	x29, x29
100138cdc: 95ebb91b    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138ce0: aa0003f6    	mov	x22, x0
100138ce4: d00ffe48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
100138ce8: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
100138cec: f00f1b08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100138cf0: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
100138cf4: a90003e8    	stp	x8, x0, [sp]
100138cf8: f00f1b02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100138cfc: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
100138d00: aa1303e0    	mov	x0, x19
100138d04: 95ebb90e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138d08: aa0003f3    	mov	x19, x0
100138d0c: aa1603e0    	mov	x0, x22
100138d10: 95ebb911    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100138d14: b00d86e1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
100138d18: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
100138d1c: b00d8782    	adrp	x2, 0x11b229000 <dyld_stub_binder+0x11b229000>
100138d20: 91267842    	add	x2, x2, #0x99e ; cstring='AppUtil+VoIPSignal.mm'
100138d24: b00d8784    	adrp	x4, 0x11b229000 <dyld_stub_binder+0x11b229000>
100138d28: 9126d084    	add	x4, x4, #0x9b4 ; cstring='+[CAppUtil(VoIPSignal) voIPRequestAnswerWithDelegate:roomID:roomKey:contact:forceToVoice:type:nicInfos:peerId:capInfo:]'
100138d2c: 52800040    	mov	w0, #0x2                ; =2
100138d30: 52800963    	mov	w3, #0x4b               ; =75
100138d34: aa1303e5    	mov	x5, x19
100138d38: 95eb5143    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
100138d3c: aa1303e0    	mov	x0, x19
100138d40: 95ebb905    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100138d44: aa1a03e0    	mov	x0, x26
100138d48: 95ebb919    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
100138d4c: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138d50: f946bd01    	ldr	x1, [x8, #0xd78] ; selector=setIsWksimCard:
100138d54: aa1903e0    	mov	x0, x25
100138d58: aa1803e2    	mov	x2, x24
100138d5c: 95ebb8f8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138d60: 95eb4f45    	bl	0x107c0ca74 <_Flutter_MMFoundation_BindContext+0x40e8658>
100138d64: aa0003e2    	mov	x2, x0
100138d68: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138d6c: f946c101    	ldr	x1, [x8, #0xd80] ; selector=setIpStack:
100138d70: aa1903e0    	mov	x0, x25
100138d74: 95ebb8f2    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138d78: 900ffe48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100138d7c: f9435101    	ldr	x1, [x8, #0x6a0] ; selector=count
100138d80: aa1503e0    	mov	x0, x21
100138d84: 95ebb8ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138d88: aa0003e2    	mov	x2, x0
100138d8c: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138d90: f946c501    	ldr	x1, [x8, #0xd88] ; selector=setNicCnt:
100138d94: aa1903e0    	mov	x0, x25
100138d98: 95ebb8e9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138d9c: 4f00e400    	movi.16b	v0, #0x0
100138da0: ad0703e0    	stp	q0, q0, [sp, #0xe0]
100138da4: ad0603e0    	stp	q0, q0, [sp, #0xc0]
100138da8: aa1503e0    	mov	x0, x21
100138dac: 95ebb8e3    	bl	0x107c27138 <_Flutter_MMFoundation_BindContext+0x4102d1c>
100138db0: 900ffe48    	adrp	x8, 0x120100000 <dyld_stub_binder+0x120100000>
100138db4: f9435518    	ldr	x24, [x8, #0x6a8] ; selector=countByEnumeratingWithState:objects:count:
100138db8: 910303e2    	add	x2, sp, #0xc0
100138dbc: d10383a3    	sub	x3, x29, #0xe0
100138dc0: aa1803e1    	mov	x1, x24
100138dc4: 52800204    	mov	w4, #0x10               ; =16
100138dc8: 95ebb8dd    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138dcc: b40004e0    	cbz	x0, 0x100138e68 <__text+0x130e68>
100138dd0: aa0003fb    	mov	x27, x0
100138dd4: f9406be8    	ldr	x8, [sp, #0xd0]
100138dd8: f9400114    	ldr	x20, [x8] ; selector=clearMarkersWithGridModel:
100138ddc: d280001c    	mov	x28, #0x0               ; =0
100138de0: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138de4: f946c913    	ldr	x19, [x8, #0xd90] ; selector=nicSet
100138de8: d00fe808    	adrp	x8, 0x11fe3a000 <dyld_stub_binder+0x11fe3a000>
100138dec: f943c51a    	ldr	x26, [x8, #0x788] ; selector=safeAddObject:
100138df0: f9406be8    	ldr	x8, [sp, #0xd0]
100138df4: f9400108    	ldr	x8, [x8] ; selector=initWithSsid:mac:cache:scene:delegate:wifiProtoType:
100138df8: eb14011f    	cmp	x8, x20
100138dfc: 54000060    	b.eq	0x100138e08 <__text+0x130e08>
100138e00: aa1503e0    	mov	x0, x21
100138e04: 95ebb8d3    	bl	0x107c27150 <_Flutter_MMFoundation_BindContext+0x4102d34>
100138e08: f94067e8    	ldr	x8, [sp, #0xc8]
100138e0c: f87c7916    	ldr	x22, [x8, x28, lsl #3]
100138e10: aa1903e0    	mov	x0, x25
100138e14: aa1303e1    	mov	x1, x19
100138e18: 95ebb8c9    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138e1c: aa1d03fd    	mov	x29, x29
100138e20: 95ebb8ca    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138e24: aa0003f7    	mov	x23, x0
100138e28: aa1a03e1    	mov	x1, x26
100138e2c: aa1603e2    	mov	x2, x22
100138e30: 95ebb8c3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138e34: aa1703e0    	mov	x0, x23
100138e38: 95ebb8c7    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100138e3c: 9100079c    	add	x28, x28, #0x1
100138e40: eb1c037f    	cmp	x27, x28
100138e44: 54fffd61    	b.ne	0x100138df0 <__text+0x130df0>
100138e48: 910303e2    	add	x2, sp, #0xc0
100138e4c: d10383a3    	sub	x3, x29, #0xe0
100138e50: aa1503e0    	mov	x0, x21
100138e54: aa1803e1    	mov	x1, x24
100138e58: 52800204    	mov	w4, #0x10               ; =16
100138e5c: 95ebb8b8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138e60: aa0003fb    	mov	x27, x0
100138e64: b5fffbc0    	cbnz	x0, 0x100138ddc <__text+0x130ddc>
100138e68: aa1503e0    	mov	x0, x21
100138e6c: 95ebb8ba    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100138e70: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138e74: f946cd01    	ldr	x1, [x8, #0xd98] ; selector=setOnlyAudio:
100138e78: aa1903e0    	mov	x0, x25
100138e7c: b9408bf7    	ldr	w23, [sp, #0x88]
100138e80: aa1703e2    	mov	x2, x23
100138e84: 95ebb8ae    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138e88: b94093e8    	ldr	w8, [sp, #0x90]
100138e8c: 7100051f    	cmp	w8, #0x1
100138e90: f9405bfc    	ldr	x28, [sp, #0xb0]
100138e94: a949ebf4    	ldp	x20, x26, [sp, #0x98]
100138e98: 54003e61    	b.ne	0x100139664 <__text+0x131664>
100138e9c: f9405fe2    	ldr	x2, [sp, #0xb8]
100138ea0: b4002582    	cbz	x2, 0x100139350 <__text+0x131350>
100138ea4: b00fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
100138ea8: f946d101    	ldr	x1, [x8, #0xda0] ; selector=setPeerId:
100138eac: aa1903e0    	mov	x0, x25
100138eb0: 95ebb8a3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138eb4: 14000186    	b	0x1001394cc <__text+0x1314cc>
100138eb8: 52800080    	mov	w0, #0x4                ; =4
100138ebc: 95eb50e1    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
100138ec0: 34002440    	cbz	w0, 0x100139348 <__text+0x131348>
100138ec4: 95ebb8b7    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
100138ec8: f90057e0    	str	x0, [sp, #0xa8]
100138ecc: f01001d3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
100138ed0: f9454660    	ldr	x0, [x19, #0xa88]
100138ed4: 95ebb8a3    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100138ed8: aa1a03f9    	mov	x25, x26
100138edc: f9454668    	ldr	x8, [x19, #0xa88]
100138ee0: a90983e8    	stp	x8, x0, [sp, #0x98]
100138ee4: f9005ff6    	str	x22, [sp, #0xb8]
100138ee8: aa1403f6    	mov	x22, x20
100138eec: f01001d4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
100138ef0: f9458a80    	ldr	x0, [x20, #0xb10]
100138ef4: 900ffe68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100138ef8: f947bd01    	ldr	x1, [x8, #0xf78] ; selector=numberWithUnsignedInt:
100138efc: aa1803e2    	mov	x2, x24
100138f00: 95ebb88f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138f04: aa1d03fd    	mov	x29, x29
100138f08: 95ebb890    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138f0c: aa0003fa    	mov	x26, x0
100138f10: f9458a80    	ldr	x0, [x20, #0xb10]
100138f14: 900ffe68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100138f18: f947c901    	ldr	x1, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
100138f1c: d2800002    	mov	x2, #0x0                ; =0
100138f20: 95ebb887    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138f24: aa1d03fd    	mov	x29, x29
100138f28: 95ebb888    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138f2c: aa1c03f8    	mov	x24, x28
100138f30: aa0003fc    	mov	x28, x0
100138f34: f9458a80    	ldr	x0, [x20, #0xb10]
100138f38: 900ffe68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100138f3c: f947b101    	ldr	x1, [x8, #0xf60] ; selector=numberWithLongLong:
100138f40: aa1b03e2    	mov	x2, x27
100138f44: 95ebb87e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138f48: aa1d03fd    	mov	x29, x29
100138f4c: 95ebb87f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138f50: aa0003f3    	mov	x19, x0
100138f54: f9458a80    	ldr	x0, [x20, #0xb10]
100138f58: aa1603f4    	mov	x20, x22
100138f5c: 900ffe68    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100138f60: f9479501    	ldr	x1, [x8, #0xf28] ; selector=numberWithBool:
100138f64: aa1703e2    	mov	x2, x23
100138f68: 95ebb875    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138f6c: aa1d03fd    	mov	x29, x29
100138f70: 95ebb876    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138f74: aa0003f6    	mov	x22, x0
100138f78: d00ffe88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100138f7c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
100138f80: a9047ff8    	stp	x24, xzr, [sp, #0x40]
100138f84: a90303f9    	stp	x25, x0, [sp, #0x30]
100138f88: f9405fe8    	ldr	x8, [sp, #0xb8]
100138f8c: a90223f5    	stp	x21, x8, [sp, #0x20]
100138f90: d00f1b82    	adrp	x2, 0x11e4aa000 <dyld_stub_binder+0x11e4aa000>
100138f94: 9117a042    	add	x2, x2, #0x5e8 ; cfstring='Params Error! (type: %@, roomID: %@, roomKey: %@, contact: %@, nicInfos: %@, peerId: %@, capInfo: %@, forceToVoice: %@, delegate: %@)'
100138f98: a90153f3    	stp	x19, x20, [sp, #0x10]
100138f9c: a90073fa    	stp	x26, x28, [sp]
100138fa0: aa1a03f7    	mov	x23, x26
100138fa4: f9404fe0    	ldr	x0, [sp, #0x98]
100138fa8: 95ebb865    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138fac: aa1d03fd    	mov	x29, x29
100138fb0: 95ebb866    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100138fb4: aa0003fa    	mov	x26, x0
100138fb8: d00ffe48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
100138fbc: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
100138fc0: f00f1b08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100138fc4: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
100138fc8: a90003e8    	stp	x8, x0, [sp]
100138fcc: f00f1b02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100138fd0: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
100138fd4: f94053e0    	ldr	x0, [sp, #0xa0]
100138fd8: 95ebb859    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100138fdc: aa0003fb    	mov	x27, x0
100138fe0: aa1a03e0    	mov	x0, x26
100138fe4: aa1903fa    	mov	x26, x25
100138fe8: 95ebb85b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100138fec: aa1603e0    	mov	x0, x22
100138ff0: f9405ff6    	ldr	x22, [sp, #0xb8]
100138ff4: 95ebb858    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100138ff8: aa1303e0    	mov	x0, x19
100138ffc: 95ebb856    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139000: aa1c03e0    	mov	x0, x28
100139004: aa1803fc    	mov	x28, x24
100139008: 95ebb853    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10013900c: aa1703e0    	mov	x0, x23
100139010: 95ebb851    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139014: 900d86e1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
100139018: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
10013901c: 900d8782    	adrp	x2, 0x11b229000 <dyld_stub_binder+0x11b229000>
100139020: 91267842    	add	x2, x2, #0x99e ; cstring='AppUtil+VoIPSignal.mm'
100139024: 900d8784    	adrp	x4, 0x11b229000 <dyld_stub_binder+0x11b229000>
100139028: 9126d084    	add	x4, x4, #0x9b4 ; cstring='+[CAppUtil(VoIPSignal) voIPRequestAnswerWithDelegate:roomID:roomKey:contact:forceToVoice:type:nicInfos:peerId:capInfo:]'
10013902c: 52800080    	mov	w0, #0x4                ; =4
100139030: 52800623    	mov	w3, #0x31               ; =49
100139034: aa1b03e5    	mov	x5, x27
100139038: 95eb5083    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10013903c: aa1b03e0    	mov	x0, x27
100139040: 95ebb845    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139044: f94057e0    	ldr	x0, [sp, #0xa8]
100139048: 140000bf    	b	0x100139344 <__text+0x131344>
10013904c: 52800080    	mov	w0, #0x4                ; =4
100139050: 95eb507c    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
100139054: 340017a0    	cbz	w0, 0x100139348 <__text+0x131348>
100139058: 95ebb852    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
10013905c: f9005fe0    	str	x0, [sp, #0xb8]
100139060: d01001d3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
100139064: f9454660    	ldr	x0, [x19, #0xa88]
100139068: 95ebb83e    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
10013906c: f9454668    	ldr	x8, [x19, #0xa88]
100139070: a90a03e8    	stp	x8, x0, [sp, #0xa0]
100139074: d01001d3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
100139078: f9458a60    	ldr	x0, [x19, #0xb10]
10013907c: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100139080: f947bd01    	ldr	x1, [x8, #0xf78] ; selector=numberWithUnsignedInt:
100139084: aa1803e2    	mov	x2, x24
100139088: 95ebb82d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10013908c: aa1d03fd    	mov	x29, x29
100139090: 95ebb82e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139094: aa0003f8    	mov	x24, x0
100139098: f9004fe0    	str	x0, [sp, #0x98]
10013909c: f9458a60    	ldr	x0, [x19, #0xb10]
1001390a0: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1001390a4: f947c901    	ldr	x1, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
1001390a8: aa1903e2    	mov	x2, x25
1001390ac: 95ebb824    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001390b0: aa1d03fd    	mov	x29, x29
1001390b4: 95ebb825    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001390b8: aa0003fb    	mov	x27, x0
1001390bc: f9458a60    	ldr	x0, [x19, #0xb10]
1001390c0: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1001390c4: f947b101    	ldr	x1, [x8, #0xf60] ; selector=numberWithLongLong:
1001390c8: d2800002    	mov	x2, #0x0                ; =0
1001390cc: 95ebb81c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001390d0: aa1d03fd    	mov	x29, x29
1001390d4: 95ebb81d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001390d8: aa1c03f9    	mov	x25, x28
1001390dc: aa0003fc    	mov	x28, x0
1001390e0: f9458a60    	ldr	x0, [x19, #0xb10]
1001390e4: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1001390e8: f9479501    	ldr	x1, [x8, #0xf28] ; selector=numberWithBool:
1001390ec: aa1703e2    	mov	x2, x23
1001390f0: 95ebb813    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001390f4: aa1d03fd    	mov	x29, x29
1001390f8: 95ebb814    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001390fc: aa0003f3    	mov	x19, x0
100139100: b00ffe88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100139104: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
100139108: a9047ff9    	stp	x25, xzr, [sp, #0x40]
10013910c: a90303fa    	stp	x26, x0, [sp, #0x30]
100139110: a9025bf5    	stp	x21, x22, [sp, #0x20]
100139114: b00f1b82    	adrp	x2, 0x11e4aa000 <dyld_stub_binder+0x11e4aa000>
100139118: 9117a042    	add	x2, x2, #0x5e8 ; cfstring='Params Error! (type: %@, roomID: %@, roomKey: %@, contact: %@, nicInfos: %@, peerId: %@, capInfo: %@, forceToVoice: %@, delegate: %@)'
10013911c: a90153fc    	stp	x28, x20, [sp, #0x10]
100139120: a9006ff8    	stp	x24, x27, [sp]
100139124: f94053e0    	ldr	x0, [sp, #0xa0]
100139128: 95ebb805    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10013912c: aa1d03fd    	mov	x29, x29
100139130: 95ebb806    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139134: aa1a03f7    	mov	x23, x26
100139138: aa1603fa    	mov	x26, x22
10013913c: aa0003f6    	mov	x22, x0
100139140: b00ffe48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
100139144: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
100139148: d00f1b08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
10013914c: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
100139150: a90003e8    	stp	x8, x0, [sp]
100139154: d00f1b02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100139158: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
10013915c: f94057e0    	ldr	x0, [sp, #0xa8]
100139160: 95ebb7f7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139164: aa0003f8    	mov	x24, x0
100139168: aa1603e0    	mov	x0, x22
10013916c: aa1a03f6    	mov	x22, x26
100139170: aa1703fa    	mov	x26, x23
100139174: 95ebb7f8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139178: aa1303e0    	mov	x0, x19
10013917c: 95ebb7f6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139180: aa1c03e0    	mov	x0, x28
100139184: aa1903fc    	mov	x28, x25
100139188: 95ebb7f3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10013918c: aa1b03e0    	mov	x0, x27
100139190: 95ebb7f1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139194: f9404fe0    	ldr	x0, [sp, #0x98]
100139198: 95ebb7ef    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10013919c: 900d86e1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
1001391a0: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
1001391a4: 900d8782    	adrp	x2, 0x11b229000 <dyld_stub_binder+0x11b229000>
1001391a8: 91267842    	add	x2, x2, #0x99e ; cstring='AppUtil+VoIPSignal.mm'
1001391ac: 900d8784    	adrp	x4, 0x11b229000 <dyld_stub_binder+0x11b229000>
1001391b0: 9126d084    	add	x4, x4, #0x9b4 ; cstring='+[CAppUtil(VoIPSignal) voIPRequestAnswerWithDelegate:roomID:roomKey:contact:forceToVoice:type:nicInfos:peerId:capInfo:]'
1001391b4: 52800080    	mov	w0, #0x4                ; =4
1001391b8: 528006c3    	mov	w3, #0x36               ; =54
1001391bc: 1400005d    	b	0x100139330 <__text+0x131330>
1001391c0: 52800080    	mov	w0, #0x4                ; =4
1001391c4: 95eb501f    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1001391c8: 34000c00    	cbz	w0, 0x100139348 <__text+0x131348>
1001391cc: 95ebb7f5    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1001391d0: f9005fe0    	str	x0, [sp, #0xb8]
1001391d4: d01001d3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
1001391d8: f9454660    	ldr	x0, [x19, #0xa88]
1001391dc: 95ebb7e1    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1001391e0: f9454668    	ldr	x8, [x19, #0xa88]
1001391e4: a90983e8    	stp	x8, x0, [sp, #0x98]
1001391e8: d01001d3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
1001391ec: f9458a60    	ldr	x0, [x19, #0xb10]
1001391f0: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1001391f4: f947bd01    	ldr	x1, [x8, #0xf78] ; selector=numberWithUnsignedInt:
1001391f8: aa1803e2    	mov	x2, x24
1001391fc: 95ebb7d0    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139200: aa1d03fd    	mov	x29, x29
100139204: 95ebb7d1    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139208: aa0003f9    	mov	x25, x0
10013920c: f9458a60    	ldr	x0, [x19, #0xb10]
100139210: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100139214: f947c901    	ldr	x1, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
100139218: f94057e2    	ldr	x2, [sp, #0xa8]
10013921c: 95ebb7c8    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139220: aa1d03fd    	mov	x29, x29
100139224: 95ebb7c9    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139228: f9005bfc    	str	x28, [sp, #0xb0]
10013922c: aa0003fc    	mov	x28, x0
100139230: f9458a60    	ldr	x0, [x19, #0xb10]
100139234: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100139238: f947b101    	ldr	x1, [x8, #0xf60] ; selector=numberWithLongLong:
10013923c: aa1b03e2    	mov	x2, x27
100139240: 95ebb7bf    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139244: aa1d03fd    	mov	x29, x29
100139248: 95ebb7c0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10013924c: aa1703e2    	mov	x2, x23
100139250: aa1a03f7    	mov	x23, x26
100139254: aa0003fa    	mov	x26, x0
100139258: f9458a60    	ldr	x0, [x19, #0xb10]
10013925c: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100139260: f9479501    	ldr	x1, [x8, #0xf28] ; selector=numberWithBool:
100139264: 95ebb7b6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139268: aa1d03fd    	mov	x29, x29
10013926c: 95ebb7b7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139270: aa0003f3    	mov	x19, x0
100139274: b00ffe88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100139278: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10013927c: f9405be8    	ldr	x8, [sp, #0xb0]
100139280: a9047fe8    	stp	x8, xzr, [sp, #0x40]
100139284: a90303f7    	stp	x23, x0, [sp, #0x30]
100139288: a9025bf5    	stp	x21, x22, [sp, #0x20]
10013928c: b00f1b82    	adrp	x2, 0x11e4aa000 <dyld_stub_binder+0x11e4aa000>
100139290: 9117a042    	add	x2, x2, #0x5e8 ; cfstring='Params Error! (type: %@, roomID: %@, roomKey: %@, contact: %@, nicInfos: %@, peerId: %@, capInfo: %@, forceToVoice: %@, delegate: %@)'
100139294: a9017ffa    	stp	x26, xzr, [sp, #0x10]
100139298: a90073f9    	stp	x25, x28, [sp]
10013929c: f9404fe0    	ldr	x0, [sp, #0x98]
1001392a0: 95ebb7a7    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001392a4: aa1d03fd    	mov	x29, x29
1001392a8: 95ebb7a8    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001392ac: aa1603fb    	mov	x27, x22
1001392b0: aa0003f6    	mov	x22, x0
1001392b4: b00ffe48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1001392b8: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
1001392bc: d00f1b08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1001392c0: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
1001392c4: a90003e8    	stp	x8, x0, [sp]
1001392c8: d00f1b02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1001392cc: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
1001392d0: f94053e0    	ldr	x0, [sp, #0xa0]
1001392d4: 95ebb79a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001392d8: aa0003f8    	mov	x24, x0
1001392dc: aa1603e0    	mov	x0, x22
1001392e0: aa1b03f6    	mov	x22, x27
1001392e4: 95ebb79c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001392e8: aa1303e0    	mov	x0, x19
1001392ec: 95ebb79a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001392f0: aa1a03e0    	mov	x0, x26
1001392f4: aa1703fa    	mov	x26, x23
1001392f8: 95ebb797    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001392fc: aa1c03e0    	mov	x0, x28
100139300: f9405bfc    	ldr	x28, [sp, #0xb0]
100139304: 95ebb794    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139308: aa1903e0    	mov	x0, x25
10013930c: 95ebb792    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139310: 900d86e1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
100139314: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
100139318: 900d8782    	adrp	x2, 0x11b229000 <dyld_stub_binder+0x11b229000>
10013931c: 91267842    	add	x2, x2, #0x99e ; cstring='AppUtil+VoIPSignal.mm'
100139320: 900d8784    	adrp	x4, 0x11b229000 <dyld_stub_binder+0x11b229000>
100139324: 9126d084    	add	x4, x4, #0x9b4 ; cstring='+[CAppUtil(VoIPSignal) voIPRequestAnswerWithDelegate:roomID:roomKey:contact:forceToVoice:type:nicInfos:peerId:capInfo:]'
100139328: 52800080    	mov	w0, #0x4                ; =4
10013932c: 528007a3    	mov	w3, #0x3d               ; =61
100139330: aa1803e5    	mov	x5, x24
100139334: 95eb4fc4    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
100139338: aa1803e0    	mov	x0, x24
10013933c: 95ebb786    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139340: f9405fe0    	ldr	x0, [sp, #0xb8]
100139344: 95ebb79a    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
100139348: 5280001b    	mov	w27, #0x0               ; =0
10013934c: 14000197    	b	0x1001399a8 <__text+0x1319a8>
100139350: 52800080    	mov	w0, #0x4                ; =4
100139354: 95eb4fbb    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
100139358: 34000ba0    	cbz	w0, 0x1001394cc <__text+0x1314cc>
10013935c: 95ebb791    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
100139360: f90033e0    	str	x0, [sp, #0x60]
100139364: d01001d3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
100139368: f9454660    	ldr	x0, [x19, #0xa88]
10013936c: 95ebb77d    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100139370: f9002fe0    	str	x0, [sp, #0x58]
100139374: f9454676    	ldr	x22, [x19, #0xa88]
100139378: d01001d3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
10013937c: f9458a60    	ldr	x0, [x19, #0xb10]
100139380: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100139384: f947bd01    	ldr	x1, [x8, #0xf78] ; selector=numberWithUnsignedInt:
100139388: 52800022    	mov	w2, #0x1                ; =1
10013938c: 95ebb76c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139390: aa1d03fd    	mov	x29, x29
100139394: 95ebb76d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139398: aa0003fb    	mov	x27, x0
10013939c: f9458a60    	ldr	x0, [x19, #0xb10]
1001393a0: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1001393a4: f947c901    	ldr	x1, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
1001393a8: f94057e2    	ldr	x2, [sp, #0xa8]
1001393ac: 95ebb764    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001393b0: aa1d03fd    	mov	x29, x29
1001393b4: 95ebb765    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001393b8: aa0003f8    	mov	x24, x0
1001393bc: f9458a60    	ldr	x0, [x19, #0xb10]
1001393c0: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1001393c4: f947b101    	ldr	x1, [x8, #0xf60] ; selector=numberWithLongLong:
1001393c8: f94037e2    	ldr	x2, [sp, #0x68]
1001393cc: 95ebb75c    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001393d0: aa1d03fd    	mov	x29, x29
1001393d4: 95ebb75d    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001393d8: aa0003fa    	mov	x26, x0
1001393dc: f9458a60    	ldr	x0, [x19, #0xb10]
1001393e0: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1001393e4: f9479501    	ldr	x1, [x8, #0xf28] ; selector=numberWithBool:
1001393e8: aa1703e2    	mov	x2, x23
1001393ec: 95ebb754    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001393f0: aa1d03fd    	mov	x29, x29
1001393f4: 95ebb755    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001393f8: aa0003f3    	mov	x19, x0
1001393fc: b00ffe88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100139400: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
100139404: a9047ffc    	stp	x28, xzr, [sp, #0x40]
100139408: f94053e8    	ldr	x8, [sp, #0xa0]
10013940c: a90303e8    	stp	x8, x0, [sp, #0x30]
100139410: a9027ff5    	stp	x21, xzr, [sp, #0x20]
100139414: b00f1b82    	adrp	x2, 0x11e4aa000 <dyld_stub_binder+0x11e4aa000>
100139418: 9117a042    	add	x2, x2, #0x5e8 ; cfstring='Params Error! (type: %@, roomID: %@, roomKey: %@, contact: %@, nicInfos: %@, peerId: %@, capInfo: %@, forceToVoice: %@, delegate: %@)'
10013941c: a90153fa    	stp	x26, x20, [sp, #0x10]
100139420: a90063fb    	stp	x27, x24, [sp]
100139424: aa1603e0    	mov	x0, x22
100139428: 95ebb745    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10013942c: aa1d03fd    	mov	x29, x29
100139430: 95ebb746    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139434: aa0003f6    	mov	x22, x0
100139438: b00ffe48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10013943c: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
100139440: d00f1b08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100139444: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
100139448: a90003e8    	stp	x8, x0, [sp]
10013944c: d00f1b02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100139450: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
100139454: f9402fe0    	ldr	x0, [sp, #0x58]
100139458: 95ebb739    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10013945c: aa0003f7    	mov	x23, x0
100139460: aa1603e0    	mov	x0, x22
100139464: 95ebb73c    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139468: aa1303e0    	mov	x0, x19
10013946c: 95ebb73a    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139470: aa1a03e0    	mov	x0, x26
100139474: f94053fa    	ldr	x26, [sp, #0xa0]
100139478: 95ebb737    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10013947c: aa1803e0    	mov	x0, x24
100139480: 95ebb735    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139484: aa1b03e0    	mov	x0, x27
100139488: 95ebb733    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10013948c: 900d86e1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
100139490: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
100139494: 900d8782    	adrp	x2, 0x11b229000 <dyld_stub_binder+0x11b229000>
100139498: 91267842    	add	x2, x2, #0x99e ; cstring='AppUtil+VoIPSignal.mm'
10013949c: 900d8784    	adrp	x4, 0x11b229000 <dyld_stub_binder+0x11b229000>
1001394a0: 9126d084    	add	x4, x4, #0x9b4 ; cstring='+[CAppUtil(VoIPSignal) voIPRequestAnswerWithDelegate:roomID:roomKey:contact:forceToVoice:type:nicInfos:peerId:capInfo:]'
1001394a4: 52800080    	mov	w0, #0x4                ; =4
1001394a8: 52800c03    	mov	w3, #0x60               ; =96
1001394ac: aa1703e5    	mov	x5, x23
1001394b0: 95eb4f65    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
1001394b4: aa1703e0    	mov	x0, x23
1001394b8: b9408bf7    	ldr	w23, [sp, #0x88]
1001394bc: f9405bfc    	ldr	x28, [sp, #0xb0]
1001394c0: 95ebb725    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001394c4: f94033e0    	ldr	x0, [sp, #0x60]
1001394c8: 95ebb739    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
1001394cc: b40000fa    	cbz	x26, 0x1001394e8 <__text+0x1314e8>
1001394d0: 900fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
1001394d4: f946d501    	ldr	x1, [x8, #0xda8] ; selector=setCapInfo:
1001394d8: aa1903e0    	mov	x0, x25
1001394dc: aa1a03e2    	mov	x2, x26
1001394e0: 95ebb717    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001394e4: 14000060    	b	0x100139664 <__text+0x131664>
1001394e8: 52800080    	mov	w0, #0x4                ; =4
1001394ec: 95eb4f55    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1001394f0: 34000ba0    	cbz	w0, 0x100139664 <__text+0x131664>
1001394f4: 95ebb72b    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1001394f8: f90033e0    	str	x0, [sp, #0x60]
1001394fc: d01001d3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
100139500: f9454660    	ldr	x0, [x19, #0xa88]
100139504: 95ebb717    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100139508: f9002fe0    	str	x0, [sp, #0x58]
10013950c: f9454676    	ldr	x22, [x19, #0xa88]
100139510: d01001d3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
100139514: f9458a60    	ldr	x0, [x19, #0xb10]
100139518: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10013951c: f947bd01    	ldr	x1, [x8, #0xf78] ; selector=numberWithUnsignedInt:
100139520: 52800022    	mov	w2, #0x1                ; =1
100139524: 95ebb706    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139528: aa1d03fd    	mov	x29, x29
10013952c: 95ebb707    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139530: aa0003fb    	mov	x27, x0
100139534: f9458a60    	ldr	x0, [x19, #0xb10]
100139538: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10013953c: f947c901    	ldr	x1, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
100139540: f94057e2    	ldr	x2, [sp, #0xa8]
100139544: 95ebb6fe    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139548: aa1d03fd    	mov	x29, x29
10013954c: 95ebb6ff    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139550: aa0003f8    	mov	x24, x0
100139554: f9458a60    	ldr	x0, [x19, #0xb10]
100139558: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10013955c: f947b101    	ldr	x1, [x8, #0xf60] ; selector=numberWithLongLong:
100139560: f94037e2    	ldr	x2, [sp, #0x68]
100139564: 95ebb6f6    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139568: aa1d03fd    	mov	x29, x29
10013956c: 95ebb6f7    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139570: aa0003fa    	mov	x26, x0
100139574: f9458a60    	ldr	x0, [x19, #0xb10]
100139578: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
10013957c: f9479501    	ldr	x1, [x8, #0xf28] ; selector=numberWithBool:
100139580: aa1703e2    	mov	x2, x23
100139584: 95ebb6ee    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139588: aa1d03fd    	mov	x29, x29
10013958c: 95ebb6ef    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139590: aa0003f3    	mov	x19, x0
100139594: b00ffe88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100139598: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10013959c: a9047ffc    	stp	x28, xzr, [sp, #0x40]
1001395a0: a90303ff    	stp	xzr, x0, [sp, #0x30]
1001395a4: f9405fe8    	ldr	x8, [sp, #0xb8]
1001395a8: a90223f5    	stp	x21, x8, [sp, #0x20]
1001395ac: b00f1b82    	adrp	x2, 0x11e4aa000 <dyld_stub_binder+0x11e4aa000>
1001395b0: 9117a042    	add	x2, x2, #0x5e8 ; cfstring='Params Error! (type: %@, roomID: %@, roomKey: %@, contact: %@, nicInfos: %@, peerId: %@, capInfo: %@, forceToVoice: %@, delegate: %@)'
1001395b4: a90153fa    	stp	x26, x20, [sp, #0x10]
1001395b8: a90063fb    	stp	x27, x24, [sp]
1001395bc: aa1603e0    	mov	x0, x22
1001395c0: 95ebb6df    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001395c4: aa1d03fd    	mov	x29, x29
1001395c8: 95ebb6e0    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001395cc: aa0003f6    	mov	x22, x0
1001395d0: b00ffe48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
1001395d4: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
1001395d8: d00f1b08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1001395dc: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
1001395e0: a90003e8    	stp	x8, x0, [sp]
1001395e4: d00f1b02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
1001395e8: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
1001395ec: f9402fe0    	ldr	x0, [sp, #0x58]
1001395f0: 95ebb6d3    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001395f4: aa0003f7    	mov	x23, x0
1001395f8: aa1603e0    	mov	x0, x22
1001395fc: 95ebb6d6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139600: aa1303e0    	mov	x0, x19
100139604: 95ebb6d4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139608: aa1a03e0    	mov	x0, x26
10013960c: f94053fa    	ldr	x26, [sp, #0xa0]
100139610: 95ebb6d1    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139614: aa1803e0    	mov	x0, x24
100139618: 95ebb6cf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10013961c: aa1b03e0    	mov	x0, x27
100139620: 95ebb6cd    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139624: 900d86e1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
100139628: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
10013962c: 900d8782    	adrp	x2, 0x11b229000 <dyld_stub_binder+0x11b229000>
100139630: 91267842    	add	x2, x2, #0x99e ; cstring='AppUtil+VoIPSignal.mm'
100139634: 900d8784    	adrp	x4, 0x11b229000 <dyld_stub_binder+0x11b229000>
100139638: 9126d084    	add	x4, x4, #0x9b4 ; cstring='+[CAppUtil(VoIPSignal) voIPRequestAnswerWithDelegate:roomID:roomKey:contact:forceToVoice:type:nicInfos:peerId:capInfo:]'
10013963c: 52800080    	mov	w0, #0x4                ; =4
100139640: 52800cc3    	mov	w3, #0x66               ; =102
100139644: aa1703e5    	mov	x5, x23
100139648: 95eb4eff    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
10013964c: aa1703e0    	mov	x0, x23
100139650: b9408bf7    	ldr	w23, [sp, #0x88]
100139654: f9405bfc    	ldr	x28, [sp, #0xb0]
100139658: 95ebb6bf    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10013965c: f94033e0    	ldr	x0, [sp, #0x60]
100139660: 95ebb6d3    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
100139664: d01001c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100139668: f9479900    	ldr	x0, [x8, #0xf30] ; class=ProtobufCGIWrap
10013966c: 95ebb6bb    	bl	0x107c27158 <_Flutter_MMFoundation_BindContext+0x4102d3c>
100139670: aa0003f8    	mov	x24, x0
100139674: d00fe808    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100139678: f9446501    	ldr	x1, [x8, #0x8c8] ; selector=setM_pbRequest:
10013967c: aa1903e2    	mov	x2, x25
100139680: 95ebb6af    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139684: d00fe808    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
100139688: f9446901    	ldr	x1, [x8, #0x8d0] ; selector=setM_uiCgi:
10013968c: aa1803e0    	mov	x0, x24
100139690: 52801582    	mov	w2, #0xac               ; =172
100139694: 95ebb6aa    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139698: 900fe848    	adrp	x8, 0x11fe41000 <dyld_stub_binder+0x11fe41000>
10013969c: f946d901    	ldr	x1, [x8, #0xdb0] ; selector=setM_uiRetryCount:
1001396a0: aa1803e0    	mov	x0, x24
1001396a4: 52800002    	mov	w2, #0x0                ; =0
1001396a8: 95ebb6a5    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001396ac: d01001c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1001396b0: f945e900    	ldr	x0, [x8, #0xbd0] ; class=MMContext
1001396b4: f94043e1    	ldr	x1, [sp, #0x80]
1001396b8: 95ebb6a1    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001396bc: aa1d03fd    	mov	x29, x29
1001396c0: 95ebb6a2    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001396c4: aa0003f3    	mov	x19, x0
1001396c8: d01001c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
1001396cc: f9479d00    	ldr	x0, [x8, #0xf38] ; class=EventService
1001396d0: f9403fe1    	ldr	x1, [sp, #0x78]
1001396d4: 95ebb69a    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001396d8: aa0003e2    	mov	x2, x0
1001396dc: aa1303e0    	mov	x0, x19
1001396e0: f9403be1    	ldr	x1, [sp, #0x70]
1001396e4: 95ebb696    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001396e8: aa1d03fd    	mov	x29, x29
1001396ec: 95ebb697    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001396f0: aa0003f6    	mov	x22, x0
1001396f4: d00fe808    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
1001396f8: f9446d01    	ldr	x1, [x8, #0x8d8] ; selector=CreateProtobufEvent:Flag:
1001396fc: aa1803e2    	mov	x2, x24
100139700: 528002a3    	mov	w3, #0x15               ; =21
100139704: 95ebb68e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139708: aa0003fb    	mov	x27, x0
10013970c: aa1603e0    	mov	x0, x22
100139710: 95ebb691    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139714: aa1303e0    	mov	x0, x19
100139718: 95ebb68f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10013971c: 34000dfb    	cbz	w27, 0x1001398d8 <__text+0x1318d8>
100139720: d01001c8    	adrp	x8, 0x120173000 <dyld_stub_binder+0x120173000>
100139724: f9464900    	ldr	x0, [x8, #0xc90] ; class=CAppUtil
100139728: d00fe808    	adrp	x8, 0x11fe3b000 <dyld_stub_binder+0x11fe3b000>
10013972c: f9447101    	ldr	x1, [x8, #0x8e0] ; selector=addPBEventObserverListItem:andValue:
100139730: aa1b03e2    	mov	x2, x27
100139734: aa1c03e3    	mov	x3, x28
100139738: 95ebb681    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10013973c: 52800040    	mov	w0, #0x2                ; =2
100139740: 95eb4ec0    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
100139744: f9405ff6    	ldr	x22, [sp, #0xb8]
100139748: 34001280    	cbz	w0, 0x100139998 <__text+0x131998>
10013974c: 95ebb695    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
100139750: f90047e0    	str	x0, [sp, #0x88]
100139754: d01001d3    	adrp	x19, 0x120173000 <dyld_stub_binder+0x120173000>
100139758: f9454660    	ldr	x0, [x19, #0xa88]
10013975c: 95ebb681    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
100139760: f9454668    	ldr	x8, [x19, #0xa88]
100139764: a90783e8    	stp	x8, x0, [sp, #0x78]
100139768: d01001d4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
10013976c: f9458a80    	ldr	x0, [x20, #0xb10]
100139770: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100139774: f947bd13    	ldr	x19, [x8, #0xf78] ; selector=numberWithUnsignedInt:
100139778: aa1303e1    	mov	x1, x19
10013977c: b94093e2    	ldr	w2, [sp, #0x90]
100139780: 95ebb66f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139784: aa1d03fd    	mov	x29, x29
100139788: 95ebb670    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
10013978c: f9004be0    	str	x0, [sp, #0x90]
100139790: f9458a80    	ldr	x0, [x20, #0xb10]
100139794: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
100139798: f947c901    	ldr	x1, [x8, #0xf90] ; selector=numberWithUnsignedLongLong:
10013979c: f94057e2    	ldr	x2, [sp, #0xa8]
1001397a0: 95ebb667    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001397a4: aa1d03fd    	mov	x29, x29
1001397a8: 95ebb668    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001397ac: f90057e0    	str	x0, [sp, #0xa8]
1001397b0: f9458a80    	ldr	x0, [x20, #0xb10]
1001397b4: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1001397b8: f947b101    	ldr	x1, [x8, #0xf60] ; selector=numberWithLongLong:
1001397bc: f94037e2    	ldr	x2, [sp, #0x68]
1001397c0: 95ebb65f    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001397c4: aa1d03fd    	mov	x29, x29
1001397c8: 95ebb660    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001397cc: aa0003fa    	mov	x26, x0
1001397d0: f9003be0    	str	x0, [sp, #0x70]
1001397d4: f9458a80    	ldr	x0, [x20, #0xb10]
1001397d8: f00ffe48    	adrp	x8, 0x120104000 <dyld_stub_binder+0x120104000>
1001397dc: f9479501    	ldr	x1, [x8, #0xf28] ; selector=numberWithBool:
1001397e0: aa1703e2    	mov	x2, x23
1001397e4: 95ebb656    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
1001397e8: aa1d03fd    	mov	x29, x29
1001397ec: 95ebb657    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
1001397f0: aa0003f7    	mov	x23, x0
1001397f4: f9458a80    	ldr	x0, [x20, #0xb10]
1001397f8: f9404ff4    	ldr	x20, [sp, #0x98]
1001397fc: aa1303e1    	mov	x1, x19
100139800: aa1b03e2    	mov	x2, x27
100139804: 95ebb64e    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139808: aa1d03fd    	mov	x29, x29
10013980c: 95ebb64f    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139810: aa0003f3    	mov	x19, x0
100139814: b00ffe88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
100139818: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
10013981c: a904ffe0    	stp	x0, xzr, [sp, #0x48]
100139820: a903f3f7    	stp	x23, x28, [sp, #0x38]
100139824: a94a23e9    	ldp	x9, x8, [sp, #0xa0]
100139828: a902a7f6    	stp	x22, x9, [sp, #0x28]
10013982c: a901d7f4    	stp	x20, x21, [sp, #0x18]
100139830: b00f1b82    	adrp	x2, 0x11e4aa000 <dyld_stub_binder+0x11e4aa000>
100139834: 91192042    	add	x2, x2, #0x648 ; cfstring='Request CGI `Answer`! (type: %@, roomID: %@, roomKey: %@, contact: %@, nicInfos: %@, peerId: %@, capInfo: %@, forceToVoice: %@, delegate: %@, eventId: %@)'
100139838: a900ebe8    	stp	x8, x26, [sp, #0x8]
10013983c: f9404be8    	ldr	x8, [sp, #0x90]
100139840: f90003e8    	str	x8, [sp]
100139844: f9403fe0    	ldr	x0, [sp, #0x78]
100139848: 95ebb63d    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10013984c: aa1d03fd    	mov	x29, x29
100139850: 95ebb63e    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139854: aa0003f6    	mov	x22, x0
100139858: b00ffe48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
10013985c: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
100139860: d00f1b08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100139864: 91352108    	add	x8, x8, #0xd48 ; cfstring='INFO: '
100139868: a90003e8    	stp	x8, x0, [sp]
10013986c: d00f1b02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100139870: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
100139874: f94043e0    	ldr	x0, [sp, #0x80]
100139878: 95ebb631    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
10013987c: aa0003fc    	mov	x28, x0
100139880: aa1603e0    	mov	x0, x22
100139884: 95ebb634    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139888: aa1303e0    	mov	x0, x19
10013988c: 95ebb632    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
100139890: aa1703e0    	mov	x0, x23
100139894: f94053fa    	ldr	x26, [sp, #0xa0]
100139898: 95ebb62f    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10013989c: f9403be0    	ldr	x0, [sp, #0x70]
1001398a0: 95ebb62d    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001398a4: f94057e0    	ldr	x0, [sp, #0xa8]
1001398a8: 95ebb62b    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001398ac: f9404be0    	ldr	x0, [sp, #0x90]
1001398b0: 95ebb629    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001398b4: 900d86e1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
1001398b8: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
1001398bc: 900d8782    	adrp	x2, 0x11b229000 <dyld_stub_binder+0x11b229000>
1001398c0: 91267842    	add	x2, x2, #0x99e ; cstring='AppUtil+VoIPSignal.mm'
1001398c4: 900d8784    	adrp	x4, 0x11b229000 <dyld_stub_binder+0x11b229000>
1001398c8: 9126d084    	add	x4, x4, #0x9b4 ; cstring='+[CAppUtil(VoIPSignal) voIPRequestAnswerWithDelegate:roomID:roomKey:contact:forceToVoice:type:nicInfos:peerId:capInfo:]'
1001398cc: 52800040    	mov	w0, #0x2                ; =2
1001398d0: 52801023    	mov	w3, #0x81               ; =129
1001398d4: 1400002a    	b	0x10013997c <__text+0x13197c>
1001398d8: 52800080    	mov	w0, #0x4                ; =4
1001398dc: 95eb4e59    	bl	0x107c0d240 <_Flutter_MMFoundation_BindContext+0x40e8e24>
1001398e0: f9405ff6    	ldr	x22, [sp, #0xb8]
1001398e4: 340005a0    	cbz	w0, 0x100139998 <__text+0x131998>
1001398e8: 95ebb62e    	bl	0x107c271a0 <_Flutter_MMFoundation_BindContext+0x4102d84>
1001398ec: f90047e0    	str	x0, [sp, #0x88]
1001398f0: d01001d4    	adrp	x20, 0x120173000 <dyld_stub_binder+0x120173000>
1001398f4: f9454680    	ldr	x0, [x20, #0xa88]
1001398f8: 95ebb61a    	bl	0x107c27160 <_Flutter_MMFoundation_BindContext+0x4102d44>
1001398fc: aa0003f3    	mov	x19, x0
100139900: f9454680    	ldr	x0, [x20, #0xa88]
100139904: f9404ff4    	ldr	x20, [sp, #0x98]
100139908: b00ffe88    	adrp	x8, 0x12010a000 <dyld_stub_binder+0x12010a000>
10013990c: f946a501    	ldr	x1, [x8, #0xd48] ; selector=stringWithFormat:
100139910: f90003ff    	str	xzr, [sp]
100139914: b00f1b82    	adrp	x2, 0x11e4aa000 <dyld_stub_binder+0x11e4aa000>
100139918: 9118a042    	add	x2, x2, #0x628 ; cfstring='Failed to request cgi `Answer`!'
10013991c: 95ebb608    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139920: aa1d03fd    	mov	x29, x29
100139924: 95ebb609    	bl	0x107c27148 <_Flutter_MMFoundation_BindContext+0x4102d2c>
100139928: aa0003f6    	mov	x22, x0
10013992c: b00ffe48    	adrp	x8, 0x120102000 <dyld_stub_binder+0x120102000>
100139930: f947d101    	ldr	x1, [x8, #0xfa0] ; selector=initWithFormat:
100139934: d00f1b08    	adrp	x8, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100139938: 91362108    	add	x8, x8, #0xd88 ; cfstring='ERROR: '
10013993c: a90003e8    	stp	x8, x0, [sp]
100139940: d00f1b02    	adrp	x2, 0x11e49b000 <dyld_stub_binder+0x11e49b000>
100139944: 9134a042    	add	x2, x2, #0xd28 ; cfstring='%@%@'
100139948: aa1303e0    	mov	x0, x19
10013994c: 95ebb5fc    	bl	0x107c2713c <_Flutter_MMFoundation_BindContext+0x4102d20>
100139950: aa0003fc    	mov	x28, x0
100139954: aa1603e0    	mov	x0, x22
100139958: 95ebb5ff    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10013995c: 900d86e1    	adrp	x1, 0x11b215000 <dyld_stub_binder+0x11b215000>
100139960: 9124e421    	add	x1, x1, #0x939 ; cstring='VoIP'
100139964: 900d8782    	adrp	x2, 0x11b229000 <dyld_stub_binder+0x11b229000>
100139968: 91267842    	add	x2, x2, #0x99e ; cstring='AppUtil+VoIPSignal.mm'
10013996c: 900d8784    	adrp	x4, 0x11b229000 <dyld_stub_binder+0x11b229000>
100139970: 9126d084    	add	x4, x4, #0x9b4 ; cstring='+[CAppUtil(VoIPSignal) voIPRequestAnswerWithDelegate:roomID:roomKey:contact:forceToVoice:type:nicInfos:peerId:capInfo:]'
100139974: 52800080    	mov	w0, #0x4                ; =4
100139978: 52800e03    	mov	w3, #0x70               ; =112
10013997c: aa1c03e5    	mov	x5, x28
100139980: 95eb4e31    	bl	0x107c0d244 <_Flutter_MMFoundation_BindContext+0x40e8e28>
100139984: aa1c03e0    	mov	x0, x28
100139988: 95ebb5f3    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
10013998c: f94047e0    	ldr	x0, [sp, #0x88]
100139990: 95ebb607    	bl	0x107c271ac <_Flutter_MMFoundation_BindContext+0x4102d90>
100139994: a94b5bfc    	ldp	x28, x22, [sp, #0xb0]
100139998: aa1803e0    	mov	x0, x24
10013999c: 95ebb5ee    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001399a0: aa1903e0    	mov	x0, x25
1001399a4: 95ebb5ec    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001399a8: aa1a03e0    	mov	x0, x26
1001399ac: 95ebb5ea    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001399b0: aa1603e0    	mov	x0, x22
1001399b4: 95ebb5e8    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001399b8: aa1503e0    	mov	x0, x21
1001399bc: 95ebb5e6    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001399c0: aa1403e0    	mov	x0, x20
1001399c4: 95ebb5e4    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001399c8: aa1c03e0    	mov	x0, x28
1001399cc: 95ebb5e2    	bl	0x107c27154 <_Flutter_MMFoundation_BindContext+0x4102d38>
1001399d0: f85a03a8    	ldur	x8, [x29, #-0x60]
1001399d4: d00ea5a9    	adrp	x9, 0x11d5ef000 <dyld_stub_binder+0x11d5ef000>
1001399d8: f9405929    	ldr	x9, [x9, #0xb0]
1001399dc: f9400129    	ldr	x9, [x9]
1001399e0: eb08013f    	cmp	x9, x8
1001399e4: 54000141    	b.ne	0x100139a0c <__text+0x131a0c>
1001399e8: aa1b03e0    	mov	x0, x27
1001399ec: a95e7bfd    	ldp	x29, x30, [sp, #0x1e0]
1001399f0: a95d4ff4    	ldp	x20, x19, [sp, #0x1d0]
1001399f4: a95c57f6    	ldp	x22, x21, [sp, #0x1c0]
1001399f8: a95b5ff8    	ldp	x24, x23, [sp, #0x1b0]
1001399fc: a95a67fa    	ldp	x26, x25, [sp, #0x1a0]
100139a00: a9596ffc    	ldp	x28, x27, [sp, #0x190]
100139a04: 9107c3ff    	add	sp, sp, #0x1f0
100139a08: d65f03c0    	ret
100139a0c: 95ebb5da    	bl	0x107c27174 <_Flutter_MMFoundation_BindContext+0x4102d58>
