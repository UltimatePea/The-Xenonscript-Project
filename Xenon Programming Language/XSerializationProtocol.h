//
//  XSerializationProtocol.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/24/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol XSerializationProtocol <NSObject>
@required
- (instancetype)initWithJSONObject:(id)jsonObject;
- (id)JSONObject;

@end
