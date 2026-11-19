#import "CSClownSession.h"
#import "CSClownTextRules.h"
#include <stdlib.h>
#include <math.h>

@interface CSClownMessageReplacement : NSObject
@property(nonatomic, strong) CSMessageActionContext *context;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, strong) id image;
@property(nonatomic, copy) NSString *amount;
@end
@implementation CSClownMessageReplacement @end

@interface CSClownSession ()
@property(nonatomic, strong) CSClownSession *warmTexts;
@property(nonatomic, strong) CSClownSession *fakeQuotes;
@property(nonatomic, strong) NSMutableArray<CSClownMessageReplacement *> *messages;
@property(nonatomic, strong) NSMutableArray<CSClownMessageReplacement *> *amounts;
@property(nonatomic, strong) NSMapTable<id, NSDate *> *times;
@end

@implementation CSClownSession
- (instancetype)initWithAccountID:(NSString *)accountID conversationID:(NSString *)conversationID {
    if (!NSThread.isMainThread || ![accountID isKindOfClass:NSString.class] || !accountID.length ||
        ![conversationID isKindOfClass:NSString.class] || !conversationID.length) return nil;
    if ((self=[super init])) {
        _accountID=[accountID copy]; _conversationID=[conversationID copy]; _active=YES; _epoch=1;
        _messages=[NSMutableArray array]; _amounts=[NSMutableArray array];
        // Native time nodes have no message wrap. Identity and lifetime belong to
        // the existing node; equality implementations must not merge two nodes.
        _times=[NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory|NSPointerFunctionsObjectPointerPersonality
                                   valueOptions:NSPointerFunctionsStrongMemory];
    }
    return self;
}
- (BOOL)acceptsContext:(CSMessageActionContext *)context {
    return NSThread.isMainThread && _active && [context isKindOfClass:CSMessageActionContext.class] &&
        [context.accountID isEqualToString:_accountID] && [context.sourceConversationID isEqualToString:_conversationID];
}
- (CSClownMessageReplacement *)replacementForContext:(CSMessageActionContext *)context create:(BOOL)create {
    return [self replacementForContext:context entries:_messages create:create];
}
- (CSClownMessageReplacement *)replacementForContext:(CSMessageActionContext *)context
    entries:(NSMutableArray<CSClownMessageReplacement *> *)entries create:(BOOL)create {
    if (![self acceptsContext:context]) return nil;
    CSClownMessageReplacement *found=nil;
    for (CSClownMessageReplacement *entry in entries) {
        CSMessageActionContext *prior=entry.context;
        // A promoted identity cannot be overwritten through a reused local ID
        // carrying a contradictory known server ID.
        if (prior.accountEpoch==context.accountEpoch && prior.outgoing==context.outgoing && prior.localID && prior.localID==context.localID &&
            prior.serverID && context.serverID && prior.serverID!=context.serverID) return nil;
        if (![prior matchesSourceContext:context]) continue;
        if (found) return nil; // Ambiguous native identities fail closed.
        found=entry;
    }
    if (found) {
        // Keep the richest identity, so local -> local+server -> server works
        // without forgetting the known server ID on a later local-only read.
        CSMessageActionContext *prior=found.context;
        if ((context.serverID && !prior.serverID) ||
            (context.serverID==prior.serverID && context.localID && !prior.localID)) found.context=context;
        return found;
    }
    if (!create) return nil;
    found=[CSClownMessageReplacement new]; found.context=context; [entries addObject:found];
    return found;
}
- (void)removeEmptyReplacement:(CSClownMessageReplacement *)entry {
    if (entry && !entry.text && !entry.image) [_messages removeObjectIdenticalTo:entry];
}
- (NSString *)textForContext:(CSMessageActionContext *)context {
    return [self replacementForContext:context create:NO].text;
}
- (BOOL)setText:(NSString *)text forContext:(CSMessageActionContext *)context {
    if (text && ![text isKindOfClass:NSString.class]) return NO;
    if (![self acceptsContext:context]) return NO;
    CSClownMessageReplacement *entry=[self replacementForContext:context create:text!=nil];
    if (!entry) return NO;
    entry.text=text; [self removeEmptyReplacement:entry]; return YES;
}
- (NSString *)warmTextForContext:(CSMessageActionContext *)context original:(NSString *)original {
    if (![self acceptsContext:context] || context.outgoing || context.messageType != 1) return nil;
    NSArray *expressions = CSClownWarmExpressions(original);
    if (!expressions.count) return nil;
    if (!self.warmTexts) self.warmTexts = [[CSClownSession alloc] initWithAccountID:self.accountID conversationID:self.conversationID];
    NSString *text = [self.warmTexts textForContext:context];
    if (!text || ![expressions containsObject:text]) {
        text = expressions[arc4random_uniform((uint32_t)expressions.count)];
        if (![self.warmTexts setText:text forContext:context]) return nil;
    }
    return text;
}
- (void)clearWarmTexts { if (!NSThread.isMainThread) return; [self.warmTexts invalidate]; self.warmTexts = nil; }
- (NSString *)fakeQuoteForContext:(CSMessageActionContext *)context {
    if (![self acceptsContext:context] || !context.outgoing || context.messageType != 1) return nil;
    return [self.fakeQuotes textForContext:context];
}
- (BOOL)setFakeQuote:(NSString *)quote forContext:(CSMessageActionContext *)context {
    if (![self acceptsContext:context] || !context.outgoing || context.messageType != 1 || ![quote isKindOfClass:NSString.class] || !quote.length) return NO;
    if (!self.fakeQuotes) self.fakeQuotes = [[CSClownSession alloc] initWithAccountID:self.accountID conversationID:self.conversationID];
    return [self.fakeQuotes setText:quote forContext:context];
}
- (void)clearFakeQuotes { if (!NSThread.isMainThread) return; [self.fakeQuotes invalidate]; self.fakeQuotes = nil; }
- (id)imageForContext:(CSMessageActionContext *)context {
    return [self replacementForContext:context create:NO].image;
}
- (BOOL)setImage:(id)image forContext:(CSMessageActionContext *)context {
    if (![self acceptsContext:context]) return NO;
    CSClownMessageReplacement *entry=[self replacementForContext:context create:image!=nil];
    if (!entry) return NO;
    entry.image=image; [self removeEmptyReplacement:entry]; return YES;
}
- (NSString *)amountForContext:(CSMessageActionContext *)context {
    return [self replacementForContext:context entries:_amounts create:NO].amount;
}
- (BOOL)setAmount:(NSString *)amount forContext:(CSMessageActionContext *)context {
    if (amount && ![amount isKindOfClass:NSString.class]) return NO;
    CSClownMessageReplacement *entry=[self replacementForContext:context entries:_amounts create:amount!=nil];
    if (!entry) return NO;
    entry.amount=amount;
    if (!amount) [_amounts removeObjectIdenticalTo:entry];
    return YES;
}
- (NSDate *)dateForTimeModel:(id)model {
    if (!NSThread.isMainThread || !_active || !model) return nil;
    return [_times objectForKey:model];
}
- (BOOL)setDate:(NSDate *)date forTimeModel:(id)model {
    if (!NSThread.isMainThread || !_active || !model ||
        (date && (![date isKindOfClass:NSDate.class] || !isfinite(date.timeIntervalSinceReferenceDate)))) return NO;
    if (date) [_times setObject:[date copy] forKey:model];
    else [_times removeObjectForKey:model];
    return YES;
}
- (void)clearText {
    if (!NSThread.isMainThread) return;
    _epoch++;
    for (CSClownMessageReplacement *entry in _messages.copy) { entry.text=nil; [self removeEmptyReplacement:entry]; }
}
- (void)clearImages {
    if (!NSThread.isMainThread) return;
    _epoch++;
    for (CSClownMessageReplacement *entry in _messages.copy) { entry.image=nil; [self removeEmptyReplacement:entry]; }
}
- (void)clearTimes {
    if (!NSThread.isMainThread) return;
    _epoch++; [_times removeAllObjects];
}
- (void)clearAmounts {
    if (!NSThread.isMainThread) return;
    _epoch++; [_amounts removeAllObjects];
}
- (void)invalidate {
    if (!NSThread.isMainThread) return;
    _epoch++; _active=NO; [_messages removeAllObjects]; [_times removeAllObjects]; [_amounts removeAllObjects];
    [self clearWarmTexts]; [self clearFakeQuotes];
}
@end
