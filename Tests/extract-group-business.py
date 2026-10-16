"""Use production cell delivery and path mapping with a small native host fixture."""
from pathlib import Path
import sys
root=Path(__file__).resolve().parent.parent
source=(Path(sys.argv[2]) if len(sys.argv)>2 else root/'Controllers/CSGroupListAdapter.m').read_text()
methods=[]
for marker in ['static id ObjectArgument(', '- (BOOL)accountMatches', '- (NSIndexPath *)currentPathForRow:', '- (NSIndexPath *)displayPath:', '- (UITableViewCell *)cellForDisplayPath:(NSIndexPath *)path target:(id)target {']:
    start=source.index(marker);brace=source.index('{',start);depth=0
    for end in range(brace,len(source)):
        if source[end]=='{':depth+=1
        elif source[end]=='}':
            depth-=1
            if not depth:
                methods.append(source[start:end+1]);break
out=Path(sys.argv[1]);out.mkdir(exist_ok=True)
(out/'GroupBusinessHelper.h').write_text(methods[0]+'\n')
(out/'GroupBusinessBodies.h').write_text('\n'.join(methods[1:])+'\n')
