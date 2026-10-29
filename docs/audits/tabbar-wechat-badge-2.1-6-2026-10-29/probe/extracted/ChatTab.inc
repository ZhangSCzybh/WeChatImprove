static BOOL ChatTab(id controller,NSUInteger index) {
    id views=CSCloseFriendRead(controller,@"viewControllers");if(![views isKindOfClass:NSArray.class] || index>=[views count])return NO;
    id root=views[index];if([root isKindOfClass:UINavigationController.class])root=[root viewControllers].firstObject;
    Class cls=NSClassFromString(@"NewMainFrameViewController");BOOL matches=cls && [root isKindOfClass:cls];
    if(matches && NSThread.isMainThread)[TabOwners addObject:controller];return matches;
}
