//
//  NSMutableArray+XSerialization.h
//  Xenon Programming Language
//
//  Created by Chen Zhibo on 6/24/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (XSerialization)

//- (id)JSONObjectWithGenerator:(id (^)(id objectToBeSerialized))generator;
- (id)JSONObject;//object must conform to XSerializationProtocol
- (instancetype)initWithJSONObject:(id)jsonObject generator:(id (^)(id jsonObjectInTheArray))generator;

@end
