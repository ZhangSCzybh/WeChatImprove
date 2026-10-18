#!/bin/bash
set -euo pipefail
project_dir="$(cd "$(dirname "$0")/.." && pwd)"
test_dir="$(mktemp -d "${TMPDIR:-/tmp}/wechat-touch-trail.XXXXXX")"
trap 'rm -rf "$test_dir"' EXIT
python3 - "$project_dir" "$test_dir" <<'PY'
from pathlib import Path
import sys
root,out=map(Path,sys.argv[1:])
s=(root/'Hooks/TouchTrailHooks.xm').read_text().replace('../Controllers/','')
a=s.index('@implementation WBTouchTrailDotView');b=s.index('// 获取当前设置的触摸轨迹颜色',a)
# Only drawing/CA interpolation are doubles; execute the production settings,
# image cache, event admission, sampling, ownership and lifecycle code.
views='''@implementation WBTouchTrailView
- (void)updateWithPoint:(CGPoint)point isMoving:(BOOL)moving { (void)moving; self.frame=CGRectMake(point.x,point.y,self.trailSize,self.trailSize); }
@end
@implementation WBTouchTrailDotView
- (instancetype)initWithPoint:(CGPoint)p dotColor:(UIColor *)c borderColor:(UIColor *)b dotSize:(CGFloat)s borderWidth:(CGFloat)w hasBorder:(BOOL)h duration:(CGFloat)d {
 return [self initWithPoint:p dotColor:c borderColor:b dotSize:s borderWidth:w hasBorder:h duration:d useCustomImage:NO customImage:nil cornerRadiusRatio:1];
}
- (instancetype)initWithPoint:(CGPoint)p dotColor:(UIColor *)c borderColor:(UIColor *)b dotSize:(CGFloat)s borderWidth:(CGFloat)w hasBorder:(BOOL)h duration:(CGFloat)d useCustomImage:(BOOL)u customImage:(UIImage *)i cornerRadiusRatio:(CGFloat)r {
 return [super initWithFrame:CGRectMake(p.x,p.y,s,s)];
}
@end
'''
s=s[:a]+views+s[b:]
s=s.replace('%hook UIApplication','@implementation UIApplication (TouchTest)').replace('%orig;','nativeEvents++;').replace('%end','@end').replace('%ctor {','static void CSInstallTouchRuntime(void) {')
(out/'TouchHookUnderTest.h').write_text(s)
PY
xcrun --sdk macosx clang -fobjc-arc -fblocks -Wall -Wextra -Werror -Wno-unused-parameter -Wno-incomplete-implementation -Wno-unused-const-variable -framework Foundation -framework CoreGraphics -framework QuartzCore -I"$project_dir/Tests/TouchUIKit" -I"$project_dir/Controllers" -I"$test_dir" "$project_dir/Tests/TabBarUIKit/TabBarUIKit.m" "$project_dir/Tests/TouchTrailRuntimeTests.m" -o "$test_dir/tests"
"$test_dir/tests"
