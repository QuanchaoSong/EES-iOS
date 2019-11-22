//
//  GlobalTool.m
//  EES
//
//  Created by Albus on 19/11/2019.
//  Copyright © 2019 Zivos. All rights reserved.
//

#import "GlobalTool.h"
#import <CommonCrypto/CommonDigest.h>

static UILabel *txtForSizeFitting = nil;

@implementation GlobalTool

#pragma mark 计算文本大小

+ (CGSize)sizeFitsWithSize:(CGSize)size text:(NSString *)text fontSize:(CGFloat)fontSize {
    return [self sizeFitsWithSize:size text:text font:[UIFont systemFontOfSize:fontSize]];
}

+ (CGSize)sizeFitsWithSize:(CGSize)size text:(NSString *)text font:(UIFont *)font {
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:(text ? text : @"") attributes:@{NSFontAttributeName:font}];
    return [self sizeFitsWithSize:size attributeText:attri];
}

+ (CGSize)sizeFitsWithSize:(CGSize)size attributeText:(NSAttributedString *)attributeText {
    if (txtForSizeFitting == nil) {
        txtForSizeFitting = [UILabel quickLabelWithFont:[UIFont systemFontOfSize:15] textColor:HexColor(@"ffffff") parentView:nil];
    }
    txtForSizeFitting.attributedText = attributeText;
    return [txtForSizeFitting sizeThatFits:size];
}

#pragma mark Alert Pop

+ (void)popSheetAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message optionsStrings:(NSArray <NSString *> *)optionStrings yesActionBlocks:(NSArray <AlertActionBlock> *)actionBlocks {
    [self popSheetAlertOnVC:[UIApplication sharedApplication].delegate.window.rootViewController title:title message:message cancelStr:@"Cancel" optionsStrings:optionStrings yesActionBlocks:actionBlocks];
}

+ (void)popSheetAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message optionsStrings:(NSArray <NSString *> *)optionStrings yesActionBlocks:(NSArray <AlertActionBlock> *)actionBlocks {
    [self popSheetAlertOnVC:vc title:title message:message cancelStr:@"Cancel" optionsStrings:optionStrings yesActionBlocks:actionBlocks];
}

+ (void)popSheetAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message cancelStr:(NSString *)cancelStr optionsStrings:(NSArray <NSString *> *)optionStrings yesActionBlocks:(NSArray <AlertActionBlock> *)actionBlocks {
    if (optionStrings.count == 0 || actionBlocks.count == 0) {
        return;
    }
    
    UIAlertController *sheetAlertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *sheetAlertActionOfNo = [UIAlertAction actionWithTitle:cancelStr style:UIAlertActionStyleCancel handler:nil];
    [sheetAlertController addAction:sheetAlertActionOfNo];
    
    NSInteger length = (optionStrings.count >= actionBlocks.count ? optionStrings.count : actionBlocks.count);
    for (int i = 0; i < length; i++) {
        NSString *optionString = optionStrings[i];
        AlertActionBlock actionBlock = actionBlocks[i];
        UIAlertAction *sheetAlertAction = [UIAlertAction actionWithTitle:optionString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (actionBlock) {
                actionBlock();
            }
        }];
        [sheetAlertController addAction:sheetAlertAction];
    }
    
    [vc presentViewController:sheetAlertController animated:YES completion:nil];
}

+ (void)popAlertWithTitle:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr yesActionBlock:(nonnull AlertActionBlock)yesActionBlock {
    [self popAlertOnVC:[UIApplication sharedApplication].delegate.window.rootViewController title:title message:message yesStr:yesStr noStr:@"取消" yesActionBlock:yesActionBlock];
}

+ (void)popAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr yesActionBlock:(nonnull AlertActionBlock)yesActionBlock {
    [self popAlertOnVC:vc title:title message:message yesStr:yesStr noStr:@"取消" yesActionBlock:yesActionBlock];
}

+ (void)popAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr noStr:(NSString *)noStr yesActionBlock:(nonnull AlertActionBlock)yesActionBlock {
    [self popAlertOnVC:vc title:title message:message yesStr:yesStr noStr:noStr yesActionBlock:yesActionBlock noActionBlock:nil];
}

+ (void)popAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr noStr:(NSString *)noStr yesActionBlock:(nonnull AlertActionBlock)yesActionBlock noActionBlock:(nonnull AlertActionBlock)noActionBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertActionOfNo = [UIAlertAction actionWithTitle:noStr style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (noActionBlock) {
            noActionBlock();
        }
    }];
    
    UIAlertAction *alertActionOfYes = [UIAlertAction actionWithTitle:yesStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (yesActionBlock) {
            yesActionBlock();
        }
    }];
    
    [alertController addAction:alertActionOfNo];
    [alertController addAction:alertActionOfYes];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}

+ (void)popSingleActionAlertOnVC:(UIViewController *)vc title:(nullable NSString *)title message:(nullable NSString *)message yesStr:(NSString *)yesStr yesActionBlock:(nullable AlertActionBlock)yesActionBlock {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertActionOfYes = [UIAlertAction actionWithTitle:yesStr style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (yesActionBlock) {
            yesActionBlock();
        }
    }];
    
    [alertController addAction:alertActionOfYes];
    
    [vc presentViewController:alertController animated:YES completion:nil];
}


#pragma mark color

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage*)contentsFileStyleImageOfName:(NSString *)imageName {
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], imageName]];
}

+ (NSString *)md5String:(NSString *)string {
    const char *cStr = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


@end
