/*
 * CPStringDrawing.j
 * AppKit
 *
 * Created by Francisco Tolmasky.
 * Copyright 2008, 280 North, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

@import <Foundation/CPString.j>

@import "CPPlatformString.j"

var CPStringSizeWithFontInWidthCache = {};

CPStringSizeCachingEnabled = YES;

@implementation CPString (CPStringDrawing)

/*!
    Returns a dictionary with the items "ascender", "descender", "lineHeight"
*/
+ (CPDictionary)metricsOfFont:(CPFont)aFont
{
    return [CPPlatformString metricsOfFont:aFont];
}

/*!
    Returns the string
*/
- (CPString)cssString
{
    return self;
}

- (CGSize)sizeWithFont:(CPFont)aFont
{
    return [self sizeWithFont:aFont inWidth:NULL];
}

- (CGSize)sizeWithFont:(CPFont)aFont inWidth:(float)aWidth
{
    if (!CPStringSizeCachingEnabled)
        return [CPPlatformString sizeOfString:self withFont:aFont forWidth:aWidth];

    var cacheKey = self + [aFont cssString] + aWidth,
        size = CPStringSizeWithFontInWidthCache[cacheKey];

    if (size === undefined)
    {
        size = [CPPlatformString sizeOfString:self withFont:aFont forWidth:aWidth];
        CPStringSizeWithFontInWidthCache[cacheKey] = size;
    }

    return CGSizeMakeCopy(size);
}

@end
