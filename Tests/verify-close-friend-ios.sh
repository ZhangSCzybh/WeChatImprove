#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."
# Build only isolated objects; never clean, package, install, restart, or use device credentials.
work=$(mktemp -d)
trap 'rm -rf "$work"' EXIT
theos_dir=${THEOS:-/Users/zhangshichao/theos}
sdk_dir=$(xcrun --sdk iphoneos --show-sdk-path)
surface_hooks=(CloseFriendContactHooks CloseFriendSearchHooks CloseFriendProfileHooks)
social_hooks=(CloseFriendSocialHooks)
hooks=("${social_hooks[@]}" CloseFriendLifecycleHooks CustomEntryHooks "${surface_hooks[@]}")
if [[ "${1:-}" == "--surfaces" ]]; then hooks=("${surface_hooks[@]}"); fi
if [[ "${1:-}" == "--social" ]]; then hooks=("${social_hooks[@]}"); fi
for hook in "${hooks[@]}"; do
 perl "$theos_dir/vendor/logos/bin/logos.pl" "Hooks/$hook.xm" > "$work/$hook.mm"
done
for arch in arm64 arm64e; do
 flags=(-target "$arch-apple-ios15.0" -isysroot "$sdk_dir" -fobjc-arc -fblocks -Wno-deprecated-declarations -Wno-unused-parameter -IControllers -IHeaders -IHooks -I"$theos_dir/vendor/include" -F"$theos_dir/vendor/lib")
 sources=(Controllers/CSCloseFriend{Policy,Crypto,Store,Account,Runtime,Signatures,Bridge,Manager,SettingsViewController,ContactProjection,ContactAdapter,SearchAdapter,ProfileAdapter,SocialProjection,SocialAdapter,TimelineAdapter,InteractionAdapter,StatusAdapter,AudienceAdapter}.m)
 if [[ "${1:-}" == "--surfaces" ]]; then sources=(Controllers/CSCloseFriend{ContactProjection,ContactAdapter,SearchAdapter,ProfileAdapter}.m); fi
 if [[ "${1:-}" == "--social" ]]; then sources=(Controllers/CSCloseFriend{SocialProjection,SocialAdapter,TimelineAdapter,InteractionAdapter,StatusAdapter,AudienceAdapter}.m); fi
 for source in "${sources[@]}"; do
  xcrun --sdk iphoneos clang "${flags[@]}" -Wall -Wextra -Werror -c "$source" -o "$work/$(basename "$source").$arch.o"
 done
 selected_hooks=("${surface_hooks[@]}" "${social_hooks[@]}")
 if [[ "${1:-}" == "--surfaces" ]]; then selected_hooks=("${surface_hooks[@]}"); fi
 if [[ "${1:-}" == "--social" ]]; then selected_hooks=("${social_hooks[@]}"); fi
 for hook in "${selected_hooks[@]}"; do
  xcrun --sdk iphoneos clang++ "${flags[@]}" -std=c++17 -Wall -Wextra -Werror -c "$work/$hook.mm" -o "$work/$hook.$arch.o"
 done
 if [[ "${1:-}" == "--surfaces" || "${1:-}" == "--social" ]]; then continue; fi
 xcrun --sdk iphoneos clang++ "${flags[@]}" -std=c++17 -Werror -c "$work/CloseFriendLifecycleHooks.mm" -o "$work/lifecycle.$arch.o"
 # Existing framework code retains its established warning policy.
 xcrun --sdk iphoneos clang "${flags[@]}" -Wno-error -c Controllers/CSCustomViewController.m -o "$work/custom.$arch.o"
 xcrun --sdk iphoneos clang++ "${flags[@]}" -std=c++17 -D_Bool=bool -Wno-error -c "$work/CustomEntryHooks.mm" -o "$work/entry.$arch.o"
done
printf 'Close-friend iOS: arm64 + arm64e source objects compiled\n'
