_runtime.resetStorage=^BOOL(NSString *account,BOOL begin,NSError **error){
            return begin ? [reset beginResetForAccountID:account error:error] : [reset resumeResetForAccountID:account error:error];
        };
