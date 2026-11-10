#import <Foundation/Foundation.h>
#import "CSClownSession.h"
#include <stdlib.h>

static NSUInteger checks;
#define CHECK(...) do { checks++; if (!(__VA_ARGS__)) { fprintf(stderr,"FAIL line %d: %s\n",__LINE__,#__VA_ARGS__); exit(1); } } while (0)

@interface ClownTestWrap : NSObject
@property(nonatomic, copy) NSString *m_nsFromUsr;
@property(nonatomic, copy) NSString *m_nsToUsr;
@property(nonatomic) unsigned int m_uiMesLocalID;
@property(nonatomic) long long m_n64MesSvrID;
@property(nonatomic) unsigned int m_uiMessageType;
@property(nonatomic, copy) NSString *m_nsContent;
@property(nonatomic) unsigned int m_uiCreateTime;
@property(nonatomic, copy) NSData *m_dtImg;
@end
@implementation ClownTestWrap @end
@interface ClownTestCell : NSObject
@property(nonatomic, strong) ClownTestWrap *wrap;
@end
@implementation ClownTestCell
- (id)getCurrentMessageWrap { return _wrap; }
@end
@interface ClownEqualTimeNode : NSObject
@property(nonatomic, copy) NSString *timeText;
@property(nonatomic) NSTimeInterval showingTime;
@end
@implementation ClownEqualTimeNode
- (BOOL)isEqual:(id)object { return [object isKindOfClass:ClownEqualTimeNode.class]; }
- (NSUInteger)hash { return 1; }
@end

static ClownTestCell *Cell(NSString *account, NSString *chat, unsigned int local, long long server, NSUInteger type) {
    ClownTestWrap *wrap=[ClownTestWrap new]; wrap.m_nsFromUsr=account; wrap.m_nsToUsr=chat;
    wrap.m_uiMesLocalID=local; wrap.m_n64MesSvrID=server; wrap.m_uiMessageType=(unsigned int)type;
    wrap.m_nsContent=@"original content"; wrap.m_uiCreateTime=1700000000;
    wrap.m_dtImg=[@"original image data" dataUsingEncoding:NSUTF8StringEncoding];
    ClownTestCell *cell=[ClownTestCell new]; cell.wrap=wrap; return cell;
}
static CSMessageActionContext *Context(ClownTestCell *cell, NSString *account, NSUInteger accountEpoch, NSUInteger generation) {
    return [CSMessageActionContext contextWithCell:cell controller:nil accountID:account accountEpoch:accountEpoch
        conversationID:nil bindingGeneration:generation];
}
static CSClownSession *Session(void) { return [[CSClownSession alloc] initWithAccountID:@"me" conversationID:@"chat"]; }

static void TestIsolationAndOriginals(void) {
    CSClownSession *session=Session(); CHECK(session.active && session.epoch==1);
    CHECK([session.accountID isEqual:@"me"] && [session.conversationID isEqual:@"chat"]);
    ClownTestCell *first=Cell(@"me",@"chat",10,100,1), *second=Cell(@"me",@"chat",11,101,1);
    ClownTestCell *picture=Cell(@"me",@"chat",12,102,3);
    CSMessageActionContext *a=Context(first,@"me",7,1), *b=Context(second,@"me",7,1), *c=Context(picture,@"me",7,1);
    CHECK(a && b && c && [session acceptsContext:a]);
    NSString *originalText=first.wrap.m_nsContent; NSData *originalImage=picture.wrap.m_dtImg;
    unsigned int originalTimestamp=first.wrap.m_uiCreateTime;
    NSMutableString *edited=[NSMutableString stringWithString:@"temporary text"];
    CHECK([session setText:edited forContext:a]); [edited appendString:@" changed after storage"];
    CHECK([[session textForContext:a] isEqual:@"temporary text"]);
    CHECK([session setText:@"second message" forContext:b]);
    CHECK([[session textForContext:b] isEqual:@"second message"]);
    NSObject *image=[NSObject new]; CHECK([session setImage:image forContext:c]); CHECK([session imageForContext:c]==image);
    CHECK([session imageForContext:a]==nil && [session textForContext:c]==nil);
    CHECK(first.wrap.m_nsContent==originalText && first.wrap.m_uiCreateTime==originalTimestamp);
    CHECK(picture.wrap.m_dtImg==originalImage && [picture.wrap.m_nsContent isEqual:@"original content"]);
    CHECK([session setText:@"" forContext:a]); CHECK([[session textForContext:a] isEqual:@""]);
    CHECK([session setText:nil forContext:a]); CHECK([session textForContext:a]==nil);
    CHECK([[session textForContext:b] isEqual:@"second message"] && [session imageForContext:c]==image);

    CSMessageActionContext *otherChat=Context(Cell(@"me",@"other",10,100,1),@"me",7,1);
    CSMessageActionContext *otherAccount=Context(Cell(@"someone",@"chat",10,100,1),@"someone",7,1);
    CHECK(![session acceptsContext:otherChat] && ![session acceptsContext:otherAccount] && ![session acceptsContext:nil]);
    for (CSMessageActionContext *wrong in @[otherChat,otherAccount]) {
        CHECK(![session setText:@"wrong" forContext:wrong]); CHECK(![session setImage:image forContext:wrong]);
        CHECK([session textForContext:wrong]==nil && [session imageForContext:wrong]==nil);
    }
    CHECK([session textForContext:Context(second,@"me",8,1)]==nil);
    CSClownSession *differentPage=Session(); CHECK([differentPage textForContext:b]==nil);
    CHECK([differentPage setText:@"other page" forContext:b]);
    CHECK([[session textForContext:b] isEqual:@"second message"]);
    CHECK([[differentPage textForContext:b] isEqual:@"other page"]);
}

