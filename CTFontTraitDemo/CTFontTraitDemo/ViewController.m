//
//  ViewController.m
//  CTFontTraitDemo
//
//  Created by 李佳 on 15/12/21.
//  Copyright © 2015年 LiJia. All rights reserved.
//

#import "ViewController.h"
#import <CoreText/CTFontCollection.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CTFontCollectionRef fontColRef = CTFontCollectionCreateFromAvailableFonts(NULL);//获取当前可用的字符集
    
    if (fontColRef)
    {
        CFArrayRef fontDescriptors = CTFontCollectionCreateMatchingFontDescriptors(fontColRef);
        for (CFIndex i = 0; i < 20; ++i)
        {
            CTFontDescriptorRef descriptor = (CTFontDescriptorRef)CFArrayGetValueAtIndex(fontDescriptors, i);
            CFTypeRef fontName = CTFontDescriptorCopyAttribute(descriptor, kCTFontDisplayNameAttribute);
            if (fontName)
            {
                NSLog(@"font Name is %@", (__bridge NSString*)fontName);
                CFRelease(fontName);
            }
            
            CFDictionaryRef attrDic = CTFontDescriptorCopyAttribute(descriptor, kCTFontTraitsAttribute);
            if (attrDic)
            {
                CFNumberRef symbolic = CFDictionaryGetValue(attrDic, kCTFontSymbolicTrait);
                if (symbolic)
                {
                    int value;
                    CFNumberGetValue(symbolic, kCFNumberSInt32Type, &value);
                    NSLog(@"kCTFontSymbolicTrait = %d", value);
                    if (value & kCTFontTraitItalic)
                        NSLog(@"斜体");
                    if (value & kCTFontTraitBold)
                        NSLog(@"粗体");
                    if (value & kCTFontTraitMonoSpace)
                        NSLog(@"等宽");
                    if (value & kCTFontTraitExpanded || value & kCTFontTraitCondensed)
                        NSLog(@"压缩或扩展");
                    /*其他就不一一列出*/
                    CFRelease(symbolic);
                }
                
                CFNumberRef weight = CFDictionaryGetValue(attrDic, kCTFontWeightTrait);
                if (weight)
                {
                    CGFloat fWeight;
                    CFNumberGetValue(weight, kCFNumberCGFloatType, &fWeight);
                    NSLog(@"kCTFontWeightTrait = %f", fWeight);
                    CFRelease(weight);
                }
                
                CFNumberRef width = CFDictionaryGetValue(attrDic, kCTFontWidthTrait);
                if (width)
                {
                    CGFloat fWidth;
                    CFNumberGetValue(width, kCFNumberCGFloatType, &fWidth);
                    NSLog(@"kCTFontWidthTrait = %f", fWidth);
                    CFRelease(width);
                }
                
                CFNumberRef slant = CFDictionaryGetValue(attrDic, kCTFontSlantTrait);
                if (slant)
                {
                    CGFloat fSlant;
                    CFNumberGetValue(slant, kCFNumberCGFloatType, &fSlant);
                    NSLog(@"kCTFontSlantTrait = %f", fSlant * 30);
                    CFRelease(slant);
                }
            }
            CFRelease(attrDic);
        }
        CFRelease(fontDescriptors);
    }
    CFRelease(fontColRef);

    
}


@end
