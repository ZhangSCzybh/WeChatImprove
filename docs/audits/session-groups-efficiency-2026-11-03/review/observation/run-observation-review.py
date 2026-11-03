#!/usr/bin/env python3
"""Run real observation scope C functions and unchanged extracted owner gates.

The UIKit substitutes only provide runtime method/ownership identities. This
does not validate a live WeChat reload dispatch, signpost capture or device FPS.
"""
import hashlib
import json
import pathlib
import subprocess

HERE=pathlib.Path(__file__).resolve().parent
ROOT=HERE.parents[4]
INPUTS=HERE/'inputs'
INPUTS.mkdir(exist_ok=True)
relative=['Controllers/CSGroupPerformanceObservation.h','Controllers/CSGroupPerformanceObservation.m','Hooks/SessionGroupPerformanceObservation.xm','Controllers/CSGroupRefreshState.h']
hashes={}
for name in relative:
    data=(ROOT/name).read_bytes()
    hashes[name]=hashlib.sha256(data).hexdigest()
    (INPUTS/pathlib.Path(name).name).write_bytes(data)
hooks=(INPUTS/'SessionGroupPerformanceObservation.xm').read_text()
begin=hooks.index('static NSUInteger CSGroupPerformanceAdapterRoute(')
end=hooks.index('%group CSGroupPerformanceObservationHooks',begin)
fixture=(HERE/'fixture-prefix.h').read_text()+hooks[begin:end]+(HERE/'fixture-tests.m').read_text()
(HERE/'extracted-owner-fixture.m').write_text(fixture)
command=['xcrun','--sdk','macosx','clang','-DCS_GROUP_PERFORMANCE_OBSERVATION=1','-fobjc-arc','-fblocks','-Wall','-Wextra','-Werror','-framework','Foundation','-I'+str(HERE),'-I'+str(INPUTS),str(INPUTS/'CSGroupPerformanceObservation.m'),str(HERE/'extracted-owner-fixture.m'),'-o',str(HERE/'observation-fixture')]
build=subprocess.run(command,text=True,capture_output=True)
(HERE/'compile.log').write_text(build.stdout+build.stderr)
if build.returncode: raise SystemExit(build.stderr)
run=subprocess.run([str(HERE/'observation-fixture')],text=True,capture_output=True)
(HERE/'run.log').write_text(run.stdout+run.stderr)
result={'source_sha256':hashes,'exit_code':run.returncode,'output':run.stdout.strip(),'stderr':run.stderr.strip(),'scope':'real observation .m scope logic plus unchanged extracted owner gates; deterministic host UIKit identities; no device, capture, timing, or rendering evidence'}
(HERE/'result.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
raise SystemExit(run.returncode)