static void TestIdentityEvolutionAndReuse(void) {
    CSClownSession *session=Session(); ClownTestCell *cell=Cell(@"me",@"chat",20,0,1);
    CSMessageActionContext *local=Context(cell,@"me",7,1);
    CHECK([session setText:@"evolving" forContext:local]);
    cell.wrap.m_n64MesSvrID=200;
    CSMessageActionContext *promoted=Context(cell,@"me",7,1);
    CHECK([[session textForContext:promoted] isEqual:@"evolving"]);
    cell.wrap.m_uiMesLocalID=0;
    CHECK([[session textForContext:Context(cell,@"me",7,1)] isEqual:@"evolving"]);
    CHECK([[session textForContext:local] isEqual:@"evolving"]);
    // Looking up a local-only snapshot cannot discard the learned server ID.
    CSMessageActionContext *conflict=Context(Cell(@"me",@"chat",20,201,1),@"me",7,1);
    CHECK([session textForContext:conflict]==nil);
    CHECK(![session setText:@"wrong message" forContext:conflict]);
    CHECK(![session setImage:[NSObject new] forContext:conflict]);
    CHECK([[session textForContext:promoted] isEqual:@"evolving"]);
    // Rebinding the same cell does not transfer the replacement to its new message.
    cell.wrap=Cell(@"me",@"chat",21,202,1).wrap;
    CHECK([session textForContext:Context(cell,@"me",7,2)]==nil);

    ClownTestCell *withoutID=Cell(@"me",@"chat",0,0,1);
    CSMessageActionContext *bound=Context(withoutID,@"me",7,4);
    CHECK([session setText:@"bound only" forContext:bound]);
    CHECK([[session textForContext:Context(withoutID,@"me",7,4)] isEqual:@"bound only"]);
    CHECK([session textForContext:Context(withoutID,@"me",7,5)]==nil);
    CHECK([session textForContext:Context(Cell(@"me",@"chat",0,0,1),@"me",7,4)]==nil);
}

static void TestTimeIdentityAndLifetime(void) {
    CSClownSession *session=Session();
    ClownEqualTimeNode *one=[ClownEqualTimeNode new], *two=[ClownEqualTimeNode new];
    one.timeText=@"native time"; one.showingTime=1700000000;
    NSDate *first=[NSDate dateWithTimeIntervalSince1970:100], *second=[NSDate dateWithTimeIntervalSince1970:200];
    CHECK([one isEqual:two]); CHECK([session setDate:first forTimeModel:one]); CHECK([session setDate:second forTimeModel:two]);
    CHECK([[session dateForTimeModel:one] isEqual:first] && [[session dateForTimeModel:two] isEqual:second]);
    CHECK([one.timeText isEqual:@"native time"] && one.showingTime==1700000000);
    CHECK([session setDate:nil forTimeModel:one]); CHECK([session dateForTimeModel:one]==nil);
    CHECK([[session dateForTimeModel:two] isEqual:second]);
    CHECK(![session setDate:first forTimeModel:nil] && [session dateForTimeModel:nil]==nil);
    __weak id weakTime;
    @autoreleasepool {
        NSObject *temporary=[NSObject new]; weakTime=temporary;
        CHECK([session setDate:first forTimeModel:temporary]);
        CHECK([[session dateForTimeModel:temporary] isEqual:first]);
    }
    CHECK(weakTime==nil);
}

