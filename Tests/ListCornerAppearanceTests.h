// Native callback regression: a theme change can arrive while child traits still
// describe the previous appearance, and without another cell delivery callback.
static void ListCornerPageAppearanceTests(void) {
    NSMutableDictionary *saved=FixtureDefaults.values.mutableCopy;
    Configure();
    UIColor *light=[UIColor colorWithRed:.82 green:.73 blue:.64 alpha:1];
    UIColor *dark=[UIColor colorWithRed:.13 green:.18 blue:.23 alpha:1];
    [FixtureConfiguration saveColor:light redKey:kListLightModeBgColorRedKey greenKey:kListLightModeBgColorGreenKey blueKey:kListLightModeBgColorBlueKey alphaKey:kListLightModeBgColorAlphaKey];
    [FixtureConfiguration saveColor:dark redKey:kListDarkModeBgColorRedKey greenKey:kListDarkModeBgColorGreenKey blueKey:kListDarkModeBgColorBlueKey alphaKey:kListDarkModeBgColorAlphaKey];
    light=[FixtureConfiguration.snapshot backgroundForStyle:UIUserInterfaceStyleLight];
    dark=[FixtureConfiguration.snapshot backgroundForStyle:UIUserInterfaceStyleDark];
    void (*layouts[])(id,void (^)(void))={HookContactsViewportLayout,HookDiscoverViewportLayout,HookMoreViewportLayout};
    void (*changes[])(id,void (^)(void))={HookContactsAppearanceChange,HookDiscoverAppearanceChange,HookMoreAppearanceChange};
    for (NSUInteger index=0;index<3;index++) {
        CSListCornerPage page=(CSListCornerPage)(index+1);
        UITableView *table=Table();id owner=Owner(page,table);
        table.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;
        table.contentOffset=CGPointMake(0,143);
        table.backgroundView=View(UIView.class,table.bounds);
        UITableViewCell *cell=Cell(table,0,4);
        cell.contentView.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;
        if (page==CSListCornerPageContacts) CSListCornerContactsDecorate(cell,table,cell.path,owner);
        else if (page==CSListCornerPageDiscover) CSListCornerDiscoverDecorate(cell,table,cell.path,owner);
        else CSListCornerMoreDecorate(cell,table,cell.path,owner);
        UIView *card=Background(cell);CAShapeLayer *mask=(id)card.layer.mask;
        CGPathRef path=mask.path;
        UIView *generatedFooter=nil,*cachedFooter=nil;
        if (page!=CSListCornerPageContacts) {
            generatedFooter=CSListCornerSectionView(owner,table,nil,4,page,YES);
            cachedFooter=CSListCornerSectionView(owner,table,nil,5,page,YES);
            [table addSubview:generatedFooter];
        }
        UIView *section=nil,*footer=nil;UILabel *title=nil,*count=nil;
        if (page==CSListCornerPageContacts) {
            section=View(UIView.class,CGRectMake(0,0,390,44));
            title=(id)View(UILabel.class,CGRectMake(15,0,200,44));title.text=@"☆ 星标朋友";
            [section addSubview:title];[table addSubview:section];
            CSListCornerContactsDecorateSection(section,table,owner);
            footer=View(UIView.class,CGRectMake(0,600,390,50));
            count=(id)View(UILabel.class,CGRectMake(0,0,390,50));count.text=@"236 个朋友";
            [footer addSubview:count];table.tableFooterView=footer;
            ((ContactsViewController *)owner)->m_countLabel=count;
        }
        __block NSUInteger originalCalls=0;
        NSUInteger queries=table.queries;
        table.throwsOnQuery=YES;
        for (NSNumber *value in @[@(UIUserInterfaceStyleDark),@(UIUserInterfaceStyleLight),@(UIUserInterfaceStyleDark)]) {
            UIUserInterfaceStyle style=value.integerValue;
            changes[index](owner,^{
                originalCalls++;
                table.traitCollection.userInterfaceStyle=style;
                // A new native viewport can retain yesterday's paint until our callback.
                table.backgroundView=View(UIView.class,table.bounds);
                table.backgroundView.backgroundColor=UIColor.whiteColor;
            });
            UIColor *canvas=style==UIUserInterfaceStyleDark ? UIColor.blackColor : CSListCornerCanvasColor();
            Check([table.backgroundColor isEqual:canvas] && [table.backgroundView.backgroundColor isEqual:canvas],@"all three page viewports use the native table's current appearance after backing-view replacement");
            if (generatedFooter) {
                Check([generatedFooter.backgroundColor isEqual:canvas],@"retained Discover/Me generated footer follows live theme changes without redelivery");
                Check([cachedFooter.backgroundColor isEqual:canvas] && !cachedFooter.superview,@"offscreen native-cached generated footer is repainted before later attachment");
            }
            Check([cell.contentView.backgroundColor isEqual:canvas] && [card.backgroundColor isEqual:style==UIUserInterfaceStyleDark ? dark : light],@"existing card and outer cell paint switch together while retaining custom light/dark colors");
            Check(card.layer.mask==mask && mask.path==path && Rounded(card,CGPointMake(1,1))==NO && Rounded(card,CGPointMake(1,59)),@"theme refresh preserves the already-delivered first-row rounded role and mask path");
            if (page==CSListCornerPageContacts) {
                Check([section.backgroundColor isEqual:canvas] && [footer.backgroundColor isEqual:canvas],@"retained Contacts letter/star headers and count footer follow the same theme without cell redelivery");
                Check([title.text isEqual:@"☆ 星标朋友"] && [count.text isEqual:@"236 个朋友"] && title.backgroundColor.alpha==0 && count.backgroundColor.alpha==0,@"Contacts native star/title/count content survives appearance repair");
            }
            NSUInteger reads=table.visibleCellReads;
            layouts[index](owner,^{ originalCalls++;table.backgroundView=View(UIView.class,table.bounds); });
            Check([table.backgroundView.backgroundColor isEqual:canvas] && table.visibleCellReads==reads,@"ordinary layout repairs a replacement viewport without enumerating unchanged visible cards");
            Check(table.queries==queries && table.reloads==0 && table.contentOffset.y==143 && table.layoutInvalidations==0,@"page appearance callbacks do not query rows, reload, force layout or alter scroll position");
        }
        Check(originalCalls==6,@"page theme and layout callbacks each preserve one original native invocation");
        [FixtureConfiguration saveEnabled:NO];
        table.backgroundColor=UIColor.whiteColor;table.backgroundView.backgroundColor=UIColor.whiteColor;
        card.backgroundColor=UIColor.whiteColor;cell.contentView.backgroundColor=UIColor.whiteColor;
        if (generatedFooter) generatedFooter.backgroundColor=UIColor.whiteColor;
        if (section) section.backgroundColor=UIColor.whiteColor;
        if (footer) footer.backgroundColor=UIColor.whiteColor;
        changes[index](owner,^{table.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;});
        layouts[index](owner,^{});
        Check([table.backgroundColor isEqual:UIColor.whiteColor] && [table.backgroundView.backgroundColor isEqual:UIColor.whiteColor] && [card.backgroundColor isEqual:UIColor.whiteColor],@"disabled list rounding leaves native page, backing and card paint untouched");
        Check((!section || [section.backgroundColor isEqual:UIColor.whiteColor]) && (!footer || [footer.backgroundColor isEqual:UIColor.whiteColor]),@"disabled Contacts appearance preserves native section/count surfaces");
        if (generatedFooter) Check([generatedFooter.backgroundColor isEqual:UIColor.whiteColor],@"disabled layout and appearance callbacks leave generated footer paint untouched");
        Configure();
        // A page with no cells must still adapt its full-height background.
        UITableView *empty=Table();id emptyOwner=Owner(page,empty);empty.rows=@[];empty.throwsOnQuery=YES;
        changes[index](emptyOwner,^{empty.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;});
        Check([empty.backgroundColor isEqual:UIColor.blackColor] && !empty.backgroundView && empty.queries==0 && empty.reloads==0,@"empty native page changes appearance without creating a background container or querying its model");
    }
    // The profile header keeps native BG_2 colors separately for each appearance.
    UITableView *more=Table();id owner=Owner(CSListCornerPageMore,more);
    more.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;
    UIView *header=View(MMUIButton.class,CGRectMake(0,0,390,200));
    more.tableHeaderView=header;[more addSubview:header];
    UIColor *nativeLight=[UIColor colorWithRed:.95 green:.94 blue:.93 alpha:1];
    header.backgroundColor=nativeLight;CSListCornerMoreDecorateHeader(header);
    UIView *headerCard=CSListCornerOwnedBackground(header);
    HookMoreAppearanceChange(owner,^{more.traitCollection.userInterfaceStyle=UIUserInterfaceStyleDark;});
    Check([headerCard.backgroundColor isEqual:dark],@"profile header never reuses fixed native light paint before dark backing is delivered");
    UIColor *nativeDark=[UIColor colorWithRed:.07 green:.08 blue:.09 alpha:1];
    header.backgroundColor=nativeDark;CSListCornerMoreDecorateHeader(header);
    Check([headerCard.backgroundColor isEqual:nativeDark],@"late native dark profile paint replaces the temporary appearance fallback");
    HookMoreAppearanceChange(owner,^{more.traitCollection.userInterfaceStyle=UIUserInterfaceStyleLight;});
    Check([headerCard.backgroundColor isEqual:nativeLight],@"returning profile appearance restores its matching native background rather than opposite-theme cached paint");
    FixtureDefaults.values=saved;[FixtureConfiguration invalidate];
}
