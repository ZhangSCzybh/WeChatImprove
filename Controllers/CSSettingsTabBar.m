#import "CSSettingsTabBar.h"
#import "CSSettingsHomeTheme.h"

@interface CSSettingsTabBar () <UITextFieldDelegate>
@property(nonatomic, strong) UIView *railView;
@property(nonatomic, strong) UIView *selectionView;
@property(nonatomic, strong) NSArray<UIButton *> *tabButtons;
@property(nonatomic, strong) UITextField *searchField;
@property(nonatomic, strong) UIButton *searchButton;
@property(nonatomic, readwrite, getter=isSearching) BOOL searching;
@property(nonatomic) NSUInteger searchTransitionGeneration;
@end

@implementation CSSettingsTabBar
- (instancetype)initWithFrame:(CGRect)frame {
    if ((self=[super initWithFrame:frame])) {
        _horizontalInset=20;
        self.backgroundColor=UIColor.systemGroupedBackgroundColor;
        _railView=[UIView new];
        _railView.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
        _railView.layer.cornerRadius=27;
        [self addSubview:_railView];

        _selectionView=[UIView new];
        _selectionView.backgroundColor=CSSettingsHomeTheme.accentColor;
        _selectionView.layer.cornerRadius=23;
        [_railView addSubview:_selectionView];

        NSMutableArray *buttons=[NSMutableArray array];
        NSArray *titles=@[@"账号",@"美化",@"增强",@"设置"];
        for (NSUInteger index=0;index<titles.count;index++) {
            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
            button.tag=index;
            [button setTitle:titles[index] forState:UIControlStateNormal];
            button.titleLabel.font=[[UIFontMetrics metricsForTextStyle:UIFontTextStyleSubheadline]
                scaledFontForFont:[UIFont systemFontOfSize:14.5 weight:UIFontWeightSemibold] maximumPointSize:17];
            button.titleLabel.adjustsFontSizeToFitWidth=YES;
            button.titleLabel.minimumScaleFactor=0.85;
            button.titleLabel.lineBreakMode=NSLineBreakByClipping;
            [button setTitleColor:UIColor.secondaryLabelColor forState:UIControlStateNormal];
            [button setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
            [button addTarget:self action:@selector(selectTab:) forControlEvents:UIControlEventTouchUpInside];
            button.accessibilityLabel=titles[index];
            [_railView addSubview:button];
            [buttons addObject:button];
        }
        _tabButtons=buttons;

        _searchField=[UITextField new];
        _searchField.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
        _searchField.layer.cornerRadius=27;
        _searchField.font=[UIFont systemFontOfSize:16];
        _searchField.textColor=UIColor.labelColor;
        _searchField.tintColor=_selectionView.backgroundColor;
        _searchField.placeholder=@"搜索功能";
        _searchField.accessibilityLabel=@"搜索全部功能";
        _searchField.returnKeyType=UIReturnKeySearch;
        _searchField.clearButtonMode=UITextFieldViewModeWhileEditing;
        _searchField.autocorrectionType=UITextAutocorrectionTypeNo;
        _searchField.autocapitalizationType=UITextAutocapitalizationTypeNone;
        _searchField.delegate=self;
        UIView *leading=[[UIView alloc] initWithFrame:CGRectMake(0,0,40,54)];
        UIImageView *searchIcon=[[UIImageView alloc] initWithImage:[UIImage systemImageNamed:@"magnifyingglass"]];
        searchIcon.frame=CGRectMake(16,18,18,18);
        searchIcon.tintColor=UIColor.secondaryLabelColor;
        searchIcon.contentMode=UIViewContentModeScaleAspectFit;
        [leading addSubview:searchIcon];
        _searchField.leftView=leading;
        _searchField.leftViewMode=UITextFieldViewModeAlways;
        _searchField.hidden=YES;
        _searchField.alpha=0;
        [_searchField addTarget:self action:@selector(searchTextChanged:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_searchField];

        _searchButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _searchButton.backgroundColor=UIColor.secondarySystemGroupedBackgroundColor;
        _searchButton.layer.cornerRadius=27;
        _searchButton.tintColor=UIColor.labelColor;
        [_searchButton addTarget:self action:@selector(toggleSearch) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_searchButton];
        [self updateButtonStates];
        [self reloadTheme];
    }
    return self;
}
- (void)reloadTheme {
    UIColor *accent=CSSettingsHomeTheme.accentColor;
    self.selectionView.backgroundColor=accent;
    self.searchField.tintColor=accent;
    self.searchButton.tintColor=accent;
    for (UIButton *button in self.tabButtons) {
        [button setTitleColor:UIColor.whiteColor forState:UIControlStateSelected];
    }
}
- (CGSize)intrinsicContentSize {
    return CGSizeMake(UIViewNoIntrinsicMetric,76);
}
- (void)setHorizontalInset:(CGFloat)horizontalInset {
    _horizontalInset=MAX(0,horizontalInset);
    [self setNeedsLayout];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width=CGRectGetWidth(self.bounds);
    CGFloat inset=MIN(self.horizontalInset,MAX(0,(width-128)/2));
    CGFloat railWidth=MAX(0,width-2*inset-64);
    CGFloat y=MAX(0,(CGRectGetHeight(self.bounds)-54)/2);
    self.railView.frame=CGRectMake(inset,y,railWidth,54);
    self.searchField.frame=self.railView.frame;
    self.searchButton.frame=CGRectMake(width-inset-54,y,54,54);
    CGFloat segmentWidth=MAX(0,railWidth-8)/4;
    for (NSUInteger index=0;index<self.tabButtons.count;index++) {
        self.tabButtons[index].frame=CGRectMake(4+index*segmentWidth,4,segmentWidth,46);
    }
    self.selectionView.frame=CGRectMake(4+self.selectedIndex*segmentWidth,4,segmentWidth,46);
}
- (void)updateButtonStates {
    for (NSUInteger index=0;index<self.tabButtons.count;index++) {
        UIButton *button=self.tabButtons[index];
        button.selected=index==self.selectedIndex;
        button.accessibilityTraits=UIAccessibilityTraitButton | (button.selected ? UIAccessibilityTraitSelected : 0);
    }
    [self.searchButton setImage:[UIImage systemImageNamed:self.searching ? @"xmark" : @"magnifyingglass"
        withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:19 weight:UIImageSymbolWeightMedium]]
        forState:UIControlStateNormal];
    self.searchButton.accessibilityLabel=self.searching ? @"取消搜索" : @"搜索功能";
    self.railView.accessibilityElementsHidden=self.searching;
    self.searchField.accessibilityElementsHidden=!self.searching;
}
- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    [self setSelectedIndex:selectedIndex animated:NO];
}
- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated {
    [self layoutIfNeeded];
    _selectedIndex=MIN(index,(NSUInteger)3);
    [self updateButtonStates];
    [self setNeedsLayout];
    if (animated && !UIAccessibilityIsReduceMotionEnabled()) {
        [UIView animateWithDuration:0.24 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut
            animations:^{ [self layoutIfNeeded]; } completion:nil];
    } else {
        [self layoutIfNeeded];
    }
}
- (void)selectTab:(UIButton *)button {
    if (self.searching || self.selectedIndex==(NSUInteger)button.tag) return;
    [self setSelectedIndex:(NSUInteger)button.tag animated:YES];
    if (self.selectionChanged) self.selectionChanged(self.selectedIndex);
}
- (void)toggleSearch {
    [self setSearching:!self.searching animated:YES];
}
- (void)cancelSearchAnimations {
    [self.railView.layer removeAllAnimations];
    [self.searchField.layer removeAllAnimations];
    [self.selectionView.layer removeAllAnimations];
    for (UIButton *button in self.tabButtons) [button.layer removeAllAnimations];
}
- (void)setSearching:(BOOL)searching animated:(BOOL)animated {
    if (_searching==searching) return;
    NSUInteger generation=++self.searchTransitionGeneration;
    _searching=searching;
    [self cancelSearchAnimations];
    if (searching) {
        if (self.searchOpened) self.searchOpened();
        // The controller may reset transient UI after observing an account change.
        if (_searching!=searching || generation!=self.searchTransitionGeneration) return;
    } else {
        [self.searchField resignFirstResponder];
        self.searchField.text=@"";
    }
    [self updateButtonStates];
    NSTimeInterval duration=animated ? (UIAccessibilityIsReduceMotionEnabled() ? 0.1 : 0.18) : 0;
    UIView *incoming=searching ? self.searchField : self.railView;
    // Retire the old layer immediately. Cross-fading labels over the text field
    // leaves a second visible control, especially if the user cancels mid-flight.
    [UIView performWithoutAnimation:^{
        self.railView.hidden=searching;
        self.searchField.hidden=!searching;
        self.railView.alpha=searching ? 0 : 1;
        self.searchField.alpha=searching ? 1 : 0;
        self.railView.userInteractionEnabled=!searching;
        self.searchField.userInteractionEnabled=searching;
        [self setNeedsLayout];
        [self layoutIfNeeded];
        incoming.alpha=duration>0 ? 0 : 1;
    }];
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut
        animations:^{ incoming.alpha=1; } completion:^(__unused BOOL finished) {
            if (generation!=self.searchTransitionGeneration || self.searching!=searching) return;
            self.railView.hidden=searching;
            self.searchField.hidden=!searching;
            self.railView.alpha=searching ? 0 : 1;
            self.searchField.alpha=searching ? 1 : 0;
        }];
    if (searching) [self.searchField becomeFirstResponder];
    else if (self.searchClosed) self.searchClosed();
}
- (void)resetSearch {
    self.searchTransitionGeneration++;
    _searching=NO;
    [self.searchField resignFirstResponder];
    self.searchField.text=@"";
    [self cancelSearchAnimations];
    self.railView.hidden=NO;
    self.railView.alpha=1;
    self.railView.userInteractionEnabled=YES;
    self.searchField.hidden=YES;
    self.searchField.alpha=0;
    self.searchField.userInteractionEnabled=NO;
    [self updateButtonStates];
}
- (void)searchTextChanged:(UITextField *)field {
    if (self.searching && self.queryChanged) self.queryChanged(field.text ?: @"");
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
