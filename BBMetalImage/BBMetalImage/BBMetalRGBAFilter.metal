//
//  BBMetalRGBAFilter.metal
//  BBMetalImage
//
//  Created by Kaibo Lu on 4/3/19.
//  Copyright © 2019 Kaibo Lu. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

kernel void rgbaKernel(texture2d<half, access::write> outputTexture [[texture(0)]],
                       texture2d<half, access::read> inputTexture [[texture(1)]],
                       device float *red [[buffer(0)]],
                       device float *green [[buffer(1)]],
                       device float *blue [[buffer(2)]],
                       device float *alpha [[buffer(3)]],
                       uint2 gid [[thread_position_in_grid]]) {
    
    const half4 inColor = inputTexture.read(gid);
    const half4 outColor(inColor.r * half(*red), inColor.g * half(*green), inColor.b * half(*blue), inColor.a * half(*alpha));
    outputTexture.write(outColor, gid);
}