static void TestClearingAndEpochs(void) {
    CSClownSession *session=Session();
    CSMessageActionContext *context=Context(Cell(@"me",@"chat",30,300,1),@"me",7,1);
    NSObject *time=[NSObject new]; NSDate *date=[NSDate dateWithTimeIntervalSince1970:200];
    __weak id weakImage;
    NSUInteger oldEpoch=session.epoch;
    @autoreleasepool {
        NSObject *image=[NSObject new]; weakImage=image;
        CHECK([session setImage:image forContext:context]);
        CHECK([session setText:@"temporary" forContext:context]); CHECK([session setDate:date forTimeModel:time]);
    }
    @autoreleasepool {
        CHECK(weakImage!=nil); oldEpoch=session.epoch; [session clearText];
        CHECK(session.active && session.epoch==oldEpoch+1 && [session textForContext:context]==nil);
        CHECK([session imageForContext:context]==weakImage && [[session dateForTimeModel:time] isEqual:date]);
        oldEpoch=session.epoch; [session clearImages];
        CHECK(session.active && session.epoch==oldEpoch+1 && [session imageForContext:context]==nil);
    }
    CHECK(weakImage==nil);
    CHECK([[session dateForTimeModel:time] isEqual:date]);
    CHECK([session setText:@"restored edit" forContext:context]);
    oldEpoch=session.epoch; [session clearTimes];
    CHECK(session.active && session.epoch==oldEpoch+1 && [session dateForTimeModel:time]==nil);
    CHECK([[session textForContext:context] isEqual:@"restored edit"]);
    CHECK([session setImage:[NSObject new] forContext:context]); CHECK([session setDate:date forTimeModel:time]);
    oldEpoch=session.epoch; [session invalidate];
    CHECK(!session.active && session.epoch==oldEpoch+1 && ![session acceptsContext:context]);
    CHECK([session textForContext:context]==nil && [session imageForContext:context]==nil && [session dateForTimeModel:time]==nil);
    CHECK(![session setText:@"late text callback" forContext:context]);
    CHECK(![session setImage:[NSObject new] forContext:context] && ![session setDate:date forTimeModel:time]);
    oldEpoch=session.epoch; [session invalidate]; CHECK(!session.active && session.epoch==oldEpoch+1);
    CSClownSession *reentered=Session();
    CHECK(reentered.active && [reentered textForContext:context]==nil && [reentered dateForTimeModel:time]==nil);
}

static void TestInvalidInputAndThread(void) {
    CHECK([[CSClownSession alloc] initWithAccountID:@"" conversationID:@"chat"]==nil);
    CHECK([[CSClownSession alloc] initWithAccountID:@"me" conversationID:@""]==nil);
    CSClownSession *session=Session(); CSMessageActionContext *context=Context(Cell(@"me",@"chat",40,400,1),@"me",7,1);
    CHECK(![session setText:@"wrong" forContext:nil] && ![session setImage:[NSObject new] forContext:nil]);
    CHECK(![session setAmount:@"1.00" forContext:nil] && [session amountForContext:nil]==nil);
    CHECK([session textForContext:nil]==nil && [session imageForContext:nil]==nil);
    CHECK([session setText:@"main thread" forContext:context]); NSUInteger epoch=session.epoch;
    NSObject *time=[NSObject new]; NSDate *date=[NSDate dateWithTimeIntervalSince1970:200];
    __block BOOL accepted=YES, wrote=YES, wroteTime=YES, wroteAmount=YES; __block NSString *read=@"unexpected";
    dispatch_group_t group=dispatch_group_create();
    dispatch_group_async(group,dispatch_get_global_queue(QOS_CLASS_USER_INITIATED,0),^{
        accepted=[session acceptsContext:context]; wrote=[session setText:@"background" forContext:context];
        wroteTime=[session setDate:date forTimeModel:time]; wroteAmount=[session setAmount:@"1.00" forContext:context];
        read=[session textForContext:context]; [session clearAmounts]; [session invalidate];
    });
    dispatch_group_wait(group,DISPATCH_TIME_FOREVER);
    CHECK(!accepted && !wrote && !wroteTime && !wroteAmount && read==nil);
    CHECK(session.active && session.epoch==epoch && [[session textForContext:context] isEqual:@"main thread"]);
}

