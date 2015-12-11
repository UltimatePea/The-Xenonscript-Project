//
//  EditAsScriptTextView.m
//  Xenonscript
//
//  Created by Chen Zhibo on 8/23/15.
//  Copyright © 2015 Chen Zhibo. All rights reserved.
//

#import "EditAsScriptTextView.h"

#import "Xenon.h"

@implementation EditAsScriptTextView



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
//may consider a class for this method
#define KEY_WORD_INHERITS_FROM @"extends"
- (NSString *)stringForClass:(XClass *)xclass
{
    NSMutableString *result = [[NSMutableString alloc] init];
    
    //formatting class
    [result appendFormat:@"class %@ extends %@", xclass.name.stringRepresentation, xclass.baseClass.stringRepresentation];
    //start class body
    [self startBraceOnString:result];
    
    //showing properties
    [xclass.properties enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XProperty *property = obj;
        [self appendDefinitionForXVariable:property onString:result];
        [self breakString:result];
    }];
    
    [xclass.methods enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XFunction *function = obj;
        [self appendDefinitionForFunction:function onString:result];
        [self breakString:result];
    }];
    
    
    //finish class body
    [self finishBraceOnString:result];
    return result;
}

- (void)appendDefinitionForFunction:(XFunction *)function onString:(NSMutableString *)string
{
    //declaration
    [string appendFormat:@"function %@", function.name.stringRepresentation];
    
    //parameters
    [string appendFormat:@"("];
    NSUInteger parameterCount = function.parameters.count;
    [function.parameters enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XParameter *param = obj;
        [self appendDefinitionForXVariable:param onString:string];
        if (idx + 1 != parameterCount) {
            [string appendFormat:@", "];
        }
    }];
    
    [string appendFormat:@")"];
    
    
    //return type
    
    [string appendFormat:@" returns %@", function.returnType.stringRepresentation];
    
    
    //start body
    [self startBraceOnString:string];
    
    //localVariables
    [function.localVariables enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XLocalVariable *lv = obj;
        [self appendDefinitionForXVariable:lv onString:string];
        [self breakString:string];
        
    }];
    
    [self breakString:string];
    [self breakString:string];
    //method calls
    
    [function.methodCalls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XMethodCall *mc = obj;
        [string appendString:mc.stringRepresentation];
        [self breakString:string];
    }];
    
    
    [self breakString:string];
    [self breakString:string];
    //local functions
    [function.localFunctions enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XFunction *func = obj;
        [self appendDefinitionForFunction:func onString:string];
    }];
    
    
    //finish body
    [self finishBraceOnString:string];
    [self breakString:string];
}



- (void)appendDefinitionForXVariable:(XVariable *)variable onString:(NSMutableString *)string
{
    NSString *variableName = variable.name.stringRepresentation;
    NSString *variableType = variable.type.stringRepresentation;
    [string appendFormat:@"%@ %@",variableType, variableName];
    
}

- (void)startBraceOnString:(NSMutableString *)string
{
    [self newLineBreakIncludingIndentationOnMutableString:string lessIndent:NO];
    [string appendFormat:@"{"];
    [self newLineBreakIncludingIndentationOnMutableString:string lessIndent:NO];
    
}

- (void)finishBraceOnString:(NSMutableString *)string
{
    [self newLineBreakIncludingIndentationOnMutableString:string lessIndent:YES];
    [string appendFormat:@"}"];
    [self newLineBreakIncludingIndentationOnMutableString:string lessIndent:YES];
}

- (void)breakString:(NSMutableString *)string
{
    [self newLineBreakIncludingIndentationOnMutableString:string lessIndent:NO];
}

- (void)newLineBreakIncludingIndentationOnMutableString:(NSMutableString *)string lessIndent:(BOOL)lessIndent
{
    [string appendString:@"\r\n"];
    for (int i = 0; i < [self numberOfCharacter:@"{" inString:string] - [self numberOfCharacter:@"}" inString:string]-lessIndent?1:0; i++) {
        [string appendString:@"     "];
    }
}
- (CGRect)frameOfTextRange:(NSRange)range inTextView:(UITextView *)textView
{
    UITextPosition *beginning = textView.beginningOfDocument;
    UITextPosition *start = [textView positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [textView positionFromPosition:beginning offset:range.location+range.length];
    UITextRange *textRange = [textView textRangeFromPosition:start toPosition:end];
    CGRect rect = [textView firstRectForRange:textRange];
    return rect;
}

- (int)numberOfCharacter:(NSString *)character inString:(NSString *)string
{
    return [[string componentsSeparatedByString:character] count] - 1;
//    NSString *yourString = string; // For example
//    NSScanner *scanner = [NSScanner scannerWithString:yourString];
//    
//    NSCharacterSet *charactersToCount = [NSCharacterSet characterSetWithCharactersInString:character]; // For example
//    NSString *charactersFromString;
//    
//    if (!([scanner scanCharactersFromSet:charactersToCount
//                              intoString:&charactersFromString])) {
//        // No characters found
//        NSLog(@"No characters found");
//    }
//    
//    // should return 2 for this
//    NSInteger characterCount = [charactersFromString length];
//    return (int)characterCount;
}

@end
