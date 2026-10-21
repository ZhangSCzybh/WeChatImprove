"""Recheck screenshot-style stale rows using the shipped hooks, without modifying source."""
from pathlib import Path
import shlex
import subprocess

root = Path(__file__).resolve().parents[3]
runner = (root / 'Tests/verify-close-friend-contacts.sh').read_text()
runner = runner.replace('cd "$(dirname "$0")/.."', 'cd ' + shlex.quote(str(root)), 1)
# The normal runner already extracts and compiles production adapter / hook bodies.
# Copy only its fixture translation unit into the same disposable test directory.
extra = '''
fixture=Path('Tests/CloseFriendSearchInputFixture.h').read_text()
marker='    [NSRunLoop.currentRunLoop runUntilDate:'
case=r\'''    // A previous search can return after typing was withheld. Include both
    // plugin gate rows and native web/suggestion rows in that late response.
    TypeSearch(page,@"65");
    presenter.results=@[@"解锁后查看",@"解锁后查看",@"搜索网络结果",@"65",@"65路公交"];
    page.sectionData=presenter.results;page.tableView.tableFooterView=@"搜索网络结果";
    NSUInteger footerReads=page.footerReads,loadingStarts=page.loadingStarts;
    NSArray *lateRows=[page objectsForListAdapter:nil];
    [page updateFooterView];[page setLoadingStatus];
    Check(!lateRows.count && !page.sectionData.count && !page.tableView.tableFooterView && page.emptyPresentation,
          @"late locked placeholders, web entry and suggestions cannot reappear while typing");
    Check(!presenter.queries.count && !presenter.history.count && !presenter.delayedSearches &&
          page.footerReads==footerReads && page.loadingStarts==loadingStarts && [[page searchBarText] isEqual:@"65"],
          @"two-character input stays visible without querying, history, footer reads or loading");
    printf("Screenshot regression: late unlock placeholders, web entry and native suggestions remain absent while typing\\n");
\'''
assert marker in fixture
(out/'CloseFriendSearchInputFixture.h').write_text(fixture.replace(marker,case+marker,1))
(out/'CloseFriendContactTests.m').write_text(Path('Tests/CloseFriendContactTests.m').read_text())
'''
runner = runner.replace('\nPY\nxcrun', '\n' + extra + '\nPY\nxcrun', 1)
runner = runner.replace(' Tests/CloseFriendContactTests.m ', ' "$work/CloseFriendContactTests.m" ')
result = subprocess.run(['bash'], input=runner, cwd=root, text=True)
raise SystemExit(result.returncode)
