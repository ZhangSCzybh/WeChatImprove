#import "CSCloseFriendAutomationProjection.h"

static BOOL CSAutomationAccountMatches(NSString *account, CSCloseFriendSnapshot *snapshot) {
    return account.length && snapshot && !snapshot.blocked && [account isEqual:snapshot.accountID];
}

NSArray<NSDictionary *> *CSCloseFriendVisibleScheduledTasks(NSArray<NSDictionary *> *tasks, NSString *account, CSCloseFriendSnapshot *snapshot) {
    if (!CSAutomationAccountMatches(account,snapshot)) return @[];
    NSMutableArray *visible=[NSMutableArray array];
    for (NSDictionary *task in tasks) {
        if (![snapshot hidesUserName:task[@"target"] surface:CSCloseFriendSurfaceScheduledTasks]) [visible addObject:task];
    }
    return [visible copy];
}

NSArray<NSString *> *CSCloseFriendVisibleAIConversations(NSDictionary *conversations, NSString *account, CSCloseFriendSnapshot *snapshot) {
    if (!CSAutomationAccountMatches(account,snapshot)) return @[];
    NSMutableArray *visible=[NSMutableArray array];
    for (NSString *identifier in [conversations.allKeys sortedArrayUsingSelector:@selector(compare:)]) {
        if ([conversations[identifier][@"enabled"] boolValue] && ![snapshot hidesUserName:identifier surface:CSCloseFriendSurfaceAIReply]) [visible addObject:identifier];
    }
    return [visible copy];
}
