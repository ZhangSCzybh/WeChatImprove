// Frozen from c52ccc80 for behavioral equivalence, not production code.
static NSString * const kMessageTimeShowYearKey = @"com.wechat.enhance.messageTime.showYear";
static NSString * const kMessageTimeShowMonthKey = @"com.wechat.enhance.messageTime.showMonth";
static NSString * const kMessageTimeShowDayKey = @"com.wechat.enhance.messageTime.showDay";
static NSString * const kMessageTimeShowHourKey = @"com.wechat.enhance.messageTime.showHour";
static NSString * const kMessageTimeShowMinuteKey = @"com.wechat.enhance.messageTime.showMinute";
static NSString * const kMessageTimeShowSecondKey = @"com.wechat.enhance.messageTime.showSecond";
static NSString * const kMessageTimeShowBelowAvatarKey = @"com.wechat.enhance.messageTime.showBelowAvatar";
static NSString * const kMessageTimeSingleLineKey = @"com.wechat.enhance.messageTime.singleLine";
static NSString *legacyTime(unsigned int timestamp) {
    // 处理时间戳
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    // 获取显示设置
    BOOL showYear = [defaults boolForKey:kMessageTimeShowYearKey];
    BOOL showMonth = [defaults boolForKey:kMessageTimeShowMonthKey];
    BOOL showDay = [defaults boolForKey:kMessageTimeShowDayKey];
    BOOL showHour = [defaults boolForKey:kMessageTimeShowHourKey];
    BOOL showMinute = [defaults boolForKey:kMessageTimeShowMinuteKey];
    BOOL showSecond = [defaults boolForKey:kMessageTimeShowSecondKey];

    // 如果没有任何显示选项开启，默认显示时分
    if (!showYear && !showMonth && !showDay && !showHour && !showMinute && !showSecond) {
        showHour = YES;
        showMinute = YES;
    }

    NSMutableArray *components = [NSMutableArray array];

    // 构建日期部分 - 使用短横线分隔
    NSMutableString *dateComponent = [NSMutableString string];

    // 添加年份
    if (showYear) {
        NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
        [yearFormatter setDateFormat:@"yyyy"];
        [dateComponent appendString:[yearFormatter stringFromDate:date]];
    }

    // 添加月份
    if (showMonth) {
        // 如果已经有年份，添加分隔符
        if (showYear && dateComponent.length > 0) {
            [dateComponent appendString:@"-"];
        }

        NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
        [monthFormatter setDateFormat:@"MM"];
        [dateComponent appendString:[monthFormatter stringFromDate:date]];

        // 如果还要显示日，添加分隔符
        if (showDay) {
            [dateComponent appendString:@"-"];
        }
    }

    // 添加日
    if (showDay) {
        // 如果没有月份但有年份，需要添加分隔符
        if (!showMonth && showYear && dateComponent.length > 0) {
            [dateComponent appendString:@"-"];
        }

        NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
        [dayFormatter setDateFormat:@"dd"];
        [dateComponent appendString:[dayFormatter stringFromDate:date]];
    }

    // 构建时间部分 - 使用冒号分隔
    NSMutableString *timeComponent = [NSMutableString string];

    // 添加时
    if (showHour) {
        NSDateFormatter *hourFormatter = [[NSDateFormatter alloc] init];
        [hourFormatter setDateFormat:@"HH"];
        [timeComponent appendString:[hourFormatter stringFromDate:date]];
    }

    // 添加分
    if (showMinute) {
        if (showHour && timeComponent.length > 0) {
            [timeComponent appendString:@":"];
        }

        NSDateFormatter *minuteFormatter = [[NSDateFormatter alloc] init];
        [minuteFormatter setDateFormat:@"mm"];
        [timeComponent appendString:[minuteFormatter stringFromDate:date]];
    }

    // 添加秒
    if (showSecond) {
        if ((showHour || showMinute) && timeComponent.length > 0) {
            [timeComponent appendString:@":"];
        }

        NSDateFormatter *secondFormatter = [[NSDateFormatter alloc] init];
        [secondFormatter setDateFormat:@"ss"];
        [timeComponent appendString:[secondFormatter stringFromDate:date]];
    }

    // 添加到组件列表，让日期在上，时间在下
    if (dateComponent.length > 0) {
        [components addObject:dateComponent];
    }

    if (timeComponent.length > 0) {
        [components addObject:timeComponent];
    }

    // 如果没有任何组件，显示默认时间
    if (components.count == 0) {
        NSDateFormatter *defaultFormatter = [[NSDateFormatter alloc] init];
        [defaultFormatter setDateFormat:@"HH:mm"];
        [components addObject:[defaultFormatter stringFromDate:date]];
    }

    // 根据用户设置决定使用空格还是换行符连接
    BOOL singleLine = [[NSUserDefaults standardUserDefaults] boolForKey:kMessageTimeSingleLineKey];
    NSString *separator = singleLine ? @" " : @"\n";
    return [components componentsJoinedByString:separator];
}