static void TestAmountIsolationAndClearing(void) {
    CSClownSession *session=Session(); ClownTestCell *cell=Cell(@"me",@"chat",50,500,49);
    cell.wrap.m_nsContent=@"<msg><appmsg><type>2000</type><wcpayinfo><feedesc>¥1.00</feedesc><total_fee>100</total_fee></wcpayinfo></appmsg></msg>";
    NSString *originalXML=cell.wrap.m_nsContent; NSData *originalImage=cell.wrap.m_dtImg;
    CSMessageActionContext *context=Context(cell,@"me",7,1);
    CSMessageActionContext *second=Context(Cell(@"me",@"chat",51,501,49),@"me",7,1);
    NSMutableString *display=[NSMutableString stringWithString:@"¥123,456.00"];
    CHECK([session setAmount:display forContext:context]); [display appendString:@" changed"];
    CHECK([[session amountForContext:context] isEqual:@"¥123,456.00"]);
    CHECK([session setAmount:@"USD 10.25" forContext:second]);
    CHECK([[session amountForContext:second] isEqual:@"USD 10.25"]);
    CHECK([session textForContext:context]==nil && [session imageForContext:context]==nil);
    CHECK(cell.wrap.m_nsContent==originalXML && cell.wrap.m_dtImg==originalImage && cell.wrap.m_uiCreateTime==1700000000);
    NSObject *image=[NSObject new], *time=[NSObject new]; NSDate *date=[NSDate dateWithTimeIntervalSince1970:100];
    CHECK([session setText:@"independent text" forContext:context] && [session setImage:image forContext:context]);
    CHECK([session setDate:date forTimeModel:time]);
    CHECK([session setAmount:nil forContext:context] && [session amountForContext:context]==nil);
    CHECK([[session amountForContext:second] isEqual:@"USD 10.25"]);
    CHECK([[session textForContext:context] isEqual:@"independent text"] && [session imageForContext:context]==image);
    CHECK([session setAmount:@"20.00" forContext:context]);
    NSUInteger epoch=session.epoch; [session clearAmounts];
    CHECK(session.active && session.epoch==epoch+1 && [session amountForContext:context]==nil && [session amountForContext:second]==nil);
    CHECK([[session textForContext:context] isEqual:@"independent text"] && [session imageForContext:context]==image);
    CHECK([[session dateForTimeModel:time] isEqual:date]);
    CHECK([session setAmount:@"30.00" forContext:context]);
    epoch=session.epoch; [session clearText]; CHECK(session.epoch==epoch+1 && [[session amountForContext:context] isEqual:@"30.00"]);
    epoch=session.epoch; [session clearImages]; CHECK(session.epoch==epoch+1 && [[session amountForContext:context] isEqual:@"30.00"]);
    epoch=session.epoch; [session clearTimes]; CHECK(session.epoch==epoch+1 && [[session amountForContext:context] isEqual:@"30.00"]);

    for (CSMessageActionContext *wrong in @[
        Context(Cell(@"me",@"another",50,500,49),@"me",7,1),
        Context(Cell(@"someone",@"chat",50,500,49),@"someone",7,1)]) {
        CHECK(![session setAmount:@"wrong" forContext:wrong]); CHECK([session amountForContext:wrong]==nil);
    }
    CHECK([session amountForContext:Context(cell,@"me",8,1)]==nil);
    CHECK(cell.wrap.m_nsContent==originalXML && cell.wrap.m_dtImg==originalImage && cell.wrap.m_uiCreateTime==1700000000);
    epoch=session.epoch; [session invalidate];
    CHECK(!session.active && session.epoch==epoch+1 && [session amountForContext:context]==nil);
    CHECK(![session setAmount:@"late amount callback" forContext:context]);
    CHECK([Session() amountForContext:context]==nil);
}

static void TestAmountIdentityEvolution(void) {
    CSClownSession *session=Session(); ClownTestCell *cell=Cell(@"me",@"chat",60,0,49);
    CSMessageActionContext *local=Context(cell,@"me",7,1);
    CHECK([session setAmount:@"60.00" forContext:local]);
    cell.wrap.m_n64MesSvrID=600; CSMessageActionContext *promoted=Context(cell,@"me",7,1);
    CHECK([[session amountForContext:promoted] isEqual:@"60.00"]);
    cell.wrap.m_uiMesLocalID=0;
    CHECK([[session amountForContext:Context(cell,@"me",7,1)] isEqual:@"60.00"]);
    CHECK([[session amountForContext:local] isEqual:@"60.00"]);
    CSMessageActionContext *conflict=Context(Cell(@"me",@"chat",60,601,49),@"me",7,1);
    CHECK([session amountForContext:conflict]==nil && ![session setAmount:@"wrong" forContext:conflict]);
    CHECK([[session amountForContext:promoted] isEqual:@"60.00"]);
    cell.wrap=Cell(@"me",@"chat",61,602,49).wrap;
    CHECK([session amountForContext:Context(cell,@"me",7,2)]==nil);
    ClownTestCell *withoutID=Cell(@"me",@"chat",0,0,49);
    CHECK([session setAmount:@"bound amount" forContext:Context(withoutID,@"me",7,4)]);
    CHECK([[session amountForContext:Context(withoutID,@"me",7,4)] isEqual:@"bound amount"]);
    CHECK([session amountForContext:Context(withoutID,@"me",7,5)]==nil);
}

int main(void) {
    @autoreleasepool {
        TestIsolationAndOriginals(); TestIdentityEvolutionAndReuse(); TestTimeIdentityAndLifetime();
        TestClearingAndEpochs(); TestInvalidInputAndThread(); TestAmountIsolationAndClearing(); TestAmountIdentityEvolution();
        printf("Clown session tests passed (%lu checks).\n",(unsigned long)checks);
    }
    return 0;
}
