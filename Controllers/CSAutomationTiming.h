#pragma once
#import <Foundation/Foundation.h>
// A claimed action may catch up once within five minutes of its original due.
static const NSTimeInterval CSAutomationLateAllowance=300;
// Native pat success has its own bounded observation, not a send retry.
static const NSTimeInterval CSAutomationObservationAllowance=30;
