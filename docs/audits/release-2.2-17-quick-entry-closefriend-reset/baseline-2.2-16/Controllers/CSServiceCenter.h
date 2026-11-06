//
// CSServiceCenter.h
// 服务中心适配器
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifdef __cplusplus
extern "C" {
#endif

id CSGetServiceCenter(void);
id CSGetService(Class serviceClass);

#ifdef __cplusplus
}
#endif

NS_ASSUME_NONNULL_END
