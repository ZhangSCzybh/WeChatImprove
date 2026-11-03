#import "../Controllers/CSCloseFriendSocialAdapter.h"
%ctor { dispatch_async(dispatch_get_main_queue(),^{ CSCFSocialInstall(); }); }
