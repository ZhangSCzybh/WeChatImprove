#import "CSPaymentCore.h"
#import <limits.h>

NSString *CSPaymentString(id value) {
    return [value isKindOfClass:NSString.class] && [value length] && [value length] <= 65536 ? value : nil;
}
NSNumber *CSPaymentInteger(id value) {
    if (![value isKindOfClass:NSString.class] && ![value isKindOfClass:NSNumber.class]) return nil;
    NSString *s=[value description];
    if (!s.length || s.length>20) return nil;
    const char *bytes=s.UTF8String; if (!bytes || !*bytes) return nil;
    const char *p=bytes; if (*p=='-') p++;
    if (!*p) return nil;
    for (; *p; p++) if (*p<'0' || *p>'9') return nil;
    errno=0; char *end=NULL; long long n=strtoll(bytes,&end,10);
    return errno==ERANGE || !end || *end ? nil : @(n);
}
NSDictionary *CSPaymentQuery(NSString *text) {
    if (!CSPaymentString(text)) return nil;
    NSRange q=[text rangeOfString:@"?"], scheme=[text rangeOfString:@"://"];
    if (scheme.location!=NSNotFound && scheme.location<q.location && q.location!=NSNotFound) text=[text substringFromIndex:q.location+1];
    NSMutableDictionary *result=[NSMutableDictionary dictionary];
    for (NSString *pair in [text componentsSeparatedByString:@"&"]) {
        NSRange eq=[pair rangeOfString:@"="]; if (eq.location==NSNotFound) continue;
        NSString *(^decode)(NSString *)=^NSString *(NSString *s){ return [[s stringByReplacingOccurrencesOfString:@"+" withString:@" "] stringByRemovingPercentEncoding]; };
        NSString *k=decode([pair substringToIndex:eq.location]);
        NSString *v=decode([pair substringFromIndex:eq.location+1]);
        if (!k.length || !v || result[k]) return nil; // ambiguous identity is never a match
        result[k]=v;
    }
    return result.count ? [result copy] : nil;
}
NSDictionary *CSPaymentDecode(NSData *data) {
    if (![data isKindOfClass:NSData.class] || !data.length || data.length>256*1024) return nil;
    id obj=[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    if ([obj isKindOfClass:NSDictionary.class]) return obj;
    return CSPaymentQuery([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}
BOOL CSPaymentErrorsOK(NSDictionary *d) {
    if (![d isKindOfClass:NSDictionary.class]) return NO;
    // Native responses may omit retcode; explicit errors must still be rejected.
    for (NSString *k in @[@"retcode",@"retCode",@"ret",@"wx_error_type",@"errorType",@"errCode",@"errorCode",@"platRet"]) {
        if (d[k] && (!CSPaymentInteger(d[k]) || [CSPaymentInteger(d[k]) longLongValue]!=0)) return NO;
    }
    return YES;
}
BOOL CSPaymentRequestMatches(NSDictionary *expected, NSDictionary *actual) {
    for (NSString *k in expected) {
        NSString *value=CSPaymentString(actual[k]);
        // Compare against the known original, stopping as soon as it matches.
        // Never decode the entire form (which would turn escaped '&' into keys).
        for (NSUInteger i=0; value && ![expected[k] isEqual:value] && i<2; i++) value=value.stringByRemovingPercentEncoding;
        if (![expected[k] isEqual:value]) return NO;
    }
    return expected.count>0;
}
NSString *CSPaymentBusinessKey(NSString *a, NSString *k, NSString *s, NSString *i) {
    return [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:@[a,k,s,i] options:0 error:NULL] encoding:NSUTF8StringEncoding];
}

@interface CSPaymentXML : NSObject <NSXMLParserDelegate>
@property NSMutableDictionary *fields;
@property NSMutableArray *path;
@property NSMutableString *text;
@property NSString *field;
@property BOOL bad;
@end
@implementation CSPaymentXML
- (void)parser:(NSXMLParser *)p didStartElement:(NSString *)name namespaceURI:(NSString *)uri qualifiedName:(NSString *)q attributes:(NSDictionary *)a {
    if (self.field) { self.bad=YES; [p abortParsing]; return; }
    [self.path addObject:name];
    if (self.path.count>=2 && [self.path[self.path.count-2] isEqual:@"wcpayinfo"]) {
        if ([@[@"transferid",@"paysubtype",@"receiver_username",@"payer_username",@"transfer_receiver_username",@"transfer_payer_username",@"invalidtime",@"nativeurl",@"exclusive_recv_username"] containsObject:name]) {
            if (self.fields[name]) { self.bad=YES; [p abortParsing]; return; }
            self.field=name; self.text=[NSMutableString string];
        }
    }
}
- (void)parser:(NSXMLParser *)p foundCharacters:(NSString *)s { if (self.field) [self.text appendString:s]; }
- (void)parser:(NSXMLParser *)p foundCDATA:(NSData *)data { if (self.field) { NSString *s=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]; if (s) [self.text appendString:s]; else self.bad=YES; } }
- (void)parser:(NSXMLParser *)p didEndElement:(NSString *)n namespaceURI:(NSString *)u qualifiedName:(NSString *)q {
    if ([self.field isEqual:n]) { self.fields[n]=[self.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet]; self.field=nil; }
    [self.path removeLastObject];
}
@end
static NSString *CSAgree(NSArray *values, BOOL *conflict) {
    NSString *value=nil;
    for (id v in values) {
        if (v==NSNull.null || [v isEqual:@""]) continue;
        if (!CSPaymentString(v) || (value && ![value isEqual:v])) { *conflict=YES; return nil; }
        value=v;
    }
    return value;
}
NSDictionary *CSPaymentXMLFields(NSString *xml) {
    if (CSPaymentString(xml)) {
        if ([xml rangeOfString:@"<!DOCTYPE" options:NSCaseInsensitiveSearch].location!=NSNotFound || [xml rangeOfString:@"<!ENTITY" options:NSCaseInsensitiveSearch].location!=NSNotFound) return nil;
        NSRange start=[xml rangeOfString:@"<msg"];
        if (start.location==NSNotFound) return nil;
        CSPaymentXML *d=[CSPaymentXML new]; d.fields=[NSMutableDictionary dictionary]; d.path=[NSMutableArray array];
        NSXMLParser *parser=[[NSXMLParser alloc] initWithData:[[xml substringFromIndex:start.location] dataUsingEncoding:NSUTF8StringEncoding]];
        parser.delegate=d; parser.shouldResolveExternalEntities=NO;
        if (![parser parse] || d.bad) return nil;
        return d.fields;
    }
    return @{};
}
NSDictionary *CSPaymentTransferFields(NSString *xml, NSDictionary *n, NSString *account, NSString *from, NSString *to) {
    if (!account.length || !from.length || !to.length || [from isEqual:account]) return nil;
    NSDictionary *x=CSPaymentXMLFields(xml); if (!x) return nil;
    BOOL conflict=NO;
    NSString *receiver=CSAgree(@[n[@"receiver"]?:NSNull.null,x[@"receiver_username"]?:NSNull.null,x[@"transfer_receiver_username"]?:NSNull.null],&conflict);
    NSString *payer=CSAgree(@[n[@"payer"]?:NSNull.null,x[@"payer_username"]?:NSNull.null,x[@"transfer_payer_username"]?:NSNull.null],&conflict);
    NSString *identifier=CSAgree(@[n[@"id"]?:NSNull.null,x[@"transferid"]?:NSNull.null],&conflict);
    NSNumber *nativeType=CSPaymentInteger(n[@"subtype"]), *xmlType=CSPaymentInteger(x[@"paysubtype"]);
    if ((n[@"subtype"] && !nativeType) || (x[@"paysubtype"] && !xmlType)) return nil;
    // A zero native subtype is the unpopulated scalar, not a receipt card.
    if ((nativeType.integerValue!=0 && nativeType.integerValue!=1) || (xmlType && xmlType.integerValue!=1) || (nativeType.integerValue!=1 && xmlType.integerValue!=1)) return nil;
    BOOL group=[from hasSuffix:@"@chatroom"];
    if (!group && [to isEqual:account]) {
        if (!receiver) receiver=account;
        if (!payer) payer=from;
    }
    if (conflict || ![receiver isEqual:account] || !payer.length || [payer isEqual:account] || !identifier.length) return nil;
    if ([to hasSuffix:@"@chatroom"] || (!group && (![to isEqual:account] || ![from isEqual:payer]))) return nil;
    NSNumber *invalid=CSPaymentInteger(x[@"invalidtime"]);
    if (x[@"invalidtime"] && (!invalid || invalid.longLongValue<0)) return nil;
    // invalidtime is forwarded unchanged. Its absolute/duration meaning is not assumed.
    return @{@"id":identifier,@"payer":payer,@"receiver":receiver,@"session":from,@"invalidtime":invalid?:@0};
}
@implementation CSPaymentTask
@end
@interface CSPaymentTaskStore ()
@property NSMutableArray<CSPaymentTask *> *pending;
@property NSMutableDictionary<NSString *,NSNumber *> *recent;
@end
@implementation CSPaymentTaskStore
- (instancetype)init { if ((self=[super init])) { _pending=[NSMutableArray array]; _recent=[NSMutableDictionary dictionary]; } return self; }
- (NSArray *)tasks { return [self.pending copy]; }
- (BOOL)contains:(CSPaymentTask *)t { return [self.pending containsObject:t] && t.phase!=CSPaymentFinished; }
- (BOOL)add:(CSPaymentTask *)t now:(NSTimeInterval)now {
    for (NSString *k in self.recent.allKeys) if (self.recent[k].doubleValue<=now) [self.recent removeObjectForKey:k];
    NSUInteger count=0;
    for (CSPaymentTask *old in self.pending) { if ([old.key isEqual:t.key] && !t.observation) return NO; if (old.envelope==t.envelope) count++; }
    if ((self.recent[t.key] && !t.observation) || count >= (t.envelope?256:128)) return NO;
    [self.pending addObject:t]; return YES;
}
- (void)finish:(CSPaymentTask *)t now:(NSTimeInterval)now {
    if (![self contains:t]) return;
    t.phase=CSPaymentFinished; t.queryRequest=nil; t.openRequest=nil;
    [self.pending removeObjectIdenticalTo:t]; self.recent[t.key]=@(now+86400);
    if (self.recent.count>2048) {
        NSString *oldest=[self.recent keysSortedByValueUsingSelector:@selector(compare:)].firstObject;
        [self.recent removeObjectForKey:oldest];
    }
}
- (NSArray *)expireAt:(NSTimeInterval)now {
    NSMutableArray *expired=[NSMutableArray array];
    for (CSPaymentTask *t in self.tasks) if (t.deadline<=now) { [expired addObject:t]; [self finish:t now:now]; }
    return expired;
}
- (CSPaymentTask *)nextAt:(NSTimeInterval)now serial:(BOOL)serial {
    NSUInteger inFlight=0,transfers=0;
    for (CSPaymentTask *t in self.pending) {
        if (t.phase==CSPaymentQuerying || t.phase==CSPaymentOpening) inFlight++;
        if (t.phase==CSPaymentConfirming || t.phase==CSPaymentVerifying) transfers++;
    }
    // Opening takes priority over new queries. One set covers both concurrency modes.
    for (NSUInteger pass=0;pass<2;pass++) for (CSPaymentTask *t in self.pending) {
        if (t.deadline<=now || t.readyAt>now) continue;
        if (!t.envelope && t.phase==CSPaymentQueued && transfers<1) return t;
        if (t.envelope && inFlight<(serial?1:5) && t.phase==(pass==0?CSPaymentReady:CSPaymentQueued)) return t;
    }
    return nil;
}
- (NSTimeInterval)nextWakeAt:(NSTimeInterval)now {
    NSTimeInterval next=DBL_MAX;
    for (CSPaymentTask *t in self.pending) {
        next=MIN(next,t.deadline);
        if ((t.phase==CSPaymentQueued || t.phase==CSPaymentReady) && t.readyAt>now) next=MIN(next,t.readyAt);
    }
    return next;
}
@end
